// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get commonAdd => 'Ekle';

  @override
  String get commonAll => 'Tümü';

  @override
  String get commonBack => 'Geri';

  @override
  String get commonCancel => 'Vazgeç';

  @override
  String get commonClear => 'Temizle';

  @override
  String get commonClose => 'Kapat';

  @override
  String commonDateLabel(Object date) {
    return 'Tarih: $date';
  }

  @override
  String get commonDelete => 'Sil';

  @override
  String commonDeleteFailed(Object error) {
    return 'Silinemedi: $error';
  }

  @override
  String get commonDeleteWrongRecord => 'Yanlış kaydı sil';

  @override
  String get commonEdit => 'Düzenle';

  @override
  String get commonLoadFailed => 'Yüklenemedi';

  @override
  String get commonNo => 'Hayır';

  @override
  String get commonNoteOptional => 'Not (isteğe bağlı)';

  @override
  String get commonOk => 'Tamam';

  @override
  String get commonRetry => 'Tekrar dene';

  @override
  String get commonSave => 'Kaydet';

  @override
  String commonSaveFailed(Object error) {
    return 'Kaydedilemedi: $error';
  }

  @override
  String get commonYes => 'Evet';

  @override
  String fmtDaysAgo(Object n) {
    return '$n gün önce';
  }

  @override
  String fmtDaysShort(Object n) {
    return '$n gün';
  }

  @override
  String fmtHoursAgo(Object n) {
    return '$n sa önce';
  }

  @override
  String fmtHoursMinutes(Object h, Object m) {
    return '$h sa $m dk';
  }

  @override
  String fmtHoursShort(Object n) {
    return '$n sa';
  }

  @override
  String get fmtJustNow => 'az önce';

  @override
  String fmtMinutes(Object n) {
    return '$n dk';
  }

  @override
  String fmtMinutesAgo(Object n) {
    return '$n dk önce';
  }

  @override
  String get fmtMonth1 => 'Oca';

  @override
  String get fmtMonth10 => 'Eki';

  @override
  String get fmtMonth11 => 'Kas';

  @override
  String get fmtMonth12 => 'Ara';

  @override
  String get fmtMonth2 => 'Şub';

  @override
  String get fmtMonth3 => 'Mar';

  @override
  String get fmtMonth4 => 'Nis';

  @override
  String get fmtMonth5 => 'May';

  @override
  String get fmtMonth6 => 'Haz';

  @override
  String get fmtMonth7 => 'Tem';

  @override
  String get fmtMonth8 => 'Ağu';

  @override
  String get fmtMonth9 => 'Eyl';

  @override
  String get fmtNowShort => 'şimdi';

  @override
  String fmtPercent(Object value) {
    return '%$value';
  }

  @override
  String get fmtSessionEvening => 'Akşam';

  @override
  String get fmtSessionMorning => 'Sabah';

  @override
  String get fmtSessionOther => 'Diğer';

  @override
  String get languageAuto => 'Cihaz dili';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTitle => 'Dil';

  @override
  String get languageTurkish => 'Türkçe';
}
