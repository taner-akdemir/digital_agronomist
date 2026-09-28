// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatments_card.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Hayvanın tedavileri (backend ADR 0084).

@ProviderFor(animalTreatments)
final animalTreatmentsProvider = AnimalTreatmentsFamily._();

/// Hayvanın tedavileri (backend ADR 0084).

final class AnimalTreatmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Treatment>>,
          List<Treatment>,
          FutureOr<List<Treatment>>
        >
    with $FutureModifier<List<Treatment>>, $FutureProvider<List<Treatment>> {
  /// Hayvanın tedavileri (backend ADR 0084).
  AnimalTreatmentsProvider._({
    required AnimalTreatmentsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'animalTreatmentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$animalTreatmentsHash();

  @override
  String toString() {
    return r'animalTreatmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Treatment>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Treatment>> create(Ref ref) {
    final argument = this.argument as String;
    return animalTreatments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AnimalTreatmentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$animalTreatmentsHash() => r'ff6364bf886b2a4009727c570ce3b814f6a35810';

/// Hayvanın tedavileri (backend ADR 0084).

final class AnimalTreatmentsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Treatment>>, String> {
  AnimalTreatmentsFamily._()
    : super(
        retry: null,
        name: r'animalTreatmentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Hayvanın tedavileri (backend ADR 0084).

  AnimalTreatmentsProvider call(String animalId) =>
      AnimalTreatmentsProvider._(argument: animalId, from: this);

  @override
  String toString() => r'animalTreatmentsProvider';
}
