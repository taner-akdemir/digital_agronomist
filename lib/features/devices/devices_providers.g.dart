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

String _$deviceTreeHash() => r'612c6a0ccedf90cf02a74460bf3ae13d6637506a';
