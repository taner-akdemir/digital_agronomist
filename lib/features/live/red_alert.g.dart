// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'red_alert.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Canlı ekranda kırmızı uyarısı (backend ADR 0091): bir nokta KIRMIZIYA
/// geçince titreşim + kısa ses, aynı sağım için bir kez.
///
/// Renk sunucunundur (§6.2): ısınma ve bitiş bastırması orada uygulanmış
/// olarak gelir, burada ikinci bir kural yok.
/// Uyarının çalınması; testte sahtesi konur.

@ProviderFor(redAlertSink)
final redAlertSinkProvider = RedAlertSinkProvider._();

/// Canlı ekranda kırmızı uyarısı (backend ADR 0091): bir nokta KIRMIZIYA
/// geçince titreşim + kısa ses, aynı sağım için bir kez.
///
/// Renk sunucunundur (§6.2): ısınma ve bitiş bastırması orada uygulanmış
/// olarak gelir, burada ikinci bir kural yok.
/// Uyarının çalınması; testte sahtesi konur.

final class RedAlertSinkProvider
    extends
        $FunctionalProvider<void Function(), void Function(), void Function()>
    with $Provider<void Function()> {
  /// Canlı ekranda kırmızı uyarısı (backend ADR 0091): bir nokta KIRMIZIYA
  /// geçince titreşim + kısa ses, aynı sağım için bir kez.
  ///
  /// Renk sunucunundur (§6.2): ısınma ve bitiş bastırması orada uygulanmış
  /// olarak gelir, burada ikinci bir kural yok.
  /// Uyarının çalınması; testte sahtesi konur.
  RedAlertSinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redAlertSinkProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redAlertSinkHash();

  @$internal
  @override
  $ProviderElement<void Function()> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void Function() create(Ref ref) {
    return redAlertSink(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void Function()>(value),
    );
  }
}

String _$redAlertSinkHash() => r'8425472706c0c039eb130e41f7e5a578a20da6fb';

/// Uyarı açık mı; cihazda saklanır, varsayılan açık.

@ProviderFor(RedAlertEnabled)
final redAlertEnabledProvider = RedAlertEnabledProvider._();

/// Uyarı açık mı; cihazda saklanır, varsayılan açık.
final class RedAlertEnabledProvider
    extends $NotifierProvider<RedAlertEnabled, bool> {
  /// Uyarı açık mı; cihazda saklanır, varsayılan açık.
  RedAlertEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'redAlertEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$redAlertEnabledHash();

  @$internal
  @override
  RedAlertEnabled create() => RedAlertEnabled();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$redAlertEnabledHash() => r'8f37eda1590f1b46a83b307a2beda268a1f78a28';

/// Uyarı açık mı; cihazda saklanır, varsayılan açık.

abstract class _$RedAlertEnabled extends $Notifier<bool> {
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
