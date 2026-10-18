// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_write.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendingWrite _$PendingWriteFromJson(Map<String, dynamic> json) =>
    _PendingWrite(
      id: json['id'] as String,
      kind: $enumDecode(_$PendingKindEnumMap, json['kind']),
      animalId: json['animalId'] as String?,
      subject: json['subject'] as String? ?? '',
      payload:
          json['payload'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      createdAt: DateTime.parse(json['createdAt'] as String),
      attempts: (json['attempts'] as num?)?.toInt() ?? 0,
      serverErrors: (json['serverErrors'] as num?)?.toInt() ?? 0,
      nextAttemptAt: json['nextAttemptAt'] == null
          ? null
          : DateTime.parse(json['nextAttemptAt'] as String),
      state:
          $enumDecodeNullable(_$PendingStateEnumMap, json['state']) ??
          PendingState.pending,
      failure: $enumDecodeNullable(_$PendingFailureEnumMap, json['failure']),
      error: json['error'] as String?,
      failedAt: json['failedAt'] == null
          ? null
          : DateTime.parse(json['failedAt'] as String),
    );

Map<String, dynamic> _$PendingWriteToJson(_PendingWrite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$PendingKindEnumMap[instance.kind]!,
      'animalId': instance.animalId,
      'subject': instance.subject,
      'payload': instance.payload,
      'createdAt': instance.createdAt.toIso8601String(),
      'attempts': instance.attempts,
      'serverErrors': instance.serverErrors,
      'nextAttemptAt': instance.nextAttemptAt?.toIso8601String(),
      'state': _$PendingStateEnumMap[instance.state]!,
      'failure': _$PendingFailureEnumMap[instance.failure],
      'error': instance.error,
      'failedAt': instance.failedAt?.toIso8601String(),
    };

const _$PendingKindEnumMap = {
  PendingKind.note: 'note',
  PendingKind.breeding: 'breeding',
  PendingKind.treatment: 'treatment',
  PendingKind.vaccination: 'vaccination',
  PendingKind.calving: 'calving',
};

const _$PendingStateEnumMap = {
  PendingState.pending: 'pending',
  PendingState.failed: 'failed',
};

const _$PendingFailureEnumMap = {
  PendingFailure.rejected: 'rejected',
  PendingFailure.expired: 'expired',
  PendingFailure.retries: 'retries',
};
