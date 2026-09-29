import 'package:flutter/widgets.dart';
import 'package:milktrace/l10n/gen/app_localizations.dart';

export 'package:milktrace/l10n/gen/app_localizations.dart';

/// Arayüz metinleri (backend ADR 0093): `l10n.liveStartMilking`.
///
/// GLOBAL, `AppLocalizations.of(context)` değil: metinlerin bir kısmı
/// bağlamı olmayan yerlerde (model etiketleri, `Fmt`, sağlayıcılar) ve
/// testlerin çoğu yerelleştirme temsilcisi kurmadan MaterialApp açıyor.
/// Dil uygulama kökünde (`MilkTraceApp`) seçilir ve [setL10nLocale] ile
/// buraya yazılır; varsayılan Türkçe.
AppLocalizations get l10n => _current;

AppLocalizations _current = lookupAppLocalizations(const Locale('tr'));

/// Seçili dil kodu: "tr" ya da "en".
String get l10nLanguage => _language;
String _language = 'tr';

/// Dili değiştirir. Desteklenmeyen dil Türkçeye düşer.
void setL10nLocale(Locale locale) {
  final lang = locale.languageCode == 'en' ? 'en' : 'tr';
  if (lang == _language) return;
  _language = lang;
  _current = lookupAppLocalizations(Locale(lang));
}

/// Cihaz dilinden uygulama dili: İngilizce cihazda İngilizce, diğer her
/// dilde Türkçe (ilk pazar Türkiye; Almanca cihazda İngilizce değil
/// Türkçe açılır çünkü kullanıcılar Türkiye'deki çiftlikler).
Locale resolveAppLocale(List<Locale>? device) {
  for (final l in device ?? const <Locale>[]) {
    if (l.languageCode == 'tr') return const Locale('tr');
    if (l.languageCode == 'en') return const Locale('en');
  }
  return const Locale('tr');
}
