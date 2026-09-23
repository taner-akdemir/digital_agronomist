import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/flow_color.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRepository repo;
  setUp(() => repo = MockRepository(latency: Duration.zero));

  test('tesis hiyerarşisi okunur', () async {
    expect(await repo.farms(), hasLength(1));
    expect(await repo.halls(), hasLength(3));
    expect(await repo.spouts(), hasLength(30));
    expect(await repo.animals(), hasLength(30));
  });

  test('bölgeye göre ünite filtresi çalışır', () async {
    final halls = await repo.halls();
    for (final h in halls) {
      final vacuums = await repo.vacuums(hallId: h.id);
      expect(vacuums, isNotEmpty, reason: '${h.name} bölgesinde ünite yok');
      for (final v in vacuums) {
        expect(v.hallId, h.id);
      }
    }
  });

  test('üniteye göre nokta filtresi çalışır', () async {
    final vacuums = await repo.vacuums();
    var total = 0;
    for (final v in vacuums) {
      final spouts = await repo.spouts(vacuumId: v.id);
      expect(spouts, hasLength(v.totalSpouts));
      total += spouts.length;
    }
    expect(total, 30);
  });

  test('canlı oturum dört rengi de içerir', () async {
    final halls = await repo.halls();
    final live = await repo.liveSession(hallId: halls.first.id);

    expect(live.updates, hasLength(10));
    final colors = live.updates.map((u) => u.flowColor).toSet();
    expect(
      colors,
      containsAll([
        MilkColor.green,
        MilkColor.yellow,
        MilkColor.red,
        MilkColor.grey,
      ]),
    );
  });

  test('canlı akış hacmi biriktirir ve rengi günceller', () async {
    final halls = await repo.halls();
    final live = await repo.liveSession(hallId: halls.first.id);

    final first = live.updates.firstWhere((u) => u.state == SpoutState.milking);
    final updates = <SpoutUpdate>[];

    await for (final u in repo.watchSession(live.session.id)) {
      if (u.spoutId == first.spoutId) {
        updates.add(u);
        if (updates.length >= 2) break;
      }
    }

    expect(
      updates.first.volumeMl,
      greaterThan(first.volumeMl),
      reason: 'sağım sürdükçe hacim artmalı',
    );
    expect(updates[1].volumeMl, greaterThan(updates.first.volumeMl));
  });

  test('ısınma fazındaki nokta akışta da kırmızıya düşmez', () async {
    // §6.2: sağımın ilk rampUpSec saniyesinde düşük debi KIRMIZI DEĞİLDİR;
    // sağım başında akış zaten doğal olarak düşüktür.
    //
    // Bu test bir regresyonu kilitliyor: mock akışı başta geçen süreyi
    // takip etmiyordu ve sabit bir değer veriyordu, bu yüzden ısınmadaki
    // nokta ilk güncellemeden sonra kırmızıya dönüyordu.
    final halls = await repo.halls();
    final live = await repo.liveSession(hallId: halls.first.id);

    final rampUp = live.updates.firstWhere(
      (u) => u.flowColor == MilkColor.yellow && u.flowRate < 0.5,
      orElse: () => throw StateError('fixture ısınma senaryosu içermiyor'),
    );

    var seen = 0;
    await for (final u in repo.watchSession(live.session.id)) {
      if (u.spoutId != rampUp.spoutId) continue;
      expect(
        u.flowColor,
        isNot(MilkColor.red),
        reason: 'ısınma süresi dolmadan kırmızı üretilmemeli',
      );
      if (++seen >= 3) break;
    }
  });

  test(
    'sonuçlar önbelleğe alınır, her çağrıda yeniden parse edilmez',
    () async {
      final a = await repo.halls();
      final b = await repo.halls();
      expect(identical(a, b), isTrue);
    },
  );
}
