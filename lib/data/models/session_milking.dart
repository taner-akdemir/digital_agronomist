import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_milking.freezed.dart';
part 'session_milking.g.dart';

/// Bir oturumdaki tek hayvan sağımı (GET /sessions/{id}/milkings, backend
/// ADR 0062). Elle eşleştirmeyi hızlandırmak için okunur: önceki sağımda
/// kimin hangi noktada sağıldığı, bu sağımın en iyi tahmini.
@freezed
abstract class SessionMilking with _$SessionMilking {
  const factory SessionMilking({
    required String animalId,
    required String earTag,
    String? spoutId,
    required DateTime startedAt,
    DateTime? endedAt,
    @Default(0) int volumeMl,
  }) = _SessionMilking;

  factory SessionMilking.fromJson(Map<String, dynamic> json) =>
      _$SessionMilkingFromJson(json);
}
