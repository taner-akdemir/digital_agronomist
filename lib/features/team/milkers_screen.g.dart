// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milkers_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Sağımcı özeti (backend ADR 0090).

@ProviderFor(milkers)
final milkersProvider = MilkersFamily._();

/// Sağımcı özeti (backend ADR 0090).

final class MilkersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Milker>>,
          List<Milker>,
          FutureOr<List<Milker>>
        >
    with $FutureModifier<List<Milker>>, $FutureProvider<List<Milker>> {
  /// Sağımcı özeti (backend ADR 0090).
  MilkersProvider._({
    required MilkersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'milkersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$milkersHash();

  @override
  String toString() {
    return r'milkersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Milker>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Milker>> create(Ref ref) {
    final argument = this.argument as int;
    return milkers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MilkersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$milkersHash() => r'3da1bbfd350b870e2d7e0a87376c6917e0a8b072';

/// Sağımcı özeti (backend ADR 0090).

final class MilkersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Milker>>, int> {
  MilkersFamily._()
    : super(
        retry: null,
        name: r'milkersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Sağımcı özeti (backend ADR 0090).

  MilkersProvider call(int days) =>
      MilkersProvider._(argument: days, from: this);

  @override
  String toString() => r'milkersProvider';
}
