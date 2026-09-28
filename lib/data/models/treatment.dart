import 'package:freezed_annotation/freezed_annotation.dart';

part 'treatment.freezed.dart';
part 'treatment.g.dart';

/// Tedavi kaydı ve arınma süresi (backend ADR 0084).
@freezed
abstract class Treatment with _$Treatment {
  const factory Treatment({
    required String id,
    required String animalId,
    required String drug,
    required DateTime startedOn,

    /// Sütün ayrılacağı SON gün (dahil).
    required DateTime withdrawalUntil,
    @Default('') String note,
    String? authorName,
    DateTime? createdAt,
  }) = _Treatment;

  const Treatment._();

  /// Arınma [today] günü sürüyor mu (gün olarak, saat değil).
  bool activeOn(DateTime today) {
    final t = DateTime.utc(today.year, today.month, today.day);
    final u = DateTime.utc(
      withdrawalUntil.year,
      withdrawalUntil.month,
      withdrawalUntil.day,
    );
    return !u.isBefore(t);
  }

  factory Treatment.fromJson(Map<String, dynamic> json) =>
      _$TreatmentFromJson(json);
}
