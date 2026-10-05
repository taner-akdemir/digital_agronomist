import Flutter
import UIKit
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Uygulama AÇIKKEN gelen push'u flutter_local_notifications gösteriyor
    // (CLAUDE.md §7). Merkezin temsilcisi uygulama olmazsa iOS ön plandaki
    // bildirimi sessizce yutar ve dokunuş Dart'a hiç ulaşmaz.
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // Geri bildirime eklenen cihaz modeli ve işletim sistemi (backend ADR 0106);
    // Android karşılığı MainActivity'de, Dart tarafı AppBuild.load().
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "MilktraceDevice") {
      FlutterMethodChannel(name: "milktrace/device", binaryMessenger: registrar.messenger())
        .setMethodCallHandler { call, result in
          guard call.method == "info" else {
            result(FlutterMethodNotImplemented)
            return
          }
          let device = UIDevice.current
          result([
            "model": "\(device.model) (\(Self.hardwareIdentifier()))",
            "osVersion": "\(device.systemName) \(device.systemVersion)",
          ])
        }
    }
  }

  /// "iPhone15,2" gibi donanım kimliği; UIDevice.model yalnızca "iPhone" der.
  /// Pazarlama adına çeviri tablosu tutulmuyor — her yeni modelde eskirdi.
  private static func hardwareIdentifier() -> String {
    var info = utsname()
    uname(&info)
    return withUnsafeBytes(of: &info.machine) { raw in
      String(decoding: raw.prefix { $0 != 0 }, as: UTF8.self)
    }
  }
}
