// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiKey _$ApiKeyFromJson(Map<String, dynamic> json) => _ApiKey(
  id: json['id'] as String,
  name: json['name'] as String,
  prefix: json['prefix'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  lastUsedAt: json['lastUsedAt'] == null
      ? null
      : DateTime.parse(json['lastUsedAt'] as String),
  createdBy: json['createdBy'] as String? ?? '',
);

Map<String, dynamic> _$ApiKeyToJson(_ApiKey instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'prefix': instance.prefix,
  'createdAt': instance.createdAt?.toIso8601String(),
  'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
  'createdBy': instance.createdBy,
};

_ApiKeyCreated _$ApiKeyCreatedFromJson(Map<String, dynamic> json) =>
    _ApiKeyCreated(
      key: ApiKey.fromJson(json['key'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$ApiKeyCreatedToJson(_ApiKeyCreated instance) =>
    <String, dynamic>{'key': instance.key, 'token': instance.token};
