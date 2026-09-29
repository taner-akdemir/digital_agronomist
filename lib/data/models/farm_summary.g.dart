// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FarmSummary _$FarmSummaryFromJson(Map<String, dynamic> json) => _FarmSummary(
  tenantId: json['tenantId'] as String,
  name: json['name'] as String,
  role: json['role'] as String? ?? '',
  todayMl: (json['todayMl'] as num?)?.toInt() ?? 0,
  todayAnimals: (json['todayAnimals'] as num?)?.toInt() ?? 0,
  openAlerts: (json['openAlerts'] as num?)?.toInt() ?? 0,
  vaccinationsDue: (json['vaccinationsDue'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FarmSummaryToJson(_FarmSummary instance) =>
    <String, dynamic>{
      'tenantId': instance.tenantId,
      'name': instance.name,
      'role': instance.role,
      'todayMl': instance.todayMl,
      'todayAnimals': instance.todayAnimals,
      'openAlerts': instance.openAlerts,
      'vaccinationsDue': instance.vaccinationsDue,
    };
