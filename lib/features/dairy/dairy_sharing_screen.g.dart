// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dairy_sharing_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// İşletmenin mandıra paylaşım onayları (backend ADR 0137). Önbelleklenmez.

@ProviderFor(dairyShares)
final dairySharesProvider = DairySharesProvider._();

/// İşletmenin mandıra paylaşım onayları (backend ADR 0137). Önbelleklenmez.

final class DairySharesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DairyShare>>,
          List<DairyShare>,
          FutureOr<List<DairyShare>>
        >
    with $FutureModifier<List<DairyShare>>, $FutureProvider<List<DairyShare>> {
  /// İşletmenin mandıra paylaşım onayları (backend ADR 0137). Önbelleklenmez.
  DairySharesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dairySharesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dairySharesHash();

  @$internal
  @override
  $FutureProviderElement<List<DairyShare>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DairyShare>> create(Ref ref) {
    return dairyShares(ref);
  }
}

String _$dairySharesHash() => r'c69297eece27259f199d935affc2e10189440cab';

/// Onay verilebilecek mandıralar.

@ProviderFor(dairies)
final dairiesProvider = DairiesProvider._();

/// Onay verilebilecek mandıralar.

final class DairiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Dairy>>,
          List<Dairy>,
          FutureOr<List<Dairy>>
        >
    with $FutureModifier<List<Dairy>>, $FutureProvider<List<Dairy>> {
  /// Onay verilebilecek mandıralar.
  DairiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dairiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dairiesHash();

  @$internal
  @override
  $FutureProviderElement<List<Dairy>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Dairy>> create(Ref ref) {
    return dairies(ref);
  }
}

String _$dairiesHash() => r'124addba9b953b57492d403484b09d18226f72eb';
