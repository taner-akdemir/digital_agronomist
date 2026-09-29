// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsStore)
final settingsStoreProvider = SettingsStoreProvider._();

final class SettingsStoreProvider
    extends $FunctionalProvider<SettingsStore, SettingsStore, SettingsStore>
    with $Provider<SettingsStore> {
  SettingsStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsStoreHash();

  @$internal
  @override
  $ProviderElement<SettingsStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsStore create(Ref ref) {
    return settingsStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsStore>(value),
    );
  }
}

String _$settingsStoreHash() => r'45f5f78429ebf4fc6692c79130bfb39b60d3eaa8';

/// Uygulama dili (backend ADR 0093): "tr", "en" ya da null (cihaz dili).

@ProviderFor(AppLanguage)
final appLanguageProvider = AppLanguageProvider._();

/// Uygulama dili (backend ADR 0093): "tr", "en" ya da null (cihaz dili).
final class AppLanguageProvider
    extends $NotifierProvider<AppLanguage, String?> {
  /// Uygulama dili (backend ADR 0093): "tr", "en" ya da null (cihaz dili).
  AppLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLanguageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLanguageHash();

  @$internal
  @override
  AppLanguage create() => AppLanguage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$appLanguageHash() => r'e8a86c698ea0dba7db4c237b6395bd385088ed60';

/// Uygulama dili (backend ADR 0093): "tr", "en" ya da null (cihaz dili).

abstract class _$AppLanguage extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Tema seçimi (backend ADR 0109): açık, karanlık ya da cihaz.
///
/// Varsayılan AÇIKTIR, cihaz değil: tasarım dili açık zemin; karanlık tema
/// isteyenin açıkça seçtiği bir tercihtir. Cihazda saklanır (hesapta değil):
/// aynı kişi ahırdaki tablette ve evdeki telefonda farklı isteyebilir.
/// Sağımhane tabletinde hesap kartı yok; tablet kayıtlı seçimi (yoksa
/// açığı) izler.

@ProviderFor(AppThemeMode)
final appThemeModeProvider = AppThemeModeProvider._();

/// Tema seçimi (backend ADR 0109): açık, karanlık ya da cihaz.
///
/// Varsayılan AÇIKTIR, cihaz değil: tasarım dili açık zemin; karanlık tema
/// isteyenin açıkça seçtiği bir tercihtir. Cihazda saklanır (hesapta değil):
/// aynı kişi ahırdaki tablette ve evdeki telefonda farklı isteyebilir.
/// Sağımhane tabletinde hesap kartı yok; tablet kayıtlı seçimi (yoksa
/// açığı) izler.
final class AppThemeModeProvider
    extends $NotifierProvider<AppThemeMode, ThemeMode> {
  /// Tema seçimi (backend ADR 0109): açık, karanlık ya da cihaz.
  ///
  /// Varsayılan AÇIKTIR, cihaz değil: tasarım dili açık zemin; karanlık tema
  /// isteyenin açıkça seçtiği bir tercihtir. Cihazda saklanır (hesapta değil):
  /// aynı kişi ahırdaki tablette ve evdeki telefonda farklı isteyebilir.
  /// Sağımhane tabletinde hesap kartı yok; tablet kayıtlı seçimi (yoksa
  /// açığı) izler.
  AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  AppThemeMode create() => AppThemeMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeModeHash() => r'69aed05ec2a3ae1e2c1d83994abd0e0374a103ca';

/// Tema seçimi (backend ADR 0109): açık, karanlık ya da cihaz.
///
/// Varsayılan AÇIKTIR, cihaz değil: tasarım dili açık zemin; karanlık tema
/// isteyenin açıkça seçtiği bir tercihtir. Cihazda saklanır (hesapta değil):
/// aynı kişi ahırdaki tablette ve evdeki telefonda farklı isteyebilir.
/// Sağımhane tabletinde hesap kartı yok; tablet kayıtlı seçimi (yoksa
/// açığı) izler.

abstract class _$AppThemeMode extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Cihazın parlaklığı; "Cihaz" seçiliyken tema bunu izler. Sistem ayarı
/// değişince (gece moduna geçiş) yeni değer yayınlanır.

@ProviderFor(PlatformBrightness)
final platformBrightnessProvider = PlatformBrightnessProvider._();

/// Cihazın parlaklığı; "Cihaz" seçiliyken tema bunu izler. Sistem ayarı
/// değişince (gece moduna geçiş) yeni değer yayınlanır.
final class PlatformBrightnessProvider
    extends $NotifierProvider<PlatformBrightness, Brightness> {
  /// Cihazın parlaklığı; "Cihaz" seçiliyken tema bunu izler. Sistem ayarı
  /// değişince (gece moduna geçiş) yeni değer yayınlanır.
  PlatformBrightnessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'platformBrightnessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$platformBrightnessHash();

  @$internal
  @override
  PlatformBrightness create() => PlatformBrightness();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Brightness value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Brightness>(value),
    );
  }
}

String _$platformBrightnessHash() =>
    r'0b92db89ab461c6a9262cac5f8fae8d369c674cb';

/// Cihazın parlaklığı; "Cihaz" seçiliyken tema bunu izler. Sistem ayarı
/// değişince (gece moduna geçiş) yeni değer yayınlanır.

abstract class _$PlatformBrightness extends $Notifier<Brightness> {
  Brightness build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Brightness, Brightness>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Brightness, Brightness>,
              Brightness,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Ekranın gerçekte çizildiği parlaklık: seçim, "Cihaz" ise cihazınki.
/// Kök bunu `AppColors.brightness`'a yazar.

@ProviderFor(effectiveBrightness)
final effectiveBrightnessProvider = EffectiveBrightnessProvider._();

/// Ekranın gerçekte çizildiği parlaklık: seçim, "Cihaz" ise cihazınki.
/// Kök bunu `AppColors.brightness`'a yazar.

final class EffectiveBrightnessProvider
    extends $FunctionalProvider<Brightness, Brightness, Brightness>
    with $Provider<Brightness> {
  /// Ekranın gerçekte çizildiği parlaklık: seçim, "Cihaz" ise cihazınki.
  /// Kök bunu `AppColors.brightness`'a yazar.
  EffectiveBrightnessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveBrightnessProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveBrightnessHash();

  @$internal
  @override
  $ProviderElement<Brightness> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Brightness create(Ref ref) {
    return effectiveBrightness(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Brightness value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Brightness>(value),
    );
  }
}

String _$effectiveBrightnessHash() =>
    r'91422f682c2c812b9fc431d33d4eab88e87b478e';
