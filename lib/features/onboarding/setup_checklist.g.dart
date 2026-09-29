// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_checklist.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kurulum listesinin kapatılması (backend ADR 0123): cihazda, işletme
/// başına. Okunamazsa kapatılmamış sayılır.

@ProviderFor(SetupDismissed)
final setupDismissedProvider = SetupDismissedProvider._();

/// Kurulum listesinin kapatılması (backend ADR 0123): cihazda, işletme
/// başına. Okunamazsa kapatılmamış sayılır.
final class SetupDismissedProvider
    extends $NotifierProvider<SetupDismissed, bool> {
  /// Kurulum listesinin kapatılması (backend ADR 0123): cihazda, işletme
  /// başına. Okunamazsa kapatılmamış sayılır.
  SetupDismissedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setupDismissedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setupDismissedHash();

  @$internal
  @override
  SetupDismissed create() => SetupDismissed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$setupDismissedHash() => r'9b3dc34c3719f65b96640fd129db44c188fc7a4a';

/// Kurulum listesinin kapatılması (backend ADR 0123): cihazda, işletme
/// başına. Okunamazsa kapatılmamış sayılır.

abstract class _$SetupDismissed extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
