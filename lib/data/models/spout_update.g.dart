// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spout_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpoutUpdate _$SpoutUpdateFromJson(Map<String, dynamic> json) => _SpoutUpdate(
  sessionId: json['sessionId'] as String,
  spoutId: json['spoutId'] as String,
  animal: json['animal'] == null
      ? null
      : SpoutAnimal.fromJson(json['animal'] as Map<String, dynamic>),
  flowRate: (json['flowRate'] as num?)?.toDouble() ?? 0,
  volumeMl: (json['volumeMl'] as num?)?.toInt() ?? 0,
  expectedMl: (json['expectedMl'] as num?)?.toInt() ?? 0,
  yieldPct: (json['yieldPct'] as num?)?.toDouble() ?? 0,
  flowColor:
      $enumDecodeNullable(_$MilkColorEnumMap, json['flowColor']) ??
      MilkColor.grey,
  yieldColor:
      $enumDecodeNullable(_$MilkColorEnumMap, json['yieldColor']) ??
      MilkColor.grey,
  state:
      $enumDecodeNullable(_$SpoutStateEnumMap, json['state']) ??
      SpoutState.idle,
  ts: json['ts'] == null ? null : DateTime.parse(json['ts'] as String),
  unmatchedTag: json['unmatchedTag'] == null
      ? null
      : UnmatchedTag.fromJson(json['unmatchedTag'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SpoutUpdateToJson(_SpoutUpdate instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'spoutId': instance.spoutId,
      'animal': instance.animal,
      'flowRate': instance.flowRate,
      'volumeMl': instance.volumeMl,
      'expectedMl': instance.expectedMl,
      'yieldPct': instance.yieldPct,
      'flowColor': _$MilkColorEnumMap[instance.flowColor]!,
      'yieldColor': _$MilkColorEnumMap[instance.yieldColor]!,
      'state': _$SpoutStateEnumMap[instance.state]!,
      'ts': instance.ts?.toIso8601String(),
      'unmatchedTag': instance.unmatchedTag,
    };

const _$MilkColorEnumMap = {
  MilkColor.green: 'green',
  MilkColor.yellow: 'yellow',
  MilkColor.red: 'red',
  MilkColor.grey: 'grey',
};

const _$SpoutStateEnumMap = {
  SpoutState.idle: 'idle',
  SpoutState.milking: 'milking',
  SpoutState.done: 'done',
  SpoutState.error: 'error',
};

_SpoutAnimal _$SpoutAnimalFromJson(Map<String, dynamic> json) => _SpoutAnimal(
  id: json['id'] as String,
  earTag: json['earTag'] as String,
  species: json['species'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$SpoutAnimalToJson(_SpoutAnimal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'earTag': instance.earTag,
      'species': instance.species,
      'name': instance.name,
    };

_UnmatchedTag _$UnmatchedTagFromJson(Map<String, dynamic> json) =>
    _UnmatchedTag(
      rfid: json['rfid'] as String,
      reason: json['reason'] as String,
      message: json['message'] as String,
      at: json['at'] == null ? null : DateTime.parse(json['at'] as String),
    );

Map<String, dynamic> _$UnmatchedTagToJson(_UnmatchedTag instance) =>
    <String, dynamic>{
      'rfid': instance.rfid,
      'reason': instance.reason,
      'message': instance.message,
      'at': instance.at?.toIso8601String(),
    };
