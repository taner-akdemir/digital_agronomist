// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'milking_schedule_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Sağım saatleri (backend ADR 0099).

@ProviderFor(milkingSchedule)
final milkingScheduleProvider = MilkingScheduleProvider._();

/// Sağım saatleri (backend ADR 0099).

final class MilkingScheduleProvider
    extends
        $FunctionalProvider<
          AsyncValue<MilkingSchedule>,
          MilkingSchedule,
          FutureOr<MilkingSchedule>
        >
    with $FutureModifier<MilkingSchedule>, $FutureProvider<MilkingSchedule> {
  /// Sağım saatleri (backend ADR 0099).
  MilkingScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'milkingScheduleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$milkingScheduleHash();

  @$internal
  @override
  $FutureProviderElement<MilkingSchedule> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MilkingSchedule> create(Ref ref) {
    return milkingSchedule(ref);
  }
}

String _$milkingScheduleHash() => r'065edc3fcd38f323c7e206a98ca45b571bb70b52';
