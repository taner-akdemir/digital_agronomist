// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliveries_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tank teslimleri (backend ADR 0089).

@ProviderFor(deliveries)
final deliveriesProvider = DeliveriesProvider._();

/// Tank teslimleri (backend ADR 0089).

final class DeliveriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Deliveries>,
          Deliveries,
          FutureOr<Deliveries>
        >
    with $FutureModifier<Deliveries>, $FutureProvider<Deliveries> {
  /// Tank teslimleri (backend ADR 0089).
  DeliveriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deliveriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deliveriesHash();

  @$internal
  @override
  $FutureProviderElement<Deliveries> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Deliveries> create(Ref ref) {
    return deliveries(ref);
  }
}

String _$deliveriesHash() => r'6c1d03bbf502e9d422c049e6b7f66d52bc0f0f4d';
