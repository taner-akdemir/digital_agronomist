import 'package:flutter/foundation.dart';
import 'package:milktrace/l10n/l10n.dart';

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

  /// Müşteri web panelinin giriş adresi (mandıra hesabı, backend ADR 0137).
  ///
  /// API tabanından TÜRETİLİR: `https://api.X/api/v1` → `https://X/giris`.
  /// Yerel geliştirme ortamında (api. öneki yok) üretim sitesi.
  static String get webLoginUrl => siteUrl('/giris');

  /// Tanıtım sitesinin kökü: `https://api.X/api/v1` → `https://X`. Yerel
  /// geliştirme ortamında (api. öneki yok) üretim sitesi.
  static String get siteBaseUrl {
    final u = Uri.parse(apiBaseUrl);
    if (u.host.startsWith('api.')) {
      return '${u.scheme}://${u.host.substring(4)}';
    }
    return 'https://milktrace.com.tr';
  }

  /// Sitede bir sayfa: `siteUrl('/yardim')`.
  static String siteUrl(String path) => '$siteBaseUrl$path';

  /// Yardım merkezi (backend ADR 0138): asistanın kaynakları ve destek
  /// numarası yokken devretme hedefi. Uygulamanın diline göre ([helpUrl]).
  static String get helpCenterUrl => helpUrl(null, l10nLanguage);

  /// Yardım makalesinin adresi, dile göre: Türkçe `/yardim/<slug>`,
  /// İngilizce `/en/help/<slug>` (slug'lar iki dilde aynı). [slug] null ya
  /// da boşsa yardım merkezinin ana sayfası. Ekranlardaki "?" düğmesi
  /// (`HelpButton`) ve asistanın göreli kaynak bağlantıları buradan geçer.
  static String helpUrl(String? slug, String language) {
    final path = slug == null || slug.isEmpty ? '/yardim' : '/yardim/$slug';
    return siteUrl(localizedSitePath(path, language));
  }

  /// Sitedeki göreli yolu dile uyarlar: İngilizcede `/yardim` ve altı
  /// `/en/help`'e çevrilir (sorgu ve çapa korunur); başka yol ve Türkçe
  /// olduğu gibi kalır.
  static String localizedSitePath(String path, String language) {
    if (language != 'en') return path;
    final m = RegExp(r'^/yardim(?=$|[/?#])').firstMatch(path);
    if (m == null) return path;
    return '/en/help${path.substring(m.end)}';
  }

  /// Gizlilik politikası (sitede herkese açık, CLAUDE.md §8).
  static String get privacyPolicyUrl => siteUrl('/gizlilik');
}
