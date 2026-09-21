// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thresholds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Thresholds _$ThresholdsFromJson(Map<String, dynamic> json) => _Thresholds(
  speciesId: json['speciesId'] as String,
  flowLow: (json['flowLow'] as num).toDouble(),
  flowHigh: (json['flowHigh'] as num).toDouble(),
  yieldGreenPct: (json['yieldGreenPct'] as num?)?.toDouble() ?? 90,
  yieldRedPct: (json['yieldRedPct'] as num?)?.toDouble() ?? 60,
  rampUpSec: (json['rampUpSec'] as num?)?.toInt() ?? 60,
  alertHoldSec: (json['alertHoldSec'] as num?)?.toInt() ?? 30,
  endFlowThreshold: (json['endFlowThreshold'] as num?)?.toDouble() ?? 0.2,
  endGraceSec: (json['endGraceSec'] as num?)?.toInt() ?? 10,
  dryOffDailyMl: (json['dryOffDailyMl'] as num?)?.toInt() ?? 0,
  highYieldDailyMl: (json['highYieldDailyMl'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ThresholdsToJson(_Thresholds instance) =>
    <String, dynamic>{
      'speciesId': instance.speciesId,
      'flowLow': instance.flowLow,
      'flowHigh': instance.flowHigh,
      'yieldGreenPct': instance.yieldGreenPct,
      'yieldRedPct': instance.yieldRedPct,
      'rampUpSec': instance.rampUpSec,
      'alertHoldSec': instance.alertHoldSec,
      'endFlowThreshold': instance.endFlowThreshold,
      'endGraceSec': instance.endGraceSec,
      'dryOffDailyMl': instance.dryOffDailyMl,
      'highYieldDailyMl': instance.highYieldDailyMl,
    };
