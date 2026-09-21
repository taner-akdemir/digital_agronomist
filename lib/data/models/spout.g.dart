// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Spout _$SpoutFromJson(Map<String, dynamic> json) => _Spout(
  id: json['id'] as String,
  vacuumId: json['vacuumId'] as String,
  positionNo: (json['positionNo'] as num).toInt(),
);

Map<String, dynamic> _$SpoutToJson(_Spout instance) => <String, dynamic>{
  'id': instance.id,
  'vacuumId': instance.vacuumId,
  'positionNo': instance.positionNo,
};
