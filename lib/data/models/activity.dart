import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.freezed.dart';
part 'activity.g.dart';

/// Hayvana bağlı aktivite cihazı (tasma / pedometre, backend ADR 0145).
@freezed
abstract class ActivityDevice with _$ActivityDevice {
  const factory ActivityDevice({
    required String id,
    @Default('') String serial,
    DateTime? lastSeen,
  }) = _ActivityDevice;

  factory ActivityDevice.fromJson(Map<String, dynamic> json) =>
      _$ActivityDeviceFromJson(json);
}

/// Bir saatin aktivite toplamı. Cihaz adım göndermiyorsa yalnız endeks
/// dolu olabilir; geviş (rumination) her cihazda yok.
@freezed
abstract class ActivityHour with _$ActivityHour {
  const factory ActivityHour({
    required DateTime hour,
    int? steps,
    double? activityIndex,
    double? ruminationMin,
  }) = _ActivityHour;

  factory ActivityHour.fromJson(Map<String, dynamic> json) =>
      _$ActivityHourFromJson(json);
}

/// Bir günün (Europe/Istanbul) aktivite toplamı.
@freezed
abstract class ActivityDay with _$ActivityDay {
  const factory ActivityDay({
    required DateTime day,
    int? steps,
    double? activityIndex,
    double? ruminationMin,
  }) = _ActivityDay;

  factory ActivityDay.fromJson(Map<String, dynamic> json) =>
      _$ActivityDayFromJson(json);
}

/// `GET /activity/animals/:id` yanıtı.
@freezed
abstract class AnimalActivity with _$AnimalActivity {
  const factory AnimalActivity({
    required String animalId,

    /// Bağlı cihaz; tasma takılı değilse null.
    ActivityDevice? device,
    @Default([]) List<ActivityHour> hourly,
    @Default([]) List<ActivityDay> daily,

    /// learning | normal | rising | heat | no_data | pregnant.
    @Default('no_data') String status,
  }) = _AnimalActivity;

  const AnimalActivity._();

  /// Grafikte gösterilecek veri var mı.
  bool get hasData => hourly.isNotEmpty || daily.isNotEmpty;

  /// Herhangi bir noktada geviş verisi var mı.
  bool get hasRumination =>
      hourly.any((h) => h.ruminationMin != null) ||
      daily.any((d) => d.ruminationMin != null);

  factory AnimalActivity.fromJson(Map<String, dynamic> json) =>
      _$AnimalActivityFromJson(json);
}

/// `GET /activity/overview` satırı: cihazı bağlı bir hayvan.
@freezed
abstract class ActivityOverviewRow with _$ActivityOverviewRow {
  const factory ActivityOverviewRow({
    required String animalId,
    @Default('') String tag,
    String? name,
    @Default('') String serial,
    DateTime? lastSeen,

    /// Hayvanın kendi tabanına göre yükseliş yüzdesi; taban yoksa null.
    double? risePct,
    @Default('no_data') String status,
    DateTime? lastHeatDetectedAt,
  }) = _ActivityOverviewRow;

  factory ActivityOverviewRow.fromJson(Map<String, dynamic> json) =>
      _$ActivityOverviewRowFromJson(json);
}
