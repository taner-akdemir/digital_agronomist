import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiet_hours.freezed.dart';
part 'quiet_hours.g.dart';

/// Kişinin sessiz saati (backend ADR 0107): İstanbul saatiyle gece
/// yarısından dakika; başlangıç > bitiş gece yarısını aşar (22:00–05:00).
/// Kapalıyken de sunucu varsayılan saati döner.
@freezed
abstract class QuietHours with _$QuietHours {
  const factory QuietHours({
    @Default(false) bool enabled,
    @Default(22 * 60) int startMinute,
    @Default(5 * 60) int endMinute,
  }) = _QuietHours;

  factory QuietHours.fromJson(Map<String, dynamic> json) =>
      _$QuietHoursFromJson(json);
}
