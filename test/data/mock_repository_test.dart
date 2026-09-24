import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/milking_session.dart';
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

  test('elle eşleştirme tanınmayan küpe uyarısını siler', () async {
    const spout8 = '0192a1f0-0050-7000-8000-000000000008';
    final before = await repo.liveSession(hallId: 'h');
    final u = before.updates.firstWhere((u) => u.spoutId == spout8);
    expect(u.unmatchedTag, isNotNull);

    final animal = (await repo.animals()).firstWhere((a) => a.isMilking);
    await repo.assignAnimal(
      sessionId: before.session.id,
      spoutId: spout8,
      animalId: animal.id,
    );

    final after = await repo.liveSession(hallId: 'h');
    final v = after.updates.firstWhere((u) => u.spoutId == spout8);
    expect(v.animal?.id, animal.id);
    expect(v.unmatchedTag, isNull);
  });

  test(
    'eşleştirme kaldırılınca nokta boşa döner, yeniden bağlanabilir',
    () async {
      const spout1 = '0192a1f0-0050-7000-8000-000000000001';
      SpoutUpdate at(LiveSession l) =>
          l.updates.firstWhere((u) => u.spoutId == spout1);

      final before = await repo.liveSession(hallId: 'h');
      expect(at(before).animal, isNotNull);

      await repo.unassignAnimal(sessionId: before.session.id, spoutId: spout1);
      final cleared = at(await repo.liveSession(hallId: 'h'));
      expect(cleared.animal, isNull);
      expect(cleared.volumeMl, 0, reason: 'silinen sağımın ölçümü görünmez');
      expect(cleared.state, SpoutState.idle);
      expect(cleared.flowColor, MilkColor.grey);

      final animal = (await repo.animals()).firstWhere((a) => a.isMilking);
      await repo.assignAnimal(
        sessionId: before.session.id,
        spoutId: spout1,
        animalId: animal.id,
      );
      expect(at(await repo.liveSession(hallId: 'h')).animal?.id, animal.id);
    },
  );
}
