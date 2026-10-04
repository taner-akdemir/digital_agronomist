// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_placements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionPlacements _$SessionPlacementsFromJson(Map<String, dynamic> json) =>
    _SessionPlacements(
      sessionId: json['sessionId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      placements:
          (json['placements'] as List<dynamic>?)
              ?.map((e) => Placement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Placement>[],
    );

Map<String, dynamic> _$SessionPlacementsToJson(_SessionPlacements instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'startedAt': instance.startedAt.toIso8601String(),
      'placements': instance.placements,
    };

_Placement _$PlacementFromJson(Map<String, dynamic> json) => _Placement(
  spoutId: json['spoutId'] as String,
  animalId: json['animalId'] as String,
);

Map<String, dynamic> _$PlacementToJson(_Placement instance) =>
    <String, dynamic>{
      'spoutId': instance.spoutId,
      'animalId': instance.animalId,
    };
