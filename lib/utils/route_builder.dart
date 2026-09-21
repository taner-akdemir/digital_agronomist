import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Platforma uygun sayfa geçişi üretir.
///
/// Bu fonksiyon daha önce main.dart ve bottom_navigator_bar.dart içinde
/// BİREBİR iki kez yazılıydı; iki ayrı yönlendirme tablosuyla birlikte
/// uygulamanın nereye gittiğini takip etmeyi zorlaştırıyordu.
PageRoute<dynamic> routeBuilder(RouteSettings settings, Widget page) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return CupertinoPageRoute(builder: (_) => page, settings: settings);
  }
  return MaterialPageRoute(builder: (_) => page, settings: settings);
}
