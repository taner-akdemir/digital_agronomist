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

/// Bir hayvanın notları, en yeni üstte.

@ProviderFor(animalNotes)
final animalNotesProvider = AnimalNotesFamily._();

/// Bir hayvanın notları, en yeni üstte.

final class AnimalNotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AnimalNote>>,
          List<AnimalNote>,
          FutureOr<List<AnimalNote>>
        >
    with $FutureModifier<List<AnimalNote>>, $FutureProvider<List<AnimalNote>> {
  /// Bir hayvanın notları, en yeni üstte.
  AnimalNotesProvider._({
    required AnimalNotesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'animalNotesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$animalNotesHash();

  @override
  String toString() {
    return r'animalNotesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AnimalNote>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AnimalNote>> create(Ref ref) {
    final argument = this.argument as String;
    return animalNotes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalNotesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$animalNotesHash() => r'fd21ed759bea6570b1b9f0375ae8e3dae8a92fe1';

/// Bir hayvanın notları, en yeni üstte.

final class AnimalNotesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AnimalNote>>, String> {
  AnimalNotesFamily._()
    : super(
        retry: null,
        name: r'animalNotesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bir hayvanın notları, en yeni üstte.

  AnimalNotesProvider call(String animalId) =>
      AnimalNotesProvider._(argument: animalId, from: this);

  @override
  String toString() => r'animalNotesProvider';
}

/// Hiçbir hayvana kayıtlı olmayan okunmuş küpeler (backend ADR 0056).
/// Yalnızca işletme sahibinin ekranında izlenir; backend başkasına 403.

@ProviderFor(unmatchedTags)
final unmatchedTagsProvider = UnmatchedTagsProvider._();

/// Hiçbir hayvana kayıtlı olmayan okunmuş küpeler (backend ADR 0056).
/// Yalnızca işletme sahibinin ekranında izlenir; backend başkasına 403.

final class UnmatchedTagsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UnmatchedTagRow>>,
          List<UnmatchedTagRow>,
          FutureOr<List<UnmatchedTagRow>>
        >
    with
        $FutureModifier<List<UnmatchedTagRow>>,
        $FutureProvider<List<UnmatchedTagRow>> {
  /// Hiçbir hayvana kayıtlı olmayan okunmuş küpeler (backend ADR 0056).
  /// Yalnızca işletme sahibinin ekranında izlenir; backend başkasına 403.
  UnmatchedTagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unmatchedTagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unmatchedTagsHash();

  @$internal
  @override
  $FutureProviderElement<List<UnmatchedTagRow>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UnmatchedTagRow>> create(Ref ref) {
    return unmatchedTags(ref);
  }
}

String _$unmatchedTagsHash() => r'f66c2b0a4ac1268641e57625b6ab75309d2db001';

/// Nokta kimliği → "A-1 · Nokta 7". Tanınmayan küpenin nerede okunduğunu
/// kimlikle değil sağımcının bildiği adla göstermek için.

@ProviderFor(spoutLabels)
final spoutLabelsProvider = SpoutLabelsProvider._();

/// Nokta kimliği → "A-1 · Nokta 7". Tanınmayan küpenin nerede okunduğunu
/// kimlikle değil sağımcının bildiği adla göstermek için.

final class SpoutLabelsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, String>>,
          Map<String, String>,
          FutureOr<Map<String, String>>
        >
    with
        $FutureModifier<Map<String, String>>,
        $FutureProvider<Map<String, String>> {
  /// Nokta kimliği → "A-1 · Nokta 7". Tanınmayan küpenin nerede okunduğunu
  /// kimlikle değil sağımcının bildiği adla göstermek için.
  SpoutLabelsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spoutLabelsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spoutLabelsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, String>> create(Ref ref) {
    return spoutLabels(ref);
  }
}

String _$spoutLabelsHash() => r'70c3cdc158b7863c47c4680ccd8c0ac75a22543b';

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

/// keepAlive: filtre, onu okuyan ekran YOKKEN de yaşamalı.
///
/// Dashboard'daki "3 hayvan kuruya aday" satırı Geçmiş ekranı kurulmadan
/// önce filtreyi ayarlıyor; autoDispose ile bu değer ekran açılmadan
/// siliniyor ve kullanıcı 30 hayvanın tamamını görüyordu. Ayrıca sekmeden
/// çıkıp dönünce seçimin durması beklenen davranış — kabuk zaten sekme
/// yığınını koruyor.

@ProviderFor(AnimalFilterState)
final animalFilterStateProvider = AnimalFilterStateProvider._();

/// keepAlive: filtre, onu okuyan ekran YOKKEN de yaşamalı.
///
/// Dashboard'daki "3 hayvan kuruya aday" satırı Geçmiş ekranı kurulmadan
/// önce filtreyi ayarlıyor; autoDispose ile bu değer ekran açılmadan
/// siliniyor ve kullanıcı 30 hayvanın tamamını görüyordu. Ayrıca sekmeden
/// çıkıp dönünce seçimin durması beklenen davranış — kabuk zaten sekme
/// yığınını koruyor.
final class AnimalFilterStateProvider
    extends $NotifierProvider<AnimalFilterState, AnimalFilter> {
  /// keepAlive: filtre, onu okuyan ekran YOKKEN de yaşamalı.
  ///
  /// Dashboard'daki "3 hayvan kuruya aday" satırı Geçmiş ekranı kurulmadan
  /// önce filtreyi ayarlıyor; autoDispose ile bu değer ekran açılmadan
  /// siliniyor ve kullanıcı 30 hayvanın tamamını görüyordu. Ayrıca sekmeden
  /// çıkıp dönünce seçimin durması beklenen davranış — kabuk zaten sekme
  /// yığınını koruyor.
  AnimalFilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animalFilterStateProvider',
        isAutoDispose: false,
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

String _$animalFilterStateHash() => r'9bfba3297f49db71648cdb110ce2f9f7f84cda52';

/// keepAlive: filtre, onu okuyan ekran YOKKEN de yaşamalı.
///
/// Dashboard'daki "3 hayvan kuruya aday" satırı Geçmiş ekranı kurulmadan
/// önce filtreyi ayarlıyor; autoDispose ile bu değer ekran açılmadan
/// siliniyor ve kullanıcı 30 hayvanın tamamını görüyordu. Ayrıca sekmeden
/// çıkıp dönünce seçimin durması beklenen davranış — kabuk zaten sekme
/// yığınını koruyor.

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

String _$filteredAnimalsHash() => r'c7344ce9c0388b94e62ce8cfe1682ff315532868';
