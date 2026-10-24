// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityDevice _$ActivityDeviceFromJson(Map<String, dynamic> json) =>
    _ActivityDevice(
      id: json['id'] as String,
      serial: json['serial'] as String? ?? '',
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
    );

Map<String, dynamic> _$ActivityDeviceToJson(_ActivityDevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serial': instance.serial,
      'lastSeen': instance.lastSeen?.toIso8601String(),
    };

_ActivityHour _$ActivityHourFromJson(Map<String, dynamic> json) =>
    _ActivityHour(
      hour: DateTime.parse(json['hour'] as String),
      steps: (json['steps'] as num?)?.toInt(),
      activityIndex: (json['activityIndex'] as num?)?.toDouble(),
      ruminationMin: (json['ruminationMin'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ActivityHourToJson(_ActivityHour instance) =>
    <String, dynamic>{
      'hour': instance.hour.toIso8601String(),
      'steps': instance.steps,
      'activityIndex': instance.activityIndex,
      'ruminationMin': instance.ruminationMin,
    };

_ActivityDay _$ActivityDayFromJson(Map<String, dynamic> json) => _ActivityDay(
  day: DateTime.parse(json['day'] as String),
  steps: (json['steps'] as num?)?.toInt(),
  activityIndex: (json['activityIndex'] as num?)?.toDouble(),
  ruminationMin: (json['ruminationMin'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ActivityDayToJson(_ActivityDay instance) =>
    <String, dynamic>{
      'day': instance.day.toIso8601String(),
      'steps': instance.steps,
      'activityIndex': instance.activityIndex,
      'ruminationMin': instance.ruminationMin,
    };

_AnimalActivity _$AnimalActivityFromJson(Map<String, dynamic> json) =>
    _AnimalActivity(
      animalId: json['animalId'] as String,
      device: json['device'] == null
          ? null
          : ActivityDevice.fromJson(json['device'] as Map<String, dynamic>),
      hourly:
          (json['hourly'] as List<dynamic>?)
              ?.map((e) => ActivityHour.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      daily:
          (json['daily'] as List<dynamic>?)
              ?.map((e) => ActivityDay.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: json['status'] as String? ?? 'no_data',
    );

Map<String, dynamic> _$AnimalActivityToJson(_AnimalActivity instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'device': instance.device,
      'hourly': instance.hourly,
      'daily': instance.daily,
      'status': instance.status,
    };

_ActivityOverviewRow _$ActivityOverviewRowFromJson(Map<String, dynamic> json) =>
    _ActivityOverviewRow(
      animalId: json['animalId'] as String,
      tag: json['tag'] as String? ?? '',
      name: json['name'] as String?,
      serial: json['serial'] as String? ?? '',
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      risePct: (json['risePct'] as num?)?.toDouble(),
      status: json['status'] as String? ?? 'no_data',
      lastHeatDetectedAt: json['lastHeatDetectedAt'] == null
          ? null
          : DateTime.parse(json['lastHeatDetectedAt'] as String),
    );

Map<String, dynamic> _$ActivityOverviewRowToJson(
  _ActivityOverviewRow instance,
) => <String, dynamic>{
  'animalId': instance.animalId,
  'tag': instance.tag,
  'name': instance.name,
  'serial': instance.serial,
  'lastSeen': instance.lastSeen?.toIso8601String(),
  'risePct': instance.risePct,
  'status': instance.status,
  'lastHeatDetectedAt': instance.lastHeatDetectedAt?.toIso8601String(),
};
