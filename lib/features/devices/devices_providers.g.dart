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
