import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/l10n/l10n.dart';

part 'species.freezed.dart';
part 'species.g.dart';

/// Tür — inek, keçi, koyun (§4). Eşikler tür bazındadır.
@freezed
abstract class Species with _$Species {
  const factory Species({
    required String id,

    /// Kanonik kod: cow | goat | sheep. Karşılaştırmalar BUNUNLA yapılır,
    /// Türkçe adla değil.
    required String code,

    /// Sunucunun verdiği Türkçe ad.
    required String nameTr,
  }) = _Species;

  const Species._();

  /// Arayüzdeki ad, seçili dilde (backend ADR 0093): bilinen kodlar
  /// çevrilir, tanınmayan tür sunucunun adıyla görünür.
  String get displayName {
    if (l10nLanguage == 'tr') return nameTr;
    return switch (code) {
      'cow' => l10n.speciesCow,
      'goat' => l10n.speciesGoat,
      'sheep' => l10n.speciesSheep,
      _ => nameTr,
    };
  }

  factory Species.fromJson(Map<String, dynamic> json) =>
      _$SpeciesFromJson(json);
}
