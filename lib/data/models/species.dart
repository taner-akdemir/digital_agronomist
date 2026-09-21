import 'package:freezed_annotation/freezed_annotation.dart';

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

    /// Arayüzde gösterilen Türkçe ad.
    required String nameTr,
  }) = _Species;

  factory Species.fromJson(Map<String, dynamic> json) => _$SpeciesFromJson(json);
}
