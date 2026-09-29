// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_location_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// İşletmenin tesisleri (konum ekranı için).

@ProviderFor(farmList)
final farmListProvider = FarmListProvider._();

/// İşletmenin tesisleri (konum ekranı için).

final class FarmListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Farm>>,
          List<Farm>,
          FutureOr<List<Farm>>
        >
    with $FutureModifier<List<Farm>>, $FutureProvider<List<Farm>> {
  /// İşletmenin tesisleri (konum ekranı için).
  FarmListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'farmListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$farmListHash();

  @$internal
  @override
  $FutureProviderElement<List<Farm>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Farm>> create(Ref ref) {
    return farmList(ref);
  }
}

String _$farmListHash() => r'4caf7010bab29f5ff713eaa7fb97f87cc28f4036';
