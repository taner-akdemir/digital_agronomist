import 'package:flutter_test/flutter_test.dart';
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
import 'package:milktrace/data/repositories/api_with_mock_live_repository.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/domain/flow_color.dart';

/// Gerçek API'yi taklit eden taraf: iki bölge, her birinde ayrı noktalar.
class _FakeApi implements MilkTraceRepository {
  @override
  Future<List<Vacuum>> vacuums({String? hallId}) async => [
        Vacuum(id: '$hallId-v1', hallId: hallId!, name: 'Ü1', totalSpouts: 2),
      ];

  @override
  Future<List<Spout>> spouts({String? vacuumId}) async => [
        Spout(id: '$vacuumId-s1', vacuumId: vacuumId!, positionNo: 1),
        Spout(id: '$vacuumId-s2', vacuumId: vacuumId, positionNo: 2),
      ];

  @override
  Future<LiveSession> liveSession({required String hallId}) =>
      throw UnimplementedError('köprü bunu mock\'a yollamalı');
  @override
  Stream<SpoutUpdate> watchSession(String sessionId) =>
      throw UnimplementedError('köprü bunu mock\'a yollamalı');

  @override
  Future<List<Species>> species() async => [];
  @override
  Future<List<Thresholds>> thresholds() async => [];
  @override
  Future<List<Farm>> farms() async => [];
  @override
  Future<List<Hall>> halls() async => [];
  @override
  Future<List<Device>> devices() async => [];
  @override
  Future<List<Animal>> animals() async => [];
}

/// Mock canlı akış: her zaman AYNI iki nokta kimliğiyle yayın yapar.
class _FakeLive implements MilkTraceRepository {
  static SpoutUpdate _u(String spoutId) => SpoutUpdate(
        sessionId: 's1',
        spoutId: spoutId,
        flowRate: 2,
        volumeMl: 5000,
        expectedMl: 11000,
        state: SpoutState.milking,
        flowColor: MilkColor.green,
        yieldColor: MilkColor.yellow,
      );

  @override
  Future<LiveSession> liveSession({required String hallId}) async => LiveSession(
        session: MilkingSession(id: 's1', hallId: hallId, status: 'active'),
        updates: [_u('mock-1'), _u('mock-2')],
      );

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) =>
      Stream.fromIterable([_u('mock-1'), _u('mock-2'), _u('bilinmeyen')]);

  @override
  Future<List<Species>> species() => throw UnimplementedError('API tarafı');
  @override
  Future<List<Thresholds>> thresholds() => throw UnimplementedError('API tarafı');
  @override
  Future<List<Farm>> farms() => throw UnimplementedError('API tarafı');
  @override
  Future<List<Hall>> halls() => throw UnimplementedError('API tarafı');
  @override
  Future<List<Vacuum>> vacuums({String? hallId}) =>
      throw UnimplementedError('API tarafı');
  @override
  Future<List<Spout>> spouts({String? vacuumId}) =>
      throw UnimplementedError('API tarafı');
  @override
  Future<List<Device>> devices() => throw UnimplementedError('API tarafı');
  @override
  Future<List<Animal>> animals() => throw UnimplementedError('API tarafı');
}

void main() {
  ApiWithMockLiveRepository build() =>
      ApiWithMockLiveRepository(api: _FakeApi(), live: _FakeLive());

  test('referans verisi API tarafına, canlı akış mock tarafına gider', () async {
    // _FakeApi.liveSession ve _FakeLive.species çağrılırsa fırlatıyor;
    // yönlendirme ters olsaydı bu test patlardı.
    final repo = build();

    expect(await repo.species(), isEmpty);
    expect(await repo.halls(), isEmpty);
    expect((await repo.liveSession(hallId: 'A')).session.id, 's1');
  });

  test('mock nokta kimlikleri seçili bölgenin GERÇEK noktalarına eşlenir', () async {
    // Ekran, noktayı gerçek listede arayıp ünite adı ve pozisyonu oradan
    // yazıyor. Eşleme olmasaydı mock kimlikler hiçbir bölgede tutmaz ve
    // kart başlıkları "B-1 · Nokta 1" yerine yalnızca "Nokta" olurdu.
    final repo = build();

    final live = await repo.liveSession(hallId: 'B');

    expect(live.updates.map((u) => u.spoutId), ['B-v1-s1', 'B-v1-s2']);
  });

  test('eşleme bölge değişince YENİLENİR', () async {
    final repo = build();

    await repo.liveSession(hallId: 'A');
    final b = await repo.liveSession(hallId: 'B');

    expect(b.updates.first.spoutId, 'B-v1-s1',
        reason: 'A\'nın eşlemesi B\'ye sızmamalı');
  });

  test('canlı akış da aynı eşlemeden geçer', () async {
    // liveSession ile watchSession farklı eşleme kullansaydı ilk yükleme
    // doğru, sonraki güncellemeler yanlış noktaya düşerdi.
    final repo = build();
    await repo.liveSession(hallId: 'B');

    final ids = await repo.watchSession('s1').map((u) => u.spoutId).toList();

    expect(ids, ['B-v1-s1', 'B-v1-s2', 'bilinmeyen'],
        reason: 'eşlemede olmayan kimlik OLDUĞU GİBİ geçmeli, düşürülmemeli');
  });
}
