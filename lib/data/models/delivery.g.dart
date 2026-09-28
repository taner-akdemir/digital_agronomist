// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Delivery _$DeliveryFromJson(Map<String, dynamic> json) => _Delivery(
  id: json['id'] as String,
  deliveredOn: DateTime.parse(json['deliveredOn'] as String),
  volumeMl: (json['volumeMl'] as num).toInt(),
  note: json['note'] as String? ?? '',
  authorName: json['authorName'] as String?,
  compared: json['compared'] as bool? ?? false,
  periodFrom: json['periodFrom'] == null
      ? null
      : DateTime.parse(json['periodFrom'] as String),
  meteredMl: (json['meteredMl'] as num?)?.toInt() ?? 0,
  withheldMl: (json['withheldMl'] as num?)?.toInt() ?? 0,
  diffPct: (json['diffPct'] as num?)?.toDouble() ?? 0,
  mismatch: json['mismatch'] as bool? ?? false,
);

Map<String, dynamic> _$DeliveryToJson(_Delivery instance) => <String, dynamic>{
  'id': instance.id,
  'deliveredOn': instance.deliveredOn.toIso8601String(),
  'volumeMl': instance.volumeMl,
  'note': instance.note,
  'authorName': instance.authorName,
  'compared': instance.compared,
  'periodFrom': instance.periodFrom?.toIso8601String(),
  'meteredMl': instance.meteredMl,
  'withheldMl': instance.withheldMl,
  'diffPct': instance.diffPct,
  'mismatch': instance.mismatch,
};

_Deliveries _$DeliveriesFromJson(Map<String, dynamic> json) => _Deliveries(
  tolerancePct: (json['tolerancePct'] as num?)?.toDouble() ?? 5,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => Delivery.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$DeliveriesToJson(_Deliveries instance) =>
    <String, dynamic>{
      'tolerancePct': instance.tolerancePct,
      'items': instance.items,
    };

_Milker _$MilkerFromJson(Map<String, dynamic> json) => _Milker(
  userId: json['userId'] as String?,
  name: json['name'] as String? ?? '',
  sessions: (json['sessions'] as num?)?.toInt() ?? 0,
  milkings: (json['milkings'] as num?)?.toInt() ?? 0,
  volumeMl: (json['volumeMl'] as num?)?.toInt() ?? 0,
  avgDurationSec: (json['avgDurationSec'] as num?)?.toInt() ?? 0,
  lowFlowMilkings: (json['lowFlowMilkings'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MilkerToJson(_Milker instance) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'sessions': instance.sessions,
  'milkings': instance.milkings,
  'volumeMl': instance.volumeMl,
  'avgDurationSec': instance.avgDurationSec,
  'lowFlowMilkings': instance.lowFlowMilkings,
};
