// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unmatched_tag_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UnmatchedTagRow _$UnmatchedTagRowFromJson(Map<String, dynamic> json) =>
    _UnmatchedTagRow(
      rfid: json['rfid'] as String,
      lastSessionId: json['lastSessionId'] as String?,
      lastSpoutId: json['lastSpoutId'] as String?,
      firstSeenAt: DateTime.parse(json['firstSeenAt'] as String),
      lastSeenAt: DateTime.parse(json['lastSeenAt'] as String),
      readCount: (json['readCount'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$UnmatchedTagRowToJson(_UnmatchedTagRow instance) =>
    <String, dynamic>{
      'rfid': instance.rfid,
      'lastSessionId': instance.lastSessionId,
      'lastSpoutId': instance.lastSpoutId,
      'firstSeenAt': instance.firstSeenAt.toIso8601String(),
      'lastSeenAt': instance.lastSeenAt.toIso8601String(),
      'readCount': instance.readCount,
    };
