/// Uygulamanın hangi veri kaynağına bağlanacağı.
enum ApiMode { mock, http }

/// Derleme zamanı ayarları.
///
/// `flutter run --dart-define=MT_API=http` ile gerçek API'ye geçilir.
/// Backend hazır olana kadar varsayılan mock'tur (§15.2).
abstract final class Env {
  static const String _api = String.fromEnvironment('MT_API', defaultValue: 'mock');

  static ApiMode get apiMode => _api == 'http' ? ApiMode.http : ApiMode.mock;

  /// Gerçek API'nin tabanı. Gateway §8.5'teki /api/v1 yolunu sunar.
  static const String apiBaseUrl =
      String.fromEnvironment('MT_API_BASE', defaultValue: 'http://10.0.2.2:8090/api/v1');
}
