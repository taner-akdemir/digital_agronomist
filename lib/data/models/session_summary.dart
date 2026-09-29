import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_summary.freezed.dart';
part 'session_summary.g.dart';

/// Kapanan oturumun özeti (`GET /sessions/{id}/summary`, backend ADR 0094);
/// sağım özeti bildirimiyle aynı veri.
@freezed
abstract class SessionSummary with _$SessionSummary {
  const factory SessionSummary({
    required String sessionId,
    @Default('') String hallName,
    @Default(0) int animals,
    @Default(0) int volumeMl,
    @Default(0) int expectedMl,
    @Default(<AnimalBrief>[]) List<AnimalBrief> lowYield,
    @Default(<AnimalBrief>[]) List<AnimalBrief> lowFlow,

    /// Sağmal olup bu oturumda sağılmayanlar: tek bölgeli işletmede bütün
    /// sağmallar, çok bölgelide bu bölgenin önceki oturumunda sağılanlar.
    @Default(<AnimalBrief>[]) List<AnimalBrief> notMilked,
  }) = _SessionSummary;

  factory SessionSummary.fromJson(Map<String, dynamic> json) =>
      _$SessionSummaryFromJson(json);
}

/// Özetteki hayvan satırı.
@freezed
abstract class AnimalBrief with _$AnimalBrief {
  const factory AnimalBrief({
    required String animalId,
    required String earTag,
    @Default('') String name,
    @Default(0) int volumeMl,
    @Default(0) int expectedMl,
  }) = _AnimalBrief;

  const AnimalBrief._();

  /// "TR340000003 · Sarıkız".
  String get label => name.isEmpty ? earTag : '$earTag · $name';

  factory AnimalBrief.fromJson(Map<String, dynamic> json) =>
      _$AnimalBriefFromJson(json);
}
