// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Alert _$AlertFromJson(Map<String, dynamic> json) => _Alert(
  id: json['id'] as String,
  message: json['message'] as String,
  type: json['type'] as String? ?? '',
  severity: json['severity'] as String? ?? 'warning',
  animalId: json['animalId'] as String?,
  sessionId: json['sessionId'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  acknowledgedBy: json['acknowledgedBy'] as String?,
  acknowledgedAt: json['acknowledgedAt'] == null
      ? null
      : DateTime.parse(json['acknowledgedAt'] as String),
  resolvedAt: json['resolvedAt'] == null
      ? null
      : DateTime.parse(json['resolvedAt'] as String),
);

Map<String, dynamic> _$AlertToJson(_Alert instance) => <String, dynamic>{
  'id': instance.id,
  'message': instance.message,
  'type': instance.type,
  'severity': instance.severity,
  'animalId': instance.animalId,
  'sessionId': instance.sessionId,
  'createdAt': instance.createdAt?.toIso8601String(),
  'acknowledgedBy': instance.acknowledgedBy,
  'acknowledgedAt': instance.acknowledgedAt?.toIso8601String(),
  'resolvedAt': instance.resolvedAt?.toIso8601String(),
};
