// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Hayvanın aktivitesi: son 48 saat saatlik, 14 gün günlük (backend ADR 0145).

@ProviderFor(animalActivity)
final animalActivityProvider = AnimalActivityFamily._();

/// Hayvanın aktivitesi: son 48 saat saatlik, 14 gün günlük (backend ADR 0145).

final class AnimalActivityProvider
    extends
        $FunctionalProvider<
          AsyncValue<AnimalActivity>,
          AnimalActivity,
          FutureOr<AnimalActivity>
        >
    with $FutureModifier<AnimalActivity>, $FutureProvider<AnimalActivity> {
  /// Hayvanın aktivitesi: son 48 saat saatlik, 14 gün günlük (backend ADR 0145).
  AnimalActivityProvider._({
    required AnimalActivityFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'animalActivityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$animalActivityHash();

  @override
  String toString() {
    return r'animalActivityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<AnimalActivity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AnimalActivity> create(Ref ref) {
    final argument = this.argument as String;
    return animalActivity(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalActivityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$animalActivityHash() => r'25d80db8fe4cbcb6b97f171116f1921145941632';

/// Hayvanın aktivitesi: son 48 saat saatlik, 14 gün günlük (backend ADR 0145).

final class AnimalActivityFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<AnimalActivity>, String> {
  AnimalActivityFamily._()
    : super(
        retry: null,
        name: r'animalActivityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Hayvanın aktivitesi: son 48 saat saatlik, 14 gün günlük (backend ADR 0145).

  AnimalActivityProvider call(String animalId) =>
      AnimalActivityProvider._(argument: animalId, from: this);

  @override
  String toString() => r'animalActivityProvider';
}

/// Aktivite cihazı bağlı hayvanlar, yükselişe göre azalan sırada; yükselişi
/// bilinmeyen (taban yok, veri yok) en sonda.

@ProviderFor(activityOverview)
final activityOverviewProvider = ActivityOverviewProvider._();

/// Aktivite cihazı bağlı hayvanlar, yükselişe göre azalan sırada; yükselişi
/// bilinmeyen (taban yok, veri yok) en sonda.

final class ActivityOverviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityOverviewRow>>,
          List<ActivityOverviewRow>,
          FutureOr<List<ActivityOverviewRow>>
        >
    with
        $FutureModifier<List<ActivityOverviewRow>>,
        $FutureProvider<List<ActivityOverviewRow>> {
  /// Aktivite cihazı bağlı hayvanlar, yükselişe göre azalan sırada; yükselişi
  /// bilinmeyen (taban yok, veri yok) en sonda.
  ActivityOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activityOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activityOverviewHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityOverviewRow>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityOverviewRow>> create(Ref ref) {
    return activityOverview(ref);
  }
}

String _$activityOverviewHash() => r'b65e711ecd81561b5a4061a507ef03ac631f5b1b';

/// Bağlanabilecek aktivite cihazları: işletmenin, hayvana bağlı olmayan
/// tasma / pedometreleri.

@ProviderFor(freeActivityDevices)
final freeActivityDevicesProvider = FreeActivityDevicesProvider._();

/// Bağlanabilecek aktivite cihazları: işletmenin, hayvana bağlı olmayan
/// tasma / pedometreleri.

final class FreeActivityDevicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Device>>,
          List<Device>,
          FutureOr<List<Device>>
        >
    with $FutureModifier<List<Device>>, $FutureProvider<List<Device>> {
  /// Bağlanabilecek aktivite cihazları: işletmenin, hayvana bağlı olmayan
  /// tasma / pedometreleri.
  FreeActivityDevicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'freeActivityDevicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$freeActivityDevicesHash();

  @$internal
  @override
  $FutureProviderElement<List<Device>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Device>> create(Ref ref) {
    return freeActivityDevices(ref);
  }
}

String _$freeActivityDevicesHash() =>
    r'41febdb0ed763186c18361cfe206e58f821b4521';
