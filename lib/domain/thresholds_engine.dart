import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/domain/flow_color.dart';

/// §6.2 / §6.3 renk kurallarının Dart aynası.
///
/// BU KURALLARIN SAHİBİ BACKEND'DİR. `spout.update` payload'ı `flowColor` ve
/// `yieldColor` taşır ve uygulama normalde ONU kullanır. Burası yalnızca üç
/// durumda çalışır:
///   1. mock modda (backend yok),
///   2. payload bu alanları taşımıyorsa (eski sürüm),
///   3. iki WebSocket karesi arasında ara değer çizilirken.
///
/// Telefonun rengi kendi başına hesaplaması TEK BAŞINA doğru olmaz: eski bir
/// uygulama sürümü, az önce aldığı push uyarısıyla çelişen bir renk çizerdi.
///
/// İki taraf `test/fixtures/color_cases.json` ile kilitlidir; o dosya
/// `common/milkrules/testdata/color_cases.json`'ın bayt-birebir kopyasıdır.
abstract final class ThresholdsEngine {
  /// Sağımın "bitiş fazı" sayıldığı kümülatif hacim oranı (§6.2).
  static const double endPhaseRatio = 0.85;

  /// Mock modda kullanılan inek varsayılanları (§6.5).
  static const Thresholds cowDefaults = Thresholds(
    speciesId: '',
    flowLow: 1.0,
    flowHigh: 2.5,
    yieldGreenPct: 90,
    yieldRedPct: 60,
    rampUpSec: 60,
    alertHoldSec: 30,
    endFlowThreshold: 0.2,
    endGraceSec: 10,
    dryOffDailyMl: 8000,
    highYieldDailyMl: 30000,
  );

  /// Anlık debinin rengi (§6.2).
  ///
  /// Öncelik sırası ÖNEMLİDİR:
  ///   1. pasif durum -> gri
  ///   2. eşik karşılaştırması
  ///   3. ısınma süresinde kırmızı SARIya bastırılır
  ///   4. bitiş fazında (hacim >= %85 beklenen) kırmızı SARIya bastırılır
  ///
  /// 3 ve 4 olmadan her sağım kırmızı başlar ve kırmızı biterdi: sağımın
  /// başında akış doğal olarak yükselir, sonunda doğal olarak düşer.
  /// Bastırma yeşile DEĞİL sarıya yapılır — durum hâlâ izlenmeye değer.
  static MilkColor flowColor({
    required double flowLpm,
    required int elapsedSec,
    required int volumeMl,
    required int expectedMl,
    required bool attached,
    required bool animalAssigned,
    required Thresholds t,
  }) {
    if (!attached || !animalAssigned || flowLpm <= 0) return MilkColor.grey;

    if (flowLpm >= t.flowHigh) return MilkColor.green;
    if (flowLpm >= t.flowLow) return MilkColor.yellow;

    if (elapsedSec < t.rampUpSec) return MilkColor.yellow;
    if (expectedMl > 0 && volumeMl >= endPhaseRatio * expectedMl) {
      return MilkColor.yellow;
    }
    return MilkColor.red;
  }

  /// Verilen sütün beklenene oranı, YÜZDE.
  ///
  /// Üst sınır uygulanmaz: hayvan beklenenin üstünde süt verebilir ve bunu
  /// %100'e kırpmak bilgi kaybı olur. İlerleme çubuğunu kırpmak UI'ın işidir.
  static double yieldPct(int volumeMl, int expectedMl) {
    if (expectedMl == 0) return 0;
    return volumeMl / expectedMl * 100;
  }

  /// Oturum veriminin rengi (§6.3).
  ///
  /// Beklenti yoksa GRİ: %0 kırmızısı yanlış alarm olurdu.
  static MilkColor yieldColor(int volumeMl, int expectedMl, Thresholds t) {
    if (expectedMl == 0) return MilkColor.grey;

    final pct = yieldPct(volumeMl, expectedMl);
    if (pct >= t.yieldGreenPct) return MilkColor.green;
    if (pct >= t.yieldRedPct) return MilkColor.yellow;
    return MilkColor.red;
  }
}
