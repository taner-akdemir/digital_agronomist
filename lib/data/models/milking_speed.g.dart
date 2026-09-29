// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milking_speed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MilkingSpeed _$MilkingSpeedFromJson(Map<String, dynamic> json) =>
    _MilkingSpeed(
      animalId: json['animalId'] as String,
      milkings: (json['milkings'] as num?)?.toInt() ?? 0,
      avgFlow: (json['avgFlow'] as num?)?.toDouble() ?? 0,
      peakFlow: (json['peakFlow'] as num?)?.toDouble() ?? 0,
      durationSec: (json['durationSec'] as num?)?.toInt() ?? 0,
      herdAvgFlow: (json['herdAvgFlow'] as num?)?.toDouble() ?? 0,
      slow: json['slow'] as bool? ?? false,
    );

Map<String, dynamic> _$MilkingSpeedToJson(_MilkingSpeed instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'milkings': instance.milkings,
      'avgFlow': instance.avgFlow,
      'peakFlow': instance.peakFlow,
      'durationSec': instance.durationSec,
      'herdAvgFlow': instance.herdAvgFlow,
      'slow': instance.slow,
    };
