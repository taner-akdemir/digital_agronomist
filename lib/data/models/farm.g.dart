// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Farm _$FarmFromJson(Map<String, dynamic> json) => _Farm(
  id: json['id'] as String,
  name: json['name'] as String,
  tenantId: json['tenantId'] as String?,
  city: json['city'] as String?,
  district: json['district'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$FarmToJson(_Farm instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tenantId': instance.tenantId,
  'city': instance.city,
  'district': instance.district,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
