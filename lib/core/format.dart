/// Sayı ve tarih biçimlendirme.
///
/// `intl` paketi YOK: uygulamanın tek dili Türkçe (§4) ve ihtiyaç duyulan
/// biçimler bir avuç. Paket eklemek, 30 satırlık iş için ~1 MB yerelleştirme
/// verisi taşımak olurdu.
abstract final class Fmt {
  static const _months = [
    'Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz',
    'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara',
  ];

  /// mL → "10.4" (L).
  ///
  /// Hacimler her yerde TAMSAYI mL taşınır (§3); çevirme yalnızca gösterim
  /// anında yapılır, modelde değil.
  static String litres(int ml, {int digits = 1}) =>
      (ml / 1000).toStringAsFixed(digits);

  /// "22 Eyl".
  ///
  /// Zaman UTC gelir, `Europe/Istanbul` gösterilir (§16). toLocal() cihazın
  /// saat dilimini kullanır — saha cihazları Türkiye'de.
  static String dayMonth(DateTime t) {
    final l = t.toLocal();
    return '${l.day} ${_months[l.month - 1]}';
  }

  /// "22 Eyl 2026".
  static String dayMonthYear(DateTime t) => '${dayMonth(t)} ${t.toLocal().year}';

  /// "06:05".
  static String time(DateTime t) {
    final l = t.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:'
        '${l.minute.toString().padLeft(2, '0')}';
  }

  /// "1 sa 15 dk" / "6 dk".
  static String duration(Duration d) {
    if (d.inMinutes < 60) return '${d.inMinutes} dk';
    return '${d.inHours} sa ${d.inMinutes % 60} dk';
  }

  /// Oturum tipinin Türkçe adı (§8.4: morning | evening | other).
  static String sessionType(String type) => switch (type) {
        'morning' => 'Sabah',
        'evening' => 'Akşam',
        _ => 'Diğer',
      };

  /// "%86" — yüzde KIRPILMAZ, hayvan beklenenin üstünde süt verebilir.
  static String percent(double pct) => '%${pct.toStringAsFixed(0)}';
}
