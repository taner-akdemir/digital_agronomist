import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @commonAdd.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get commonAdd;

  /// No description provided for @commonAll.
  ///
  /// In tr, this message translates to:
  /// **'Tümü'**
  String get commonAll;

  /// No description provided for @commonBack.
  ///
  /// In tr, this message translates to:
  /// **'Geri'**
  String get commonBack;

  /// No description provided for @commonCancel.
  ///
  /// In tr, this message translates to:
  /// **'Vazgeç'**
  String get commonCancel;

  /// No description provided for @commonClear.
  ///
  /// In tr, this message translates to:
  /// **'Temizle'**
  String get commonClear;

  /// No description provided for @commonClose.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get commonClose;

  /// No description provided for @commonDateLabel.
  ///
  /// In tr, this message translates to:
  /// **'Tarih: {date}'**
  String commonDateLabel(Object date);

  /// No description provided for @commonDelete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get commonDelete;

  /// No description provided for @commonDeleteFailed.
  ///
  /// In tr, this message translates to:
  /// **'Silinemedi: {error}'**
  String commonDeleteFailed(Object error);

  /// No description provided for @commonDeleteWrongRecord.
  ///
  /// In tr, this message translates to:
  /// **'Yanlış kaydı sil'**
  String get commonDeleteWrongRecord;

  /// No description provided for @commonEdit.
  ///
  /// In tr, this message translates to:
  /// **'Düzenle'**
  String get commonEdit;

  /// No description provided for @commonLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Yüklenemedi'**
  String get commonLoadFailed;

  /// No description provided for @commonNo.
  ///
  /// In tr, this message translates to:
  /// **'Hayır'**
  String get commonNo;

  /// No description provided for @commonNoteOptional.
  ///
  /// In tr, this message translates to:
  /// **'Not (isteğe bağlı)'**
  String get commonNoteOptional;

  /// No description provided for @commonOk.
  ///
  /// In tr, this message translates to:
  /// **'Tamam'**
  String get commonOk;

  /// No description provided for @commonRetry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar dene'**
  String get commonRetry;

  /// No description provided for @commonSave.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get commonSave;

  /// No description provided for @commonSaveFailed.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilemedi: {error}'**
  String commonSaveFailed(Object error);

  /// No description provided for @commonYes.
  ///
  /// In tr, this message translates to:
  /// **'Evet'**
  String get commonYes;

  /// No description provided for @fmtDaysAgo.
  ///
  /// In tr, this message translates to:
  /// **'{n} gün önce'**
  String fmtDaysAgo(Object n);

  /// No description provided for @fmtDaysShort.
  ///
  /// In tr, this message translates to:
  /// **'{n} gün'**
  String fmtDaysShort(Object n);

  /// No description provided for @fmtHoursAgo.
  ///
  /// In tr, this message translates to:
  /// **'{n} sa önce'**
  String fmtHoursAgo(Object n);

  /// No description provided for @fmtHoursMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{h} sa {m} dk'**
  String fmtHoursMinutes(Object h, Object m);

  /// No description provided for @fmtHoursShort.
  ///
  /// In tr, this message translates to:
  /// **'{n} sa'**
  String fmtHoursShort(Object n);

  /// No description provided for @fmtJustNow.
  ///
  /// In tr, this message translates to:
  /// **'az önce'**
  String get fmtJustNow;

  /// No description provided for @fmtMinutes.
  ///
  /// In tr, this message translates to:
  /// **'{n} dk'**
  String fmtMinutes(Object n);

  /// No description provided for @fmtMinutesAgo.
  ///
  /// In tr, this message translates to:
  /// **'{n} dk önce'**
  String fmtMinutesAgo(Object n);

  /// No description provided for @fmtMonth1.
  ///
  /// In tr, this message translates to:
  /// **'Oca'**
  String get fmtMonth1;

  /// No description provided for @fmtMonth10.
  ///
  /// In tr, this message translates to:
  /// **'Eki'**
  String get fmtMonth10;

  /// No description provided for @fmtMonth11.
  ///
  /// In tr, this message translates to:
  /// **'Kas'**
  String get fmtMonth11;

  /// No description provided for @fmtMonth12.
  ///
  /// In tr, this message translates to:
  /// **'Ara'**
  String get fmtMonth12;

  /// No description provided for @fmtMonth2.
  ///
  /// In tr, this message translates to:
  /// **'Şub'**
  String get fmtMonth2;

  /// No description provided for @fmtMonth3.
  ///
  /// In tr, this message translates to:
  /// **'Mar'**
  String get fmtMonth3;

  /// No description provided for @fmtMonth4.
  ///
  /// In tr, this message translates to:
  /// **'Nis'**
  String get fmtMonth4;

  /// No description provided for @fmtMonth5.
  ///
  /// In tr, this message translates to:
  /// **'May'**
  String get fmtMonth5;

  /// No description provided for @fmtMonth6.
  ///
  /// In tr, this message translates to:
  /// **'Haz'**
  String get fmtMonth6;

  /// No description provided for @fmtMonth7.
  ///
  /// In tr, this message translates to:
  /// **'Tem'**
  String get fmtMonth7;

  /// No description provided for @fmtMonth8.
  ///
  /// In tr, this message translates to:
  /// **'Ağu'**
  String get fmtMonth8;

  /// No description provided for @fmtMonth9.
  ///
  /// In tr, this message translates to:
  /// **'Eyl'**
  String get fmtMonth9;

  /// No description provided for @fmtNowShort.
  ///
  /// In tr, this message translates to:
  /// **'şimdi'**
  String get fmtNowShort;

  /// No description provided for @fmtPercent.
  ///
  /// In tr, this message translates to:
  /// **'%{value}'**
  String fmtPercent(Object value);

  /// No description provided for @fmtSessionEvening.
  ///
  /// In tr, this message translates to:
  /// **'Akşam'**
  String get fmtSessionEvening;

  /// No description provided for @fmtSessionMorning.
  ///
  /// In tr, this message translates to:
  /// **'Sabah'**
  String get fmtSessionMorning;

  /// No description provided for @fmtSessionOther.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get fmtSessionOther;

  /// No description provided for @languageAuto.
  ///
  /// In tr, this message translates to:
  /// **'Cihaz dili'**
  String get languageAuto;

  /// No description provided for @languageEnglish.
  ///
  /// In tr, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageTitle.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get languageTitle;

  /// No description provided for @languageTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageTurkish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
