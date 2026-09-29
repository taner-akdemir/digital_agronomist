// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiet_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuietHours _$QuietHoursFromJson(Map<String, dynamic> json) => _QuietHours(
  enabled: json['enabled'] as bool? ?? false,
  startMinute: (json['startMinute'] as num?)?.toInt() ?? 22 * 60,
  endMinute: (json['endMinute'] as num?)?.toInt() ?? 5 * 60,
);

Map<String, dynamic> _$QuietHoursToJson(_QuietHours instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'startMinute': instance.startMinute,
      'endMinute': instance.endMinute,
    };
