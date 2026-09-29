// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionSummary _$SessionSummaryFromJson(Map<String, dynamic> json) =>
    _SessionSummary(
      sessionId: json['sessionId'] as String,
      hallName: json['hallName'] as String? ?? '',
      animals: (json['animals'] as num?)?.toInt() ?? 0,
      volumeMl: (json['volumeMl'] as num?)?.toInt() ?? 0,
      expectedMl: (json['expectedMl'] as num?)?.toInt() ?? 0,
      lowYield:
          (json['lowYield'] as List<dynamic>?)
              ?.map((e) => AnimalBrief.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AnimalBrief>[],
      lowFlow:
          (json['lowFlow'] as List<dynamic>?)
              ?.map((e) => AnimalBrief.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AnimalBrief>[],
      notMilked:
          (json['notMilked'] as List<dynamic>?)
              ?.map((e) => AnimalBrief.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AnimalBrief>[],
    );

Map<String, dynamic> _$SessionSummaryToJson(_SessionSummary instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'hallName': instance.hallName,
      'animals': instance.animals,
      'volumeMl': instance.volumeMl,
      'expectedMl': instance.expectedMl,
      'lowYield': instance.lowYield,
      'lowFlow': instance.lowFlow,
      'notMilked': instance.notMilked,
    };

_AnimalBrief _$AnimalBriefFromJson(Map<String, dynamic> json) => _AnimalBrief(
  animalId: json['animalId'] as String,
  earTag: json['earTag'] as String,
  name: json['name'] as String? ?? '',
  volumeMl: (json['volumeMl'] as num?)?.toInt() ?? 0,
  expectedMl: (json['expectedMl'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AnimalBriefToJson(_AnimalBrief instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'earTag': instance.earTag,
      'name': instance.name,
      'volumeMl': instance.volumeMl,
      'expectedMl': instance.expectedMl,
    };
