// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milking_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MilkingSchedule _$MilkingScheduleFromJson(Map<String, dynamic> json) =>
    _MilkingSchedule(
      morningAt: json['morningAt'] as String? ?? '',
      eveningAt: json['eveningAt'] as String? ?? '',
      graceMinutes: (json['graceMinutes'] as num?)?.toInt() ?? 45,
    );

Map<String, dynamic> _$MilkingScheduleToJson(_MilkingSchedule instance) =>
    <String, dynamic>{
      'morningAt': instance.morningAt,
      'eveningAt': instance.eveningAt,
      'graceMinutes': instance.graceMinutes,
    };
