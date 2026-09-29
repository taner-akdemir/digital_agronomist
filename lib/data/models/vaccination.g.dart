// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VaccinePlan _$VaccinePlanFromJson(Map<String, dynamic> json) => _VaccinePlan(
  id: json['id'] as String,
  name: json['name'] as String,
  intervalDays: (json['intervalDays'] as num).toInt(),
  speciesId: json['speciesId'] as String?,
  note: json['note'] as String? ?? '',
  animals: (json['animals'] as num?)?.toInt() ?? 0,
  dueSoon: (json['dueSoon'] as num?)?.toInt() ?? 0,
  never: (json['never'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$VaccinePlanToJson(_VaccinePlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'intervalDays': instance.intervalDays,
      'speciesId': instance.speciesId,
      'note': instance.note,
      'animals': instance.animals,
      'dueSoon': instance.dueSoon,
      'never': instance.never,
    };

_VaccinationDue _$VaccinationDueFromJson(Map<String, dynamic> json) =>
    _VaccinationDue(
      planId: json['planId'] as String,
      planName: json['planName'] as String,
      animalId: json['animalId'] as String,
      earTag: json['earTag'] as String,
      animalName: json['animalName'] as String? ?? '',
      lastGivenOn: json['lastGivenOn'] == null
          ? null
          : DateTime.parse(json['lastGivenOn'] as String),
      dueOn: json['dueOn'] == null
          ? null
          : DateTime.parse(json['dueOn'] as String),
    );

Map<String, dynamic> _$VaccinationDueToJson(_VaccinationDue instance) =>
    <String, dynamic>{
      'planId': instance.planId,
      'planName': instance.planName,
      'animalId': instance.animalId,
      'earTag': instance.earTag,
      'animalName': instance.animalName,
      'lastGivenOn': instance.lastGivenOn?.toIso8601String(),
      'dueOn': instance.dueOn?.toIso8601String(),
    };

_Vaccination _$VaccinationFromJson(Map<String, dynamic> json) => _Vaccination(
  id: json['id'] as String,
  planId: json['planId'] as String,
  planName: json['planName'] as String,
  animalId: json['animalId'] as String,
  givenOn: DateTime.parse(json['givenOn'] as String),
  note: json['note'] as String? ?? '',
  authorName: json['authorName'] as String? ?? '',
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$VaccinationToJson(_Vaccination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planId': instance.planId,
      'planName': instance.planName,
      'animalId': instance.animalId,
      'givenOn': instance.givenOn.toIso8601String(),
      'note': instance.note,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_AnimalVaccinations _$AnimalVaccinationsFromJson(Map<String, dynamic> json) =>
    _AnimalVaccinations(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => Vaccination.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      due:
          (json['due'] as List<dynamic>?)
              ?.map((e) => VaccinationDue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$AnimalVaccinationsToJson(_AnimalVaccinations instance) =>
    <String, dynamic>{'items': instance.items, 'due': instance.due};
