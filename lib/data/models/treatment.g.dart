// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Treatment _$TreatmentFromJson(Map<String, dynamic> json) => _Treatment(
  id: json['id'] as String,
  animalId: json['animalId'] as String,
  drug: json['drug'] as String,
  startedOn: DateTime.parse(json['startedOn'] as String),
  withdrawalUntil: DateTime.parse(json['withdrawalUntil'] as String),
  note: json['note'] as String? ?? '',
  authorName: json['authorName'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$TreatmentToJson(_Treatment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animalId': instance.animalId,
      'drug': instance.drug,
      'startedOn': instance.startedOn.toIso8601String(),
      'withdrawalUntil': instance.withdrawalUntil.toIso8601String(),
      'note': instance.note,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
