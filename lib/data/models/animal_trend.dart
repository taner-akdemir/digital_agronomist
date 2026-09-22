import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/domain/yield_class.dart';

part 'animal_trend.freezed.dart';
part 'animal_trend.g.dart';

/// `GET /animals/{id}/trend` yanıtı: 7/30 gün hareketli ortalama, eğim ve
/// sınıf (§6.4, §8.5).
///
/// Hesabı analytics'in günlük cron'u yapar; uygulama hesaplamaz. Eğim ve
/// sınıfın uygulamada yeniden türetilmesi, iki tarafın farklı gün sayılarını
/// kullanıp farklı sonuç göstermesi demekti.
@freezed
abstract class AnimalTrend with _$AnimalTrend {
  const factory AnimalTrend({
    required String animalId,
    @Default(YieldClass.normal)
    @JsonKey(unknownEnumValue: YieldClass.normal)
    YieldClass yieldClass,

    /// 7 ve 30 günlük hareketli ortalama, GÜNLÜK toplam mL.
    @Default(0) int ma7Ml,
    @Default(0) int ma30Ml,

    /// Günlük değişim eğimi, mL/gün. Negatif = düşüş (§8.4 trend_slope).
    @Default(0) double trendSlope,

    /// Günlük seri — grafiğin veri kaynağı. Eskiden yeniye sıralı.
    @Default(<AnimalDailyStat>[]) List<AnimalDailyStat> daily,
  }) = _AnimalTrend;

  factory AnimalTrend.fromJson(Map<String, dynamic> json) =>
      _$AnimalTrendFromJson(json);
}

/// Bir hayvanın bir günü (§8.4 animal_daily_stats).
@freezed
abstract class AnimalDailyStat with _$AnimalDailyStat {
  const factory AnimalDailyStat({
    required DateTime date,
    @Default(0) int totalMl,
    @Default(0) int milkingCount,

    /// O güne kadarki hareketli ortalamalar; serinin başında veri yetmediği
    /// için null olabilir.
    int? ma7Ml,
    int? ma30Ml,
  }) = _AnimalDailyStat;

  factory AnimalDailyStat.fromJson(Map<String, dynamic> json) =>
      _$AnimalDailyStatFromJson(json);
}
