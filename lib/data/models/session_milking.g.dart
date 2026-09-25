// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_milking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionMilking _$SessionMilkingFromJson(Map<String, dynamic> json) =>
    _SessionMilking(
      animalId: json['animalId'] as String,
      earTag: json['earTag'] as String,
      spoutId: json['spoutId'] as String?,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      volumeMl: (json['volumeMl'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SessionMilkingToJson(_SessionMilking instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'earTag': instance.earTag,
      'spoutId': instance.spoutId,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'volumeMl': instance.volumeMl,
    };
