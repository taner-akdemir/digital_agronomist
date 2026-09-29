// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: json['id'] as String,
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  role: json['role'] as String,
  tenantId: json['tenantId'] as String?,
  tenants:
      (json['tenants'] as List<dynamic>?)
          ?.map((e) => TenantRef.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TenantRef>[],
  volumeUnit: json['volumeUnit'] as String? ?? 'L',
  kiosk: json['kiosk'] as bool? ?? false,
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'fullName': instance.fullName,
  'role': instance.role,
  'tenantId': instance.tenantId,
  'tenants': instance.tenants,
  'volumeUnit': instance.volumeUnit,
  'kiosk': instance.kiosk,
};

_TenantRef _$TenantRefFromJson(Map<String, dynamic> json) => _TenantRef(
  id: json['id'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$TenantRefToJson(_TenantRef instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
    };

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
);

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

_LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => _LoginResult(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  user: AuthUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LoginResultToJson(_LoginResult instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };
