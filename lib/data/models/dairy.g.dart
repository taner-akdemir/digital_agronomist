// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dairy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Dairy _$DairyFromJson(Map<String, dynamic> json) => _Dairy(
  id: json['id'] as String,
  name: json['name'] as String,
  city: json['city'] as String? ?? '',
  status: json['status'] as String? ?? 'active',
);

Map<String, dynamic> _$DairyToJson(_Dairy instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'city': instance.city,
  'status': instance.status,
};

_DairyShare _$DairyShareFromJson(Map<String, dynamic> json) => _DairyShare(
  id: json['id'] as String,
  dairyId: json['dairyId'] as String,
  dairyName: json['dairyName'] as String,
  dairyCity: json['dairyCity'] as String? ?? '',
  grantedAt: DateTime.parse(json['grantedAt'] as String),
  grantedBy: json['grantedBy'] as String? ?? '',
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  revokedAt: json['revokedAt'] == null
      ? null
      : DateTime.parse(json['revokedAt'] as String),
  status: json['status'] as String? ?? 'active',
);

Map<String, dynamic> _$DairyShareToJson(_DairyShare instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dairyId': instance.dairyId,
      'dairyName': instance.dairyName,
      'dairyCity': instance.dairyCity,
      'grantedAt': instance.grantedAt.toIso8601String(),
      'grantedBy': instance.grantedBy,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'revokedAt': instance.revokedAt?.toIso8601String(),
      'status': instance.status,
    };
