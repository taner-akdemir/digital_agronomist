/// Uygulamanın hangi veri kaynağına bağlanacağı.
enum ApiMode { mock, http }

/// Derleme zamanı ayarları.
///
/// Varsayılan artık GERÇEK API'dir: backend'in auth, device-registry ve herd
/// servisleri ayakta (Faz 2). Mock'a dönmek için
/// `flutter run --dart-define=MT_API=mock` — kimlik sunucusu olmadan
/// çalışmak, uçak modunda demo yapmak veya ekran tasarlamak için.
abstract final class Env {
  static const String _api = String.fromEnvironment(
    'MT_API',
    defaultValue: 'http',
  );

  static ApiMode get apiMode => _api == 'mock' ? ApiMode.mock : ApiMode.http;

  /// Gerçek API'nin tabanı. Gateway §8.5'teki /api/v1 yolunu sunar.
  ///
  /// 10.0.2.2 Android emülatöründen ana makineye giden adrestir; iOS
  /// simülatöründe veya masaüstünde `--dart-define=MT_API_BASE=...` ile
  /// localhost verilir.
  static const String apiBaseUrl = String.fromEnvironment(
    'MT_API_BASE',
    defaultValue: 'http://10.0.2.2:8190/api/v1',
  );

  /// Canlı akışın WebSocket tabanı (§8.5 WS /ws).
  ///
  /// API tabanından TÜRETİLİR, ayrı bir ayar değildir: ikisi aynı gateway'e
  /// gidiyor ve ayrı tanımlansaydı biri değişip diğeri unutulduğunda canlı
  /// ekran sessizce bağlanamazdı. https -> wss eşlemesi de böyle kendiliğinden
  /// doğru kalıyor.
  static String get wsBaseUrl =>
      apiBaseUrl.replaceFirst(RegExp(r'^http'), 'ws');
}
