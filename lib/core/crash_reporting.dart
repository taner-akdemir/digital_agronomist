import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Çökme raporu (backend ADR 0100): Flutter çerçeve hataları, yakalanmamış
/// asenkron hatalar ve yerel çökmeler Firebase Crashlytics'e gider.
///
/// KİŞİSEL VERİ GÖNDERİLMEZ: kullanıcı kimliği, e-posta, işletme ya da küpe
/// atanmaz; rapor yığın izi, cihaz modeli, işletim sistemi ve sürümdür.
/// Debug derlemede toplama kapalı. Firebase açılamazsa (yapılandırma yok)
/// sessizce atlanır — push'taki gibi (CLAUDE.md §7), uygulama çalışır.
abstract final class CrashReporting {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      debugPrint('[crash] Firebase başlatılamadı, çökme raporu kapalı: $e');
      return;
    }
    final crashlytics = FirebaseCrashlytics.instance;
    await crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);
    FlutterError.onError = crashlytics.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      crashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
