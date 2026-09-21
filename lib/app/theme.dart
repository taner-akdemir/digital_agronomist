import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Uygulamanın renk paleti.
///
/// Mevcut tasarım dili KORUNUR (§15): açık arka plan, yeşil/koyu yeşil palet.
/// Aşağıdaki ham renkler ilk prototipten birebir gelir; yeni olan tek şey
/// anlamsal takma adlar ve sarı bandıdır.
abstract final class AppColors {
  // --- ham palet (değiştirilmedi) ---
  static const Color primaryColor = Color.fromRGBO(246, 249, 252, 1);
  static const Color secondaryColor = Color.fromRGBO(244, 247, 250, 1);
  static const Color darkBlackColor = Color.fromRGBO(24, 26, 28, 1);
  static const Color darkBlueColor = Color.fromRGBO(48, 88, 120, 1);
  static const Color darkRedColor = Color.fromRGBO(126, 28, 19, 1);
  static const Color redColor = Color.fromRGBO(164, 44, 30, 1);
  static const Color lightRedColor = Color.fromRGBO(248, 235, 235, 1);
  static const Color darkGreenColor = Color.fromRGBO(31, 71, 50, 1);
  static const Color lightGreenColor = Color.fromRGBO(180, 235, 201, 1);
  static const Color lightGreyColor = Color.fromRGBO(165, 181, 173, 1);
  static const Color veryLightGreyColor = Color.fromRGBO(238, 241, 245, 1);
  static const Color iconGreyColor = Color.fromRGBO(57, 64, 59, 1);

  // --- sarı bandı (YENİ) ---
  //
  // Palette sarı YOKTU ve ilk prototip bu yüzden yalnızca kırmızı/yeşil
  // gösteriyordu (§15.3/14). Oysa §6.2 üç bant tanımlıyor ve sarı, normal
  // aralığın rengidir — yani sağımların ÇOĞU sarıdır. Kehribar tonu hem
  // yeşilden hem kırmızıdan ayrışsın ve beyaz üzerinde okunsun diye seçildi.
  static const Color amberColor = Color.fromRGBO(224, 150, 20, 1);
  static const Color darkAmberColor = Color.fromRGBO(140, 92, 10, 1);
  static const Color lightAmberColor = Color.fromRGBO(253, 244, 227, 1);

  // --- anlamsal takma adlar (§6.2 debi renkleri) ---
  //
  // Widget'lar ham renk değil BUNLARI kullanır: renk kuralı değişirse tek
  // yerden değişir ve "neden bu renk?" sorusunun cevabı adında durur.
  static const Color flowGreen = darkGreenColor;
  static const Color flowYellow = darkAmberColor;
  static const Color flowRed = redColor;
  static const Color flowGrey = lightGreyColor;

  /// Kart arka planları — renk durumunun yumuşak karşılığı.
  static const Color flowGreenSurface = lightGreenColor;
  static const Color flowYellowSurface = lightAmberColor;
  static const Color flowRedSurface = lightRedColor;
  static const Color flowGreySurface = veryLightGreyColor;

  // --- yüzeyler ---
  static const Color background = primaryColor;
  static const Color surface = Colors.white;
  static const Color surfaceAlt = secondaryColor;
  static const Color border = veryLightGreyColor;
  static const Color onSurface = darkBlackColor;
  static const Color onSurfaceMuted = iconGreyColor;
}

/// Boşluk ölçeği.
///
/// Prototipte her çağrı yerinde sabit sayı yazılıydı (5, 7, 10, 12, 15, 20);
/// aynı görsel boşluk farklı yerlerde farklı değerler almıştı.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// Köşe yarıçapları.
abstract final class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;

  static const BorderRadius smAll = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
}

/// Uygulamanın tema verisi.
///
/// Daha önce MyApp.build içinde satır içiydi ve metin temasını
/// `Theme.of(context)` üzerinden kuruyordu — ama o context MaterialApp'in
/// ÜSTÜNDEydi, yani okunan tema uygulamanın kendi teması değil Flutter'ın
/// varsayılanıydı. Poppins doğrudan uygulanır.
ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(seedColor: AppColors.darkBlueColor);

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: AppColors.darkGreenColor),
  );
}
