import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal_import.freezed.dart';
part 'animal_import.g.dart';

/// Toplu hayvan içe aktarmanın raporu (POST /animals/import, backend ADR
/// 0063, 0101). Önizlemede (`dryRun`) hiçbir şey yazılmamıştır; her satırın
/// ne OLACAĞI söylenir.
@freezed
abstract class AnimalImportReport with _$AnimalImportReport {
  const factory AnimalImportReport({
    @Default(false) bool dryRun,

    /// `update=true` ile istendi: kayıtlı küpeler güncellenir (ADR 0101).
    @Default(false) bool updateExisting,
    @Default(0) int total,

    /// Eklenecek (önizleme) ya da eklenen hayvan sayısı.
    @Default(0) int create,

    /// Küpesi zaten kayıtlı ve güncelleme istenmedi; kayda DOKUNULMAZ.
    @Default(0) int exists,

    /// Kayıtlı; en az bir alanı değişecek (değişti).
    @Default(0) int update,

    /// Kayıtlı; dosyadaki dolu hücrelerin hepsi kayıtla aynı.
    @Default(0) int unchanged,

    /// Atlanan hatalı satır sayısı.
    @Default(0) int errors,

    /// Dosyada adı geçen, işletmede olmayan gruplar; içe aktarmada
    /// oluşturulur.
    @Default(<String>[]) List<String> newGroups,

    /// Tanınmayan, alınmayan sütun başlıkları.
    @Default(<String>[]) List<String> ignoredColumns,
    @Default(<AnimalImportRow>[]) List<AnimalImportRow> rows,
  }) = _AnimalImportReport;

  const AnimalImportReport._();

  /// Onayla yazılacak hayvan sayısı (eklenen + güncellenen).
  int get toWrite => create + update;

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

    /// "create", "exists", "update", "unchanged" ya da "error". String, enum
    /// değil: yeni bir sonuç raporu düşürmesin.
    required String outcome,

    /// Hata sebebi (Türkçe, olduğu gibi gösterilir).
    String? message,

    /// Satırı engellemeyen not ("TR ile başlamıyor").
    String? warning,
    String? animalId,

    /// "update" satırında değişen alanlar.
    @Default(<AnimalImportChange>[]) List<AnimalImportChange> changes,
  }) = _AnimalImportRow;

  const AnimalImportRow._();

  bool get isError => outcome == 'error';
  bool get exists => outcome == 'exists';

  factory AnimalImportRow.fromJson(Map<String, dynamic> json) =>
      _$AnimalImportRowFromJson(json);
}

/// Güncellenen hayvanın bir alanı: eski → yeni (backend ADR 0101).
///
/// Değerler HAM gelir: tarih `YYYY-AA-GG`, durum kodu (`dry`), grup adı; boş
/// dize "yoktu" demek. Biçimleme ekranda.
@freezed
abstract class AnimalImportChange with _$AnimalImportChange {
  const factory AnimalImportChange({
    /// name, breed, rfid, status, birthDate, lastCalvingDate, lactationNo,
    /// group. String: tanınmayan alan ham gösterilir.
    required String field,
    @Default('') String from,
    @Default('') String to,
  }) = _AnimalImportChange;

  factory AnimalImportChange.fromJson(Map<String, dynamic> json) =>
      _$AnimalImportChangeFromJson(json);
}
