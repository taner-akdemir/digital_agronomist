// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spout_health.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpoutHealth _$SpoutHealthFromJson(Map<String, dynamic> json) => _SpoutHealth(
  spoutId: json['spoutId'] as String,
  milkings: (json['milkings'] as num?)?.toInt() ?? 0,
  animals: (json['animals'] as num?)?.toInt() ?? 0,
  avgFlow: (json['avgFlow'] as num?)?.toDouble() ?? 0,
  unitMedian: (json['unitMedian'] as num?)?.toDouble(),
  diffPct: (json['diffPct'] as num?)?.toDouble() ?? 0,
  low: json['low'] as bool? ?? false,
);

Map<String, dynamic> _$SpoutHealthToJson(_SpoutHealth instance) =>
    <String, dynamic>{
      'spoutId': instance.spoutId,
      'milkings': instance.milkings,
      'animals': instance.animals,
      'avgFlow': instance.avgFlow,
      'unitMedian': instance.unitMedian,
      'diffPct': instance.diffPct,
      'low': instance.low,
    };
