// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditEntry _$AuditEntryFromJson(Map<String, dynamic> json) => _AuditEntry(
  id: json['id'] as String,
  at: DateTime.parse(json['at'] as String),
  action: json['action'] as String,
  target: json['target'] as String? ?? '',
  detail: json['detail'] as String? ?? '',
  userName: json['userName'] as String?,
  userDeleted: json['userDeleted'] as bool? ?? false,
);

Map<String, dynamic> _$AuditEntryToJson(_AuditEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'at': instance.at.toIso8601String(),
      'action': instance.action,
      'target': instance.target,
      'detail': instance.detail,
      'userName': instance.userName,
      'userDeleted': instance.userDeleted,
    };
