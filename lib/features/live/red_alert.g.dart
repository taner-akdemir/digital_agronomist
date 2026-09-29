// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'red_alert.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsStore)
final settingsStoreProvider = SettingsStoreProvider._();

final class SettingsStoreProvider
    extends $FunctionalProvider<BoolStore, BoolStore, BoolStore>
    with $Provider<BoolStore> {
  SettingsStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsStoreHash();

  @$internal
  @override
  $ProviderElement<BoolStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BoolStore create(Ref ref) {
    return settingsStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoolStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoolStore>(value),
    );
  }
}

String _$settingsStoreHash() => r'a3ff63bac36d46e8f92b47c306a8180e10d3fbc5';

/// Uyarının çalınması; testte sahtesi konur.

@ProviderFor(redAlertSink)
final redAlertSinkProvider = RedAlertSinkProvider._();

/// Uyarının çalınması; testte sahtesi konur.

final class RedAlertSinkProvider
    extends
        $FunctionalProvider<void Function(), void Function(), void Function()>
    with $Provider<void Function()> {
  /// Uyarının çalınması; testte sahtesi konur.
  RedAlertSinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redAlertSinkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redAlertSinkHash();

  @$internal
  @override
  $ProviderElement<void Function()> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void Function() create(Ref ref) {
    return redAlertSink(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void Function()>(value),
    );
  }
}

String _$redAlertSinkHash() => r'8425472706c0c039eb130e41f7e5a578a20da6fb';

/// Uyarı açık mı; cihazda saklanır, varsayılan açık.

@ProviderFor(RedAlertEnabled)
final redAlertEnabledProvider = RedAlertEnabledProvider._();

/// Uyarı açık mı; cihazda saklanır, varsayılan açık.
final class RedAlertEnabledProvider
    extends $NotifierProvider<RedAlertEnabled, bool> {
  /// Uyarı açık mı; cihazda saklanır, varsayılan açık.
  RedAlertEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redAlertEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redAlertEnabledHash();

  @$internal
  @override
  RedAlertEnabled create() => RedAlertEnabled();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$redAlertEnabledHash() => r'ba19146c723cf19e7c7d60e24a570e419d7a7772';

/// Uyarı açık mı; cihazda saklanır, varsayılan açık.

abstract class _$RedAlertEnabled extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
