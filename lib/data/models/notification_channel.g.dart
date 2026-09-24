// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationChannel _$NotificationChannelFromJson(Map<String, dynamic> json) =>
    _NotificationChannel(
      id: json['id'] as String,
      name: json['name'] as String,
      kind: json['kind'] as String,
      provider: json['provider'] as String,
      tenantId: json['tenantId'] as String?,
      config:
          (json['config'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      secrets:
          (json['secrets'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const <String, bool>{},
      recipients:
          (json['recipients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      minSeverity: json['minSeverity'] as String? ?? 'warning',
      sendResolved: json['sendResolved'] as bool? ?? true,
      enabled: json['enabled'] as bool? ?? true,
      sources:
          (json['sources'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['ops', 'summary'],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$NotificationChannelToJson(
  _NotificationChannel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'kind': instance.kind,
  'provider': instance.provider,
  'tenantId': instance.tenantId,
  'config': instance.config,
  'secrets': instance.secrets,
  'recipients': instance.recipients,
  'minSeverity': instance.minSeverity,
  'sendResolved': instance.sendResolved,
  'enabled': instance.enabled,
  'sources': instance.sources,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

_NotificationProvider _$NotificationProviderFromJson(
  Map<String, dynamic> json,
) => _NotificationProvider(
  kind: json['kind'] as String,
  provider: json['provider'] as String,
  recipients: json['recipients'] as String? ?? 'none',
  fields:
      (json['fields'] as List<dynamic>?)
          ?.map((e) => ProviderField.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ProviderField>[],
);

Map<String, dynamic> _$NotificationProviderToJson(
  _NotificationProvider instance,
) => <String, dynamic>{
  'kind': instance.kind,
  'provider': instance.provider,
  'recipients': instance.recipients,
  'fields': instance.fields,
};

_ProviderField _$ProviderFieldFromJson(Map<String, dynamic> json) =>
    _ProviderField(
      name: json['name'] as String,
      required: json['required'] as bool? ?? false,
      secret: json['secret'] as bool? ?? false,
    );

Map<String, dynamic> _$ProviderFieldToJson(_ProviderField instance) =>
    <String, dynamic>{
      'name': instance.name,
      'required': instance.required,
      'secret': instance.secret,
    };
