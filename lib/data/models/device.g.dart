// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Device _$DeviceFromJson(Map<String, dynamic> json) => _Device(
  id: json['id'] as String,
  serialNo: json['serialNo'] as String,
  spoutId: json['spoutId'] as String?,
  profile: json['profile'] == null
      ? null
      : DeviceProfile.fromJson(json['profile'] as Map<String, dynamic>),
  status: json['status'] as String? ?? 'unknown',
  firmware: json['firmware'] as String?,
  calibrationFactor: (json['calibrationFactor'] as num?)?.toDouble() ?? 1.0,
  lastSeenAt: json['lastSeenAt'] == null
      ? null
      : DateTime.parse(json['lastSeenAt'] as String),
  isSimulated: json['isSimulated'] as bool? ?? false,
  lastError: json['lastError'] == null
      ? null
      : DeviceError.fromJson(json['lastError'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DeviceToJson(_Device instance) => <String, dynamic>{
  'id': instance.id,
  'serialNo': instance.serialNo,
  'spoutId': instance.spoutId,
  'profile': instance.profile,
  'status': instance.status,
  'firmware': instance.firmware,
  'calibrationFactor': instance.calibrationFactor,
  'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
  'isSimulated': instance.isSimulated,
  'lastError': instance.lastError,
};
