import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

  /// Sürüm adı ("1.4.0"), işletim sistemi sürümü ve cihaz modeli: geri
  /// bildirimde (backend ADR 0106); sürüm oturum listesindeki User-Agent'a da
  /// girer (ADR 0105).
  static String? version;
  static String? osVersion;
  static String? device;

  /// Cihaz bilgisi için yerel kanal (Android `MainActivity`). Eklenti
  /// eklenmedi: iki alan için bir bağımlılık fazla. Kanal yoksa (iOS,
  /// testler) Dart'ın verdiğiyle yetinilir.
  static const _deviceChannel = MethodChannel('milktrace/device');

  static Future<void> load() async {
    try {
      final p = await PackageInfo.fromPlatform();
      build = int.tryParse(p.buildNumber);
      version = p.version;
      platform = Platform.isAndroid
          ? 'android'
          : Platform.isIOS
          ? 'ios'
          : null;
      osVersion = Platform.operatingSystemVersion;
    } on Object {
      // Sürüm okunamazsa zorlama da olmaz; uygulama çalışmaya devam eder.
    }
    try {
      final info = await _deviceChannel.invokeMapMethod<String, String>('info');
      device = info?['model'];
      osVersion = info?['osVersion'] ?? osVersion;
    } on Object {
      // Kanal yok: model boş kalır.
    }
  }

  /// Geri bildirime eklenen alanlar (`POST /feedback`).
  static Map<String, String> get feedbackInfo => {
    'appVersion': [?version, if (build case final b?) '($b)'].join(' '),
    'platform': platform ?? Platform.operatingSystem,
    'osVersion': osVersion ?? '',
    'device': device ?? '',
  };

  static Map<String, String> get headers => {
    'X-App-Platform': ?platform,
    if (build case final b?) 'X-App-Build': '$b',
    // Sunucu hata ve bilgi mesajlarını bu dilde döner (backend ADR 0093).
    'Accept-Language': l10nLanguage,
    // Oturum listesinde "Milk Trace · Android" diye tanınsın (backend ADR
    // 0105); Dio'nun varsayılanı "Dart/3 (dart:io)" hiçbir şey söylemiyordu.
    if (platform case final p?)
      'User-Agent': 'MilkTrace/${version ?? '?'} ($p)',
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
