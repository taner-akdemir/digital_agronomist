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
