// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Animal _$AnimalFromJson(Map<String, dynamic> json) => _Animal(
  id: json['id'] as String,
  speciesId: json['speciesId'] as String,
  earTag: json['earTag'] as String,
  rfid: json['rfid'] as String?,
  name: json['name'] as String?,
  breed: json['breed'] as String?,
  birthDate: json['birthDate'] == null
      ? null
      : DateTime.parse(json['birthDate'] as String),
  lastCalvingDate: json['lastCalvingDate'] == null
      ? null
      : DateTime.parse(json['lastCalvingDate'] as String),
  lactationNo: (json['lactationNo'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? 'active',
  yieldClass:
      $enumDecodeNullable(
        _$YieldClassEnumMap,
        json['yieldClass'],
        unknownValue: YieldClass.normal,
      ) ??
      YieldClass.normal,
  yieldClassAt: json['yieldClassAt'] == null
      ? null
      : DateTime.parse(json['yieldClassAt'] as String),
);

Map<String, dynamic> _$AnimalToJson(_Animal instance) => <String, dynamic>{
  'id': instance.id,
  'speciesId': instance.speciesId,
  'earTag': instance.earTag,
  'rfid': instance.rfid,
  'name': instance.name,
  'breed': instance.breed,
  'birthDate': instance.birthDate?.toIso8601String(),
  'lastCalvingDate': instance.lastCalvingDate?.toIso8601String(),
  'lactationNo': instance.lactationNo,
  'status': instance.status,
  'yieldClass': _$YieldClassEnumMap[instance.yieldClass]!,
  'yieldClassAt': instance.yieldClassAt?.toIso8601String(),
};

const _$YieldClassEnumMap = {
  YieldClass.high: 'high',
  YieldClass.normal: 'normal',
  YieldClass.declining: 'declining',
  YieldClass.dryOffCandidate: 'dry_off_candidate',
  YieldClass.noMilk: 'no_milk',
};
