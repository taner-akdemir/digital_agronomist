// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnimalNote _$AnimalNoteFromJson(Map<String, dynamic> json) => _AnimalNote(
  id: json['id'] as String,
  animalId: json['animalId'] as String,
  note: json['note'] as String,
  authorName: json['authorName'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  kind: json['kind'] as String? ?? 'manual',
);

Map<String, dynamic> _$AnimalNoteToJson(_AnimalNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animalId': instance.animalId,
      'note': instance.note,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt.toIso8601String(),
      'kind': instance.kind,
    };
