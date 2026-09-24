// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceError _$DeviceErrorFromJson(Map<String, dynamic> json) => _DeviceError(
  code: json['code'] as String,
  description: json['description'] as String?,
  at: DateTime.parse(json['at'] as String),
);

Map<String, dynamic> _$DeviceErrorToJson(_DeviceError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'at': instance.at.toIso8601String(),
    };
