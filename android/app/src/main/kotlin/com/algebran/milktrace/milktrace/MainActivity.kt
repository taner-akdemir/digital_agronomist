package com.algebran.milktrace.milktrace

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    // Geri bildirime eklenen cihaz modeli ve Android sürümü (backend ADR 0106).
    // Eklenti yerine tek kanal: yalnızca iki alan gerekiyor.
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "milktrace/device")
            .setMethodCallHandler { call, result ->
                if (call.method == "info") {
                    val maker = Build.MANUFACTURER.replaceFirstChar { it.uppercase() }
                    val model =
                        if (Build.MODEL.startsWith(Build.MANUFACTURER, ignoreCase = true)) {
                            Build.MODEL
                        } else {
                            "$maker ${Build.MODEL}"
                        }
                    result.success(
                        mapOf(
                            "model" to model,
                            "osVersion" to "Android ${Build.VERSION.RELEASE} (API ${Build.VERSION.SDK_INT})",
                        ),
                    )
                } else {
                    result.notImplemented()
                }
            }
    }
}
