// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farms_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Çiftliklerim (backend ADR 0116).

@ProviderFor(myFarms)
final myFarmsProvider = MyFarmsProvider._();

/// Çiftliklerim (backend ADR 0116).

final class MyFarmsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FarmSummary>>,
          List<FarmSummary>,
          FutureOr<List<FarmSummary>>
        >
    with
        $FutureModifier<List<FarmSummary>>,
        $FutureProvider<List<FarmSummary>> {
  /// Çiftliklerim (backend ADR 0116).
  MyFarmsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myFarmsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myFarmsHash();

  @$internal
  @override
  $FutureProviderElement<List<FarmSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FarmSummary>> create(Ref ref) {
    return myFarms(ref);
  }
}

String _$myFarmsHash() => r'ec3c6ae4006aa33c528504084b958c8fc0eead28';
