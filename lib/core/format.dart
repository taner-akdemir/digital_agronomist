import 'package:milktrace/l10n/l10n.dart';

/// Sayı ve tarih biçimlendirme; metinler seçili dilde (backend ADR 0093).
///
/// Biçimler bir avuç ve elle yazılı: `intl`'in tarih biçimleyicisi burada
/// kullanılmıyor, ay adları ARB'den geliyor.
abstract final class Fmt {
  static String _month(int m) => switch (m) {
    1 => l10n.fmtMonth1,
    2 => l10n.fmtMonth2,
    3 => l10n.fmtMonth3,
    4 => l10n.fmtMonth4,
    5 => l10n.fmtMonth5,
    6 => l10n.fmtMonth6,
    7 => l10n.fmtMonth7,
    8 => l10n.fmtMonth8,
    9 => l10n.fmtMonth9,
    10 => l10n.fmtMonth10,
    11 => l10n.fmtMonth11,
    _ => l10n.fmtMonth12,
  };

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
    return '${l.day} ${_month(l.month)}';
  }

  /// "22 Eyl 2026".
  static String dayMonthYear(DateTime t) =>
      '${dayMonth(t)} ${t.toLocal().year}';

  /// "06:05".
  static String time(DateTime t) {
    final l = t.toLocal();
    return '${l.hour.toString().padLeft(2, '0')}:'
        '${l.minute.toString().padLeft(2, '0')}';
  }

  /// "1 sa 15 dk" / "6 dk".
  static String duration(Duration d) {
    if (d.inMinutes < 60) return l10n.fmtMinutes(d.inMinutes);
    return l10n.fmtHoursMinutes(d.inHours, d.inMinutes % 60);
  }

  /// Oturum tipinin adı (§8.4: morning | evening | other).
  static String sessionType(String type) => switch (type) {
    'morning' => l10n.fmtSessionMorning,
    'evening' => l10n.fmtSessionEvening,
    _ => l10n.fmtSessionOther,
  };

  /// "%86" — yüzde KIRPILMAZ, hayvan beklenenin üstünde süt verebilir.
  static String percent(double pct) => l10n.fmtPercent(pct.toStringAsFixed(0));

  /// "az önce" / "12 dk önce" / "3 sa önce" / "2 gün önce".
  ///
  /// Cihaz listesinde MUTLAK saat işe yaramıyor: "06:12" yazan bir sayacın
  /// şu an sorunlu olup olmadığını anlamak için kullanıcının saate bakıp
  /// çıkarma yapması gerekirdi.
  /// "24 dk" / "3 sa" / "2 gün" — since'in "önce"siz, dar hâli.
  static String sinceShort(DateTime t, {DateTime? now}) {
    final d = (now ?? DateTime.now()).difference(t);
    if (d.isNegative || d.inMinutes < 1) return l10n.fmtNowShort;
    if (d.inMinutes < 60) return l10n.fmtMinutes(d.inMinutes);
    if (d.inHours < 24) return l10n.fmtHoursShort(d.inHours);
    return l10n.fmtDaysShort(d.inDays);
  }

  static String since(DateTime t, {DateTime? now}) {
    final d = (now ?? DateTime.now()).difference(t);
    if (d.isNegative || d.inSeconds < 60) return l10n.fmtJustNow;
    if (d.inMinutes < 60) return l10n.fmtMinutesAgo(d.inMinutes);
    if (d.inHours < 24) return l10n.fmtHoursAgo(d.inHours);
    return l10n.fmtDaysAgo(d.inDays);
  }
}
