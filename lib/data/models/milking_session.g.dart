// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milking_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MilkingSession _$MilkingSessionFromJson(Map<String, dynamic> json) =>
    _MilkingSession(
      id: json['id'] as String,
      hallId: json['hallId'] as String,
      type: json['type'] as String? ?? 'morning',
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      status: json['status'] as String? ?? 'active',
    );

Map<String, dynamic> _$MilkingSessionToJson(_MilkingSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hallId': instance.hallId,
      'type': instance.type,
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'status': instance.status,
    };

_LiveSession _$LiveSessionFromJson(Map<String, dynamic> json) => _LiveSession(
  session: MilkingSession.fromJson(json['session'] as Map<String, dynamic>),
  updates:
      (json['updates'] as List<dynamic>?)
          ?.map((e) => SpoutUpdate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SpoutUpdate>[],
);

Map<String, dynamic> _$LiveSessionToJson(_LiveSession instance) =>
    <String, dynamic>{'session': instance.session, 'updates': instance.updates};
