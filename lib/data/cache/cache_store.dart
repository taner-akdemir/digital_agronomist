import 'package:shared_preferences/shared_preferences.dart';

/// Çevrimdışı önbelleğin anahtar-değer deposu (§18/7).
///
/// Arayüz, testte bellek içi depo kullanabilmek için: gerçek depo platform
/// kanalına gidiyor.
abstract interface class CacheStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);

  /// [prefix] ile başlayan bütün anahtarları siler.
  Future<void> clear(String prefix);
}

/// shared_preferences üzerinde depo. Başlatma gerektirmeyen async API
/// kullanılıyor: uygulama açılışını beklemeden çalışır.
class PrefsCacheStore implements CacheStore {
  PrefsCacheStore([SharedPreferencesAsync? prefs])
    : _prefs = prefs ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _prefs;

  @override
  Future<String?> read(String key) => _prefs.getString(key);

  @override
  Future<void> write(String key, String value) => _prefs.setString(key, value);

  @override
  Future<void> clear(String prefix) async {
    final keys = await _prefs.getKeys();
    await _prefs.clear(
      allowList: {
        for (final k in keys)
          if (k.startsWith(prefix)) k,
      },
    );
  }
}

/// Bellek içi depo (testler).
class MemoryCacheStore implements CacheStore {
  final Map<String, String> values = {};

  @override
  Future<String?> read(String key) async => values[key];

  @override
  Future<void> write(String key, String value) async => values[key] = value;

  @override
  Future<void> clear(String prefix) async =>
      values.removeWhere((k, _) => k.startsWith(prefix));
}
