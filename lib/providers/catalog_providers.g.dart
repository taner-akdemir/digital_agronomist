// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nadiren değişen katalog verisi: bölgeler, türler, eşikler, hayvanlar.
///
/// ÜÇ SEKME de bunları okuyor (Canlı, Geçmiş, Cihazlar). Önce canlı ekranın
/// kendi dosyasındaydılar; Geçmiş'in Canlı'dan provider almak zorunda
/// kalması, iki sekmeyi birbirine gereksiz yere bağlardı.

@ProviderFor(halls)
final hallsProvider = HallsProvider._();

/// Nadiren değişen katalog verisi: bölgeler, türler, eşikler, hayvanlar.
///
/// ÜÇ SEKME de bunları okuyor (Canlı, Geçmiş, Cihazlar). Önce canlı ekranın
/// kendi dosyasındaydılar; Geçmiş'in Canlı'dan provider almak zorunda
/// kalması, iki sekmeyi birbirine gereksiz yere bağlardı.

final class HallsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Hall>>,
          List<Hall>,
          FutureOr<List<Hall>>
        >
    with $FutureModifier<List<Hall>>, $FutureProvider<List<Hall>> {
  /// Nadiren değişen katalog verisi: bölgeler, türler, eşikler, hayvanlar.
  ///
  /// ÜÇ SEKME de bunları okuyor (Canlı, Geçmiş, Cihazlar). Önce canlı ekranın
  /// kendi dosyasındaydılar; Geçmiş'in Canlı'dan provider almak zorunda
  /// kalması, iki sekmeyi birbirine gereksiz yere bağlardı.
  HallsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hallsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hallsHash();

  @$internal
  @override
  $FutureProviderElement<List<Hall>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Hall>> create(Ref ref) {
    return halls(ref);
  }
}

String _$hallsHash() => r'1b4c5823ee4cb041a3c5c290300f8d6587b38f77';

@ProviderFor(speciesList)
final speciesListProvider = SpeciesListProvider._();

final class SpeciesListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Species>>,
          List<Species>,
          FutureOr<List<Species>>
        >
    with $FutureModifier<List<Species>>, $FutureProvider<List<Species>> {
  SpeciesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speciesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speciesListHash();

  @$internal
  @override
  $FutureProviderElement<List<Species>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Species>> create(Ref ref) {
    return speciesList(ref);
  }
}

String _$speciesListHash() => r'2a18d0a1e009f565b3cf8924b22b3d89ebaef96f';

@ProviderFor(thresholdsList)
final thresholdsListProvider = ThresholdsListProvider._();

final class ThresholdsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Thresholds>>,
          List<Thresholds>,
          FutureOr<List<Thresholds>>
        >
    with $FutureModifier<List<Thresholds>>, $FutureProvider<List<Thresholds>> {
  ThresholdsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'thresholdsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$thresholdsListHash();

  @$internal
  @override
  $FutureProviderElement<List<Thresholds>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Thresholds>> create(Ref ref) {
    return thresholdsList(ref);
  }
}

String _$thresholdsListHash() => r'7b513c30cbecd880034d2ef7bb23b2a1ee74a512';

@ProviderFor(animals)
final animalsProvider = AnimalsProvider._();

final class AnimalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Animal>>,
          List<Animal>,
          FutureOr<List<Animal>>
        >
    with $FutureModifier<List<Animal>>, $FutureProvider<List<Animal>> {
  AnimalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$animalsHash();

  @$internal
  @override
  $FutureProviderElement<List<Animal>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Animal>> create(Ref ref) {
    return animals(ref);
  }
}

String _$animalsHash() => r'1cb5caa6be6ae261d57b524eabc7a35faaeb2dd2';
