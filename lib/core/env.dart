import 'package:flutter/foundation.dart';

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
  /// `--dart-define=MT_API_BASE=...` verilmişse o kazanır. Verilmemişse
  /// yerel geliştirme gateway'i: Android emülatöründen ana makine 10.0.2.2,
  /// iOS simülatöründen ve masaüstünden localhost. Tek sabit bir varsayılan,
  /// iOS'ta dart-define unutulduğunda girişin sessizce zaman aşımına düşmesi
  /// demekti.
  static String get apiBaseUrl {
    if (_apiBase.isNotEmpty) return _apiBase;
    final host = !kIsWeb && defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : 'localhost';
    return 'http://$host:8190/api/v1';
  }

  static const String _apiBase = String.fromEnvironment('MT_API_BASE');

  /// Canlı akışın WebSocket tabanı (§8.5 WS /ws).
  ///
  /// API tabanından TÜRETİLİR, ayrı bir ayar değildir: ikisi aynı gateway'e
  /// gidiyor ve ayrı tanımlansaydı biri değişip diğeri unutulduğunda canlı
  /// ekran sessizce bağlanamazdı. https -> wss eşlemesi de böyle kendiliğinden
  /// doğru kalıyor.
  static String get wsBaseUrl =>
      apiBaseUrl.replaceFirst(RegExp(r'^http'), 'ws');
}
