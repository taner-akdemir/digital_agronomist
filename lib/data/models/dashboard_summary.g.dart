// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardSummary _$DashboardSummaryFromJson(Map<String, dynamic> json) =>
    _DashboardSummary(
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      totalMl: (json['totalMl'] as num?)?.toInt() ?? 0,
      milkingCount: (json['milkingCount'] as num?)?.toInt() ?? 0,
      animalCount: (json['animalCount'] as num?)?.toInt() ?? 0,
      activeSessions: (json['activeSessions'] as num?)?.toInt() ?? 0,
      openAlerts: (json['openAlerts'] as num?)?.toInt() ?? 0,
      bySpecies:
          (json['bySpecies'] as List<dynamic>?)
              ?.map((e) => SpeciesTotal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SpeciesTotal>[],
      classDistribution:
          (json['classDistribution'] as List<dynamic>?)
              ?.map((e) => YieldClassCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <YieldClassCount>[],
      byGroup:
          (json['byGroup'] as List<dynamic>?)
              ?.map((e) => GroupTotal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GroupTotal>[],
      breeding: json['breeding'] == null
          ? null
          : BreedingKpi.fromJson(json['breeding'] as Map<String, dynamic>),
      exits:
          (json['exits'] as List<dynamic>?)
              ?.map((e) => ExitCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExitCount>[],
    );

Map<String, dynamic> _$DashboardSummaryToJson(_DashboardSummary instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'totalMl': instance.totalMl,
      'milkingCount': instance.milkingCount,
      'animalCount': instance.animalCount,
      'activeSessions': instance.activeSessions,
      'openAlerts': instance.openAlerts,
      'bySpecies': instance.bySpecies,
      'classDistribution': instance.classDistribution,
      'byGroup': instance.byGroup,
      'breeding': instance.breeding,
      'exits': instance.exits,
    };

_SpeciesTotal _$SpeciesTotalFromJson(Map<String, dynamic> json) =>
    _SpeciesTotal(
      speciesId: json['speciesId'] as String,
      totalMl: (json['totalMl'] as num?)?.toInt() ?? 0,
      animalCount: (json['animalCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SpeciesTotalToJson(_SpeciesTotal instance) =>
    <String, dynamic>{
      'speciesId': instance.speciesId,
      'totalMl': instance.totalMl,
      'animalCount': instance.animalCount,
    };

_YieldClassCount _$YieldClassCountFromJson(Map<String, dynamic> json) =>
    _YieldClassCount(
      yieldClass: $enumDecode(
        _$YieldClassEnumMap,
        json['yieldClass'],
        unknownValue: YieldClass.normal,
      ),
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$YieldClassCountToJson(_YieldClassCount instance) =>
    <String, dynamic>{
      'yieldClass': _$YieldClassEnumMap[instance.yieldClass]!,
      'count': instance.count,
    };

const _$YieldClassEnumMap = {
  YieldClass.high: 'high',
  YieldClass.normal: 'normal',
  YieldClass.declining: 'declining',
  YieldClass.dryOffCandidate: 'dry_off_candidate',
  YieldClass.noMilk: 'no_milk',
};

_GroupTotal _$GroupTotalFromJson(Map<String, dynamic> json) => _GroupTotal(
  groupId: json['groupId'] as String,
  name: json['name'] as String,
  animals: (json['animals'] as num?)?.toInt() ?? 0,
  milked: (json['milked'] as num?)?.toInt() ?? 0,
  totalMl: (json['totalMl'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$GroupTotalToJson(_GroupTotal instance) =>
    <String, dynamic>{
      'groupId': instance.groupId,
      'name': instance.name,
      'animals': instance.animals,
      'milked': instance.milked,
      'totalMl': instance.totalMl,
    };

_BreedingKpi _$BreedingKpiFromJson(Map<String, dynamic> json) => _BreedingKpi(
  calvingIntervalDays: (json['calvingIntervalDays'] as num?)?.toDouble(),
  calvingIntervals: (json['calvingIntervals'] as num?)?.toInt() ?? 0,
  firstServicePct: (json['firstServicePct'] as num?)?.toDouble(),
  firstServices: (json['firstServices'] as num?)?.toInt() ?? 0,
  daysOpen: (json['daysOpen'] as num?)?.toDouble(),
  daysOpenN: (json['daysOpenN'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$BreedingKpiToJson(_BreedingKpi instance) =>
    <String, dynamic>{
      'calvingIntervalDays': instance.calvingIntervalDays,
      'calvingIntervals': instance.calvingIntervals,
      'firstServicePct': instance.firstServicePct,
      'firstServices': instance.firstServices,
      'daysOpen': instance.daysOpen,
      'daysOpenN': instance.daysOpenN,
    };

_ExitCount _$ExitCountFromJson(Map<String, dynamic> json) => _ExitCount(
  reason: json['reason'] as String,
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ExitCountToJson(_ExitCount instance) =>
    <String, dynamic>{'reason': instance.reason, 'count': instance.count};
