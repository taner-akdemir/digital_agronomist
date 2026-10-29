import 'package:flutter/material.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

/// Sitedeki yardım makalelerinin slug'ları (`milktrace-site/src/help`).
/// İki dilde aynıdır: Türkçe `/yardim/<slug>`, İngilizce `/en/help/<slug>`
/// ([Env.helpUrl]). Ekrana uygun makale yoksa [HelpButton] slug'sız
/// kullanılır ve yardım merkezinin ana sayfası açılır.
abstract final class HelpSlug {
  static const firstSetup = 'ilk-kurulum';
  static const farmSettings = 'ciftlik-ayarlari';
  static const assistant = 'yardim-asistani';
  static const animals = 'hayvan-ekleme-ve-ice-aktarma';
  static const groups = 'gruplar';
  static const healthRecords = 'asi-ve-tedavi-kayitlari';
  static const devices = 'cihaz-esleme-ve-kalibrasyon';
  static const liveMilking = 'canli-sagim';
  static const kiosk = 'kiosk-modu';
  static const thresholds = 'esikler-ve-uyarilar';
  static const activity = 'aktivite-ve-kizginlik';
  static const notifications = 'bildirim-kanallari-ve-sessiz-saat';
  static const deliveries = 'tanker-teslimleri-ve-sut-kalitesi';
  static const yieldReport = 'verim-raporu-ve-disa-aktarma';
  static const monthlyReport = 'aylik-rapor';
  static const team = 'ekip-ve-roller';
  static const dairySharing = 'mandira-paylasimi';
  static const apiKeys = 'api-anahtarlari';
  static const security = 'iki-adimli-dogrulama-ve-oturumlar';
  static const subscription = 'abonelik-ve-odeme';
  static const offline = 'cevrimdisi-kullanim';
  static const deleteAccount = 'hesap-silme';
  static const support = 'destek-talebi';
  static const faq = 'sss';
  static const auditLog = 'islem-kaydi';
  static const updateRequired = 'guncelleme-gerekli';
  static const feedback = 'geri-bildirim';
}

/// Üst çubuktaki "?" düğmesi: ekranın yardım makalesini uygulamanın
/// dilinde tarayıcıda açar. Etiket (tooltip ve ekran okuyucu) ARB'den.
class HelpButton extends StatelessWidget {
  const HelpButton({super.key, this.slug, this.color});

  /// [HelpSlug] sabitlerinden biri; null ise yardım merkezinin ana sayfası.
  final String? slug;

  /// Koyu zeminli üst çubuklarda ikon rengi; null ise temadan.
  final Color? color;

  /// Bağlantıyı açan işlev; testte değiştirilir.
  @visibleForTesting
  static Future<bool> Function(Uri uri) launcher = (uri) =>
      launchUrl(uri, mode: LaunchMode.externalApplication);

  /// Düğmenin açacağı adres (dil o anki uygulama dilidir).
  Uri get uri => Uri.parse(Env.helpUrl(slug, l10nLanguage));

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('helpButton'),
      tooltip: l10n.commonHelpTooltip,
      icon: Icon(Icons.help_outline, color: color),
      onPressed: () => launcher(uri),
    );
  }
}
