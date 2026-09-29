// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_import.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnimalImportReport _$AnimalImportReportFromJson(Map<String, dynamic> json) =>
    _AnimalImportReport(
      dryRun: json['dryRun'] as bool? ?? false,
      updateExisting: json['updateExisting'] as bool? ?? false,
      total: (json['total'] as num?)?.toInt() ?? 0,
      create: (json['create'] as num?)?.toInt() ?? 0,
      exists: (json['exists'] as num?)?.toInt() ?? 0,
      update: (json['update'] as num?)?.toInt() ?? 0,
      unchanged: (json['unchanged'] as num?)?.toInt() ?? 0,
      errors: (json['errors'] as num?)?.toInt() ?? 0,
      newGroups:
          (json['newGroups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
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
      'updateExisting': instance.updateExisting,
      'total': instance.total,
      'create': instance.create,
      'exists': instance.exists,
      'update': instance.update,
      'unchanged': instance.unchanged,
      'errors': instance.errors,
      'newGroups': instance.newGroups,
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
      changes:
          (json['changes'] as List<dynamic>?)
              ?.map(
                (e) => AnimalImportChange.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <AnimalImportChange>[],
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
      'changes': instance.changes,
    };

_AnimalImportChange _$AnimalImportChangeFromJson(Map<String, dynamic> json) =>
    _AnimalImportChange(
      field: json['field'] as String,
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
    );

Map<String, dynamic> _$AnimalImportChangeToJson(_AnimalImportChange instance) =>
    <String, dynamic>{
      'field': instance.field,
      'from': instance.from,
      'to': instance.to,
    };
