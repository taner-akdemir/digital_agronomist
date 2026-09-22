// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Uyarı listesi (§8.5 GET /alerts).
///
/// SIRALAMA: önce açık uyarılar, sonra yeniden eskiye. Zamana göre düz
/// sıralamak, dün okunmuş bir uyarıyı bu sabahki açık uyarının üstüne
/// koyabilirdi.

@ProviderFor(AlertList)
final alertListProvider = AlertListProvider._();

/// Uyarı listesi (§8.5 GET /alerts).
///
/// SIRALAMA: önce açık uyarılar, sonra yeniden eskiye. Zamana göre düz
/// sıralamak, dün okunmuş bir uyarıyı bu sabahki açık uyarının üstüne
/// koyabilirdi.
final class AlertListProvider
    extends $AsyncNotifierProvider<AlertList, List<Alert>> {
  /// Uyarı listesi (§8.5 GET /alerts).
  ///
  /// SIRALAMA: önce açık uyarılar, sonra yeniden eskiye. Zamana göre düz
  /// sıralamak, dün okunmuş bir uyarıyı bu sabahki açık uyarının üstüne
  /// koyabilirdi.
  AlertListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alertListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alertListHash();

  @$internal
  @override
  AlertList create() => AlertList();
}

String _$alertListHash() => r'303985eab07b1d44b9aeaab0aa3e48ab1248f857';

/// Uyarı listesi (§8.5 GET /alerts).
///
/// SIRALAMA: önce açık uyarılar, sonra yeniden eskiye. Zamana göre düz
/// sıralamak, dün okunmuş bir uyarıyı bu sabahki açık uyarının üstüne
/// koyabilirdi.

abstract class _$AlertList extends $AsyncNotifier<List<Alert>> {
  FutureOr<List<Alert>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Alert>>, List<Alert>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Alert>>, List<Alert>>,
              AsyncValue<List<Alert>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Açık (okunmamış) uyarı sayısı — üst çubuktaki zilin rozeti.

@ProviderFor(openAlertCount)
final openAlertCountProvider = OpenAlertCountProvider._();

/// Açık (okunmamış) uyarı sayısı — üst çubuktaki zilin rozeti.

final class OpenAlertCountProvider extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Açık (okunmamış) uyarı sayısı — üst çubuktaki zilin rozeti.
  OpenAlertCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openAlertCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openAlertCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return openAlertCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$openAlertCountHash() => r'b2494adbcd0eeecbd873004c6c3915f623aa73c2';
