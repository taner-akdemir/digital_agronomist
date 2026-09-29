// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ağacı tek seferde kurar.
///
/// Dört çağrı BİRLİKTE beklenir. Sırayla beklenseydi ekran dört kez
/// yeniden çizilir ve ara karelerde yarım bir ağaç görünürdü; eski
/// spout_list_screen'in sayımları iki Future'ın bitiş SIRASINA bağlıydı ve
/// tesadüfen doğru çalışıyordu (§15.3/9).

@ProviderFor(deviceTree)
final deviceTreeProvider = DeviceTreeProvider._();

/// Ağacı tek seferde kurar.
///
/// Dört çağrı BİRLİKTE beklenir. Sırayla beklenseydi ekran dört kez
/// yeniden çizilir ve ara karelerde yarım bir ağaç görünürdü; eski
/// spout_list_screen'in sayımları iki Future'ın bitiş SIRASINA bağlıydı ve
/// tesadüfen doğru çalışıyordu (§15.3/9).

final class DeviceTreeProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceTree>,
          DeviceTree,
          FutureOr<DeviceTree>
        >
    with $FutureModifier<DeviceTree>, $FutureProvider<DeviceTree> {
  /// Ağacı tek seferde kurar.
  ///
  /// Dört çağrı BİRLİKTE beklenir. Sırayla beklenseydi ekran dört kez
  /// yeniden çizilir ve ara karelerde yarım bir ağaç görünürdü; eski
  /// spout_list_screen'in sayımları iki Future'ın bitiş SIRASINA bağlıydı ve
  /// tesadüfen doğru çalışıyordu (§15.3/9).
  DeviceTreeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceTreeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceTreeHash();

  @$internal
  @override
  $FutureProviderElement<DeviceTree> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceTree> create(Ref ref) {
    return deviceTree(ref);
  }
}

String _$deviceTreeHash() => r'eb12b951da672548bb37d90a533435aac836a28b';

/// Nokta sağlığı (backend ADR 0113), noktaya göre. Okunamazsa BOŞ: ağaç ve
/// sayaç durumu bu ek bilgi yüzünden düşmesin.

@ProviderFor(spoutHealth)
final spoutHealthProvider = SpoutHealthProvider._();

/// Nokta sağlığı (backend ADR 0113), noktaya göre. Okunamazsa BOŞ: ağaç ve
/// sayaç durumu bu ek bilgi yüzünden düşmesin.

final class SpoutHealthProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, SpoutHealth>>,
          Map<String, SpoutHealth>,
          FutureOr<Map<String, SpoutHealth>>
        >
    with
        $FutureModifier<Map<String, SpoutHealth>>,
        $FutureProvider<Map<String, SpoutHealth>> {
  /// Nokta sağlığı (backend ADR 0113), noktaya göre. Okunamazsa BOŞ: ağaç ve
  /// sayaç durumu bu ek bilgi yüzünden düşmesin.
  SpoutHealthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spoutHealthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spoutHealthHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, SpoutHealth>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, SpoutHealth>> create(Ref ref) {
    return spoutHealth(ref);
  }
}

String _$spoutHealthHash() => r'5fdb0c54420b2fc0096e757575ede0f20891acc9';

/// Sayaç kontrolü özetleri (backend ADR 0124), sayaca göre. Okunamazsa BOŞ:
/// ağaç ve sayaç durumu bu ek bilgi yüzünden düşmesin.

@ProviderFor(meterSummaries)
final meterSummariesProvider = MeterSummariesProvider._();

/// Sayaç kontrolü özetleri (backend ADR 0124), sayaca göre. Okunamazsa BOŞ:
/// ağaç ve sayaç durumu bu ek bilgi yüzünden düşmesin.

final class MeterSummariesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, MeterSummary>>,
          Map<String, MeterSummary>,
          FutureOr<Map<String, MeterSummary>>
        >
    with
        $FutureModifier<Map<String, MeterSummary>>,
        $FutureProvider<Map<String, MeterSummary>> {
  /// Sayaç kontrolü özetleri (backend ADR 0124), sayaca göre. Okunamazsa BOŞ:
  /// ağaç ve sayaç durumu bu ek bilgi yüzünden düşmesin.
  MeterSummariesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meterSummariesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meterSummariesHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, MeterSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, MeterSummary>> create(Ref ref) {
    return meterSummaries(ref);
  }
}

String _$meterSummariesHash() => r'6635118763c60a6c42dd5d2b0b76200f459c3d7e';

/// Sayacın son kontrolleri ve özeti (sayaç sayfası).

@ProviderFor(deviceMeterChecks)
final deviceMeterChecksProvider = DeviceMeterChecksFamily._();

/// Sayacın son kontrolleri ve özeti (sayaç sayfası).

final class DeviceMeterChecksProvider
    extends
        $FunctionalProvider<
          AsyncValue<MeterChecks>,
          MeterChecks,
          FutureOr<MeterChecks>
        >
    with $FutureModifier<MeterChecks>, $FutureProvider<MeterChecks> {
  /// Sayacın son kontrolleri ve özeti (sayaç sayfası).
  DeviceMeterChecksProvider._({
    required DeviceMeterChecksFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'deviceMeterChecksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$deviceMeterChecksHash();

  @override
  String toString() {
    return r'deviceMeterChecksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MeterChecks> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MeterChecks> create(Ref ref) {
    final argument = this.argument as String;
    return deviceMeterChecks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DeviceMeterChecksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$deviceMeterChecksHash() => r'942427b48bf22178cb0c4e5389b7728986720071';

/// Sayacın son kontrolleri ve özeti (sayaç sayfası).

final class DeviceMeterChecksFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MeterChecks>, String> {
  DeviceMeterChecksFamily._()
    : super(
        retry: null,
        name: r'deviceMeterChecksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Sayacın son kontrolleri ve özeti (sayaç sayfası).

  DeviceMeterChecksProvider call(String deviceId) =>
      DeviceMeterChecksProvider._(argument: deviceId, from: this);

  @override
  String toString() => r'deviceMeterChecksProvider';
}
