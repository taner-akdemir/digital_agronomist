// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Geçmiş oturumlar (§8.5 GET /sessions).

@ProviderFor(pastSessions)
final pastSessionsProvider = PastSessionsProvider._();

/// Geçmiş oturumlar (§8.5 GET /sessions).

final class PastSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MilkingSession>>,
          List<MilkingSession>,
          FutureOr<List<MilkingSession>>
        >
    with
        $FutureModifier<List<MilkingSession>>,
        $FutureProvider<List<MilkingSession>> {
  /// Geçmiş oturumlar (§8.5 GET /sessions).
  PastSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pastSessionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pastSessionsHash();

  @$internal
  @override
  $FutureProviderElement<List<MilkingSession>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MilkingSession>> create(Ref ref) {
    return pastSessions(ref);
  }
}

String _$pastSessionsHash() => r'3aff06d2956e793c57263ada17260b213f254f99';

/// Bir hayvanın sağım geçmişi.

@ProviderFor(animalHistory)
final animalHistoryProvider = AnimalHistoryFamily._();

/// Bir hayvanın sağım geçmişi.

final class AnimalHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AnimalMilking>>,
          List<AnimalMilking>,
          FutureOr<List<AnimalMilking>>
        >
    with
        $FutureModifier<List<AnimalMilking>>,
        $FutureProvider<List<AnimalMilking>> {
  /// Bir hayvanın sağım geçmişi.
  AnimalHistoryProvider._({
    required AnimalHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'animalHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$animalHistoryHash();

  @override
  String toString() {
    return r'animalHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AnimalMilking>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AnimalMilking>> create(Ref ref) {
    final argument = this.argument as String;
    return animalHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$animalHistoryHash() => r'f8a69a271f40253160476ec5849fa6bc6f273b4d';

/// Bir hayvanın sağım geçmişi.

final class AnimalHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AnimalMilking>>, String> {
  AnimalHistoryFamily._()
    : super(
        retry: null,
        name: r'animalHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bir hayvanın sağım geçmişi.

  AnimalHistoryProvider call(String animalId) =>
      AnimalHistoryProvider._(argument: animalId, from: this);

  @override
  String toString() => r'animalHistoryProvider';
}

/// Bir hayvanın trendi ve sınıfı.

@ProviderFor(animalTrend)
final animalTrendProvider = AnimalTrendFamily._();

/// Bir hayvanın trendi ve sınıfı.

final class AnimalTrendProvider
    extends
        $FunctionalProvider<
          AsyncValue<AnimalTrend>,
          AnimalTrend,
          FutureOr<AnimalTrend>
        >
    with $FutureModifier<AnimalTrend>, $FutureProvider<AnimalTrend> {
  /// Bir hayvanın trendi ve sınıfı.
  AnimalTrendProvider._({
    required AnimalTrendFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'animalTrendProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$animalTrendHash();

  @override
  String toString() {
    return r'animalTrendProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AnimalTrend> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AnimalTrend> create(Ref ref) {
    final argument = this.argument as String;
    return animalTrend(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalTrendProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$animalTrendHash() => r'3aa333c60121e4ace0b37905030cd2365db96d64';

/// Bir hayvanın trendi ve sınıfı.

final class AnimalTrendFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AnimalTrend>, String> {
  AnimalTrendFamily._()
    : super(
        retry: null,
        name: r'animalTrendProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bir hayvanın trendi ve sınıfı.

  AnimalTrendProvider call(String animalId) =>
      AnimalTrendProvider._(argument: animalId, from: this);

  @override
  String toString() => r'animalTrendProvider';
}

@ProviderFor(AnimalFilterState)
final animalFilterStateProvider = AnimalFilterStateProvider._();

final class AnimalFilterStateProvider
    extends $NotifierProvider<AnimalFilterState, AnimalFilter> {
  AnimalFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animalFilterStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$animalFilterStateHash();

  @$internal
  @override
  AnimalFilterState create() => AnimalFilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnimalFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnimalFilter>(value),
    );
  }
}

String _$animalFilterStateHash() => r'3a9e8e47a38b5bdf8885f21f3a95fa024279bede';

abstract class _$AnimalFilterState extends $Notifier<AnimalFilter> {
  AnimalFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AnimalFilter, AnimalFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AnimalFilter, AnimalFilter>,
              AnimalFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Filtreden geçmiş hayvan listesi.
///
/// Sıralama SINIFA göre: ilgilenilmesi gereken hayvan (süt vermiyor, kuruya
/// aday, düşüşte) listenin başında olmalı. Küpe numarasına göre sıralamak,
/// 30 hayvanlık bir sürüde bile sorunlu olanı aramak demekti.

@ProviderFor(filteredAnimals)
final filteredAnimalsProvider = FilteredAnimalsProvider._();

/// Filtreden geçmiş hayvan listesi.
///
/// Sıralama SINIFA göre: ilgilenilmesi gereken hayvan (süt vermiyor, kuruya
/// aday, düşüşte) listenin başında olmalı. Küpe numarasına göre sıralamak,
/// 30 hayvanlık bir sürüde bile sorunlu olanı aramak demekti.

final class FilteredAnimalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Animal>>,
          List<Animal>,
          FutureOr<List<Animal>>
        >
    with $FutureModifier<List<Animal>>, $FutureProvider<List<Animal>> {
  /// Filtreden geçmiş hayvan listesi.
  ///
  /// Sıralama SINIFA göre: ilgilenilmesi gereken hayvan (süt vermiyor, kuruya
  /// aday, düşüşte) listenin başında olmalı. Küpe numarasına göre sıralamak,
  /// 30 hayvanlık bir sürüde bile sorunlu olanı aramak demekti.
  FilteredAnimalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredAnimalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredAnimalsHash();

  @$internal
  @override
  $FutureProviderElement<List<Animal>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Animal>> create(Ref ref) {
    return filteredAnimals(ref);
  }
}

String _$filteredAnimalsHash() => r'b59be6ec0ebdcd0dca9184cfe07368739817b4c4';
