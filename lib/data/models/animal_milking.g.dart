// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_milking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnimalMilking _$AnimalMilkingFromJson(Map<String, dynamic> json) =>
    _AnimalMilking(
      id: json['id'] as String,
      sessionId: json['sessionId'] as String,
      animalId: json['animalId'] as String,
      spoutId: json['spoutId'] as String?,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      volumeMl: (json['volumeMl'] as num?)?.toInt() ?? 0,
      expectedMl: (json['expectedMl'] as num?)?.toInt() ?? 0,
      peakFlow: (json['peakFlow'] as num?)?.toDouble() ?? 0,
      avgFlow: (json['avgFlow'] as num?)?.toDouble() ?? 0,
      yieldPct: (json['yieldPct'] as num?)?.toDouble() ?? 0,
      color:
          $enumDecodeNullable(_$MilkColorEnumMap, json['color']) ??
          MilkColor.grey,
      sessionType: json['sessionType'] as String? ?? 'morning',
      endReason: json['endReason'] as String?,
    );

Map<String, dynamic> _$AnimalMilkingToJson(_AnimalMilking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'animalId': instance.animalId,
      'spoutId': instance.spoutId,
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'volumeMl': instance.volumeMl,
      'expectedMl': instance.expectedMl,
      'peakFlow': instance.peakFlow,
      'avgFlow': instance.avgFlow,
      'yieldPct': instance.yieldPct,
      'color': _$MilkColorEnumMap[instance.color]!,
      'sessionType': instance.sessionType,
      'endReason': instance.endReason,
    };

const _$MilkColorEnumMap = {
  MilkColor.green: 'green',
  MilkColor.yellow: 'yellow',
  MilkColor.red: 'red',
  MilkColor.grey: 'grey',
};
