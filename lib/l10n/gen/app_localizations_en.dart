// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonAdd => 'Add';

  @override
  String get commonAll => 'All';

  @override
  String get commonBack => 'Back';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonClose => 'Close';

  @override
  String commonDateLabel(Object date) {
    return 'Date: $date';
  }

  @override
  String get commonDelete => 'Delete';

  @override
  String commonDeleteFailed(Object error) {
    return 'Could not delete: $error';
  }

  @override
  String get commonDeleteWrongRecord => 'Delete wrong entry';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonLoadFailed => 'Could not load';

  @override
  String get commonNo => 'No';

  @override
  String get commonNoteOptional => 'Note (optional)';

  @override
  String get commonOk => 'OK';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonSave => 'Save';

  @override
  String commonSaveFailed(Object error) {
    return 'Could not save: $error';
  }

  @override
  String get commonYes => 'Yes';

  @override
  String fmtDaysAgo(Object n) {
    return '$n d ago';
  }

  @override
  String fmtDaysShort(Object n) {
    return '$n d';
  }

  @override
  String fmtHoursAgo(Object n) {
    return '$n h ago';
  }

  @override
  String fmtHoursMinutes(Object h, Object m) {
    return '$h h $m min';
  }

  @override
  String fmtHoursShort(Object n) {
    return '$n h';
  }

  @override
  String get fmtJustNow => 'just now';

  @override
  String fmtMinutes(Object n) {
    return '$n min';
  }

  @override
  String fmtMinutesAgo(Object n) {
    return '$n min ago';
  }

  @override
  String get fmtMonth1 => 'Jan';

  @override
  String get fmtMonth10 => 'Oct';

  @override
  String get fmtMonth11 => 'Nov';

  @override
  String get fmtMonth12 => 'Dec';

  @override
  String get fmtMonth2 => 'Feb';

  @override
  String get fmtMonth3 => 'Mar';

  @override
  String get fmtMonth4 => 'Apr';

  @override
  String get fmtMonth5 => 'May';

  @override
  String get fmtMonth6 => 'Jun';

  @override
  String get fmtMonth7 => 'Jul';

  @override
  String get fmtMonth8 => 'Aug';

  @override
  String get fmtMonth9 => 'Sep';

  @override
  String get fmtNowShort => 'now';

  @override
  String fmtPercent(Object value) {
    return '$value%';
  }

  @override
  String get fmtSessionEvening => 'Evening';

  @override
  String get fmtSessionMorning => 'Morning';

  @override
  String get fmtSessionOther => 'Other';

  @override
  String get languageAuto => 'Device language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageTurkish => 'Türkçe';
}
