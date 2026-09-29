import 'package:flutter/material.dart';

/// Bir parlaklığın (açık/karanlık) ham renk tablosu.
///
/// Tema seçilebilir (backend ADR 0109): açık tema varsayılandır ve tasarım
/// dilinin kendisidir; karanlık tema isteğe bağlıdır. Widget'lar bu sınıfı
/// DOĞRUDAN kullanmaz, [AppColors] üzerinden okur — o da geçerli parlaklığın
/// tablosunu döner.
class AppPalette {
  const AppPalette({
    required this.primaryColor,
    required this.secondaryColor,
    required this.darkBlackColor,
    required this.darkBlueColor,
    required this.darkRedColor,
    required this.redColor,
    required this.lightRedColor,
    required this.darkGreenColor,
    required this.lightGreenColor,
    required this.lightGreyColor,
    required this.veryLightGreyColor,
    required this.iconGreyColor,
    required this.amberColor,
    required this.darkAmberColor,
    required this.lightAmberColor,
    required this.chartContext,
    required this.chartHeat,
    required this.surface,
    required this.brandFill,
    required this.dangerFill,
    required this.warningFill,
    required this.onFill,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color darkBlackColor;
  final Color darkBlueColor;
  final Color darkRedColor;
  final Color redColor;
  final Color lightRedColor;
  final Color darkGreenColor;
  final Color lightGreenColor;
  final Color lightGreyColor;
  final Color veryLightGreyColor;
  final Color iconGreyColor;
  final Color amberColor;
  final Color darkAmberColor;
  final Color lightAmberColor;
  final Color chartContext;

  /// Verim grafiğinde ısı stresi günü işareti (backend ADR 0119). §6.2
  /// durum renklerinden (yeşil/sarı/kırmızı) AYRI bir turuncu.
  final Color chartHeat;
  final Color surface;
  final Color brandFill;
  final Color dangerFill;
  final Color warningFill;
  final Color onFill;

  /// İlk prototipten birebir gelen palet (değiştirilmedi).
  static const light = AppPalette(
    primaryColor: Color.fromRGBO(246, 249, 252, 1),
    secondaryColor: Color.fromRGBO(244, 247, 250, 1),
    darkBlackColor: Color.fromRGBO(24, 26, 28, 1),
    darkBlueColor: Color.fromRGBO(48, 88, 120, 1),
    darkRedColor: Color.fromRGBO(126, 28, 19, 1),
    redColor: Color.fromRGBO(164, 44, 30, 1),
    lightRedColor: Color.fromRGBO(248, 235, 235, 1),
    darkGreenColor: Color.fromRGBO(31, 71, 50, 1),
    lightGreenColor: Color.fromRGBO(180, 235, 201, 1),
    lightGreyColor: Color.fromRGBO(165, 181, 173, 1),
    veryLightGreyColor: Color.fromRGBO(238, 241, 245, 1),
    iconGreyColor: Color.fromRGBO(57, 64, 59, 1),
    amberColor: Color.fromRGBO(224, 150, 20, 1),
    darkAmberColor: Color.fromRGBO(140, 92, 10, 1),
    lightAmberColor: Color.fromRGBO(253, 244, 227, 1),
    // Gri, lightGreyColor'dan KOYUdur: o ton beyaz üzerinde 2.08:1
    // kontrasttaydı ve 90 günlük ince çizgi silik kalıyordu; bu ton 3:1
    // eşiğini geçiyor.
    chartContext: Color.fromRGBO(120, 134, 126, 1),
    chartHeat: Color.fromRGBO(217, 116, 43, 1),
    surface: Colors.white,
    brandFill: Color.fromRGBO(31, 71, 50, 1),
    dangerFill: Color.fromRGBO(164, 44, 30, 1),
    warningFill: Color.fromRGBO(140, 92, 10, 1),
    onFill: Colors.white,
  );

  /// Karanlık tema (ADR 0109).
  ///
  /// Adlar AÇIK temadaki ROLÜ taşır: "darkGreenColor" karanlıkta açık bir
  /// yeşildir, çünkü rolü "zemin üzerindeki marka metni/ikonu"dur; "light…"
  /// yumuşak zeminler koyu, tonlu yüzeylere döner. §6.2 durum renkleri
  /// ANLAMINI korur — yeşil yeşil, sarı kehribar, kırmızı kırmızı, gri gri —
  /// yalnızca koyu zeminde okunacak kadar açılır.
  static const dark = AppPalette(
    primaryColor: Color.fromRGBO(17, 21, 19, 1),
    secondaryColor: Color.fromRGBO(29, 34, 31, 1),
    darkBlackColor: Color.fromRGBO(229, 234, 231, 1),
    darkBlueColor: Color.fromRGBO(48, 88, 120, 1),
    darkRedColor: Color.fromRGBO(255, 170, 158, 1),
    redColor: Color.fromRGBO(240, 110, 94, 1),
    lightRedColor: Color.fromRGBO(66, 30, 26, 1),
    darkGreenColor: Color.fromRGBO(128, 204, 158, 1),
    lightGreenColor: Color.fromRGBO(33, 74, 51, 1),
    lightGreyColor: Color.fromRGBO(132, 146, 139, 1),
    veryLightGreyColor: Color.fromRGBO(45, 52, 48, 1),
    iconGreyColor: Color.fromRGBO(178, 189, 183, 1),
    amberColor: Color.fromRGBO(236, 168, 48, 1),
    darkAmberColor: Color.fromRGBO(240, 188, 88, 1),
    lightAmberColor: Color.fromRGBO(64, 48, 18, 1),
    chartContext: Color.fromRGBO(150, 163, 156, 1),
    chartHeat: Color.fromRGBO(240, 150, 90, 1),
    surface: Color.fromRGBO(26, 31, 28, 1),
    brandFill: Color.fromRGBO(44, 118, 78, 1),
    dangerFill: Color.fromRGBO(176, 52, 38, 1),
    warningFill: Color.fromRGBO(150, 100, 20, 1),
    onFill: Colors.white,
  );

  static AppPalette of(Brightness b) => b == Brightness.dark ? dark : light;
}

/// Uygulamanın renk paleti.
///
/// Mevcut tasarım dili KORUNUR (§15): açık arka plan, yeşil/koyu yeşil palet.
/// Ham renkler ilk prototipten birebir gelir; yeni olanlar anlamsal takma
/// adlar, sarı bandı ve karanlık tema (ADR 0109).
///
/// Değerler SABİT DEĞİLDİR, geçerli parlaklıktan okunur ([brightness]; kökte
/// `MilkTraceApp` yazar ve tema değişince ağacı baştan kurar). Bu yüzden
/// `const` bağlamda kullanılamazlar. Widget'ta `Colors.white` gibi sabit renk
/// YAZMA, buradan oku: yoksa o parça karanlık temada beyaz kalır.
abstract final class AppColors {
  /// Geçerli parlaklık. Yalnızca kök (ve testler) yazar.
  static Brightness brightness = Brightness.light;

  static AppPalette get _p => AppPalette.of(brightness);

  // --- ham palet ---
  static Color get primaryColor => _p.primaryColor;
  static Color get secondaryColor => _p.secondaryColor;
  static Color get darkBlackColor => _p.darkBlackColor;
  static Color get darkBlueColor => _p.darkBlueColor;
  static Color get darkRedColor => _p.darkRedColor;
  static Color get redColor => _p.redColor;
  static Color get lightRedColor => _p.lightRedColor;
  static Color get darkGreenColor => _p.darkGreenColor;
  static Color get lightGreenColor => _p.lightGreenColor;
  static Color get lightGreyColor => _p.lightGreyColor;
  static Color get veryLightGreyColor => _p.veryLightGreyColor;
  static Color get iconGreyColor => _p.iconGreyColor;

  // --- sarı bandı ---
  //
  // Palette sarı YOKTU ve ilk prototip bu yüzden yalnızca kırmızı/yeşil
  // gösteriyordu (§15.3/14). Oysa §6.2 üç bant tanımlıyor ve sarı, normal
  // aralığın rengidir — yani sağımların ÇOĞU sarıdır. Kehribar tonu hem
  // yeşilden hem kırmızıdan ayrışsın ve beyaz üzerinde okunsun diye seçildi.
  static Color get amberColor => _p.amberColor;
  static Color get darkAmberColor => _p.darkAmberColor;
  static Color get lightAmberColor => _p.lightAmberColor;

  // --- anlamsal takma adlar (§6.2 debi renkleri) ---
  //
  // Widget'lar ham renk değil BUNLARI kullanır: renk kuralı değişirse tek
  // yerden değişir ve "neden bu renk?" sorusunun cevabı adında durur.
  static Color get flowGreen => darkGreenColor;
  static Color get flowYellow => darkAmberColor;
  static Color get flowRed => redColor;
  static Color get flowGrey => lightGreyColor;

  /// Kart arka planları — renk durumunun yumuşak karşılığı.
  static Color get flowGreenSurface => lightGreenColor;
  static Color get flowYellowSurface => lightAmberColor;
  static Color get flowRedSurface => lightRedColor;
  static Color get flowGreySurface => veryLightGreyColor;

  // --- grafik çizgileri (§15.1 verim grafiği) ---
  //
  // Verim grafiği DURUM RENKLERİNİ (yeşil/sarı/kırmızı) seri rengi olarak
  // KULLANMAZ: o üç renk §6.2/§6.3'te "düşük debi", "izlenmeli" gibi sabit
  // anlamlar taşıyor. Bir çizgiyi sırf ikinci seri olduğu için sarıya
  // boyamak, o anlamı sulandırırdı.
  //
  // Bu yüzden ana seri (7 gün ortalaması) marka yeşili (karanlıkta açık
  // yeşil), bağlam serisi (günlük toplam) nötr gridir.
  static Color get chartPrimary => darkGreenColor;
  static Color get chartContext => _p.chartContext;
  static Color get chartHeat => _p.chartHeat;
  static Color get chartGrid => veryLightGreyColor;

  // --- yüzeyler ---
  static Color get background => primaryColor;
  static Color get surface => _p.surface;
  static Color get surfaceAlt => secondaryColor;
  static Color get border => veryLightGreyColor;
  static Color get onSurface => darkBlackColor;
  static Color get onSurfaceMuted => iconGreyColor;

  // --- dolgular (düğme, FAB, snackbar, grafik ipucu) ---
  //
  // darkGreenColor karanlıkta açık yeşile döner ki METİN olarak okunsun;
  // dolgu olarak kullanılsaydı üzerindeki beyaz yazı kaybolurdu. Dolgu ve
  // üstündeki yazı bu yüzden AYRI token'lardır.
  static Color get brandFill => _p.brandFill;
  static Color get dangerFill => _p.dangerFill;

  /// Uyarı (amber) dolgusu: bildirim çubuğu gibi beyaz yazılı zeminler.
  static Color get warningFill => _p.warningFill;

  /// [brandFill] ve [dangerFill] üzerindeki metin/ikon.
  static Color get onFill => _p.onFill;
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
/// varsayılanıydı.
///
/// Poppins pubspec'ten bundle edilir; google_fonts ÇALIŞMA ZAMANINDA indirir
/// ve ahırda internet zayıfsa yazı tipi ilk açılışta sonradan oturur.
ThemeData buildAppTheme([Brightness brightness = Brightness.light]) {
  // Tema iki parlaklık için de AYNI anda kurulur (MaterialApp theme +
  // darkTheme); global AppColors.brightness'a değil, açık tabloya bakar.
  final p = AppPalette.of(brightness);
  final dark = brightness == Brightness.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: p.darkBlueColor,
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: dark
        ? scheme.copyWith(surface: p.surface, onSurface: p.darkBlackColor)
        : scheme,
    primaryColor: p.primaryColor,
    scaffoldBackgroundColor: p.primaryColor,
    fontFamily: 'Poppins',
    appBarTheme: AppBarTheme(
      backgroundColor: p.primaryColor,
      centerTitle: true,
    ),
    iconTheme: IconThemeData(color: p.darkGreenColor),
    // Karanlıkta Material varsayılanları tohum renginden (mavi) gelir ve
    // dolgulu düğmenin yazısı koyulaşır; düğme ve snackbar dolgusu yeşil
    // paletten, yazısı beyaz olsun. Açık tema bunlar olmadan zaten bugünkü
    // görünümündedir.
    filledButtonTheme: dark
        ? FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: p.brandFill,
              foregroundColor: p.onFill,
            ),
          )
        : null,
    snackBarTheme: dark
        ? SnackBarThemeData(
            backgroundColor: p.veryLightGreyColor,
            contentTextStyle: TextStyle(color: p.darkBlackColor),
          )
        : null,
  );
}
