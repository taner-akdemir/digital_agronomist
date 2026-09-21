// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Bölge listesi.
///
/// Bir kez yüklenir ve seçili bölgeden BAĞIMSIZDIR. Eski ekranda her bölge
/// değişiminde bölge listesi de yeniden çekiliyordu ve açılır menü kısa süre
/// kayboluyordu (§15.3/11).

@ProviderFor(halls)
final hallsProvider = HallsProvider._();

/// Bölge listesi.
///
/// Bir kez yüklenir ve seçili bölgeden BAĞIMSIZDIR. Eski ekranda her bölge
/// değişiminde bölge listesi de yeniden çekiliyordu ve açılır menü kısa süre
/// kayboluyordu (§15.3/11).

final class HallsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Hall>>,
          List<Hall>,
          FutureOr<List<Hall>>
        >
    with $FutureModifier<List<Hall>>, $FutureProvider<List<Hall>> {
  /// Bölge listesi.
  ///
  /// Bir kez yüklenir ve seçili bölgeden BAĞIMSIZDIR. Eski ekranda her bölge
  /// değişiminde bölge listesi de yeniden çekiliyordu ve açılır menü kısa süre
  /// kayboluyordu (§15.3/11).
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

/// Seçili sağım bölgesi.
///
/// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
/// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
/// Artık tek doğruluk kaynağı burası.

@ProviderFor(SelectedHall)
final selectedHallProvider = SelectedHallProvider._();

/// Seçili sağım bölgesi.
///
/// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
/// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
/// Artık tek doğruluk kaynağı burası.
final class SelectedHallProvider
    extends $NotifierProvider<SelectedHall, String?> {
  /// Seçili sağım bölgesi.
  ///
  /// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
  /// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
  /// Artık tek doğruluk kaynağı burası.
  SelectedHallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHallProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHallHash();

  @$internal
  @override
  SelectedHall create() => SelectedHall();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedHallHash() => r'4726e5308640a81c9a8f8082dc47e36d2cc75a66';

/// Seçili sağım bölgesi.
///
/// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
/// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
/// Artık tek doğruluk kaynağı burası.

abstract class _$SelectedHall extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Seçili bölge yoksa ilk bölgeye düşer.

@ProviderFor(effectiveHall)
final effectiveHallProvider = EffectiveHallProvider._();

/// Seçili bölge yoksa ilk bölgeye düşer.

final class EffectiveHallProvider
    extends $FunctionalProvider<AsyncValue<Hall?>, Hall?, FutureOr<Hall?>>
    with $FutureModifier<Hall?>, $FutureProvider<Hall?> {
  /// Seçili bölge yoksa ilk bölgeye düşer.
  EffectiveHallProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveHallProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveHallHash();

  @$internal
  @override
  $FutureProviderElement<Hall?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Hall?> create(Ref ref) {
    return effectiveHall(ref);
  }
}

String _$effectiveHallHash() => r'c387f07e764d4fb18a97f8cdff218d6561ffcd5c';

@ProviderFor(vacuumsByHall)
final vacuumsByHallProvider = VacuumsByHallFamily._();

final class VacuumsByHallProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Vacuum>>,
          List<Vacuum>,
          FutureOr<List<Vacuum>>
        >
    with $FutureModifier<List<Vacuum>>, $FutureProvider<List<Vacuum>> {
  VacuumsByHallProvider._({
    required VacuumsByHallFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'vacuumsByHallProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$vacuumsByHallHash();

  @override
  String toString() {
    return r'vacuumsByHallProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Vacuum>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vacuum>> create(Ref ref) {
    final argument = this.argument as String;
    return vacuumsByHall(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is VacuumsByHallProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$vacuumsByHallHash() => r'b4d647a44353ddbcb5c6fe08f3c581df4b8eb7c8';

final class VacuumsByHallFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Vacuum>>, String> {
  VacuumsByHallFamily._()
    : super(
        retry: null,
        name: r'vacuumsByHallProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  VacuumsByHallProvider call(String hallId) =>
      VacuumsByHallProvider._(argument: hallId, from: this);

  @override
  String toString() => r'vacuumsByHallProvider';
}

/// Bölgedeki tüm noktalar.
///
/// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
/// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
/// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
/// Burada iki çağrı birlikte beklenir.

@ProviderFor(spoutsByHall)
final spoutsByHallProvider = SpoutsByHallFamily._();

/// Bölgedeki tüm noktalar.
///
/// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
/// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
/// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
/// Burada iki çağrı birlikte beklenir.

final class SpoutsByHallProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Spout>>,
          List<Spout>,
          FutureOr<List<Spout>>
        >
    with $FutureModifier<List<Spout>>, $FutureProvider<List<Spout>> {
  /// Bölgedeki tüm noktalar.
  ///
  /// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
  /// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
  /// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
  /// Burada iki çağrı birlikte beklenir.
  SpoutsByHallProvider._({
    required SpoutsByHallFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'spoutsByHallProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spoutsByHallHash();

  @override
  String toString() {
    return r'spoutsByHallProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Spout>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Spout>> create(Ref ref) {
    final argument = this.argument as String;
    return spoutsByHall(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpoutsByHallProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spoutsByHallHash() => r'1e1aa982026be126fbb89fb29c772b4dc3114733';

/// Bölgedeki tüm noktalar.
///
/// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
/// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
/// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
/// Burada iki çağrı birlikte beklenir.

final class SpoutsByHallFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Spout>>, String> {
  SpoutsByHallFamily._()
    : super(
        retry: null,
        name: r'spoutsByHallProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bölgedeki tüm noktalar.
  ///
  /// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
  /// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
  /// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
  /// Burada iki çağrı birlikte beklenir.

  SpoutsByHallProvider call(String hallId) =>
      SpoutsByHallProvider._(argument: hallId, from: this);

  @override
  String toString() => r'spoutsByHallProvider';
}

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

@ProviderFor(LiveBoard)
final liveBoardProvider = LiveBoardFamily._();

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.
final class LiveBoardProvider
    extends $AsyncNotifierProvider<LiveBoard, List<SpoutUpdate>> {
  /// Bölgenin canlı sağım durumu.
  ///
  /// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
  /// Gelen her güncelleme nokta kimliğine göre yerine yazılır.
  LiveBoardProvider._({
    required LiveBoardFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'liveBoardProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$liveBoardHash();

  @override
  String toString() {
    return r'liveBoardProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LiveBoard create() => LiveBoard();

  @override
  bool operator ==(Object other) {
    return other is LiveBoardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$liveBoardHash() => r'70bbed448c1180eb62ec511a8f08cedf62da28de';

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

final class LiveBoardFamily extends $Family
    with
        $ClassFamilyOverride<
          LiveBoard,
          AsyncValue<List<SpoutUpdate>>,
          List<SpoutUpdate>,
          FutureOr<List<SpoutUpdate>>,
          String
        > {
  LiveBoardFamily._()
    : super(
        retry: null,
        name: r'liveBoardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Bölgenin canlı sağım durumu.
  ///
  /// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
  /// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

  LiveBoardProvider call(String hallId) =>
      LiveBoardProvider._(argument: hallId, from: this);

  @override
  String toString() => r'liveBoardProvider';
}

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.

abstract class _$LiveBoard extends $AsyncNotifier<List<SpoutUpdate>> {
  late final _$args = ref.$arg as String;
  String get hallId => _$args;

  FutureOr<List<SpoutUpdate>> build(String hallId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SpoutUpdate>>, List<SpoutUpdate>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<SpoutUpdate>>, List<SpoutUpdate>>,
              AsyncValue<List<SpoutUpdate>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
