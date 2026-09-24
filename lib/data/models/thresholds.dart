import 'package:freezed_annotation/freezed_annotation.dart';

part 'thresholds.freezed.dart';
part 'thresholds.g.dart';

/// Bir türün renk ve uyarı eşikleri (§6.5, §8.4 species_thresholds).
///
/// Bu değerler §6.5'te "tahmini başlangıç değerleri" olarak işaretlidir; ırk,
/// laktasyon dönemi ve işletmeye göre çok değişir ve saha verisiyle kalibre
/// edilmelidir. Arayüzde kullanıcıya bu not gösterilmelidir.
@freezed
abstract class Thresholds with _$Thresholds {
  const factory Thresholds({
    required String speciesId,

    /// Altında debi kırmızı (L/dk).
    required double flowLow,

    /// Üstünde debi yeşil (L/dk).
    required double flowHigh,
    @Default(90) double yieldGreenPct,
    @Default(60) double yieldRedPct,

    /// Sağım başından sonraki ısınma süresi; bu sürede kırmızı üretilmez.
    @Default(60) int rampUpSec,

    /// Kırmızı durumun uyarıya dönüşmesi için sürmesi gereken süre.
    @Default(30) int alertHoldSec,
    @Default(0.2) double endFlowThreshold,
    @Default(10) int endGraceSec,
    @Default(0) int dryOffDailyMl,
    @Default(0) int highYieldDailyMl,

    /// Hayvanın GEÇMİŞİ YOKKEN beklenen sağım hacmi, mL (§6.3). Kaydetmede
    /// GÖNDERİLMELİ: backend sıfırı reddediyor.
    @Default(0) int expectedPerMilkingMl,

    /// false: işletme kendi eşiğini tanımlamamış, platform varsayılanı.
    @Default(false) bool tenantScoped,

    /// Sınıflandırma kuralları (§6.4, backend ADR 0054). Varsayılanlar
    /// backend'inkilerle aynı.
    ///
    /// 7 günlük ortalama 30 günlüğe göre yüzde kaç düşünce "düşüşte".
    @Default(20) int declinePct,

    /// Bu değerin altındaki sağım boş sayılır (mL).
    @Default(100) int noMilkMl,

    /// Son kaç sağımın hepsi boşsa "süt vermiyor".
    @Default(4) int noMilkMilkings,
  }) = _Thresholds;

  factory Thresholds.fromJson(Map<String, dynamic> json) =>
      _$ThresholdsFromJson(json);
}
