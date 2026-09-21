import 'package:milktrace/data/models/animal.dart';
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

/// GEÇİCİ: referans verisi gerçek API'den, canlı sağım akışı mock'tan.
///
/// Sebep tek: `milking` servisinin HTTP katmanı henüz yazılmadı (Faz 3).
/// Gateway'de `/sessions` rotası var ama arkasında uç yok, yani
/// `liveSession()` gerçek API'ye gitse 502 döner ve uygulamanın merkezindeki
/// Canlı sekmesi tamamen ölürdü.
///
/// Bu sınıf, milking servisi geldiğinde TEK COMMIT'te silinir:
/// `repositoryProvider` doğrudan `ApiRepository` döndürmeye başlar. Başka
/// hiçbir yerde değişiklik gerekmez — ekranlar yalnızca arayüzü görüyor.
///
/// Ayrımın nerede olduğu bilinçli olarak AÇIKTIR; "bazı uçlar bazen mock"
/// gibi belirsiz bir durum bırakmamak için hangi metodun nereye gittiği
/// aşağıda tek tek yazılı.
class ApiWithMockLiveRepository implements MilkTraceRepository {
  ApiWithMockLiveRepository({
    required MilkTraceRepository api,
    required MilkTraceRepository live,
  })  : _api = api,
        _live = live;

  final MilkTraceRepository _api;

  /// Yalnızca canlı sağım akışı için. Faz 3'te kaldırılacak.
  final MilkTraceRepository _live;

  // --- gerçek API ---
  @override
  Future<List<Species>> species() => _api.species();
  @override
  Future<List<Thresholds>> thresholds() => _api.thresholds();
  @override
  Future<List<Farm>> farms() => _api.farms();
  @override
  Future<List<Hall>> halls() => _api.halls();
  @override
  Future<List<Vacuum>> vacuums({String? hallId}) => _api.vacuums(hallId: hallId);
  @override
  Future<List<Spout>> spouts({String? vacuumId}) => _api.spouts(vacuumId: vacuumId);
  @override
  Future<List<Device>> devices() => _api.devices();
  @override
  Future<List<Animal>> animals() => _api.animals();

  // --- mock (milking servisi gelene kadar) ---

  /// Mock nokta kimliği -> seçili bölgenin GERÇEK nokta kimliği.
  ///
  /// Mock canlı akışı tek bir bölge için yazılmıştır ve hep aynı nokta
  /// kimliklerini taşır. Ekran ise noktayı gerçek API'den gelen listede
  /// arayıp ünite adı ve pozisyon numarasını oradan yazıyor. Eşleme
  /// yapılmazsa diğer bölgelerde arama tutmaz ve kartların başlığı
  /// "A-1 · Nokta 3" yerine yalnızca "Nokta" olur.
  ///
  /// Gerçek /sessions/{id}/live zaten o bölgenin noktalarını döndüreceği
  /// için bu eşleme milking servisiyle birlikte ortadan kalkar.
  final Map<String, String> _spoutRemap = {};

  @override
  Future<LiveSession> liveSession({required String hallId}) async {
    final live = await _live.liveSession(hallId: hallId);
    final real = await _realSpoutsOf(hallId);

    _spoutRemap.clear();
    if (real.isEmpty) return live;

    final updates = <SpoutUpdate>[];
    for (var i = 0; i < live.updates.length; i++) {
      final mockId = live.updates[i].spoutId;
      // Sıraya göre eşleştir: mock N nokta üretir, bölgede M nokta vardır.
      // Fazlası taşarsa başa döner ki hiçbir kart eşleşmesiz kalmasın.
      final realId = real[i % real.length].id;
      _spoutRemap[mockId] = realId;
      updates.add(live.updates[i].copyWith(spoutId: realId));
    }

    return live.copyWith(updates: updates);
  }

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) =>
      _live.watchSession(sessionId).map((u) {
        final mapped = _spoutRemap[u.spoutId];
        return mapped == null ? u : u.copyWith(spoutId: mapped);
      });

  /// Bölgenin gerçek noktaları: önce üniteler, sonra her ünitenin noktaları.
  ///
  /// Depo arayüzü noktaları yalnızca üniteye göre filtreliyor (bölgeye göre
  /// filtre backend'de var ama arayüzde yok); iki adımda toplanıyor.
  Future<List<Spout>> _realSpoutsOf(String hallId) async {
    final vacuums = await _api.vacuums(hallId: hallId);
    final out = <Spout>[];
    for (final v in vacuums) {
      out.addAll(await _api.spouts(vacuumId: v.id));
    }
    return out;
  }
}
