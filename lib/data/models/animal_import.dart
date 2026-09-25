import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal_import.freezed.dart';
part 'animal_import.g.dart';

/// Toplu hayvan içe aktarmanın raporu (POST /animals/import, backend ADR
/// 0063). Önizlemede (`dryRun`) hiçbir şey yazılmamıştır; her satırın ne
/// OLACAĞI söylenir.
@freezed
abstract class AnimalImportReport with _$AnimalImportReport {
  const factory AnimalImportReport({
    @Default(false) bool dryRun,
    @Default(0) int total,

    /// Eklenecek (önizleme) ya da eklenen hayvan sayısı.
    @Default(0) int create,

    /// Küpesi zaten kayıtlı; kayda DOKUNULMAZ.
    @Default(0) int exists,

    /// Atlanan hatalı satır sayısı.
    @Default(0) int errors,

    /// Tanınmayan, alınmayan sütun başlıkları.
    @Default(<String>[]) List<String> ignoredColumns,
    @Default(<AnimalImportRow>[]) List<AnimalImportRow> rows,
  }) = _AnimalImportReport;

  factory AnimalImportReport.fromJson(Map<String, dynamic> json) =>
      _$AnimalImportReportFromJson(json);
}

/// Dosyanın bir satırı ve sonucu.
@freezed
abstract class AnimalImportRow with _$AnimalImportRow {
  const factory AnimalImportRow({
    /// Dosyadaki satır numarası (başlık 1).
    required int line,
    @Default('') String earTag,
    String? name,

    /// "create", "exists" ya da "error". String, enum değil: yeni bir sonuç
    /// raporu düşürmesin.
    required String outcome,

    /// Hata sebebi (Türkçe, olduğu gibi gösterilir).
    String? message,

    /// Satırı engellemeyen not ("TR ile başlamıyor").
    String? warning,
    String? animalId,
  }) = _AnimalImportRow;

  const AnimalImportRow._();

  bool get isError => outcome == 'error';
  bool get exists => outcome == 'exists';

  factory AnimalImportRow.fromJson(Map<String, dynamic> json) =>
      _$AnimalImportRowFromJson(json);
}
