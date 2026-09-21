// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacuum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Vacuum _$VacuumFromJson(Map<String, dynamic> json) => _Vacuum(
  id: json['id'] as String,
  hallId: json['hallId'] as String,
  name: json['name'] as String,
  totalSpouts: (json['totalSpouts'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VacuumToJson(_Vacuum instance) => <String, dynamic>{
  'id': instance.id,
  'hallId': instance.hallId,
  'name': instance.name,
  'totalSpouts': instance.totalSpouts,
};
