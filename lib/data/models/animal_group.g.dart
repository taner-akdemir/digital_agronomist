// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnimalGroup _$AnimalGroupFromJson(Map<String, dynamic> json) => _AnimalGroup(
  id: json['id'] as String,
  name: json['name'] as String,
  animals: (json['animals'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AnimalGroupToJson(_AnimalGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'animals': instance.animals,
    };
