// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeterCheck _$MeterCheckFromJson(Map<String, dynamic> json) => _MeterCheck(
  id: json['id'] as String,
  milkingId: json['milkingId'] as String,
  deviceId: json['deviceId'] as String?,
  earTag: json['earTag'] as String? ?? '',
  meteredMl: (json['meteredMl'] as num?)?.toInt() ?? 0,
  manualMl: (json['manualMl'] as num?)?.toInt() ?? 0,
  deviationPct: (json['deviationPct'] as num?)?.toDouble() ?? 0,
  authorName: json['authorName'] as String? ?? '',
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$MeterCheckToJson(_MeterCheck instance) =>
    <String, dynamic>{
      'id': instance.id,
      'milkingId': instance.milkingId,
      'deviceId': instance.deviceId,
      'earTag': instance.earTag,
      'meteredMl': instance.meteredMl,
      'manualMl': instance.manualMl,
      'deviationPct': instance.deviationPct,
      'authorName': instance.authorName,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_MeterSummary _$MeterSummaryFromJson(Map<String, dynamic> json) =>
    _MeterSummary(
      deviceId: json['deviceId'] as String? ?? '',
      serialNo: json['serialNo'] as String? ?? '',
      checks: (json['checks'] as num?)?.toInt() ?? 0,
      avgDeviationPct: (json['avgDeviationPct'] as num?)?.toDouble() ?? 0,
      needsCalibration: json['needsCalibration'] as bool? ?? false,
    );

Map<String, dynamic> _$MeterSummaryToJson(_MeterSummary instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'serialNo': instance.serialNo,
      'checks': instance.checks,
      'avgDeviationPct': instance.avgDeviationPct,
      'needsCalibration': instance.needsCalibration,
    };

_MeterChecks _$MeterChecksFromJson(Map<String, dynamic> json) => _MeterChecks(
  summary: json['summary'] == null
      ? const MeterSummary()
      : MeterSummary.fromJson(json['summary'] as Map<String, dynamic>),
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => MeterCheck.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MeterCheck>[],
);

Map<String, dynamic> _$MeterChecksToJson(_MeterChecks instance) =>
    <String, dynamic>{'summary': instance.summary, 'items': instance.items};

_MeterCheckResult _$MeterCheckResultFromJson(Map<String, dynamic> json) =>
    _MeterCheckResult(
      check: MeterCheck.fromJson(json['check'] as Map<String, dynamic>),
      summary: json['summary'] == null
          ? const MeterSummary()
          : MeterSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeterCheckResultToJson(_MeterCheckResult instance) =>
    <String, dynamic>{'check': instance.check, 'summary': instance.summary};
