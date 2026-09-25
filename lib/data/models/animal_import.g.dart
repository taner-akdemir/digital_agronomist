// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_import.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnimalImportReport _$AnimalImportReportFromJson(Map<String, dynamic> json) =>
    _AnimalImportReport(
      dryRun: json['dryRun'] as bool? ?? false,
      total: (json['total'] as num?)?.toInt() ?? 0,
      create: (json['create'] as num?)?.toInt() ?? 0,
      exists: (json['exists'] as num?)?.toInt() ?? 0,
      errors: (json['errors'] as num?)?.toInt() ?? 0,
      ignoredColumns:
          (json['ignoredColumns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      rows:
          (json['rows'] as List<dynamic>?)
              ?.map((e) => AnimalImportRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AnimalImportRow>[],
    );

Map<String, dynamic> _$AnimalImportReportToJson(_AnimalImportReport instance) =>
    <String, dynamic>{
      'dryRun': instance.dryRun,
      'total': instance.total,
      'create': instance.create,
      'exists': instance.exists,
      'errors': instance.errors,
      'ignoredColumns': instance.ignoredColumns,
      'rows': instance.rows,
    };

_AnimalImportRow _$AnimalImportRowFromJson(Map<String, dynamic> json) =>
    _AnimalImportRow(
      line: (json['line'] as num).toInt(),
      earTag: json['earTag'] as String? ?? '',
      name: json['name'] as String?,
      outcome: json['outcome'] as String,
      message: json['message'] as String?,
      warning: json['warning'] as String?,
      animalId: json['animalId'] as String?,
    );

Map<String, dynamic> _$AnimalImportRowToJson(_AnimalImportRow instance) =>
    <String, dynamic>{
      'line': instance.line,
      'earTag': instance.earTag,
      'name': instance.name,
      'outcome': instance.outcome,
      'message': instance.message,
      'warning': instance.warning,
      'animalId': instance.animalId,
    };
