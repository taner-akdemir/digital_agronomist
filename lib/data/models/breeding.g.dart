// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeding.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Pregnancy _$PregnancyFromJson(Map<String, dynamic> json) => _Pregnancy(
  status: json['status'] as String,
  lastInsemination: json['lastInsemination'] == null
      ? null
      : DateTime.parse(json['lastInsemination'] as String),
  expectedCalving: json['expectedCalving'] == null
      ? null
      : DateTime.parse(json['expectedCalving'] as String),
  dryOffDate: json['dryOffDate'] == null
      ? null
      : DateTime.parse(json['dryOffDate'] as String),
  lastHeat: json['lastHeat'] == null
      ? null
      : DateTime.parse(json['lastHeat'] as String),
  expectedHeat: json['expectedHeat'] == null
      ? null
      : DateTime.parse(json['expectedHeat'] as String),
);

Map<String, dynamic> _$PregnancyToJson(_Pregnancy instance) =>
    <String, dynamic>{
      'status': instance.status,
      'lastInsemination': instance.lastInsemination?.toIso8601String(),
      'expectedCalving': instance.expectedCalving?.toIso8601String(),
      'dryOffDate': instance.dryOffDate?.toIso8601String(),
      'lastHeat': instance.lastHeat?.toIso8601String(),
      'expectedHeat': instance.expectedHeat?.toIso8601String(),
    };

_BreedingEvent _$BreedingEventFromJson(Map<String, dynamic> json) =>
    _BreedingEvent(
      id: json['id'] as String,
      animalId: json['animalId'] as String,
      kind: json['kind'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
      sire: json['sire'] as String? ?? '',
      result: json['result'] as String?,
      note: json['note'] as String? ?? '',
      authorName: json['authorName'] as String?,
    );

Map<String, dynamic> _$BreedingEventToJson(_BreedingEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'animalId': instance.animalId,
      'kind': instance.kind,
      'eventDate': instance.eventDate.toIso8601String(),
      'sire': instance.sire,
      'result': instance.result,
      'note': instance.note,
      'authorName': instance.authorName,
    };

_UpcomingBreeding _$UpcomingBreedingFromJson(Map<String, dynamic> json) =>
    _UpcomingBreeding(
      animalId: json['animalId'] as String,
      earTag: json['earTag'] as String,
      name: json['name'] as String?,
      event: json['event'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$UpcomingBreedingToJson(_UpcomingBreeding instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'earTag': instance.earTag,
      'name': instance.name,
      'event': instance.event,
      'date': instance.date.toIso8601String(),
      'status': instance.status,
    };
