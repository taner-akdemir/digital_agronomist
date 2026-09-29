import 'package:freezed_annotation/freezed_annotation.dart';

part 'milking_schedule.freezed.dart';
part 'milking_schedule.g.dart';

/// Sağım saatleri (backend ADR 0099): "HH:MM"; boş = o sağım yok. Saatten
/// gecikme payı kadar sonra oturumu açılmamış bölge için uyarı gelir.
@freezed
abstract class MilkingSchedule with _$MilkingSchedule {
  const factory MilkingSchedule({
    @Default('') String morningAt,
    @Default('') String eveningAt,
    @Default(45) int graceMinutes,
  }) = _MilkingSchedule;

  factory MilkingSchedule.fromJson(Map<String, dynamic> json) =>
      _$MilkingScheduleFromJson(json);
}
