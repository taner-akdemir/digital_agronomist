import 'package:freezed_annotation/freezed_annotation.dart';

part 'vaccination.freezed.dart';
part 'vaccination.g.dart';

/// Aşı ve ilaç takvimi (backend ADR 0112).

/// Günü takvim günü olarak alır; sunucu tarihi "2026-10-03T00:00:00Z"
/// gönderir ve yerel saate çevirmek batıdaki bir cihazda günü kaydırırdı.
DateTime vaccineDay(DateTime d) => DateTime(d.year, d.month, d.day);

/// Tekrarlayan uygulama planı ("Şap", 180 günde bir) ve durumu.
@freezed
abstract class VaccinePlan with _$VaccinePlan {
  const factory VaccinePlan({
    required String id,
    required String name,
    required int intervalDays,

    /// Null: bütün türler.
    String? speciesId,
    @Default('') String note,

    /// Plana giren (sağmal ya da kurudaki) hayvan.
    @Default(0) int animals,

    /// Zamanı geçmiş ya da 7 gün içinde olan; [never] buna dahil.
    @Default(0) int dueSoon,

    /// Hiç uygulanmamış.
    @Default(0) int never,
  }) = _VaccinePlan;

  factory VaccinePlan.fromJson(Map<String, dynamic> json) =>
      _$VaccinePlanFromJson(json);
}

/// Planın bir hayvandaki sırası. [dueOn] null: hiç uygulanmadı ("kayıt
/// yok") — zamanı gelmiş sayılır.
@freezed
abstract class VaccinationDue with _$VaccinationDue {
  const factory VaccinationDue({
    required String planId,
    required String planName,
    required String animalId,
    required String earTag,
    @Default('') String animalName,
    DateTime? lastGivenOn,
    DateTime? dueOn,
  }) = _VaccinationDue;

  const VaccinationDue._();

  /// Zamanı [today] gününden önce miydi (gecikti). Kayıt yok da gecikmiş
  /// sayılmaz; ayrı gösterilir.
  bool overdueOn(DateTime today) =>
      dueOn != null && vaccineDay(dueOn!).isBefore(vaccineDay(today));

  factory VaccinationDue.fromJson(Map<String, dynamic> json) =>
      _$VaccinationDueFromJson(json);
}

/// Bir uygulama kaydı.
@freezed
abstract class Vaccination with _$Vaccination {
  const factory Vaccination({
    required String id,
    required String planId,
    required String planName,
    required String animalId,
    required DateTime givenOn,
    @Default('') String note,
    @Default('') String authorName,
    DateTime? createdAt,
  }) = _Vaccination;

  factory Vaccination.fromJson(Map<String, dynamic> json) =>
      _$VaccinationFromJson(json);
}

/// `GET /animals/{id}/vaccinations`: son uygulamalar ve planlardaki sıra.
@freezed
abstract class AnimalVaccinations with _$AnimalVaccinations {
  const factory AnimalVaccinations({
    @Default([]) List<Vaccination> items,
    @Default([]) List<VaccinationDue> due,
  }) = _AnimalVaccinations;

  factory AnimalVaccinations.fromJson(Map<String, dynamic> json) =>
      _$AnimalVaccinationsFromJson(json);
}
