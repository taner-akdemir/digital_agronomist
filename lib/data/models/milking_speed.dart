import 'package:freezed_annotation/freezed_annotation.dart';

part 'milking_speed.freezed.dart';
part 'milking_speed.g.dart';

/// Sağım hızı (backend ADR 0125, `GET /milking-speed`): hayvanın son 30
/// günlük bitmiş sağımlarından ortalama debi, ortalama tepe debi, ortalama
/// süre ve AYNI TÜRÜN sürü ortalaması. `slow` (en az 10 sağım ve sürü
/// ortalamasının %80'inin altı) kararını SUNUCU verir.
@freezed
abstract class MilkingSpeed with _$MilkingSpeed {
  const factory MilkingSpeed({
    required String animalId,
    @Default(0) int milkings,

    /// L/dk.
    @Default(0) double avgFlow,
    @Default(0) double peakFlow,
    @Default(0) int durationSec,
    @Default(0) double herdAvgFlow,
    @Default(false) bool slow,
  }) = _MilkingSpeed;

  const MilkingSpeed._();

  /// Sürü ortalamasının yüzde kaç altında (yuvarlanmış; sürü yoksa 0).
  int get belowHerdPct =>
      herdAvgFlow <= 0 ? 0 : ((1 - avgFlow / herdAvgFlow) * 100).round();

  factory MilkingSpeed.fromJson(Map<String, dynamic> json) =>
      _$MilkingSpeedFromJson(json);
}
