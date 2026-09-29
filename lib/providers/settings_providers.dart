import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_providers.g.dart';

/// Cihazda saklanan küçük ayarlar (kırmızı uyarısı, dil); testte sahtesi
/// konur. Okuma/yazma hatası ayarı varsayılana düşürür, uygulamayı değil.
abstract interface class SettingsStore {
  Future<bool?> readBool(String key);
  Future<void> writeBool(String key, bool value);
  Future<String?> readString(String key);
  Future<void> writeString(String key, String? value);
}

class _PrefsSettingsStore implements SettingsStore {
  SharedPreferencesAsync? _prefs;

  SharedPreferencesAsync get _p => _prefs ??= SharedPreferencesAsync();

  @override
  Future<bool?> readBool(String key) => _p.getBool(key);

  @override
  Future<void> writeBool(String key, bool value) => _p.setBool(key, value);

  @override
  Future<String?> readString(String key) => _p.getString(key);

  @override
  Future<void> writeString(String key, String? value) =>
      value == null ? _p.remove(key) : _p.setString(key, value);
}

@Riverpod(keepAlive: true)
SettingsStore settingsStore(Ref ref) => _PrefsSettingsStore();

/// Uygulama dili (backend ADR 0093): "tr", "en" ya da null (cihaz dili).
@Riverpod(keepAlive: true)
class AppLanguage extends _$AppLanguage {
  static const _key = 'app.language';

  @override
  String? build() {
    _load();
    return null;
  }

  Future<void> _load() async {
    try {
      final v = await ref.read(settingsStoreProvider).readString(_key);
      if (v == 'tr' || v == 'en') state = v;
    } on Object {
      // Okunamazsa cihaz dili.
    }
  }

  Future<void> set(String? lang) async {
    state = lang;
    try {
      await ref.read(settingsStoreProvider).writeString(_key, lang);
    } on Object {
      // Kaydedilemese de bu oturumda geçerli.
    }
  }
}

/// Tema seçimi (backend ADR 0109): açık, karanlık ya da cihaz.
///
/// Varsayılan AÇIKTIR, cihaz değil: tasarım dili açık zemin; karanlık tema
/// isteyenin açıkça seçtiği bir tercihtir. Cihazda saklanır (hesapta değil):
/// aynı kişi ahırdaki tablette ve evdeki telefonda farklı isteyebilir.
/// Sağımhane tabletinde hesap kartı yok; tablet kayıtlı seçimi (yoksa
/// açığı) izler.
@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  static const _key = 'app.theme';

  @override
  ThemeMode build() {
    _load();
    return ThemeMode.light;
  }

  Future<void> _load() async {
    try {
      final v = await ref.read(settingsStoreProvider).readString(_key);
      final mode = _parse(v);
      if (mode != null) state = mode;
    } on Object {
      // Okunamazsa açık tema.
    }
  }

  static ThemeMode? _parse(String? v) => switch (v) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    'system' => ThemeMode.system,
    _ => null,
  };

  Future<void> set(ThemeMode mode) async {
    state = mode;
    try {
      await ref.read(settingsStoreProvider).writeString(_key, mode.name);
    } on Object {
      // Kaydedilemese de bu oturumda geçerli.
    }
  }
}

/// Cihazın parlaklığı; "Cihaz" seçiliyken tema bunu izler. Sistem ayarı
/// değişince (gece moduna geçiş) yeni değer yayınlanır.
@Riverpod(keepAlive: true)
class PlatformBrightness extends _$PlatformBrightness
    with WidgetsBindingObserver {
  @override
  Brightness build() {
    final binding = WidgetsBinding.instance;
    binding.addObserver(this);
    ref.onDispose(() => binding.removeObserver(this));
    return binding.platformDispatcher.platformBrightness;
  }

  @override
  void didChangePlatformBrightness() {
    state = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}

/// Ekranın gerçekte çizildiği parlaklık: seçim, "Cihaz" ise cihazınki.
/// Kök bunu `AppColors.brightness`'a yazar.
@Riverpod(keepAlive: true)
Brightness effectiveBrightness(Ref ref) =>
    switch (ref.watch(appThemeModeProvider)) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => ref.watch(platformBrightnessProvider),
    };
