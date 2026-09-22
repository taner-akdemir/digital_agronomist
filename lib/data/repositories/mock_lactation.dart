import 'dart:math';

import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/domain/thresholds_engine.dart';
import 'package:milktrace/domain/yield_class.dart';

/// Mock geçmiş ve trend üreteci.
///
/// NEDEN ASSET DEĞİL: diğer mock verileri (`animals.json`, `halls.json`)
/// elle yazılmış JSON'lar. Burada 30 hayvan × 90 gün × 2 sağım = 5400 kayıt
/// var; elle tutulamaz, gözden geçirilemez ve her tarih değişiminde bayatlar.
/// Simülatör de aynı işi backend tarafında yapıyor (§10) — burada onun
/// küçültülmüş hâli var.
///
/// Üretim DETERMİNİSTİKTİR: tohum hayvan kimliğinden gelir, yani aynı hayvan
/// her açılışta aynı grafiği gösterir. Rastgele olsaydı ekranı her yenileyiş
/// farklı bir geçmiş çizer ve hata ayıklamak imkânsızlaşırdı.
///
/// Şekil §10'daki Wood laktasyon eğrisidir: `y = a·t^b·e^(−ct)`. Düz çizgi
/// çizmek, trend ekranının asıl işini — yükselen ve düşen bir eğriyi okumayı
/// — göstermezdi.
abstract final class MockLactation {
  /// Grafikte gösterilen gün sayısı.
  static const int windowDays = 90;

  /// Hareketli ortalamaların ilk günden itibaren dolu olması için önden
  /// üretilen ek gün sayısı. 30 günlük ortalama 30 gün geçmiş ister.
  static const int _warmupDays = 30;

  static const double _b = 0.20;
  static const double _c = 0.004;

  /// Wood eğrisinin laktasyon gününe göre normalize edilmemiş değeri.
  static double _wood(int lactationDay) {
    final t = lactationDay.clamp(1, 400).toDouble();
    return pow(t, _b).toDouble() * exp(-_c * t);
  }

  /// Bir günün toplam hacmi, mL.
  ///
  /// Bugünkü seviye SINIFA sabitlenir, geçmiş günler eğrinin bugüne oranıyla
  /// türetilir. Tersi yapılsaydı — mutlak eğri değeri kullanılsaydı —
  /// laktasyonun ilerisindeki "yüksek verimli" bir hayvanın 7 gün ortalaması
  /// tür üst eşiğinin altına düşer ve rozetiyle çelişirdi (§6.4).
  static int _dailyMl({
    required DateTime day,
    required DateTime today,
    required int lactationDayToday,
    required double level,
    required YieldClass yieldClass,
    required Random random,
  }) {
    final back = today.difference(day).inDays;
    final t = lactationDayToday - back;
    if (t < 1) return 0;

    final ratio = (_wood(t) / _wood(lactationDayToday)).clamp(0.30, 2.50);

    // Düşüşte olan hayvanın son 30 günü ayrıca aşağı çekilir: Wood eğrisinin
    // doğal inişi §6.4'ün "30 günde belirgin düşüş" eşiğini tek başına
    // geçmiyor, yani sınıf ile grafik birbirini tutmuyordu.
    final decline = yieldClass == YieldClass.declining && back < 30
        ? 0.55 + 0.45 * (back / 30)
        : 1.0;

    final jitter = 0.93 + random.nextDouble() * 0.14;
    return (level * ratio * decline * jitter).round();
  }

  /// Sınıfın bugünkü günlük seviyesi, mL.
  ///
  /// Eşiklerden TÜRETİLİR, sabit yazılmaz: keçi ve koyun için ayrı sayı
  /// tutmak, §6.5'teki tablo değişince üç yerde güncelleme demekti.
  static double _levelFor(YieldClass c, Thresholds t) {
    final high = t.highYieldDailyMl.toDouble();
    final dry = t.dryOffDailyMl.toDouble();
    final normal = (high + dry) / 2;

    return switch (c) {
      YieldClass.high => high * 1.15,
      YieldClass.normal => normal,
      YieldClass.declining => normal * 0.95,
      YieldClass.dryOffCandidate => dry * 0.80,
      YieldClass.noMilk => dry * 0.02,
    };
  }

  /// Hayvanın bugünkü laktasyon günü.
  ///
  /// Buzağılama tarihi yoksa 120'ye düşer: eğrinin tepe noktasından sonraki,
  /// "sürünün çoğu burada" sayılabilecek bir gün.
  static int _lactationDay(Animal animal, DateTime today) {
    final calving = animal.lastCalvingDate;
    if (calving == null) return 120;
    final days = today.difference(calving).inDays;
    return days < 1 ? 1 : days;
  }

  /// Günlük toplamlar, eskiden yeniye. Uzunluğu [windowDays] + [_warmupDays].
  static List<int> _series(Animal animal, Thresholds t, DateTime today) {
    final random = Random(animal.id.hashCode);
    final level = _levelFor(animal.yieldClass, t);
    final lactationDayToday = _lactationDay(animal, today);
    const total = windowDays + _warmupDays;

    return [
      for (var i = total - 1; i >= 0; i--)
        _dailyMl(
          day: today.subtract(Duration(days: i)),
          today: today,
          lactationDayToday: lactationDayToday,
          level: level,
          yieldClass: animal.yieldClass,
          random: random,
        ),
    ];
  }

  /// Son [n] günün ortalaması, mL. Veri yetmiyorsa null.
  static int? _movingAverage(List<int> series, int endIndex, int n) {
    if (endIndex + 1 < n) return null;
    var sum = 0;
    for (var i = endIndex - n + 1; i <= endIndex; i++) {
      sum += series[i];
    }
    return (sum / n).round();
  }

  /// Son 30 günün en küçük kareler eğimi, mL/gün (§8.4 trend_slope).
  static double _slope(List<int> series) {
    const n = 30;
    final start = series.length - n;
    const meanX = (n - 1) / 2;
    final meanY = series.sublist(start).reduce((a, b) => a + b) / n;

    var num = 0.0;
    var den = 0.0;
    for (var i = 0; i < n; i++) {
      final dx = i - meanX;
      num += dx * (series[start + i] - meanY);
      den += dx * dx;
    }
    return den == 0 ? 0 : num / den;
  }

  /// `GET /animals/{id}/trend` yanıtının mock karşılığı.
  static AnimalTrend trend(Animal animal, Thresholds t, DateTime today) {
    final series = _series(animal, t, today);
    final last = series.length - 1;

    final daily = <AnimalDailyStat>[
      for (var i = _warmupDays; i < series.length; i++)
        AnimalDailyStat(
          date: today.subtract(Duration(days: series.length - 1 - i)),
          totalMl: series[i],
          milkingCount: series[i] > 0 ? 2 : 0,
          ma7Ml: _movingAverage(series, i, 7),
          ma30Ml: _movingAverage(series, i, 30),
        ),
    ];

    return AnimalTrend(
      animalId: animal.id,
      yieldClass: animal.yieldClass,
      ma7Ml: _movingAverage(series, last, 7) ?? 0,
      ma30Ml: _movingAverage(series, last, 30) ?? 0,
      trendSlope: _slope(series),
      daily: daily,
    );
  }

  /// Sabah sağımının günlük toplamdaki payı.
  ///
  /// Sabah sağımı akşamdan düzenli olarak yüksektir (§6.3); 50/50 bölmek
  /// oturum tipi ayrımını anlamsız kılardı.
  static const double _morningShare = 0.55;

  /// `GET /animals/{id}/history` yanıtının mock karşılığı.
  ///
  /// Yeniden eskiye sıralı — geçmiş listesinde son sağım en üstte.
  static List<AnimalMilking> history(
    Animal animal,
    Thresholds t,
    DateTime today, {
    DateTime? from,
    DateTime? to,
  }) {
    final series = _series(animal, t, today);
    final out = <AnimalMilking>[];

    for (var i = series.length - 1; i >= _warmupDays; i--) {
      final day = today.subtract(Duration(days: series.length - 1 - i));
      if (from != null && day.isBefore(from)) continue;
      if (to != null && day.isAfter(to)) continue;
      if (series[i] == 0) continue;

      // Beklenen verim, ÖNCEKİ 7 günün ortalamasıdır (§6.3) — o günün
      // kendisi dahil edilseydi hayvan kendi sonucuyla kıyaslanır ve her
      // sağım yeşil çıkardı.
      final expectedDaily = _movingAverage(series, i - 1, 7) ?? series[i];

      out.add(_milking(animal, t, day, series[i], expectedDaily, morning: true));
      out.add(_milking(animal, t, day, series[i], expectedDaily, morning: false));
    }
    return List.unmodifiable(out);
  }

  static AnimalMilking _milking(
    Animal animal,
    Thresholds t,
    DateTime day,
    int dailyMl,
    int expectedDailyMl, {
    required bool morning,
  }) {
    final share = morning ? _morningShare : 1 - _morningShare;
    final volumeMl = (dailyMl * share).round();
    final expectedMl = (expectedDailyMl * share).round();

    // Ortalama debi tür bandının ortası; süre buradan çıkar, tersi değil.
    // Sabit süre verilseydi az süt veren hayvan da uzun sağım görünürdü.
    final avgFlow = (t.flowLow + t.flowHigh) / 2;
    final minutes = volumeMl / (avgFlow * 1000);
    final startedAt = DateTime(day.year, day.month, day.day, morning ? 6 : 18);

    return AnimalMilking(
      id: '${animal.id}-${day.toIso8601String().substring(0, 10)}-'
          '${morning ? 'm' : 'e'}',
      sessionId: 'mock-${day.toIso8601String().substring(0, 10)}-'
          '${morning ? 'm' : 'e'}',
      animalId: animal.id,
      startedAt: startedAt,
      endedAt: startedAt.add(Duration(seconds: (minutes * 60).round())),
      volumeMl: volumeMl,
      expectedMl: expectedMl,
      avgFlow: double.parse(avgFlow.toStringAsFixed(2)),
      peakFlow: double.parse((avgFlow * 1.4).toStringAsFixed(2)),
      yieldPct: ThresholdsEngine.yieldPct(volumeMl, expectedMl),
      color: ThresholdsEngine.yieldColor(volumeMl, expectedMl, t),
      sessionType: morning ? 'morning' : 'evening',
      endReason: 'flow_stopped',
    );
  }
}
