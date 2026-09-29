import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/l10n/l10n.dart';

part 'breeding.freezed.dart';
part 'breeding.g.dart';

/// Hayvanın üreme durumu (backend ADR 0088); sunucu hesaplar.
@freezed
abstract class Pregnancy with _$Pregnancy {
  const factory Pregnancy({
    /// open | inseminated | pregnant. String: yeni durum ekranı düşürmesin.
    required String status,
    DateTime? lastInsemination,
    DateTime? expectedCalving,
    DateTime? dryOffDate,
  }) = _Pregnancy;

  const Pregnancy._();

  String get statusLabel => switch (status) {
    'pregnant' => l10n.modelPregnancyPregnant,
    'inseminated' => l10n.modelPregnancyInseminated,
    'open' => l10n.modelPregnancyOpen,
    _ => status,
  };

  factory Pregnancy.fromJson(Map<String, dynamic> json) =>
      _$PregnancyFromJson(json);
}

/// Tohumlama ya da gebelik kontrolü (backend ADR 0088).
@freezed
abstract class BreedingEvent with _$BreedingEvent {
  const factory BreedingEvent({
    required String id,
    required String animalId,

    /// insemination | pregnancy_check.
    required String kind,
    required DateTime eventDate,
    @Default('') String sire,

    /// pregnancy_check'te pregnant | open.
    String? result,
    @Default('') String note,
    String? authorName,
  }) = _BreedingEvent;

  const BreedingEvent._();

  bool get isInsemination => kind == 'insemination';

  /// "Tohumlama · Holstein 123" / "Gebelik kontrolü · gebe".
  String get label => isInsemination
      ? [l10n.modelBreedingInsemination, if (sire.isNotEmpty) sire].join(' · ')
      : l10n.modelBreedingPregnancyCheck(
          result == 'pregnant'
              ? l10n.modelBreedingResultPregnant
              : l10n.modelBreedingResultOpen,
        );

  factory BreedingEvent.fromJson(Map<String, dynamic> json) =>
      _$BreedingEventFromJson(json);
}

/// Yaklaşan doğum ya da kuruya çıkarma (`GET /breeding/upcoming`).
@freezed
abstract class UpcomingBreeding with _$UpcomingBreeding {
  const factory UpcomingBreeding({
    required String animalId,
    required String earTag,
    String? name,

    /// calving | dry_off.
    required String event,
    required DateTime date,
    @Default('') String status,
  }) = _UpcomingBreeding;

  const UpcomingBreeding._();

  String get eventLabel =>
      event == 'calving' ? l10n.modelUpcomingCalving : l10n.modelUpcomingDryOff;

  factory UpcomingBreeding.fromJson(Map<String, dynamic> json) =>
      _$UpcomingBreedingFromJson(json);
}
