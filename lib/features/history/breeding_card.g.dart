// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeding_card.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Hayvanın üreme kayıtları (backend ADR 0088).

@ProviderFor(animalBreeding)
final animalBreedingProvider = AnimalBreedingFamily._();

/// Hayvanın üreme kayıtları (backend ADR 0088).

final class AnimalBreedingProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BreedingEvent>>,
          List<BreedingEvent>,
          FutureOr<List<BreedingEvent>>
        >
    with
        $FutureModifier<List<BreedingEvent>>,
        $FutureProvider<List<BreedingEvent>> {
  /// Hayvanın üreme kayıtları (backend ADR 0088).
  AnimalBreedingProvider._({
    required AnimalBreedingFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'animalBreedingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$animalBreedingHash();

  @override
  String toString() {
    return r'animalBreedingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<BreedingEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BreedingEvent>> create(Ref ref) {
    final argument = this.argument as String;
    return animalBreeding(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalBreedingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$animalBreedingHash() => r'0daa31b6afc25d1f809264bda8eaa0cb5d98b80b';

/// Hayvanın üreme kayıtları (backend ADR 0088).

final class AnimalBreedingFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<BreedingEvent>>, String> {
  AnimalBreedingFamily._()
    : super(
        retry: null,
        name: r'animalBreedingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Hayvanın üreme kayıtları (backend ADR 0088).

  AnimalBreedingProvider call(String animalId) =>
      AnimalBreedingProvider._(argument: animalId, from: this);

  @override
  String toString() => r'animalBreedingProvider';
}

/// Yaklaşan doğum ve kuruya çıkarmalar (30 gün).

@ProviderFor(upcomingBreeding)
final upcomingBreedingProvider = UpcomingBreedingProvider._();

/// Yaklaşan doğum ve kuruya çıkarmalar (30 gün).

final class UpcomingBreedingProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingBreeding>>,
          List<UpcomingBreeding>,
          FutureOr<List<UpcomingBreeding>>
        >
    with
        $FutureModifier<List<UpcomingBreeding>>,
        $FutureProvider<List<UpcomingBreeding>> {
  /// Yaklaşan doğum ve kuruya çıkarmalar (30 gün).
  UpcomingBreedingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingBreedingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingBreedingHash();

  @$internal
  @override
  $FutureProviderElement<List<UpcomingBreeding>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UpcomingBreeding>> create(Ref ref) {
    return upcomingBreeding(ref);
  }
}

String _$upcomingBreedingHash() => r'd8eee0cafbf9e3091c8173e1b665cb636a196a63';
