// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_factor_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// İki adımlı doğrulama durumu (backend ADR 0102).

@ProviderFor(twoFactorEnabled)
final twoFactorEnabledProvider = TwoFactorEnabledProvider._();

/// İki adımlı doğrulama durumu (backend ADR 0102).

final class TwoFactorEnabledProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// İki adımlı doğrulama durumu (backend ADR 0102).
  TwoFactorEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'twoFactorEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$twoFactorEnabledHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return twoFactorEnabled(ref);
  }
}

String _$twoFactorEnabledHash() => r'f2739d87dce129ef3a18db1d3edda4453e7b0558';
