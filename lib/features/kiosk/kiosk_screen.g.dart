// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kiosk_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ekranın kararmasını açıp kapatır; testte sahtesi konur.

@ProviderFor(screenAwake)
final screenAwakeProvider = ScreenAwakeProvider._();

/// Ekranın kararmasını açıp kapatır; testte sahtesi konur.

final class ScreenAwakeProvider
    extends
        $FunctionalProvider<
          Future<void> Function(bool on),
          Future<void> Function(bool on),
          Future<void> Function(bool on)
        >
    with $Provider<Future<void> Function(bool on)> {
  /// Ekranın kararmasını açıp kapatır; testte sahtesi konur.
  ScreenAwakeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenAwakeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenAwakeHash();

  @$internal
  @override
  $ProviderElement<Future<void> Function(bool on)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<void> Function(bool on) create(Ref ref) {
    return screenAwake(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<void> Function(bool on) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<void> Function(bool on)>(
        value,
      ),
    );
  }
}

String _$screenAwakeHash() => r'1594e45512c64e6836a13a9d3e72fae863e382bd';
