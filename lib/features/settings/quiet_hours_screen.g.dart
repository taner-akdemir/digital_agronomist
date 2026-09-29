// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiet_hours_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kişinin sessiz saati (backend ADR 0107).

@ProviderFor(quietHours)
final quietHoursProvider = QuietHoursProvider._();

/// Kişinin sessiz saati (backend ADR 0107).

final class QuietHoursProvider
    extends
        $FunctionalProvider<
          AsyncValue<QuietHours>,
          QuietHours,
          FutureOr<QuietHours>
        >
    with $FutureModifier<QuietHours>, $FutureProvider<QuietHours> {
  /// Kişinin sessiz saati (backend ADR 0107).
  QuietHoursProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quietHoursProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quietHoursHash();

  @$internal
  @override
  $FutureProviderElement<QuietHours> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<QuietHours> create(Ref ref) {
    return quietHours(ref);
  }
}

String _$quietHoursHash() => r'e99fbcce2c6eb7743090cf708fcaefba9e8bebdb';
