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
  }) = _Thresholds;

  factory Thresholds.fromJson(Map<String, dynamic> json) =>
      _$ThresholdsFromJson(json);
}
