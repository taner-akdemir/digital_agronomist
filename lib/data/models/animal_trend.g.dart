// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_trend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnimalTrend _$AnimalTrendFromJson(Map<String, dynamic> json) => _AnimalTrend(
  animalId: json['animalId'] as String,
  yieldClass:
      $enumDecodeNullable(
        _$YieldClassEnumMap,
        json['yieldClass'],
        unknownValue: YieldClass.normal,
      ) ??
      YieldClass.normal,
  ma7Ml: (json['ma7Ml'] as num?)?.toInt() ?? 0,
  ma30Ml: (json['ma30Ml'] as num?)?.toInt() ?? 0,
  trendSlope: (json['trendSlope'] as num?)?.toDouble() ?? 0,
  daily:
      (json['daily'] as List<dynamic>?)
          ?.map((e) => AnimalDailyStat.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AnimalDailyStat>[],
  lactation: json['lactation'] == null
      ? null
      : Lactation305.fromJson(json['lactation'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AnimalTrendToJson(_AnimalTrend instance) =>
    <String, dynamic>{
      'animalId': instance.animalId,
      'yieldClass': _$YieldClassEnumMap[instance.yieldClass]!,
      'ma7Ml': instance.ma7Ml,
      'ma30Ml': instance.ma30Ml,
      'trendSlope': instance.trendSlope,
      'daily': instance.daily,
      'lactation': instance.lactation,
    };

const _$YieldClassEnumMap = {
  YieldClass.high: 'high',
  YieldClass.normal: 'normal',
  YieldClass.declining: 'declining',
  YieldClass.dryOffCandidate: 'dry_off_candidate',
  YieldClass.noMilk: 'no_milk',
};

_AnimalDailyStat _$AnimalDailyStatFromJson(Map<String, dynamic> json) =>
    _AnimalDailyStat(
      date: DateTime.parse(json['date'] as String),
      totalMl: (json['totalMl'] as num?)?.toInt() ?? 0,
      milkingCount: (json['milkingCount'] as num?)?.toInt() ?? 0,
      ma7Ml: (json['ma7Ml'] as num?)?.toInt(),
      ma30Ml: (json['ma30Ml'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AnimalDailyStatToJson(_AnimalDailyStat instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'totalMl': instance.totalMl,
      'milkingCount': instance.milkingCount,
      'ma7Ml': instance.ma7Ml,
      'ma30Ml': instance.ma30Ml,
    };

_Lactation305 _$Lactation305FromJson(Map<String, dynamic> json) =>
    _Lactation305(
      calvingDate: DateTime.parse(json['calvingDate'] as String),
      daysInMilk: (json['daysInMilk'] as num?)?.toInt() ?? 0,
      actualMl: (json['actualMl'] as num?)?.toInt() ?? 0,
      projected305Ml: (json['projected305Ml'] as num?)?.toInt(),
      complete: json['complete'] as bool? ?? false,
    );

Map<String, dynamic> _$Lactation305ToJson(_Lactation305 instance) =>
    <String, dynamic>{
      'calvingDate': instance.calvingDate.toIso8601String(),
      'daysInMilk': instance.daysInMilk,
      'actualMl': instance.actualMl,
      'projected305Ml': instance.projected305Ml,
      'complete': instance.complete,
    };
