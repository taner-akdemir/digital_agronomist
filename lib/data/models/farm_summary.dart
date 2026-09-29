import 'package:freezed_annotation/freezed_annotation.dart';

part 'farm_summary.freezed.dart';
part 'farm_summary.g.dart';

/// Çiftliklerim satırı (backend ADR 0116, `GET /me/farms`): kişinin üye
/// olduğu bir işletmenin bugünkü özeti.
@freezed
abstract class FarmSummary with _$FarmSummary {
  const factory FarmSummary({
    required String tenantId,
    required String name,
    @Default('') String role,
    @Default(0) int todayMl,
    @Default(0) int todayAnimals,
    @Default(0) int openAlerts,
    @Default(0) int vaccinationsDue,
  }) = _FarmSummary;

  factory FarmSummary.fromJson(Map<String, dynamic> json) =>
      _$FarmSummaryFromJson(json);
}
