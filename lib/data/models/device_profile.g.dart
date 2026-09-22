// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceProfile _$DeviceProfileFromJson(Map<String, dynamic> json) =>
    _DeviceProfile(
      id: json['id'] as String,
      vendor: json['vendor'] as String? ?? '',
      model: json['model'] as String? ?? '',
      protocol: json['protocol'] as String? ?? '',
      version: (json['version'] as num?)?.toInt() ?? 1,
      status: json['status'] as String? ?? 'approved',
    );

Map<String, dynamic> _$DeviceProfileToJson(_DeviceProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vendor': instance.vendor,
      'model': instance.model,
      'protocol': instance.protocol,
      'version': instance.version,
      'status': instance.status,
    };
