import 'package:dio/dio.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';

/// Gerçek backend'e bağlanan kaynak (§8.5).
///
/// Mock ile AYNI fromJson'ları kullanır; mock'a dönüş
/// `--dart-define=MT_API=mock` ile yapılır.
class ApiRepository implements MilkTraceRepository {
  ApiRepository({
    required Dio dio,
    Duration pollInterval = const Duration(seconds: 5),
  })  : _dio = dio,
        _pollInterval = pollInterval;

  final Dio _dio;

  /// Canlı akış yoklama aralığı.
  ///
  /// Varsayılan backend'in Postgres'e toplu yazım aralığıyla (5 sn) aynı:
  /// daha sık yoklamak aynı veriyi tekrar okumak olurdu. Testler kısa bir
  /// değer veriyor — aksi halde akış testleri gerçek saniyeleri bekler ve
  /// test paketi kimsenin çalıştırmak istemeyeceği kadar yavaşlar.
  final Duration _pollInterval;

  /// §16'daki zarf: {"success":..,"data":..,"error":{"code","message"}}
  List<T> _listOf<T>(Response<dynamic> r, T Function(Map<String, dynamic>) from) {
    final data = (r.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data.map((e) => from(e as Map<String, dynamic>)).toList(growable: false);
  }

  Map<String, dynamic> _dataOf(Response<dynamic> r) =>
      (r.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;

  @override
  Future<List<Species>> species() async =>
      _listOf(await _dio.get<dynamic>('/species'), Species.fromJson);

  @override
  Future<List<Thresholds>> thresholds() async =>
      _listOf(await _dio.get<dynamic>('/species/thresholds'), Thresholds.fromJson);

  @override
  Future<List<Farm>> farms() async =>
      _listOf(await _dio.get<dynamic>('/farms'), Farm.fromJson);

  @override
  Future<List<Hall>> halls() async =>
      _listOf(await _dio.get<dynamic>('/halls'), Hall.fromJson);

  @override
  Future<List<Vacuum>> vacuums({String? hallId}) async => _listOf(
      await _dio.get<dynamic>('/vacuums',
          queryParameters: {'hallId': ?hallId}),
      Vacuum.fromJson);

  @override
  Future<List<Spout>> spouts({String? vacuumId}) async => _listOf(
      await _dio.get<dynamic>('/spouts',
          queryParameters: {'vacuumId': ?vacuumId}),
      Spout.fromJson);

  @override
  Future<List<Device>> devices() async =>
      _listOf(await _dio.get<dynamic>('/devices'), Device.fromJson);

  @override
  Future<List<Animal>> animals() async =>
      _listOf(await _dio.get<dynamic>('/animals'), Animal.fromJson);

  @override
  Future<LiveSession> liveSession({required String hallId}) async {
    final session = await _activeSession(hallId);
    if (session == null) {
      // Bölgede açık oturum yok. BOŞ LİSTE değil, "oturum yok" durumu
      // dönülüyor ki ekran "sağım başlatın" diyebilsin; boş liste
      // "oturum var ama nokta yok" ile karışırdı.
      return LiveSession(
        session: MilkingSession(id: '', hallId: hallId, status: 'none'),
      );
    }

    final r = await _dio.get<dynamic>('/sessions/${session.id}/live');
    return LiveSession.fromJson(_dataOf(r));
  }

  /// Bölgedeki AÇIK oturumu bulur; yoksa null.
  ///
  /// Filtre İSTEMCİDE: `GET /sessions` durum parametresi almıyor ve
  /// oturumları başlangıç saatine göre tersten döndürüyor. Listenin ilkini
  /// körlemesine almak, bölgede son sağım bitmişse KAPALI bir oturumu canlı
  /// sanmak olurdu.
  Future<MilkingSession?> _activeSession(String hallId) async {
    for (final s in await sessions(hallId: hallId)) {
      if (s.status == 'active') return s;
    }
    return null;
  }

  /// Canlı güncellemeler.
  ///
  /// GEÇİCİ OLARAK YOKLAMA (polling). §8.5 bunun WebSocket olmasını
  /// söylüyor ama `realtime` servisi henüz yazılmadı (§17 Faz 3'ün kalanı).
  /// WebSocket'e bağlanmayı denemek, bağlantı hatasıyla akışı düşürür ve
  /// canlı ekran ilk karede donardı.
  ///
  /// `GET /sessions/{id}/live` zaten noktaların tamamını dönüyor.
  ///
  /// realtime geldiğinde YALNIZCA bu metot değişir; ekran ve provider aynı
  /// kalır çünkü ikisi de Stream görüyor.
  @override
  Stream<SpoutUpdate> watchSession(String sessionId) async* {
    if (sessionId.isEmpty) return;

    // Son gönderilen kareyi nokta bazında tutuyoruz: değişmeyen noktayı
    // tekrar yayınlamak ekranı her yoklamada baştan çizdirirdi.
    final lastTs = <String, DateTime?>{};

    while (true) {
      await Future<void>.delayed(_pollInterval);

      final LiveSession live;
      try {
        final r = await _dio.get<dynamic>('/sessions/$sessionId/live');
        live = LiveSession.fromJson(_dataOf(r));
      } on DioException {
        // Ağ hatası akışı BİTİRMEZ: ahırda kapsama sık kopuyor ve akışı
        // kapatmak, bağlantı geri geldiğinde ekranın ölü kalması demekti.
        continue;
      }

      if (live.session.status != 'active') {
        // Oturum kapandı: akış biter ve ekran son durumu gösterir.
        return;
      }

      for (final u in live.updates) {
        if (lastTs[u.spoutId] == u.ts) continue;
        lastTs[u.spoutId] = u.ts;
        yield u;
      }
    }
  }

  @override
  Future<List<MilkingSession>> sessions(
      {String? hallId, DateTime? from, DateTime? to}) async {
    final r = await _dio.get<dynamic>('/sessions',
        queryParameters: {..._range(from, to), 'hallId': ?hallId});
    return _listOf(r, MilkingSession.fromJson);
  }

  @override
  Future<List<AnimalMilking>> animalHistory(String animalId,
      {DateTime? from, DateTime? to}) async {
    final r = await _dio.get<dynamic>('/animals/$animalId/history',
        queryParameters: _range(from, to));
    return _listOf(r, AnimalMilking.fromJson);
  }

  @override
  Future<AnimalTrend> animalTrend(String animalId) async =>
      AnimalTrend.fromJson(_dataOf(await _dio.get<dynamic>('/animals/$animalId/trend')));

  /// from/to parametreleri, verilmişlerse.
  ///
  /// UTC'ye ÇEVRİLİR: ekranlar Europe/Istanbul'da çalışır (§16) ve yerel
  /// gece yarısını olduğu gibi göndermek, backend'de üç saat kayık bir
  /// aralık sorgulamak olurdu.
  Map<String, dynamic> _range(DateTime? from, DateTime? to) => {
        'from': ?from?.toUtc().toIso8601String(),
        'to': ?to?.toUtc().toIso8601String(),
      };

  @override
  Future<List<Alert>> alerts() async =>
      _listOf(await _dio.get<dynamic>('/alerts'), Alert.fromJson);

  @override
  Future<void> ackAlert(String alertId) =>
      _dio.post<dynamic>('/alerts/$alertId/ack');
}
