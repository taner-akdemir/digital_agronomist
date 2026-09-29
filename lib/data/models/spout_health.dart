import 'package:freezed_annotation/freezed_annotation.dart';

part 'spout_health.freezed.dart';
part 'spout_health.g.dart';

/// Nokta sağlığı (backend ADR 0113): noktanın son 7 günlük ortalama debisi
/// ve ünitesinin diğer noktalarıyla farkı. `low`: ünite ortancasının
/// %70'inin altında — ekipman işareti (başlık, pulsatör, hortum). Kararı
/// SUNUCU verir; `unitMedian` null ise karşılaştırma yapılamadı.
@freezed
abstract class SpoutHealth with _$SpoutHealth {
  const factory SpoutHealth({
    required String spoutId,
    @Default(0) int milkings,
    @Default(0) int animals,
    @Default(0) double avgFlow,
    double? unitMedian,
    @Default(0) double diffPct,
    @Default(false) bool low,
  }) = _SpoutHealth;

  factory SpoutHealth.fromJson(Map<String, dynamic> json) =>
      _$SpoutHealthFromJson(json);
}
