import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/yield_class.dart';

/// Sabit bir "bugün": üretilen seri tarihe bağlı, gerçek tarihle beklenen
/// değerler her gün kayardı.
final _today = DateTime(2026, 9, 22);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRepository repo;
  setUp(() => repo = MockRepository(latency: Duration.zero, today: _today));

  Future<Animal> animalOf(YieldClass c) async =>
      (await repo.animals()).firstWhere((a) => a.yieldClass == c);

  // Üretimin DETERMİNİSTİK olduğunu doğrular.
  //
  // Rastgele olsaydı ekranı her yenileyiş farklı bir geçmiş çizer ve
  // "bu grafik neden böyle?" sorusu hiç cevaplanamazdı.
  test('aynı hayvan her çağrıda aynı seriyi verir', () async {
    final a = await animalOf(YieldClass.normal);

    final first = await repo.animalTrend(a.id);
    final second =
        await MockRepository(latency: Duration.zero, today: _today).animalTrend(a.id);

    expect(second.daily.map((d) => d.totalMl), first.daily.map((d) => d.totalMl));
  });

  // Sınıf ile GRAFİĞİN birbirini tuttuğunu doğrular (§6.4).
  //
  // Rozet "Yüksek Verimli" derken 7 gün ortalaması tür üst eşiğinin altında
  // kalsaydı, ekran kendi kendisiyle çelişirdi.
  test('yüksek verimli hayvanın 7 gün ortalaması üst eşiğin üstünde', () async {
    final a = await animalOf(YieldClass.high);
    final t = (await repo.thresholds()).firstWhere((x) => x.speciesId == a.speciesId);

    expect((await repo.animalTrend(a.id)).ma7Ml, greaterThan(t.highYieldDailyMl));
  });

  test('kuruya çıkma adayının 7 gün ortalaması alt eşiğin altında', () async {
    final a = await animalOf(YieldClass.dryOffCandidate);
    final t = (await repo.thresholds()).firstWhere((x) => x.speciesId == a.speciesId);

    expect((await repo.animalTrend(a.id)).ma7Ml, lessThan(t.dryOffDailyMl));
  });

  test('süt vermeyen hayvanın ortalaması sıfıra yakın', () async {
    final a = await animalOf(YieldClass.noMilk);
    final t = (await repo.thresholds()).firstWhere((x) => x.speciesId == a.speciesId);

    expect((await repo.animalTrend(a.id)).ma7Ml, lessThan(t.dryOffDailyMl ~/ 10));
  });

  // DÜŞÜŞTE olan hayvanın eğiminin NEGATİF olduğunu doğrular.
  //
  // Wood eğrisinin doğal inişi §6.4'ün "30 günde belirgin düşüş" eşiğini tek
  // başına geçmiyordu; sınıf ile eğim ayrı yönlere bakıyordu.
  test('düşüşteki hayvanın eğimi negatif', () async {
    final a = await animalOf(YieldClass.declining);

    expect((await repo.animalTrend(a.id)).trendSlope, lessThan(0));
  });

  test('trend 90 günlük seri döndürür ve hareketli ortalamalar doludur', () async {
    final trend = await repo.animalTrend((await animalOf(YieldClass.normal)).id);

    expect(trend.daily, hasLength(90));
    expect(trend.daily.first.date.isBefore(trend.daily.last.date), isTrue,
        reason: 'seri eskiden yeniye sıralı olmalı');
    expect(trend.daily.map((d) => d.ma30Ml), everyElement(isNotNull),
        reason: '30 gün ısınma üretildiği için ilk gün de dolu olmalı');
  });

  // Geçmişin YENİDEN ESKİYE sıralı geldiğini doğrular: son sağım en üstte.
  test('geçmiş yeniden eskiye sıralıdır ve günde iki sağım vardır', () async {
    final history = await repo.animalHistory((await animalOf(YieldClass.normal)).id);

    expect(history, hasLength(90 * 2));
    expect(history.first.startedAt!.isAfter(history.last.startedAt!), isTrue);
    expect(history.first.sessionType, 'morning');
    expect(history[1].sessionType, 'evening');
  });

  // Sabah sağımının akşamdan yüksek olduğunu doğrular (§6.3).
  //
  // 50/50 bölünseydi oturum tipi ayrımı anlamsız kalırdı.
  test('sabah sağımı akşamdan yüksektir', () async {
    final history = await repo.animalHistory((await animalOf(YieldClass.normal)).id);

    expect(history.first.volumeMl, greaterThan(history[1].volumeMl));
  });

  // Beklenen verimin ÖNCEKİ günlerden geldiğini doğrular (§6.3).
  //
  // O günün kendisi dahil edilseydi hayvan kendi sonucuyla kıyaslanır ve
  // her sağım yeşil çıkardı — renk bandı hiç çalışmazdı.
  test('beklenen verim o günün kendi sonucu değildir', () async {
    final history = await repo.animalHistory((await animalOf(YieldClass.declining)).id);

    expect(history.map((m) => m.expectedMl == m.volumeMl), anyElement(isFalse));
    expect(history.first.expectedMl, greaterThan(history.first.volumeMl),
        reason: 'düşüşteki hayvan beklenenin altında kalmalı');
  });

  test('tarih aralığı filtresi uygulanır', () async {
    final a = await animalOf(YieldClass.normal);
    final from = _today.subtract(const Duration(days: 6));

    final history = await repo.animalHistory(a.id, from: from);

    expect(history, hasLength(7 * 2));
    expect(history.every((m) => !m.startedAt!.isBefore(from)), isTrue);
  });

  // Keçinin İNEK eşikleriyle değerlendirilmediğini doğrular (§4).
  //
  // İnek varsayılanı herkese uygulansaydı keçilerin tamamı "süt vermiyor"
  // görünürdü: beklenen verimleri on kat farklı.
  test('keçi kendi eşikleriyle üretilir', () async {
    final species = await repo.species();
    final goatId = species.firstWhere((s) => s.code == 'goat').id;
    final goat = (await repo.animals()).firstWhere((a) => a.speciesId == goatId);
    final cow = await animalOf(YieldClass.normal);

    final goatMa = (await repo.animalTrend(goat.id)).ma7Ml;

    expect(goatMa, lessThan((await repo.animalTrend(cow.id)).ma7Ml ~/ 4));
    expect(goatMa, greaterThan(0));
  });

  // Geçmiş oturum listesinin CANLI oturumla aynı kaydı gösterdiğini doğrular.
  test('oturum listesi açık oturumu en üstte ve tek kez içerir', () async {
    final live = await repo.liveSession(hallId: (await repo.halls()).first.id);
    final sessions = await repo.sessions();

    expect(sessions.first.id, live.session.id);
    expect(sessions.where((s) => s.id == live.session.id), hasLength(1));
    expect(sessions.where((s) => s.status == 'active'), hasLength(1));
  });

  test('oturum listesi bölgeye göre filtrelenir', () async {
    final hall = (await repo.halls()).last;

    final sessions = await repo.sessions(hallId: hall.id);

    expect(sessions, isNotEmpty);
    expect(sessions.every((s) => s.hallId == hall.id), isTrue);
  });

  // Dashboard'un GÜN ORTASINDA doğru saydığını doğrular.
  //
  // Akşam sağımı henüz olmadan toplama girerse, sabah 8'de bakan kullanıcı
  // günün sonundaki rakamı görür ve "bu süt nerede?" diye sorar.
  group('dashboard', () {
    // Öğlen: sabah sağımı olmuş, akşam sağımı olmamış.
    final noon = DateTime(2026, 9, 22, 12);
    late MockRepository repo;
    setUp(() => repo = MockRepository(latency: Duration.zero, today: noon));

    test('yalnızca yapılmış sağımlar toplanır', () async {
      final d = await repo.dashboard();

      expect(d.milkingCount, d.animalCount,
          reason: 'öğlen her hayvanın yalnızca sabah sağımı olmalı');
      expect(d.totalMl, greaterThan(0));
    });

    test('toplam, hayvanların geçmişiyle tutarlıdır', () async {
      final animals = await repo.animals();

      var expected = 0;
      for (final a in animals) {
        final today = await repo.animalHistory(a.id,
            from: DateTime(noon.year, noon.month, noon.day));
        for (final m in today) {
          if (m.startedAt!.isBefore(noon)) expected += m.volumeMl;
        }
      }

      expect((await repo.dashboard()).totalMl, expected);
    });

    test('gün başında henüz sağım yoktur', () async {
      final midnight = MockRepository(
          latency: Duration.zero, today: DateTime(2026, 9, 22));

      final d = await midnight.dashboard();

      expect(d.totalMl, 0);
      expect(d.bySpecies, isEmpty);
    });

    // Sayısı SIFIR olan sınıfın da döndüğünü doğrular: ekran "bu sınıfta
    // hiç yok" ile "bu sınıf hiç hesaplanmadı"yı ayırabilmeli.
    test('sınıf dağılımı tüm sınıfları ve toplam sürüyü kapsar', () async {
      final d = await repo.dashboard();

      expect(d.classDistribution.map((c) => c.yieldClass),
          containsAll(YieldClass.values));
      expect(d.classDistribution.fold(0, (a, c) => a + c.count),
          (await repo.animals()).length);
    });

    test('tür dağılımı üç türü de içerir', () async {
      final d = await repo.dashboard();

      expect(d.bySpecies, hasLength(3));
      expect(d.bySpecies.every((s) => s.animalCount == 10), isTrue);
    });

    test('açık uyarı sayısı uyarı listesiyle aynıdır', () async {
      final open =
          (await repo.alerts()).where((a) => !a.isAcknowledged).length;

      expect((await repo.dashboard()).openAlerts, open);
    });

    test('açık oturum sayılır', () async {
      expect((await repo.dashboard()).activeSessions, 1);
    });
  });
}
