import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_note.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/farm.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/data/models/session_milking.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/unmatched_tag_row.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Gerçek backend'e bağlanan kaynak (§8.5).
///
/// Mock ile AYNI fromJson'ları kullanır; mock'a dönüş
/// `--dart-define=MT_API=mock` ile yapılır.
class ApiRepository implements MilkTraceRepository {
  ApiRepository({
    required Dio dio,
    required String wsBaseUrl,
    String? Function()? accessToken,
    WebSocketChannel Function(Uri uri, Map<String, dynamic> headers)? connect,
    Duration reconnectDelay = const Duration(seconds: 3),
    void Function(DateTime lastFrameAt)? onLiveLost,
  }) : _dio = dio,
       _wsBaseUrl = wsBaseUrl,
       _accessToken = accessToken ?? _noToken,
       _connect = connect ?? _defaultConnect,
       _reconnectDelay = reconnectDelay,
       _onLiveLost = onLiveLost;

  final Dio _dio;

  /// Canlı bağlantı koptu ya da kurulamadı; parametre son karenin anı.
  ///
  /// Çevrimdışı bandı içindir (backend ADR 0061): canlı tahtada oturan
  /// kullanıcı başka bir okuma yapmadığı için önbellek katmanı kopuşu hiç
  /// görmüyor, değerler DONUK ama güncel görünüyordu (cihazda bulundu).
  final void Function(DateTime lastFrameAt)? _onLiveLost;

  /// WebSocket tabanı: `ws://host/api/v1` (§8.5).
  final String _wsBaseUrl;

  /// Erişim token'ı sağlayıcısı.
  ///
  /// FONKSİYON, DEĞER DEĞİL: token yenilenince değişiyor ve her yeniden
  /// bağlanmada GÜNCELİ okunmalı. Kurulum anındaki değeri saklasaydık,
  /// uzun bir sağımda token'ın ömrü dolduğunda yeniden bağlanma sessizce
  /// 401 alır ve canlı ekran bir daha hiç açılmazdı.
  final String? Function() _accessToken;

  /// Bağlantı kurucu; testler sahte kanal veriyor.
  final WebSocketChannel Function(Uri uri, Map<String, dynamic> headers)
  _connect;

  /// Kopan bağlantıdan sonra beklenen süre.
  final Duration _reconnectDelay;

  static String? _noToken() => null;

  static WebSocketChannel _defaultConnect(
    Uri uri,
    Map<String, dynamic> headers,
  ) => IOWebSocketChannel.connect(uri, headers: headers);

  /// §16'daki zarf: {"success":..,"data":..,"error":{"code","message"}}
  List<T> _listOf<T>(
    Response<dynamic> r,
    T Function(Map<String, dynamic>) from,
  ) {
    final data = (r.data as Map<String, dynamic>)['data'] as List<dynamic>;
    return data
        .map((e) => from(e as Map<String, dynamic>))
        .toList(growable: false);
  }

  Map<String, dynamic> _dataOf(Response<dynamic> r) =>
      (r.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;

  @override
  Future<List<Species>> species() async =>
      _listOf(await _dio.get<dynamic>('/species'), Species.fromJson);

  @override
  Future<List<Thresholds>> thresholds() async => _listOf(
    await _dio.get<dynamic>('/species/thresholds'),
    Thresholds.fromJson,
  );

  @override
  Future<List<Farm>> farms() async =>
      _listOf(await _dio.get<dynamic>('/farms'), Farm.fromJson);

  @override
  Future<List<Hall>> halls() async =>
      _listOf(await _dio.get<dynamic>('/halls'), Hall.fromJson);

  @override
  Future<List<Vacuum>> vacuums({String? hallId}) async => _listOf(
    await _dio.get<dynamic>('/vacuums', queryParameters: {'hallId': ?hallId}),
    Vacuum.fromJson,
  );

  @override
  Future<List<Spout>> spouts({String? vacuumId}) async => _listOf(
    await _dio.get<dynamic>(
      '/spouts',
      queryParameters: {'vacuumId': ?vacuumId},
    ),
    Spout.fromJson,
  );

  @override
  Future<List<Device>> devices() async =>
      _listOf(await _dio.get<dynamic>('/devices'), Device.fromJson);

  @override
  Future<List<Animal>> animals() async =>
      _listOf(await _dio.get<dynamic>('/animals'), Animal.fromJson);

  @override
  Future<Animal> saveAnimal(Animal a) async {
    final body = animalBody(a);
    final r = a.id.isEmpty
        ? await _dio.post<dynamic>('/animals', data: body)
        : await _dio.put<dynamic>('/animals/${a.id}', data: body);
    return Animal.fromJson(_dataOf(r));
  }

  @override
  Future<List<AnimalNote>> animalNotes(String animalId) async => _listOf(
    await _dio.get<dynamic>('/animals/$animalId/notes'),
    AnimalNote.fromJson,
  );

  @override
  Future<AnimalNote> addAnimalNote(String animalId, String note) async =>
      AnimalNote.fromJson(
        _dataOf(
          await _dio.post<dynamic>(
            '/animals/$animalId/notes',
            data: {'note': note},
          ),
        ),
      );

  @override
  Future<Animal> recordCalving(String animalId, DateTime date) async =>
      Animal.fromJson(
        _dataOf(
          await _dio.post<dynamic>(
            '/animals/$animalId/calving',
            // Yalnızca GÜN: saat yok, saat dilimi kaydırması olmasın.
            data: {
              'date':
                  '${date.year.toString().padLeft(4, '0')}-'
                  '${date.month.toString().padLeft(2, '0')}-'
                  '${date.day.toString().padLeft(2, '0')}',
            },
          ),
        ),
      );

  /// Formun gövdesi: kimlik ve verim sınıfı YOK (sınıfı gece hesabı yazar;
  /// formun eski bir değerle ezmesi istenmez). Tarihler gün olarak, UTC
  /// gece yarısı: saat dilimi kayması doğum gününü bir gün geri atmasın.
  @visibleForTesting
  static Map<String, dynamic> animalBody(Animal a) => {
    'speciesId': a.speciesId,
    'earTag': a.earTag,
    'rfid': a.rfid,
    'name': a.name,
    'breed': a.breed,
    'birthDate': _day(a.birthDate),
    'lastCalvingDate': _day(a.lastCalvingDate),
    'lactationNo': a.lactationNo,
    'status': a.status,
  };

  static String? _day(DateTime? d) =>
      d == null ? null : DateTime.utc(d.year, d.month, d.day).toIso8601String();

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

  /// Canlı güncellemeler (§8.5 WS /ws?sessionId=).
  ///
  /// YOKLAMA KALDIRILDI: backend'in `realtime` servisi güncellemeleri Redis
  /// Pub/Sub'dan WebSocket'e akıtıyor. Yoklama en iyi ihtimalle 5 saniyelik
  /// gecikme demekti ve sağımın ilk saniyeleri (§6.2 ısınma fazı) o
  /// pencerede tamamen kaçıyordu.
  ///
  /// Akış KENDİ KENDİNİ ONARIR: bağlantı koptuğunda yeniden bağlanır ve her
  /// bağlanışta önce ANLIK GÖRÜNTÜYÜ çeker. Kopukluk boyunca kaçırılan
  /// kareleri kurtarmaya çalışmak yerine tam durumu okumak doğrusu — canlı
  /// veride en son değer geçerli olandır ve backend de düşürdüğü istemciden
  /// tam olarak bunu bekliyor.
  @override
  Stream<SpoutUpdate> watchSession(String sessionId) async* {
    if (sessionId.isEmpty) return;

    // Son başarılı karenin anı; kopuş bildirimi "veri ne zamandan" diye.
    var lastFrameAt = DateTime.now();
    void lost() => _onLiveLost?.call(lastFrameAt);

    while (true) {
      // Anlık görüntü: ilk bağlantıda ekranı doldurur, yeniden bağlanmada
      // kopukluk boyunca değişenleri kapatır.
      final live = await _liveOrNull(sessionId);
      if (live != null) {
        if (live.session.status != 'active') return;
        lastFrameAt = DateTime.now();
        for (final u in live.updates) {
          yield u;
        }
      }

      final channel = _open(sessionId);
      // El sıkışma BEKLENİR: sunucu kapalıyken (gateway yeniden başlıyor,
      // ahırın interneti yok) bağlantı reddedilir. Beklenmezse hata
      // "unhandled" düşer ve kurulamamış kanalın sink.close()'u hiç
      // tamamlanmadığı için yeniden bağlanma döngüsü TAKILI kalırdı —
      // cihazda denenerek bulundu: gateway dönünce canlı tahta donuk kaldı.
      try {
        await channel.ready;
      } on Object {
        lost();
        await Future<void>.delayed(_reconnectDelay);
        continue;
      }
      var ended = false;
      try {
        await for (final raw in channel.stream) {
          final message = _decodeMessage(raw);
          switch (message) {
            case final SpoutUpdate u:
              lastFrameAt = DateTime.now();
              yield u;
            case _SessionEnded():
              // Oturum kapandı: akış biter, ekran son durumu gösterir.
              // Bu duyuru olmadan telefon sessiz ama açık bir bağlantıda
              // kalır ve son kareyi sonsuza dek gösterirdi.
              ended = true;
            case null:
              // Tanınmayan mesaj akışı DÜŞÜRMEZ: backend ileride uyarı
              // gibi başka tipler yayınlayabilir ve eski bir uygulama
              // sürümü onlar yüzünden canlı ekranı kaybetmemeli.
              break;
          }
          if (ended) break;
        }
      } on Object {
        // Bağlantı hatası akışı BİTİRMEZ; aşağıda yeniden bağlanılır.
      } finally {
        // Kopmuş bağlantının kapanışı sunucudan cevap beklemesin.
        await channel.sink.close().timeout(
          const Duration(seconds: 2),
          onTimeout: () {},
        );
      }

      if (ended) return;
      lost();

      // Ahırda kapsama sık kopuyor; hemen yeniden denemek broker'ı
      // gereksiz yere döver.
      await Future<void>.delayed(_reconnectDelay);
    }
  }

  /// Oturumun anlık görüntüsü; ağ hatasında null.
  Future<LiveSession?> _liveOrNull(String sessionId) async {
    try {
      final r = await _dio.get<dynamic>('/sessions/$sessionId/live');
      return LiveSession.fromJson(_dataOf(r));
    } on DioException {
      return null;
    }
  }

  /// WebSocket bağlantısını açar.
  ///
  /// Token BAŞLIKTA gider, sorgu dizesinde değil: sorgu dizesi sunucu
  /// loglarına ve proxy geçmişine düşer. El sıkışma sıradan bir HTTP GET
  /// olduğu için gateway JWT'yi diğer uçlarla birebir aynı doğrular.
  WebSocketChannel _open(String sessionId) {
    final uri = Uri.parse('$_wsBaseUrl/ws?sessionId=$sessionId');
    final token = _accessToken();

    return _connect(uri, {if (token != null) 'Authorization': 'Bearer $token'});
  }

  /// Gelen çerçeveyi çözer: güncelleme, oturum sonu ya da tanınmayan (null).
  Object? _decodeMessage(Object? raw) {
    if (raw is! String) return null;

    final Map<String, dynamic> json;
    try {
      json = jsonDecode(raw) as Map<String, dynamic>;
    } on Object {
      return null;
    }

    return switch (json['type']) {
      'spout.update' => SpoutUpdate.fromJson(json),
      'session.ended' => const _SessionEnded(),
      _ => null,
    };
  }

  @override
  Future<List<MilkingSession>> sessions({
    String? hallId,
    DateTime? from,
    DateTime? to,
  }) async {
    final r = await _dio.get<dynamic>(
      '/sessions',
      queryParameters: {..._range(from, to), 'hallId': ?hallId},
    );
    return _listOf(r, MilkingSession.fromJson);
  }

  @override
  Future<List<SessionMilking>> sessionMilkings(String sessionId) async =>
      _listOf(
        await _dio.get<dynamic>('/sessions/$sessionId/milkings'),
        SessionMilking.fromJson,
      );

  @override
  Future<List<AnimalMilking>> animalHistory(
    String animalId, {
    DateTime? from,
    DateTime? to,
  }) async {
    final r = await _dio.get<dynamic>(
      '/animals/$animalId/history',
      queryParameters: _range(from, to),
    );
    return _listOf(r, AnimalMilking.fromJson);
  }

  @override
  Future<AnimalTrend> animalTrend(String animalId) async =>
      AnimalTrend.fromJson(
        _dataOf(await _dio.get<dynamic>('/animals/$animalId/trend')),
      );

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

  @override
  Future<DashboardSummary> dashboard() async =>
      DashboardSummary.fromJson(_dataOf(await _dio.get<dynamic>('/dashboard')));

  @override
  Future<void> registerPushToken({
    required String token,
    required String platform,
  }) => _dio.post<dynamic>(
    '/me/push-tokens',
    data: {'token': token, 'platform': platform},
  );

  @override
  Future<void> unregisterPushToken(String token) =>
      _dio.delete<dynamic>('/me/push-tokens/$token');

  @override
  Future<int> sendTestPush() async {
    final data = _dataOf(await _dio.post<dynamic>('/me/push-tokens/test'));
    return (data['sent'] as num?)?.toInt() ?? 0;
  }

  @override
  Future<List<NotificationProvider>> notificationProviders() async => _listOf(
    await _dio.get<dynamic>('/notification-providers'),
    NotificationProvider.fromJson,
  );

  @override
  Future<List<NotificationChannel>> notificationChannels() async => _listOf(
    await _dio.get<dynamic>('/notification-channels'),
    NotificationChannel.fromJson,
  );

  @override
  Future<NotificationChannel> createNotificationChannel(
    NotificationChannelDraft draft,
  ) async => NotificationChannel.fromJson(
    _dataOf(
      await _dio.post<dynamic>('/notification-channels', data: draft.toJson()),
    ),
  );

  @override
  Future<NotificationChannel> updateNotificationChannel(
    String id,
    NotificationChannelDraft draft,
  ) async => NotificationChannel.fromJson(
    _dataOf(
      await _dio.put<dynamic>(
        '/notification-channels/$id',
        // Tür ve sağlayıcı değişmez; backend okumuyor, göndermiyoruz.
        data: draft.toJson()
          ..remove('kind')
          ..remove('provider'),
      ),
    ),
  );

  @override
  Future<void> deleteNotificationChannel(String id) =>
      _dio.delete<dynamic>('/notification-channels/$id');

  @override
  Future<void> testNotificationChannel(String id) =>
      _dio.post<dynamic>('/notification-channels/$id/test');

  @override
  Future<Thresholds> updateThresholds(Thresholds thresholds) async {
    final r = await _dio.put<dynamic>(
      '/species/thresholds',
      data: thresholds.toJson(),
    );
    // Eski backend gövdesiz ("data" yok) cevap veriyordu ve burada
    // düşülüyordu: kayıt başarılıyken ekran "kaydedilemedi" diyordu.
    final data = (r.data as Map<String, dynamic>?)?['data'];
    return data is Map<String, dynamic>
        ? Thresholds.fromJson(data)
        : thresholds.copyWith(tenantScoped: true);
  }

  @override
  Future<MilkingSession> startSession({
    required String hallId,
    required String type,
  }) async => MilkingSession.fromJson(
    _dataOf(
      await _dio.post<dynamic>(
        '/sessions',
        data: {'hallId': hallId, 'type': type},
      ),
    ),
  );

  @override
  Future<void> assignAnimal({
    required String sessionId,
    required String spoutId,
    required String animalId,
  }) => _dio.put<dynamic>(
    '/sessions/$sessionId/spouts/$spoutId/animal',
    data: {'animalId': animalId},
  );

  @override
  Future<List<UnmatchedTagRow>> unmatchedTags() async => _listOf(
    await _dio.get<dynamic>('/unmatched-tags'),
    UnmatchedTagRow.fromJson,
  );

  @override
  Future<void> dismissUnmatchedTag(String rfid) =>
      _dio.delete<dynamic>('/unmatched-tags/${Uri.encodeComponent(rfid)}');

  @override
  Future<void> unassignAnimal({
    required String sessionId,
    required String spoutId,
  }) => _dio.delete<dynamic>('/sessions/$sessionId/spouts/$spoutId/animal');

  @override
  Future<MilkingSession> endSession(String sessionId) async =>
      MilkingSession.fromJson(
        _dataOf(await _dio.post<dynamic>('/sessions/$sessionId/end')),
      );
}

/// Oturumun kapandığını bildiren iç işaret.
class _SessionEnded {
  const _SessionEnded();
}
