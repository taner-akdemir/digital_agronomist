// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSession _$UserSessionFromJson(Map<String, dynamic> json) => _UserSession(
  id: json['id'] as String,
  userAgent: json['userAgent'] as String? ?? '',
  ip: json['ip'] as String? ?? '',
  startedAt: json['startedAt'] == null
      ? null
      : DateTime.parse(json['startedAt'] as String),
  lastUsedAt: json['lastUsedAt'] == null
      ? null
      : DateTime.parse(json['lastUsedAt'] as String),
  current: json['current'] as bool? ?? false,
);

Map<String, dynamic> _$UserSessionToJson(_UserSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userAgent': instance.userAgent,
      'ip': instance.ip,
      'startedAt': instance.startedAt?.toIso8601String(),
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'current': instance.current,
    };
