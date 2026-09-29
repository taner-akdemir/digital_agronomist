// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_keys_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// İşletmenin etkin API anahtarları (backend ADR 0126). Önbelleklenmez.

@ProviderFor(apiKeys)
final apiKeysProvider = ApiKeysProvider._();

/// İşletmenin etkin API anahtarları (backend ADR 0126). Önbelleklenmez.

final class ApiKeysProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ApiKey>>,
          List<ApiKey>,
          FutureOr<List<ApiKey>>
        >
    with $FutureModifier<List<ApiKey>>, $FutureProvider<List<ApiKey>> {
  /// İşletmenin etkin API anahtarları (backend ADR 0126). Önbelleklenmez.
  ApiKeysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiKeysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiKeysHash();

  @$internal
  @override
  $FutureProviderElement<List<ApiKey>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ApiKey>> create(Ref ref) {
    return apiKeys(ref);
  }
}

String _$apiKeysHash() => r'ba999d4ff859de096e5565eba813f4feb3bbe9a0';
