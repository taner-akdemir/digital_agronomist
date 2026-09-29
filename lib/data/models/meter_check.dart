import 'package:freezed_annotation/freezed_annotation.dart';

part 'meter_check.freezed.dart';
part 'meter_check.g.dart';

/// Sayaç kontrolü (backend ADR 0124): bir sağımın elle ölçülen sütü ile o
/// anki sayaç ölçümü. Sapma `(sayaç − elle) / elle`, yüzde; artı = sayaç
/// FAZLA ölçüyor. Sapmayı SUNUCU hesaplar.
@freezed
abstract class MeterCheck with _$MeterCheck {
  const factory MeterCheck({
    required String id,
    required String milkingId,
    String? deviceId,
    @Default('') String earTag,
    @Default(0) int meteredMl,
    @Default(0) int manualMl,
    @Default(0) double deviationPct,
    @Default('') String authorName,
    DateTime? createdAt,
  }) = _MeterCheck;

  factory MeterCheck.fromJson(Map<String, dynamic> json) =>
      _$MeterCheckFromJson(json);
}

/// Sayacın son kontrollerinin özeti: son 90 günün son 10 kontrolünün
/// ortalaması. `needsCalibration`: en az 3 kontrol ve |ortalama| > %5 —
/// kararı SUNUCU verir; uygulama katsayıyı DEĞİŞTİRMEZ (kurulum ekibi).
@freezed
abstract class MeterSummary with _$MeterSummary {
  const factory MeterSummary({
    @Default('') String deviceId,
    @Default('') String serialNo,
    @Default(0) int checks,
    @Default(0) double avgDeviationPct,
    @Default(false) bool needsCalibration,
  }) = _MeterSummary;

  factory MeterSummary.fromJson(Map<String, dynamic> json) =>
      _$MeterSummaryFromJson(json);
}

/// `GET /meter-checks?deviceId=`: sayacın son kontrolleri (en yeni üstte)
/// ve özeti.
@freezed
abstract class MeterChecks with _$MeterChecks {
  const factory MeterChecks({
    @Default(MeterSummary()) MeterSummary summary,
    @Default(<MeterCheck>[]) List<MeterCheck> items,
  }) = _MeterChecks;

  factory MeterChecks.fromJson(Map<String, dynamic> json) =>
      _$MeterChecksFromJson(json);
}

/// `POST /milkings/{id}/meter-check` cevabı: yazılan kontrol ve sayacın
/// güncel özeti.
@freezed
abstract class MeterCheckResult with _$MeterCheckResult {
  const factory MeterCheckResult({
    required MeterCheck check,
    @Default(MeterSummary()) MeterSummary summary,
  }) = _MeterCheckResult;

  factory MeterCheckResult.fromJson(Map<String, dynamic> json) =>
      _$MeterCheckResultFromJson(json);
}

/// "+8.0" — sapma işaretiyle (artı = sayaç fazla ölçüyor).
String signedPct(double v, {int digits = 1}) =>
    '${v > 0 ? '+' : ''}${v.toStringAsFixed(digits)}';
