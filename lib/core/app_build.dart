import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Uygulamanın platformu ve yapı numarası (Play versionCode); her istekte
/// başlıkta gider ki gateway asgari sürümü zorlayabilsin (backend ADR 0080).
///
/// main() runApp'ten önce [load] eder. Yüklenmemişse (testler) başlık
/// gönderilmez ve gateway isteği geçirir.
abstract final class AppBuild {
  static String? platform;
  static int? build;

  static Future<void> load() async {
    try {
      final p = await PackageInfo.fromPlatform();
      build = int.tryParse(p.buildNumber);
      platform = Platform.isAndroid
          ? 'android'
          : Platform.isIOS
          ? 'ios'
          : null;
    } on Object {
      // Sürüm okunamazsa zorlama da olmaz; uygulama çalışmaya devam eder.
    }
  }

  static Map<String, String> get headers => {
    'X-App-Platform': ?platform,
    if (build case final b?) 'X-App-Build': '$b',
    // Sunucu hata ve bilgi mesajlarını bu dilde döner (backend ADR 0093).
    'Accept-Language': l10nLanguage,
  };
}

/// Sunucu "güncelleme gerekli" (426) dediğinde açılır ve uygulama kapanana
/// kadar açık kalır: router bu bayrağı dinleyip her ekranı güncelleme
/// ekranına çevirir. Tek bir yerde (burada) tutulur çünkü 426 hem kimlik
/// uçlarından hem veri uçlarından gelebilir.
abstract final class UpgradeGate {
  static final required = ValueNotifier<bool>(false);
}

/// Başlıkları ekler ve 426'yı [UpgradeGate]'e bildirir.
class AppBuildInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(AppBuild.headers);
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 426) UpgradeGate.required.value = true;
    handler.next(err);
  }
}
