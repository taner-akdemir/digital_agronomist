import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_placements.freezed.dart';
part 'session_placements.g.dart';

/// Bitmiş bir oturumun nokta → hayvan yerleşimi
/// (GET /sessions/placements?hallId=, backend ADR 0136). Okuyucusuz
/// çiftlikte "kimin arkasından kim gelir" önerisinin girdisi.
@freezed
abstract class SessionPlacements with _$SessionPlacements {
  const factory SessionPlacements({
    required String sessionId,
    required DateTime startedAt,
    @Default(<Placement>[]) List<Placement> placements,
  }) = _SessionPlacements;

  factory SessionPlacements.fromJson(Map<String, dynamic> json) =>
      _$SessionPlacementsFromJson(json);
}

/// Oturumda bir noktada sağılan hayvan.
@freezed
abstract class Placement with _$Placement {
  const factory Placement({required String spoutId, required String animalId}) =
      _Placement;

  factory Placement.fromJson(Map<String, dynamic> json) =>
      _$PlacementFromJson(json);
}
