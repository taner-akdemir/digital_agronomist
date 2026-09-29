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

  /// No description provided for @accountAuditLog.
  ///
  /// In tr, this message translates to:
  /// **'İşlem kaydı'**
  String get accountAuditLog;

  /// No description provided for @accountDefaultName.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı'**
  String get accountDefaultName;

  /// No description provided for @accountMilkUnit.
  ///
  /// In tr, this message translates to:
  /// **'Süt birimi'**
  String get accountMilkUnit;

  /// No description provided for @accountMilkers.
  ///
  /// In tr, this message translates to:
  /// **'Sağımcılar'**
  String get accountMilkers;

  /// No description provided for @accountMockMode.
  ///
  /// In tr, this message translates to:
  /// **'Demo verisiyle çalışıyorsunuz (mock mod).'**
  String get accountMockMode;

  /// No description provided for @accountNotificationChannels.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim kanalları'**
  String get accountNotificationChannels;

  /// No description provided for @accountPickFarm.
  ///
  /// In tr, this message translates to:
  /// **'İşletme seçin'**
  String get accountPickFarm;

  /// No description provided for @accountPushUnavailable.
  ///
  /// In tr, this message translates to:
  /// **'Bu telefonda bildirim kapalı: izin verilmedi ya da bildirim servisi henüz bağlanmadı. Uyarılar bildirim merkezinde görünmeye devam eder.'**
  String get accountPushUnavailable;

  /// No description provided for @accountSignOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış yap'**
  String get accountSignOut;

  /// No description provided for @accountSwitchFarm.
  ///
  /// In tr, this message translates to:
  /// **'İşletme değiştir'**
  String get accountSwitchFarm;

  /// No description provided for @accountSwitchFarmFailed.
  ///
  /// In tr, this message translates to:
  /// **'İşletme değiştirilemedi: {error}'**
  String accountSwitchFarmFailed(Object error);

  /// No description provided for @accountTestPush.
  ///
  /// In tr, this message translates to:
  /// **'Bu telefona test bildirimi'**
  String get accountTestPush;

  /// No description provided for @accountTestPushFailed.
  ///
  /// In tr, this message translates to:
  /// **'Test bildirimi gönderilemedi: {error}'**
  String accountTestPushFailed(Object error);

  /// No description provided for @accountTestPushNone.
  ///
  /// In tr, this message translates to:
  /// **'Test bildirimi hiçbir telefona ulaşmadı'**
  String get accountTestPushNone;

  /// No description provided for @accountTestPushSending.
  ///
  /// In tr, this message translates to:
  /// **'Gönderiliyor…'**
  String get accountTestPushSending;

  /// No description provided for @accountTestPushSent.
  ///
  /// In tr, this message translates to:
  /// **'Test bildirimi gönderildi ({count} telefon)'**
  String accountTestPushSent(Object count);

  /// No description provided for @accountThresholds.
  ///
  /// In tr, this message translates to:
  /// **'Eşik ayarları'**
  String get accountThresholds;

  /// No description provided for @accountUnitKilogram.
  ///
  /// In tr, this message translates to:
  /// **'Kilogram'**
  String get accountUnitKilogram;

  /// No description provided for @accountUnitLitre.
  ///
  /// In tr, this message translates to:
  /// **'Litre'**
  String get accountUnitLitre;

  /// No description provided for @accountUsers.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcılar'**
  String get accountUsers;

  /// No description provided for @alertsAcknowledged.
  ///
  /// In tr, this message translates to:
  /// **'okundu'**
  String get alertsAcknowledged;

  /// No description provided for @alertsBackOnlineAt.
  ///
  /// In tr, this message translates to:
  /// **'geri geldi {time}'**
  String alertsBackOnlineAt(Object time);

  /// No description provided for @alertsEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Açık uyarı yok'**
  String get alertsEmpty;

  /// No description provided for @alertsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Uyarılar yüklenemedi'**
  String get alertsLoadFailed;

  /// No description provided for @alertsMarkRead.
  ///
  /// In tr, this message translates to:
  /// **'Okundu'**
  String get alertsMarkRead;

  /// No description provided for @alertsRecoveredAt.
  ///
  /// In tr, this message translates to:
  /// **'düzeldi {time}'**
  String alertsRecoveredAt(Object time);

  /// No description provided for @alertsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uyarılar'**
  String get alertsTitle;

  /// No description provided for @animalDetailAddNote.
  ///
  /// In tr, this message translates to:
  /// **'Not ekle'**
  String get animalDetailAddNote;

  /// No description provided for @animalDetailAvg30.
  ///
  /// In tr, this message translates to:
  /// **'30 gün ort.'**
  String get animalDetailAvg30;

  /// No description provided for @animalDetailAvg7.
  ///
  /// In tr, this message translates to:
  /// **'7 gün ort.'**
  String get animalDetailAvg7;

  /// No description provided for @animalDetailBreed.
  ///
  /// In tr, this message translates to:
  /// **'Irk'**
  String get animalDetailBreed;

  /// No description provided for @animalDetailCalved.
  ///
  /// In tr, this message translates to:
  /// **'Buzağıladı'**
  String get animalDetailCalved;

  /// No description provided for @animalDetailCalvingAlreadyToday.
  ///
  /// In tr, this message translates to:
  /// **'Bugün için buzağılama zaten kayıtlı'**
  String get animalDetailCalvingAlreadyToday;

  /// No description provided for @animalDetailCalvingConfirmTitle.
  ///
  /// In tr, this message translates to:
  /// **'Buzağılama kaydedilsin mi?'**
  String get animalDetailCalvingConfirmTitle;

  /// No description provided for @animalDetailCalvingDate.
  ///
  /// In tr, this message translates to:
  /// **'Buzağılama tarihi'**
  String get animalDetailCalvingDate;

  /// No description provided for @animalDetailCalvingLactation.
  ///
  /// In tr, this message translates to:
  /// **'Laktasyon {current} → {next}'**
  String animalDetailCalvingLactation(Object current, Object next);

  /// No description provided for @animalDetailCalvingSaved.
  ///
  /// In tr, this message translates to:
  /// **'Buzağılama kaydedildi'**
  String get animalDetailCalvingSaved;

  /// No description provided for @animalDetailCalvingStatus.
  ///
  /// In tr, this message translates to:
  /// **'Durum {status} → Sağmal'**
  String animalDetailCalvingStatus(Object status);

  /// No description provided for @animalDetailDaysInMilk.
  ///
  /// In tr, this message translates to:
  /// **'Laktasyon günü'**
  String get animalDetailDaysInMilk;

  /// No description provided for @animalDetailDisclaimer.
  ///
  /// In tr, this message translates to:
  /// **'Bu bir öneridir, teşhis değildir. Gebelik, laktasyon dönemi ve hastalık verimi düşürebilir; veteriner kontrolü gerekir.'**
  String get animalDetailDisclaimer;

  /// No description provided for @animalDetailFreshLactation.
  ///
  /// In tr, this message translates to:
  /// **'Taze laktasyon: ilk {days} günde \"düşüşte\" ve \"kuruya çıkarma adayı\" etiketi verilmez; verim henüz yükseliyor.'**
  String animalDetailFreshLactation(Object days);

  /// No description provided for @animalDetailFrozenClassNote.
  ///
  /// In tr, this message translates to:
  /// **'Sağmal olmayan hayvan sınıflandırılmaz; bu etiket sağmalken yapılan son hesaptan kalmadır.'**
  String get animalDetailFrozenClassNote;

  /// No description provided for @animalDetailGroup.
  ///
  /// In tr, this message translates to:
  /// **'Grup'**
  String get animalDetailGroup;

  /// No description provided for @animalDetailHistoryFailed.
  ///
  /// In tr, this message translates to:
  /// **'Sağım geçmişi alınamadı'**
  String get animalDetailHistoryFailed;

  /// No description provided for @animalDetailLactation.
  ///
  /// In tr, this message translates to:
  /// **'Laktasyon'**
  String get animalDetailLactation;

  /// No description provided for @animalDetailLastCalving.
  ///
  /// In tr, this message translates to:
  /// **'Son buzağılama'**
  String get animalDetailLastCalving;

  /// No description provided for @animalDetailLastClass.
  ///
  /// In tr, this message translates to:
  /// **'Son sınıf: {label}'**
  String animalDetailLastClass(Object label);

  /// No description provided for @animalDetailLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan bilgisi yüklenemedi'**
  String get animalDetailLoadFailed;

  /// No description provided for @animalDetailMoreNotes.
  ///
  /// In tr, this message translates to:
  /// **'{n, plural, other{{n} not daha}}'**
  String animalDetailMoreNotes(int n);

  /// No description provided for @animalDetailNoMilkings.
  ///
  /// In tr, this message translates to:
  /// **'Bu hayvana ait sağım kaydı yok'**
  String get animalDetailNoMilkings;

  /// No description provided for @animalDetailNoNotes.
  ///
  /// In tr, this message translates to:
  /// **'Henüz not yok. Veteriner kontrolü, gebelik ya da tedavi bilgisi sınıf etiketini yorumlamaya yardım eder.'**
  String get animalDetailNoNotes;

  /// No description provided for @animalDetailNotRegistered.
  ///
  /// In tr, this message translates to:
  /// **'Bu hayvan kayıtlı değil'**
  String get animalDetailNotRegistered;

  /// No description provided for @animalDetailNoteAddFailed.
  ///
  /// In tr, this message translates to:
  /// **'Not eklenemedi: {error}'**
  String animalDetailNoteAddFailed(Object error);

  /// No description provided for @animalDetailNoteAdded.
  ///
  /// In tr, this message translates to:
  /// **'Not eklendi'**
  String get animalDetailNoteAdded;

  /// No description provided for @animalDetailNoteHint.
  ///
  /// In tr, this message translates to:
  /// **'Örn. Son veteriner kontrolü: mastitis, tedavide.'**
  String get animalDetailNoteHint;

  /// No description provided for @animalDetailNotes.
  ///
  /// In tr, this message translates to:
  /// **'Notlar'**
  String get animalDetailNotes;

  /// No description provided for @animalDetailNotesFailed.
  ///
  /// In tr, this message translates to:
  /// **'Notlar alınamadı'**
  String get animalDetailNotesFailed;

  /// No description provided for @animalDetailOrdinal.
  ///
  /// In tr, this message translates to:
  /// **'{n}.'**
  String animalDetailOrdinal(Object n);

  /// No description provided for @animalDetailRecentMilkings.
  ///
  /// In tr, this message translates to:
  /// **'Son sağımlar'**
  String get animalDetailRecentMilkings;

  /// No description provided for @animalDetailShownOfTotal.
  ///
  /// In tr, this message translates to:
  /// **'{total} sağımın ilk {limit} tanesi gösteriliyor'**
  String animalDetailShownOfTotal(Object total, Object limit);

  /// No description provided for @animalDetailStaleClass.
  ///
  /// In tr, this message translates to:
  /// **'Sınıf {date} hesabından: gece hesabı yalnızca son 30 günde sağılan hayvanı yeniler.'**
  String animalDetailStaleClass(Object date);

  /// No description provided for @animalDetailTitleFallback.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan'**
  String get animalDetailTitleFallback;

  /// No description provided for @animalDetailTrend30.
  ///
  /// In tr, this message translates to:
  /// **'30 günlük eğilim'**
  String get animalDetailTrend30;

  /// No description provided for @animalDetailTrendFailed.
  ///
  /// In tr, this message translates to:
  /// **'Trend alınamadı'**
  String get animalDetailTrendFailed;

  /// No description provided for @animalDetailYieldTrend.
  ///
  /// In tr, this message translates to:
  /// **'Verim trendi'**
  String get animalDetailYieldTrend;

  /// No description provided for @animalFormAdded.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan eklendi'**
  String get animalFormAdded;

  /// No description provided for @animalFormAnimalFailed.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan yüklenemedi'**
  String get animalFormAnimalFailed;

  /// No description provided for @animalFormBirthDate.
  ///
  /// In tr, this message translates to:
  /// **'Doğum tarihi'**
  String get animalFormBirthDate;

  /// No description provided for @animalFormBreed.
  ///
  /// In tr, this message translates to:
  /// **'Irk (isteğe bağlı)'**
  String get animalFormBreed;

  /// No description provided for @animalFormClearDate.
  ///
  /// In tr, this message translates to:
  /// **'{label} temizle'**
  String animalFormClearDate(Object label);

  /// No description provided for @animalFormEarTag.
  ///
  /// In tr, this message translates to:
  /// **'Küpe numarası'**
  String get animalFormEarTag;

  /// No description provided for @animalFormEarTagHelper.
  ///
  /// In tr, this message translates to:
  /// **'Hayvanı tanımlayan alan; işletmede tekil.'**
  String get animalFormEarTagHelper;

  /// No description provided for @animalFormEarTagRequired.
  ///
  /// In tr, this message translates to:
  /// **'Küpe numarası zorunlu'**
  String get animalFormEarTagRequired;

  /// No description provided for @animalFormEditTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hayvanı düzenle'**
  String get animalFormEditTitle;

  /// No description provided for @animalFormGroup.
  ///
  /// In tr, this message translates to:
  /// **'Grup'**
  String get animalFormGroup;

  /// No description provided for @animalFormLactationNo.
  ///
  /// In tr, this message translates to:
  /// **'Laktasyon sırası'**
  String get animalFormLactationNo;

  /// No description provided for @animalFormLastCalving.
  ///
  /// In tr, this message translates to:
  /// **'Son buzağılama'**
  String get animalFormLastCalving;

  /// No description provided for @animalFormName.
  ///
  /// In tr, this message translates to:
  /// **'Ad (isteğe bağlı)'**
  String get animalFormName;

  /// No description provided for @animalFormNewTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni hayvan'**
  String get animalFormNewTitle;

  /// No description provided for @animalFormNoGroup.
  ///
  /// In tr, this message translates to:
  /// **'Grupsuz'**
  String get animalFormNoGroup;

  /// No description provided for @animalFormNotEntered.
  ///
  /// In tr, this message translates to:
  /// **'Girilmedi'**
  String get animalFormNotEntered;

  /// No description provided for @animalFormNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan bulunamadı'**
  String get animalFormNotFound;

  /// No description provided for @animalFormPickDate.
  ///
  /// In tr, this message translates to:
  /// **'{label} seç'**
  String animalFormPickDate(Object label);

  /// No description provided for @animalFormRfid.
  ///
  /// In tr, this message translates to:
  /// **'RFID (isteğe bağlı)'**
  String get animalFormRfid;

  /// No description provided for @animalFormRfidHelper.
  ///
  /// In tr, this message translates to:
  /// **'Küpedeki çipin numarası; sayaç okursa hayvan noktaya kendiliğinden eşleşir.'**
  String get animalFormRfidHelper;

  /// No description provided for @animalFormSaving.
  ///
  /// In tr, this message translates to:
  /// **'Kaydediliyor…'**
  String get animalFormSaving;

  /// No description provided for @animalFormSpecies.
  ///
  /// In tr, this message translates to:
  /// **'Tür'**
  String get animalFormSpecies;

  /// No description provided for @animalFormSpeciesFailed.
  ///
  /// In tr, this message translates to:
  /// **'Türler yüklenemedi'**
  String get animalFormSpeciesFailed;

  /// No description provided for @animalFormSpeciesRequired.
  ///
  /// In tr, this message translates to:
  /// **'Tür seçin'**
  String get animalFormSpeciesRequired;

  /// No description provided for @animalFormStatus.
  ///
  /// In tr, this message translates to:
  /// **'Durum'**
  String get animalFormStatus;

  /// No description provided for @animalFormStatusHelper.
  ///
  /// In tr, this message translates to:
  /// **'Yalnızca sağmal hayvan sağıma eşleştirilir ve sınıflandırılır.'**
  String get animalFormStatusHelper;

  /// No description provided for @animalFormUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan güncellendi'**
  String get animalFormUpdated;

  /// No description provided for @animalImportAddN.
  ///
  /// In tr, this message translates to:
  /// **'{n} hayvanı ekle'**
  String animalImportAddN(Object n);

  /// No description provided for @animalImportAdded.
  ///
  /// In tr, this message translates to:
  /// **'{n, plural, other{{n} hayvan eklendi}}'**
  String animalImportAdded(int n);

  /// No description provided for @animalImportColumns.
  ///
  /// In tr, this message translates to:
  /// **'Sütunlar: Küpe No (zorunlu) · Tür · Adı · Irkı · RFID · Doğum Tarihi · Son Buzağılama · Laktasyon · Durumu'**
  String get animalImportColumns;

  /// No description provided for @animalImportCountCreate.
  ///
  /// In tr, this message translates to:
  /// **'{n} eklenecek'**
  String animalImportCountCreate(Object n);

  /// No description provided for @animalImportCountErrors.
  ///
  /// In tr, this message translates to:
  /// **'{n} hatalı, atlanacak'**
  String animalImportCountErrors(Object n);

  /// No description provided for @animalImportCountExists.
  ///
  /// In tr, this message translates to:
  /// **'{n} zaten kayıtlı'**
  String animalImportCountExists(Object n);

  /// No description provided for @animalImportDefaultSpecies.
  ///
  /// In tr, this message translates to:
  /// **'Türü yazılmamış satırlar'**
  String get animalImportDefaultSpecies;

  /// No description provided for @animalImportFailed.
  ///
  /// In tr, this message translates to:
  /// **'İçe aktarılamadı: {error}'**
  String animalImportFailed(Object error);

  /// No description provided for @animalImportIgnoredColumns.
  ///
  /// In tr, this message translates to:
  /// **'Alınmayan sütunlar: {columns}'**
  String animalImportIgnoredColumns(Object columns);

  /// No description provided for @animalImportIntro.
  ///
  /// In tr, this message translates to:
  /// **'Veterinerden, Birlik\'ten ya da Hayvan Bilgi Sistemi\'nden aldığınız listeyi yükleyin (Excel .xlsx ya da CSV). İlk satır sütun başlıkları olmalı; tarihler gün önde (03.04.2021).'**
  String get animalImportIntro;

  /// No description provided for @animalImportNothingToAdd.
  ///
  /// In tr, this message translates to:
  /// **'Eklenecek hayvan yok'**
  String get animalImportNothingToAdd;

  /// No description provided for @animalImportPickFile.
  ///
  /// In tr, this message translates to:
  /// **'Dosya seç'**
  String get animalImportPickFile;

  /// No description provided for @animalImportPickOtherFile.
  ///
  /// In tr, this message translates to:
  /// **'Başka dosya seç'**
  String get animalImportPickOtherFile;

  /// No description provided for @animalImportReadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Dosya okunamadı: {error}'**
  String animalImportReadFailed(Object error);

  /// No description provided for @animalImportRules.
  ///
  /// In tr, this message translates to:
  /// **'Küpesi zaten kayıtlı hayvanlar değiştirilmez. Hatalı satırlar atlanır; dosyayı düzeltip yeniden yüklemek güvenlidir.'**
  String get animalImportRules;

  /// No description provided for @animalImportSectionCreate.
  ///
  /// In tr, this message translates to:
  /// **'Eklenecek'**
  String get animalImportSectionCreate;

  /// No description provided for @animalImportSectionErrors.
  ///
  /// In tr, this message translates to:
  /// **'Hatalı satırlar'**
  String get animalImportSectionErrors;

  /// No description provided for @animalImportSectionExists.
  ///
  /// In tr, this message translates to:
  /// **'Zaten kayıtlı (değiştirilmez)'**
  String get animalImportSectionExists;

  /// No description provided for @animalImportSectionWarnings.
  ///
  /// In tr, this message translates to:
  /// **'Uyarılar'**
  String get animalImportSectionWarnings;

  /// No description provided for @animalImportSpeciesLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Türler yüklenemedi'**
  String get animalImportSpeciesLoadFailed;

  /// No description provided for @animalImportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Listeden içe aktar'**
  String get animalImportTitle;

  /// No description provided for @auditAnimalCalving.
  ///
  /// In tr, this message translates to:
  /// **'Buzağılama kaydedildi'**
  String get auditAnimalCalving;

  /// No description provided for @auditAnimalCreate.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan eklendi'**
  String get auditAnimalCreate;

  /// No description provided for @auditAnimalImport.
  ///
  /// In tr, this message translates to:
  /// **'Listeden içe aktarma'**
  String get auditAnimalImport;

  /// No description provided for @auditAnimalUpdate.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan kaydı değişti'**
  String get auditAnimalUpdate;

  /// No description provided for @auditBreedingAdd.
  ///
  /// In tr, this message translates to:
  /// **'Üreme kaydı eklendi'**
  String get auditBreedingAdd;

  /// No description provided for @auditBreedingDelete.
  ///
  /// In tr, this message translates to:
  /// **'Üreme kaydı silindi'**
  String get auditBreedingDelete;

  /// No description provided for @auditChannelCreate.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim kanalı eklendi'**
  String get auditChannelCreate;

  /// No description provided for @auditChannelDelete.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim kanalı silindi'**
  String get auditChannelDelete;

  /// No description provided for @auditChannelUpdate.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim kanalı değişti'**
  String get auditChannelUpdate;

  /// No description provided for @auditDeletedUser.
  ///
  /// In tr, this message translates to:
  /// **'Silinmiş kullanıcı'**
  String get auditDeletedUser;

  /// No description provided for @auditDeliveryAdd.
  ///
  /// In tr, this message translates to:
  /// **'Tank teslimi girildi'**
  String get auditDeliveryAdd;

  /// No description provided for @auditDeliveryDelete.
  ///
  /// In tr, this message translates to:
  /// **'Tank teslimi silindi'**
  String get auditDeliveryDelete;

  /// No description provided for @auditEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Son 90 günde kayıtlı değişiklik yok.'**
  String get auditEmpty;

  /// No description provided for @auditIntro.
  ///
  /// In tr, this message translates to:
  /// **'Son 90 gün: eşik, hayvan kaydı, eşleştirme, kullanıcı ve bildirim kanalı değişiklikleri.'**
  String get auditIntro;

  /// No description provided for @auditLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'İşlem kaydı yüklenemedi'**
  String get auditLoadFailed;

  /// No description provided for @auditSettingsUpdate.
  ///
  /// In tr, this message translates to:
  /// **'İşletme ayarı değişti'**
  String get auditSettingsUpdate;

  /// No description provided for @auditSpoutUnassign.
  ///
  /// In tr, this message translates to:
  /// **'Eşleştirme kaldırıldı'**
  String get auditSpoutUnassign;

  /// No description provided for @auditTagDismiss.
  ///
  /// In tr, this message translates to:
  /// **'Tanınmayan küpe yok sayıldı'**
  String get auditTagDismiss;

  /// No description provided for @auditTeamAdd.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı eklendi'**
  String get auditTeamAdd;

  /// No description provided for @auditTeamRemove.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı çıkarıldı'**
  String get auditTeamRemove;

  /// No description provided for @auditTeamUpdate.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı değişti'**
  String get auditTeamUpdate;

  /// No description provided for @auditThresholdsUpdate.
  ///
  /// In tr, this message translates to:
  /// **'Eşikler değişti'**
  String get auditThresholdsUpdate;

  /// No description provided for @auditTitle.
  ///
  /// In tr, this message translates to:
  /// **'İşlem kaydı'**
  String get auditTitle;

  /// No description provided for @auditTreatmentAdd.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi eklendi'**
  String get auditTreatmentAdd;

  /// No description provided for @auditTreatmentDelete.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi silindi'**
  String get auditTreatmentDelete;

  /// No description provided for @breedingAddRecord.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt ekle'**
  String get breedingAddRecord;

  /// No description provided for @breedingAdded.
  ///
  /// In tr, this message translates to:
  /// **'Üreme kaydı eklendi'**
  String get breedingAdded;

  /// No description provided for @breedingDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'Yalnızca yanlış girilen kaydı silin; durum ve tarihler yeniden hesaplanır.'**
  String get breedingDeleteBody;

  /// No description provided for @breedingDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Üreme kaydı silinsin mi?'**
  String get breedingDeleteTitle;

  /// No description provided for @breedingDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Üreme kaydı'**
  String get breedingDialogTitle;

  /// No description provided for @breedingDryOff.
  ///
  /// In tr, this message translates to:
  /// **'Önerilen kuruya çıkarma: {date}'**
  String breedingDryOff(Object date);

  /// No description provided for @breedingEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt yok. Tohumlama ve gebelik kontrolünü girin: beklenen doğum ve kuruya çıkarma tarihi hesaplanır.'**
  String get breedingEmpty;

  /// No description provided for @breedingExpectedCalving.
  ///
  /// In tr, this message translates to:
  /// **'Beklenen doğum: {date}'**
  String breedingExpectedCalving(Object date);

  /// No description provided for @breedingInsemination.
  ///
  /// In tr, this message translates to:
  /// **'Tohumlama'**
  String get breedingInsemination;

  /// No description provided for @breedingLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Üreme kayıtları alınamadı'**
  String get breedingLoadFailed;

  /// No description provided for @breedingOpen.
  ///
  /// In tr, this message translates to:
  /// **'Boş'**
  String get breedingOpen;

  /// No description provided for @breedingPregnancyCheck.
  ///
  /// In tr, this message translates to:
  /// **'Gebelik kontrolü'**
  String get breedingPregnancyCheck;

  /// No description provided for @breedingPregnant.
  ///
  /// In tr, this message translates to:
  /// **'Gebe'**
  String get breedingPregnant;

  /// No description provided for @breedingSireLabel.
  ///
  /// In tr, this message translates to:
  /// **'Boğa/teke ya da sperma kodu (isteğe bağlı)'**
  String get breedingSireLabel;

  /// No description provided for @breedingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Üreme'**
  String get breedingTitle;

  /// No description provided for @channelsAdd.
  ///
  /// In tr, this message translates to:
  /// **'Kanal ekle'**
  String get channelsAdd;

  /// No description provided for @channelsAdded.
  ///
  /// In tr, this message translates to:
  /// **'Kanal eklendi'**
  String get channelsAdded;

  /// No description provided for @channelsCardDailyLimit.
  ///
  /// In tr, this message translates to:
  /// **'günde en çok {n}'**
  String channelsCardDailyLimit(Object n);

  /// No description provided for @channelsCardStatus.
  ///
  /// In tr, this message translates to:
  /// **'{severity} ve üstü · {sources}'**
  String channelsCardStatus(Object severity, Object sources);

  /// No description provided for @channelsChannelLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Kanal yüklenemedi'**
  String get channelsChannelLoadFailed;

  /// No description provided for @channelsConnectionSection.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı ayarları'**
  String get channelsConnectionSection;

  /// No description provided for @channelsDailyLimit.
  ///
  /// In tr, this message translates to:
  /// **'Günlük sınır'**
  String get channelsDailyLimit;

  /// No description provided for @channelsDailyLimitHelperDefault.
  ///
  /// In tr, this message translates to:
  /// **'Boş bırakılırsa {n}. Sınırdan sonrakiler gönderilmez; sayaç gece yarısı sıfırlanır.'**
  String channelsDailyLimitHelperDefault(Object n);

  /// No description provided for @channelsDailyLimitHelperUnlimited.
  ///
  /// In tr, this message translates to:
  /// **'Boş bırakılırsa sınırsız. Sınırdan sonrakiler gönderilmez; sayaç gece yarısı sıfırlanır.'**
  String get channelsDailyLimitHelperUnlimited;

  /// No description provided for @channelsDailyLimitRange.
  ///
  /// In tr, this message translates to:
  /// **'1 ile 10000 arasında olmalı'**
  String get channelsDailyLimitRange;

  /// No description provided for @channelsDelete.
  ///
  /// In tr, this message translates to:
  /// **'Kanalı sil'**
  String get channelsDelete;

  /// No description provided for @channelsDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'\"{name}\" kanalına artık bildirim gitmeyecek. Bu işlem geri alınamaz.'**
  String channelsDeleteBody(Object name);

  /// No description provided for @channelsDeleteFailed.
  ///
  /// In tr, this message translates to:
  /// **'Silinemedi'**
  String get channelsDeleteFailed;

  /// No description provided for @channelsDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kanal silinsin mi?'**
  String get channelsDeleteTitle;

  /// No description provided for @channelsDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Kanal silindi'**
  String get channelsDeleted;

  /// No description provided for @channelsEditTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kanalı düzenle'**
  String get channelsEditTitle;

  /// No description provided for @channelsEmailAddresses.
  ///
  /// In tr, this message translates to:
  /// **'E-posta adresleri'**
  String get channelsEmailAddresses;

  /// No description provided for @channelsEmailHelper.
  ///
  /// In tr, this message translates to:
  /// **'Her satıra bir adres'**
  String get channelsEmailHelper;

  /// No description provided for @channelsEmptyBody.
  ///
  /// In tr, this message translates to:
  /// **'E-posta ya da SMS ile de uyarı almak için kanal ekleyin.'**
  String get channelsEmptyBody;

  /// No description provided for @channelsEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kanal yok'**
  String get channelsEmptyTitle;

  /// No description provided for @channelsEnabled.
  ///
  /// In tr, this message translates to:
  /// **'Kanal açık'**
  String get channelsEnabled;

  /// No description provided for @channelsFieldApiKey.
  ///
  /// In tr, this message translates to:
  /// **'API anahtarı'**
  String get channelsFieldApiKey;

  /// No description provided for @channelsFieldApiSecret.
  ///
  /// In tr, this message translates to:
  /// **'API sırrı'**
  String get channelsFieldApiSecret;

  /// No description provided for @channelsFieldApplicationId.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama kimliği'**
  String get channelsFieldApplicationId;

  /// No description provided for @channelsFieldBearerToken.
  ///
  /// In tr, this message translates to:
  /// **'Bearer jetonu'**
  String get channelsFieldBearerToken;

  /// No description provided for @channelsFieldFrom.
  ///
  /// In tr, this message translates to:
  /// **'Gönderen'**
  String get channelsFieldFrom;

  /// No description provided for @channelsFieldFromName.
  ///
  /// In tr, this message translates to:
  /// **'Gönderen adı'**
  String get channelsFieldFromName;

  /// No description provided for @channelsFieldHost.
  ///
  /// In tr, this message translates to:
  /// **'SMTP sunucusu'**
  String get channelsFieldHost;

  /// No description provided for @channelsFieldLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get channelsFieldLanguage;

  /// No description provided for @channelsFieldPassword.
  ///
  /// In tr, this message translates to:
  /// **'Parola'**
  String get channelsFieldPassword;

  /// No description provided for @channelsFieldPrivateKey.
  ///
  /// In tr, this message translates to:
  /// **'Özel anahtar (PEM)'**
  String get channelsFieldPrivateKey;

  /// No description provided for @channelsFieldRegion.
  ///
  /// In tr, this message translates to:
  /// **'Bölge'**
  String get channelsFieldRegion;

  /// No description provided for @channelsFieldRequired.
  ///
  /// In tr, this message translates to:
  /// **'{field} gerekli'**
  String channelsFieldRequired(Object field);

  /// No description provided for @channelsFieldSecret.
  ///
  /// In tr, this message translates to:
  /// **'İmza sırrı'**
  String get channelsFieldSecret;

  /// No description provided for @channelsFieldSmsHeader.
  ///
  /// In tr, this message translates to:
  /// **'SMS başlığı'**
  String get channelsFieldSmsHeader;

  /// No description provided for @channelsFieldTls.
  ///
  /// In tr, this message translates to:
  /// **'Şifreleme (starttls, tls)'**
  String get channelsFieldTls;

  /// No description provided for @channelsFieldUrl.
  ///
  /// In tr, this message translates to:
  /// **'Adres (https)'**
  String get channelsFieldUrl;

  /// No description provided for @channelsFieldUserCode.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı kodu'**
  String get channelsFieldUserCode;

  /// No description provided for @channelsFieldUsername.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı adı'**
  String get channelsFieldUsername;

  /// No description provided for @channelsFieldVoice.
  ///
  /// In tr, this message translates to:
  /// **'Ses'**
  String get channelsFieldVoice;

  /// No description provided for @channelsFieldWebhookUrl.
  ///
  /// In tr, this message translates to:
  /// **'Webhook adresi'**
  String get channelsFieldWebhookUrl;

  /// No description provided for @channelsHintFrom.
  ///
  /// In tr, this message translates to:
  /// **'ornek@alanadi.com.tr'**
  String get channelsHintFrom;

  /// No description provided for @channelsHintRegion.
  ///
  /// In tr, this message translates to:
  /// **'Boş bırakılabilir (eu: AB veri yerleşimi)'**
  String get channelsHintRegion;

  /// No description provided for @channelsHintSecret.
  ///
  /// In tr, this message translates to:
  /// **'Verilirse istek HMAC ile imzalanır'**
  String get channelsHintSecret;

  /// No description provided for @channelsHintSmsHeader.
  ///
  /// In tr, this message translates to:
  /// **'Sağlayıcıda onaylı gönderici adı (en çok 11 karakter)'**
  String get channelsHintSmsHeader;

  /// No description provided for @channelsHintTls.
  ///
  /// In tr, this message translates to:
  /// **'Boş bırakılırsa starttls'**
  String get channelsHintTls;

  /// No description provided for @channelsHintUrl.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim JSON olarak bu adrese POST edilir'**
  String get channelsHintUrl;

  /// No description provided for @channelsHintWebhookUrl.
  ///
  /// In tr, this message translates to:
  /// **'Slack / Teams\'in verdiği gelen webhook adresi'**
  String get channelsHintWebhookUrl;

  /// No description provided for @channelsInvalidEmail.
  ///
  /// In tr, this message translates to:
  /// **'Geçersiz e-posta: {value}'**
  String channelsInvalidEmail(Object value);

  /// No description provided for @channelsInvalidPhone.
  ///
  /// In tr, this message translates to:
  /// **'Uluslararası biçimde olmalı (+905…): {value}'**
  String channelsInvalidPhone(Object value);

  /// No description provided for @channelsKindEmail.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get channelsKindEmail;

  /// No description provided for @channelsKindPickerTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kanal türü'**
  String get channelsKindPickerTitle;

  /// No description provided for @channelsKindVoiceCall.
  ///
  /// In tr, this message translates to:
  /// **'Sesli arama'**
  String get channelsKindVoiceCall;

  /// No description provided for @channelsKindsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Kanal türleri yüklenemedi'**
  String get channelsKindsLoadFailed;

  /// No description provided for @channelsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Kanallar yüklenemedi'**
  String get channelsLoadFailed;

  /// No description provided for @channelsMinSeverity.
  ///
  /// In tr, this message translates to:
  /// **'En düşük önem'**
  String get channelsMinSeverity;

  /// No description provided for @channelsName.
  ///
  /// In tr, this message translates to:
  /// **'Kanal adı'**
  String get channelsName;

  /// No description provided for @channelsNameRequired.
  ///
  /// In tr, this message translates to:
  /// **'Kanal adı gerekli'**
  String get channelsNameRequired;

  /// No description provided for @channelsNewTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yeni kanal'**
  String get channelsNewTitle;

  /// No description provided for @channelsNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Kanal bulunamadı'**
  String get channelsNotFound;

  /// No description provided for @channelsOff.
  ///
  /// In tr, this message translates to:
  /// **'Kapalı'**
  String get channelsOff;

  /// No description provided for @channelsPhoneHelper.
  ///
  /// In tr, this message translates to:
  /// **'Her satıra bir numara, ülke koduyla: +905xxxxxxxxx'**
  String get channelsPhoneHelper;

  /// No description provided for @channelsPhoneNumbers.
  ///
  /// In tr, this message translates to:
  /// **'Telefon numaraları'**
  String get channelsPhoneNumbers;

  /// No description provided for @channelsPushNote.
  ///
  /// In tr, this message translates to:
  /// **'Uyarılar telefon bildirimi olarak her zaman gelir. Buradaki kanallar ek olarak e-posta, Slack, SMS gibi yollarla da gönderir.'**
  String get channelsPushNote;

  /// No description provided for @channelsRecipientMax.
  ///
  /// In tr, this message translates to:
  /// **'En fazla 50 alıcı'**
  String get channelsRecipientMax;

  /// No description provided for @channelsRecipientRequired.
  ///
  /// In tr, this message translates to:
  /// **'En az bir alıcı gerekli'**
  String get channelsRecipientRequired;

  /// No description provided for @channelsSaveFailed.
  ///
  /// In tr, this message translates to:
  /// **'Kaydedilemedi'**
  String get channelsSaveFailed;

  /// No description provided for @channelsSaved.
  ///
  /// In tr, this message translates to:
  /// **'Kanal kaydedildi'**
  String get channelsSaved;

  /// No description provided for @channelsSaving.
  ///
  /// In tr, this message translates to:
  /// **'Kaydediliyor…'**
  String get channelsSaving;

  /// No description provided for @channelsSecretSaved.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı. Değiştirmek için yeni değeri yazın; boş bırakılırsa korunur.'**
  String get channelsSecretSaved;

  /// No description provided for @channelsSendFailed.
  ///
  /// In tr, this message translates to:
  /// **'Gönderilemedi'**
  String get channelsSendFailed;

  /// No description provided for @channelsSendResolved.
  ///
  /// In tr, this message translates to:
  /// **'Çözüldüğünde de bildir'**
  String get channelsSendResolved;

  /// No description provided for @channelsSendTest.
  ///
  /// In tr, this message translates to:
  /// **'Deneme bildirimi gönder'**
  String get channelsSendTest;

  /// No description provided for @channelsSeverityCritical.
  ///
  /// In tr, this message translates to:
  /// **'Kritik'**
  String get channelsSeverityCritical;

  /// No description provided for @channelsSeverityInfo.
  ///
  /// In tr, this message translates to:
  /// **'Bilgi'**
  String get channelsSeverityInfo;

  /// No description provided for @channelsSeverityWarning.
  ///
  /// In tr, this message translates to:
  /// **'Uyarı'**
  String get channelsSeverityWarning;

  /// No description provided for @channelsSourceHerd.
  ///
  /// In tr, this message translates to:
  /// **'Her sürü uyarısı'**
  String get channelsSourceHerd;

  /// No description provided for @channelsSourceHerdHint.
  ///
  /// In tr, this message translates to:
  /// **'Düşük debi olan her hayvan için ayrı mesaj (kalabalık olabilir)'**
  String get channelsSourceHerdHint;

  /// No description provided for @channelsSourceOps.
  ///
  /// In tr, this message translates to:
  /// **'Sistem alarmları'**
  String get channelsSourceOps;

  /// No description provided for @channelsSourceOpsHint.
  ///
  /// In tr, this message translates to:
  /// **'Sayaç kutusu sustu, veri kaybı gibi sistem sorunları'**
  String get channelsSourceOpsHint;

  /// No description provided for @channelsSourceRequired.
  ///
  /// In tr, this message translates to:
  /// **'En az bir bildirim türü seçin'**
  String get channelsSourceRequired;

  /// No description provided for @channelsSourceSummary.
  ///
  /// In tr, this message translates to:
  /// **'Sağım özeti'**
  String get channelsSourceSummary;

  /// No description provided for @channelsSourceSummaryHint.
  ///
  /// In tr, this message translates to:
  /// **'Sağım bitince tek mesaj (toplam süt, düşük verim ve düşük debi olan hayvanlar) ve Pazartesi sabahı haftalık özet (e-postada Excel raporu ekli)'**
  String get channelsSourceSummaryHint;

  /// No description provided for @channelsTestSent.
  ///
  /// In tr, this message translates to:
  /// **'Deneme bildirimi gönderildi'**
  String get channelsTestSent;

  /// No description provided for @channelsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim kanalları'**
  String get channelsTitle;

  /// No description provided for @channelsUnsupported.
  ///
  /// In tr, this message translates to:
  /// **'Bu kanal türü desteklenmiyor: {kind}/{provider}'**
  String channelsUnsupported(Object kind, Object provider);

  /// No description provided for @channelsWhenSection.
  ///
  /// In tr, this message translates to:
  /// **'Ne zaman gönderilsin'**
  String get channelsWhenSection;

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

  /// No description provided for @coreErrorBadCertificate.
  ///
  /// In tr, this message translates to:
  /// **'Sunucu sertifikası doğrulanamadı.'**
  String get coreErrorBadCertificate;

  /// No description provided for @coreErrorBadResponse.
  ///
  /// In tr, this message translates to:
  /// **'Sunucu beklenmeyen bir yanıt verdi.'**
  String get coreErrorBadResponse;

  /// No description provided for @coreErrorCancelled.
  ///
  /// In tr, this message translates to:
  /// **'İstek iptal edildi.'**
  String get coreErrorCancelled;

  /// No description provided for @coreErrorConnection.
  ///
  /// In tr, this message translates to:
  /// **'Sunucuya ulaşılamıyor. Bağlantınızı kontrol edin.'**
  String get coreErrorConnection;

  /// No description provided for @coreErrorTimeout.
  ///
  /// In tr, this message translates to:
  /// **'Sunucu yanıt vermiyor. Bağlantınızı kontrol edin.'**
  String get coreErrorTimeout;

  /// No description provided for @coreErrorTransform.
  ///
  /// In tr, this message translates to:
  /// **'Sunucunun yanıtı işlenemedi.'**
  String get coreErrorTransform;

  /// No description provided for @coreErrorUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Beklenmeyen bir hata oluştu.'**
  String get coreErrorUnknown;

  /// No description provided for @coreMemberAddedFallback.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı eklendi.'**
  String get coreMemberAddedFallback;

  /// No description provided for @coreResetLinkSentFallback.
  ///
  /// In tr, this message translates to:
  /// **'Sıfırlama bağlantısı gönderildi.'**
  String get coreResetLinkSentFallback;

  /// No description provided for @coreRouteNotFound.
  ///
  /// In tr, this message translates to:
  /// **'Sayfa bulunamadı'**
  String get coreRouteNotFound;

  /// No description provided for @coreRouteNotFoundBody.
  ///
  /// In tr, this message translates to:
  /// **'Aradığınız sayfa bulunamadı:\n{uri}'**
  String coreRouteNotFoundBody(Object uri);

  /// No description provided for @dashboardActiveSessions.
  ///
  /// In tr, this message translates to:
  /// **'{n} sağım sürüyor'**
  String dashboardActiveSessions(int n);

  /// No description provided for @dashboardBySpecies.
  ///
  /// In tr, this message translates to:
  /// **'Tür bazında'**
  String get dashboardBySpecies;

  /// No description provided for @dashboardGroupMilked.
  ///
  /// In tr, this message translates to:
  /// **'{milked}/{animals} hayvan sağıldı'**
  String dashboardGroupMilked(Object milked, Object animals);

  /// No description provided for @dashboardGroupsToday.
  ///
  /// In tr, this message translates to:
  /// **'Gruplar · bugün'**
  String get dashboardGroupsToday;

  /// No description provided for @dashboardLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Günün özeti alınamadı'**
  String get dashboardLoadFailed;

  /// No description provided for @dashboardMilkingsAnimals.
  ///
  /// In tr, this message translates to:
  /// **'{milkings} sağım · {animals} hayvan'**
  String dashboardMilkingsAnimals(Object milkings, Object animals);

  /// No description provided for @dashboardMoreAlerts.
  ///
  /// In tr, this message translates to:
  /// **'{n} uyarı daha'**
  String dashboardMoreAlerts(int n);

  /// No description provided for @dashboardNoMilkingToday.
  ///
  /// In tr, this message translates to:
  /// **'Bugün henüz sağım yapılmadı'**
  String get dashboardNoMilkingToday;

  /// No description provided for @dashboardNoOpenAlerts.
  ///
  /// In tr, this message translates to:
  /// **'Açık uyarı yok'**
  String get dashboardNoOpenAlerts;

  /// No description provided for @dashboardOpenAlerts.
  ///
  /// In tr, this message translates to:
  /// **'Açık uyarılar'**
  String get dashboardOpenAlerts;

  /// No description provided for @dashboardPerAnimal.
  ///
  /// In tr, this message translates to:
  /// **'hayvan başı {amount}'**
  String dashboardPerAnimal(Object amount);

  /// No description provided for @dashboardSpeciesAnimals.
  ///
  /// In tr, this message translates to:
  /// **'{species} · {n} hayvan'**
  String dashboardSpeciesAnimals(Object species, Object n);

  /// No description provided for @dashboardSpeciesFallback.
  ///
  /// In tr, this message translates to:
  /// **'Tür'**
  String get dashboardSpeciesFallback;

  /// No description provided for @dashboardTodayMilk.
  ///
  /// In tr, this message translates to:
  /// **'Bugün toplanan süt'**
  String get dashboardTodayMilk;

  /// No description provided for @dashboardYieldClasses.
  ///
  /// In tr, this message translates to:
  /// **'Verim sınıfları · {n} hayvan'**
  String dashboardYieldClasses(Object n);

  /// No description provided for @deliveriesAmountLabel.
  ///
  /// In tr, this message translates to:
  /// **'Teslim edilen ({unit})'**
  String deliveriesAmountLabel(Object unit);

  /// No description provided for @deliveriesCardHint.
  ///
  /// In tr, this message translates to:
  /// **'Tanker fişini girin: sayaçların ölçtüğüyle karşılaştırılır, fark büyükse uyarı gelir.'**
  String get deliveriesCardHint;

  /// No description provided for @deliveriesDay.
  ///
  /// In tr, this message translates to:
  /// **'Gün: {date}'**
  String deliveriesDay(Object date);

  /// No description provided for @deliveriesDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'{date} · {amount}\nYalnızca yanlış girilen kaydı silin; doğrusunu yeniden girin.'**
  String deliveriesDeleteBody(Object date, Object amount);

  /// No description provided for @deliveriesDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Teslim silinsin mi?'**
  String get deliveriesDeleteTitle;

  /// No description provided for @deliveriesDiffOver.
  ///
  /// In tr, this message translates to:
  /// **'+%{pct} · sayaçlar fazla'**
  String deliveriesDiffOver(Object pct);

  /// No description provided for @deliveriesDiffUnder.
  ///
  /// In tr, this message translates to:
  /// **'−%{pct} · sayaçlar eksik'**
  String deliveriesDiffUnder(Object pct);

  /// No description provided for @deliveriesEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz teslim girilmedi. İlk teslim karşılaştırılmaz; fark ikinci teslimden itibaren hesaplanır.'**
  String get deliveriesEmpty;

  /// No description provided for @deliveriesEnter.
  ///
  /// In tr, this message translates to:
  /// **'Teslim gir'**
  String get deliveriesEnter;

  /// No description provided for @deliveriesEnterAmount.
  ///
  /// In tr, this message translates to:
  /// **'Tanker fişindeki miktarı girin.'**
  String get deliveriesEnterAmount;

  /// No description provided for @deliveriesExplainer.
  ///
  /// In tr, this message translates to:
  /// **'Tanker fişi, önceki teslimden bu yana sayaçların ölçtüğüyle karşılaştırılır (ayrılan süt hariç). Fark %{pct} üstündeyse uyarı.'**
  String deliveriesExplainer(Object pct);

  /// No description provided for @deliveriesLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Teslimler yüklenemedi'**
  String get deliveriesLoadFailed;

  /// No description provided for @deliveriesMetered.
  ///
  /// In tr, this message translates to:
  /// **'Sayaçlar {span}{date}: {amount}{withheld}'**
  String deliveriesMetered(
    Object span,
    Object date,
    Object amount,
    Object withheld,
  );

  /// No description provided for @deliveriesNotCompared.
  ///
  /// In tr, this message translates to:
  /// **'Karşılaştırılmadı (önceki teslim ya da sayaç verisi yok)'**
  String get deliveriesNotCompared;

  /// No description provided for @deliveriesSaved.
  ///
  /// In tr, this message translates to:
  /// **'Teslim kaydedildi'**
  String get deliveriesSaved;

  /// No description provided for @deliveriesSavedMismatch.
  ///
  /// In tr, this message translates to:
  /// **'Teslim kaydedildi — sayaçlarla fark var: {diff}'**
  String deliveriesSavedMismatch(Object diff);

  /// No description provided for @deliveriesTankDelivery.
  ///
  /// In tr, this message translates to:
  /// **'Tank teslimi'**
  String get deliveriesTankDelivery;

  /// No description provided for @deliveriesTankerLine.
  ///
  /// In tr, this message translates to:
  /// **'{date} · tanker {amount}'**
  String deliveriesTankerLine(Object date, Object amount);

  /// No description provided for @deliveriesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tank teslimleri'**
  String get deliveriesTitle;

  /// No description provided for @deliveriesToleranceHelper.
  ///
  /// In tr, this message translates to:
  /// **'Sayaçlar ile tanker bundan fazla ayrışırsa uyarı.'**
  String get deliveriesToleranceHelper;

  /// No description provided for @deliveriesToleranceLabel.
  ///
  /// In tr, this message translates to:
  /// **'Uyarı için fark (%)'**
  String get deliveriesToleranceLabel;

  /// No description provided for @deliveriesToleranceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fark eşiği'**
  String get deliveriesToleranceTitle;

  /// No description provided for @deliveriesWithheld.
  ///
  /// In tr, this message translates to:
  /// **' (ayrılan {amount} hariç)'**
  String deliveriesWithheld(Object amount);

  /// No description provided for @devicesDetailCalibration.
  ///
  /// In tr, this message translates to:
  /// **'Kalibrasyon katsayısı'**
  String get devicesDetailCalibration;

  /// No description provided for @devicesDetailFirmware.
  ///
  /// In tr, this message translates to:
  /// **'Yazılım sürümü'**
  String get devicesDetailFirmware;

  /// No description provided for @devicesDetailLastError.
  ///
  /// In tr, this message translates to:
  /// **'Son hata'**
  String get devicesDetailLastError;

  /// No description provided for @devicesDetailLastSeen.
  ///
  /// In tr, this message translates to:
  /// **'Son görülme'**
  String get devicesDetailLastSeen;

  /// No description provided for @devicesDetailProfile.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get devicesDetailProfile;

  /// No description provided for @devicesDetailProtocol.
  ///
  /// In tr, this message translates to:
  /// **'Protokol'**
  String get devicesDetailProtocol;

  /// No description provided for @devicesEmptySpoutsCount.
  ///
  /// In tr, this message translates to:
  /// **'{n} Sayaçsız nokta'**
  String devicesEmptySpoutsCount(Object n);

  /// No description provided for @devicesErrorShort.
  ///
  /// In tr, this message translates to:
  /// **'Hata {code} · {since}'**
  String devicesErrorShort(Object code, Object since);

  /// No description provided for @devicesFirmwareShort.
  ///
  /// In tr, this message translates to:
  /// **'Yazılım {version}'**
  String devicesFirmwareShort(Object version);

  /// No description provided for @devicesHallNoVacuums.
  ///
  /// In tr, this message translates to:
  /// **'Bu bölgede tanımlı ünite yok'**
  String get devicesHallNoVacuums;

  /// No description provided for @devicesHallTitle.
  ///
  /// In tr, this message translates to:
  /// **'{name} Bölgesi'**
  String devicesHallTitle(Object name);

  /// No description provided for @devicesLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Cihazlar yüklenemedi'**
  String get devicesLoadFailed;

  /// No description provided for @devicesNoProfile.
  ///
  /// In tr, this message translates to:
  /// **'Profilsiz'**
  String get devicesNoProfile;

  /// No description provided for @devicesNoRecord.
  ///
  /// In tr, this message translates to:
  /// **'Kayıt yok'**
  String get devicesNoRecord;

  /// No description provided for @devicesOfflineCount.
  ///
  /// In tr, this message translates to:
  /// **'{n} Çevrimdışı'**
  String devicesOfflineCount(Object n);

  /// No description provided for @devicesOnlineCount.
  ///
  /// In tr, this message translates to:
  /// **'{n} Çevrimiçi'**
  String devicesOnlineCount(Object n);

  /// No description provided for @devicesProfileUnassigned.
  ///
  /// In tr, this message translates to:
  /// **'Atanmamış (karantinada)'**
  String get devicesProfileUnassigned;

  /// No description provided for @devicesSimulated.
  ///
  /// In tr, this message translates to:
  /// **'Simülatör cihazı'**
  String get devicesSimulated;

  /// No description provided for @devicesSourcesLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kaynaklar:'**
  String get devicesSourcesLabel;

  /// No description provided for @devicesSpoutLabel.
  ///
  /// In tr, this message translates to:
  /// **'Nokta {no}'**
  String devicesSpoutLabel(Object no);

  /// No description provided for @devicesStatusNoMeter.
  ///
  /// In tr, this message translates to:
  /// **'Sayaç takılı değil'**
  String get devicesStatusNoMeter;

  /// No description provided for @devicesStatusOffline.
  ///
  /// In tr, this message translates to:
  /// **'Çevrimdışı'**
  String get devicesStatusOffline;

  /// No description provided for @devicesStatusOnline.
  ///
  /// In tr, this message translates to:
  /// **'Çevrimiçi'**
  String get devicesStatusOnline;

  /// No description provided for @devicesStatusReportedError.
  ///
  /// In tr, this message translates to:
  /// **'Hata bildirdi'**
  String get devicesStatusReportedError;

  /// No description provided for @devicesUnassignedHint.
  ///
  /// In tr, this message translates to:
  /// **'Bir sağım noktasına bağlı değil.'**
  String get devicesUnassignedHint;

  /// No description provided for @devicesUnassignedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Takılı olmayan sayaçlar'**
  String get devicesUnassignedTitle;

  /// No description provided for @devicesUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmiyor'**
  String get devicesUnknown;

  /// No description provided for @devicesUnprofiledCount.
  ///
  /// In tr, this message translates to:
  /// **'{n} Profilsiz sayaç'**
  String devicesUnprofiledCount(Object n);

  /// No description provided for @devicesVacuumAllOnline.
  ///
  /// In tr, this message translates to:
  /// **'{points} nokta · tümü çevrimiçi'**
  String devicesVacuumAllOnline(Object points);

  /// No description provided for @devicesVacuumProblems.
  ///
  /// In tr, this message translates to:
  /// **'{points} nokta · {problems} ilgilenilmeli'**
  String devicesVacuumProblems(Object points, Object problems);

  /// No description provided for @devicesVacuumTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ünite {name}'**
  String devicesVacuumTitle(Object name);

  /// No description provided for @domainClassDeclining.
  ///
  /// In tr, this message translates to:
  /// **'Düşüşte'**
  String get domainClassDeclining;

  /// No description provided for @domainClassDecliningExplanation.
  ///
  /// In tr, this message translates to:
  /// **'Son 30 günde belirgin düşüş var. Gebelik, laktasyon dönemi veya hastalık olabilir; takip listesinde.'**
  String get domainClassDecliningExplanation;

  /// No description provided for @domainClassDryOffCandidate.
  ///
  /// In tr, this message translates to:
  /// **'Kuruya Çıkma Adayı'**
  String get domainClassDryOffCandidate;

  /// No description provided for @domainClassDryOffCandidateExplanation.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 günün ortalaması tür alt eşiğinin altında. Kuruya çıkarma zamanı gelmiş olabilir.'**
  String get domainClassDryOffCandidateExplanation;

  /// No description provided for @domainClassHigh.
  ///
  /// In tr, this message translates to:
  /// **'Yüksek Verimli'**
  String get domainClassHigh;

  /// No description provided for @domainClassHighExplanation.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 günün ortalaması tür üst eşiğinin üzerinde. Bu hayvan sürünün en verimlileri arasında.'**
  String get domainClassHighExplanation;

  /// No description provided for @domainClassNoMilk.
  ///
  /// In tr, this message translates to:
  /// **'Süt Vermiyor'**
  String get domainClassNoMilk;

  /// No description provided for @domainClassNoMilkExplanation.
  ///
  /// In tr, this message translates to:
  /// **'Son sağımlarda süt alınamadı. Değerlendirme gerekli.'**
  String get domainClassNoMilkExplanation;

  /// No description provided for @domainClassNormal.
  ///
  /// In tr, this message translates to:
  /// **'Normal'**
  String get domainClassNormal;

  /// No description provided for @domainClassNormalExplanation.
  ///
  /// In tr, this message translates to:
  /// **'Verim beklenen aralıkta, eğim stabil.'**
  String get domainClassNormalExplanation;

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

  /// No description provided for @groupsAdd.
  ///
  /// In tr, this message translates to:
  /// **'Grup ekle'**
  String get groupsAdd;

  /// No description provided for @groupsDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'Gruptaki hayvanlar silinmez, grupsuz kalır.'**
  String get groupsDeleteBody;

  /// No description provided for @groupsDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'\"{name}\" silinsin mi?'**
  String groupsDeleteTitle(Object name);

  /// No description provided for @groupsDeleteTooltip.
  ///
  /// In tr, this message translates to:
  /// **'Grubu sil'**
  String get groupsDeleteTooltip;

  /// No description provided for @groupsEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Henüz grup yok.'**
  String get groupsEmpty;

  /// No description provided for @groupsIntro.
  ///
  /// In tr, this message translates to:
  /// **'Her hayvanın en çok bir grubu olur; hayvan gruba düzenleme formundan atanır. Panoda grupların günlük toplamı görünür.'**
  String get groupsIntro;

  /// No description provided for @groupsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Gruplar yüklenemedi'**
  String get groupsLoadFailed;

  /// No description provided for @groupsMilkingCount.
  ///
  /// In tr, this message translates to:
  /// **'{n, plural, other{{n} sağmal hayvan}}'**
  String groupsMilkingCount(int n);

  /// No description provided for @groupsNameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ad (ör. Padok 1, Yüksek verim)'**
  String get groupsNameLabel;

  /// No description provided for @groupsNew.
  ///
  /// In tr, this message translates to:
  /// **'Yeni grup'**
  String get groupsNew;

  /// No description provided for @groupsRenameTitle.
  ///
  /// In tr, this message translates to:
  /// **'Grubun adı'**
  String get groupsRenameTitle;

  /// No description provided for @groupsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gruplar'**
  String get groupsTitle;

  /// No description provided for @historyAddAnimal.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan ekle'**
  String get historyAddAnimal;

  /// No description provided for @historyAnimalCount.
  ///
  /// In tr, this message translates to:
  /// **'{count, plural, other{{count} hayvan}}'**
  String historyAnimalCount(int count);

  /// No description provided for @historyAnimalsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Hayvanlar yüklenemedi'**
  String get historyAnimalsLoadFailed;

  /// No description provided for @historyFilterGroup.
  ///
  /// In tr, this message translates to:
  /// **'Grup'**
  String get historyFilterGroup;

  /// No description provided for @historyFilterSpecies.
  ///
  /// In tr, this message translates to:
  /// **'Tür'**
  String get historyFilterSpecies;

  /// No description provided for @historyFromList.
  ///
  /// In tr, this message translates to:
  /// **'Listeden'**
  String get historyFromList;

  /// No description provided for @historyGroups.
  ///
  /// In tr, this message translates to:
  /// **'Gruplar'**
  String get historyGroups;

  /// No description provided for @historyLactationNo.
  ///
  /// In tr, this message translates to:
  /// **'{n}. laktasyon'**
  String historyLactationNo(Object n);

  /// No description provided for @historyNoAnimalsForFilter.
  ///
  /// In tr, this message translates to:
  /// **'Bu filtreye uyan hayvan yok'**
  String get historyNoAnimalsForFilter;

  /// No description provided for @historyNoSessions.
  ///
  /// In tr, this message translates to:
  /// **'Kayıtlı sağım oturumu yok'**
  String get historyNoSessions;

  /// No description provided for @historyReport.
  ///
  /// In tr, this message translates to:
  /// **'Rapor'**
  String get historyReport;

  /// No description provided for @historySessionAutoStarted.
  ///
  /// In tr, this message translates to:
  /// **'otomatik açıldı'**
  String get historySessionAutoStarted;

  /// No description provided for @historySessionRunning.
  ///
  /// In tr, this message translates to:
  /// **'Sürüyor'**
  String get historySessionRunning;

  /// No description provided for @historySessionStartUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç bilinmiyor'**
  String get historySessionStartUnknown;

  /// No description provided for @historySessionTitle.
  ///
  /// In tr, this message translates to:
  /// **'{hall} Bölgesi · {type} Sağımı'**
  String historySessionTitle(Object hall, Object type);

  /// No description provided for @historySessionsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Oturumlar yüklenemedi'**
  String get historySessionsLoadFailed;

  /// No description provided for @historySpoutLabel.
  ///
  /// In tr, this message translates to:
  /// **'{vacuum} · Nokta {n}'**
  String historySpoutLabel(Object vacuum, Object n);

  /// No description provided for @historyTabAnimals.
  ///
  /// In tr, this message translates to:
  /// **'Hayvanlar'**
  String get historyTabAnimals;

  /// No description provided for @historyTabSessions.
  ///
  /// In tr, this message translates to:
  /// **'Oturumlar'**
  String get historyTabSessions;

  /// No description provided for @historyUnknownVacuum.
  ///
  /// In tr, this message translates to:
  /// **'Ünite'**
  String get historyUnknownVacuum;

  /// No description provided for @historyUnmatchedBanner.
  ///
  /// In tr, this message translates to:
  /// **'{n, plural, other{{n} tanınmayan küpe}}'**
  String historyUnmatchedBanner(int n);

  /// No description provided for @historyUnmatchedBannerHint.
  ///
  /// In tr, this message translates to:
  /// **'Sağımda okundu; hayvanına atayın'**
  String get historyUnmatchedBannerHint;

  /// No description provided for @kioskExitBody.
  ///
  /// In tr, this message translates to:
  /// **'Yeniden girmek için tablet hesabının e-postası ve parolası gerekir.'**
  String get kioskExitBody;

  /// No description provided for @kioskExitTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tabletten çıkılsın mı?'**
  String get kioskExitTitle;

  /// No description provided for @kioskSignOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış'**
  String get kioskSignOut;

  /// No description provided for @kioskTitle.
  ///
  /// In tr, this message translates to:
  /// **'Milk Trace · Sağımhane'**
  String get kioskTitle;

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

  /// No description provided for @liveActionFailed.
  ///
  /// In tr, this message translates to:
  /// **'İşlem tamamlanamadı: {error}'**
  String liveActionFailed(Object error);

  /// No description provided for @liveActiveCount.
  ///
  /// In tr, this message translates to:
  /// **'{n} Aktif'**
  String liveActiveCount(Object n);

  /// No description provided for @liveClearBodyEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Bu sağım silinecek.'**
  String get liveClearBodyEmpty;

  /// No description provided for @liveClearBodyMeasured.
  ///
  /// In tr, this message translates to:
  /// **'Bu sağımdaki ölçüm ({amount}) silinecek ve hiçbir hayvana yazılmayacak.'**
  String liveClearBodyMeasured(Object amount);

  /// No description provided for @liveClearConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Kaldır'**
  String get liveClearConfirm;

  /// No description provided for @liveClearTitle.
  ///
  /// In tr, this message translates to:
  /// **'Eşleştirme kaldırılsın mı?'**
  String get liveClearTitle;

  /// No description provided for @liveDataFailed.
  ///
  /// In tr, this message translates to:
  /// **'Canlı veri alınamadı'**
  String get liveDataFailed;

  /// No description provided for @liveEndConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Bitir'**
  String get liveEndConfirm;

  /// No description provided for @liveEndDialogBody.
  ///
  /// In tr, this message translates to:
  /// **'Açık kalan hayvan sağımları kapatılacak ve oturum özetleri hesaplanacak. Bu işlem geri alınamaz.'**
  String get liveEndDialogBody;

  /// No description provided for @liveEndDialogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sağımı bitir'**
  String get liveEndDialogTitle;

  /// No description provided for @liveEndMilking.
  ///
  /// In tr, this message translates to:
  /// **'Sağımı Bitir'**
  String get liveEndMilking;

  /// No description provided for @liveFlowRate.
  ///
  /// In tr, this message translates to:
  /// **'Akış oranı'**
  String get liveFlowRate;

  /// No description provided for @liveFlowUnit.
  ///
  /// In tr, this message translates to:
  /// **'L/dk'**
  String get liveFlowUnit;

  /// No description provided for @liveHallName.
  ///
  /// In tr, this message translates to:
  /// **'{name} Bölgesi'**
  String liveHallName(Object name);

  /// No description provided for @liveHallsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Bölgeler yüklenemedi'**
  String get liveHallsLoadFailed;

  /// No description provided for @liveLowFlow.
  ///
  /// In tr, this message translates to:
  /// **'Düşük Debi'**
  String get liveLowFlow;

  /// No description provided for @liveNoHalls.
  ///
  /// In tr, this message translates to:
  /// **'Tanımlı sağım bölgesi yok'**
  String get liveNoHalls;

  /// No description provided for @liveNoOpenSession.
  ///
  /// In tr, this message translates to:
  /// **'Bu bölgede açık sağım yok.\nBaşlatmak için yukarıdaki düğmeyi kullanın.'**
  String get liveNoOpenSession;

  /// No description provided for @liveNoSpouts.
  ///
  /// In tr, this message translates to:
  /// **'Bu bölgede sağım noktası bulunamadı'**
  String get liveNoSpouts;

  /// No description provided for @liveNoTarget.
  ///
  /// In tr, this message translates to:
  /// **'Hedef tanımsız'**
  String get liveNoTarget;

  /// No description provided for @liveNotAssigned.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan eşleştirilmedi'**
  String get liveNotAssigned;

  /// No description provided for @liveNow.
  ///
  /// In tr, this message translates to:
  /// **'Şu an'**
  String get liveNow;

  /// No description provided for @livePassiveCount.
  ///
  /// In tr, this message translates to:
  /// **'{n} Pasif'**
  String livePassiveCount(Object n);

  /// No description provided for @livePickerClear.
  ///
  /// In tr, this message translates to:
  /// **'Eşleştirmeyi kaldır'**
  String get livePickerClear;

  /// No description provided for @livePickerClearHint.
  ///
  /// In tr, this message translates to:
  /// **'{animal} yanlış bağlandıysa'**
  String livePickerClearHint(Object animal);

  /// No description provided for @livePickerElsewhere.
  ///
  /// In tr, this message translates to:
  /// **'başka noktada'**
  String get livePickerElsewhere;

  /// No description provided for @livePickerLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Hayvanlar yüklenemedi'**
  String get livePickerLoadFailed;

  /// No description provided for @livePickerNoMatch.
  ///
  /// In tr, this message translates to:
  /// **'Eşleşen hayvan yok'**
  String get livePickerNoMatch;

  /// No description provided for @livePickerNotMilking.
  ///
  /// In tr, this message translates to:
  /// **'{message}: listede yok. Yanlışlıkla girdiyse başlığı çıkarın; sağılacaksa önce hayvanın durumunu değiştirin.'**
  String livePickerNotMilking(Object message);

  /// No description provided for @livePickerPrevHere.
  ///
  /// In tr, this message translates to:
  /// **'önceki sağımda bu noktadaydı'**
  String get livePickerPrevHere;

  /// No description provided for @livePickerPrevMilked.
  ///
  /// In tr, this message translates to:
  /// **'önceki sağımda sağıldı'**
  String get livePickerPrevMilked;

  /// No description provided for @livePickerSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Küpe numarası, ad veya RFID'**
  String get livePickerSearchHint;

  /// No description provided for @livePickerTitle.
  ///
  /// In tr, this message translates to:
  /// **'{spout} · hayvan seç'**
  String livePickerTitle(Object spout);

  /// No description provided for @livePickerUnknownTag.
  ///
  /// In tr, this message translates to:
  /// **'{message}. Hayvanı aşağıdan seçin.'**
  String livePickerUnknownTag(Object message);

  /// No description provided for @livePickerWithhold.
  ///
  /// In tr, this message translates to:
  /// **'Sütü ayır\n{date}'**
  String livePickerWithhold(Object date);

  /// No description provided for @liveRedAlertOff.
  ///
  /// In tr, this message translates to:
  /// **'Kırmızı uyarısını kapat'**
  String get liveRedAlertOff;

  /// No description provided for @liveRedAlertOn.
  ///
  /// In tr, this message translates to:
  /// **'Kırmızı uyarısını aç'**
  String get liveRedAlertOn;

  /// No description provided for @liveReplaceBody.
  ///
  /// In tr, this message translates to:
  /// **'{who} için bu noktada {amount} ölçüldü.\n\nSağıldıysa ölçüm ona yazılır. Eşleştirme yanlışsa ölçüm silinir.'**
  String liveReplaceBody(Object who, Object amount);

  /// No description provided for @liveReplaceMilked.
  ///
  /// In tr, this message translates to:
  /// **'Sağıldı'**
  String get liveReplaceMilked;

  /// No description provided for @liveReplaceMistaken.
  ///
  /// In tr, this message translates to:
  /// **'Yanlış eşleştirme'**
  String get liveReplaceMistaken;

  /// No description provided for @liveReplaceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Önceki hayvan sağıldı mı?'**
  String get liveReplaceTitle;

  /// No description provided for @liveSessionTypeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sağım tipi'**
  String get liveSessionTypeTitle;

  /// No description provided for @liveSpout.
  ///
  /// In tr, this message translates to:
  /// **'Nokta'**
  String get liveSpout;

  /// No description provided for @liveSpoutTitle.
  ///
  /// In tr, this message translates to:
  /// **'{unit} · Nokta {no}'**
  String liveSpoutTitle(Object unit, Object no);

  /// No description provided for @liveStartMilking.
  ///
  /// In tr, this message translates to:
  /// **'Sağımı Başlat'**
  String get liveStartMilking;

  /// No description provided for @liveTarget.
  ///
  /// In tr, this message translates to:
  /// **'Hedef'**
  String get liveTarget;

  /// No description provided for @liveTitle.
  ///
  /// In tr, this message translates to:
  /// **'Canlı Veriler'**
  String get liveTitle;

  /// No description provided for @liveUnitFallback.
  ///
  /// In tr, this message translates to:
  /// **'Ünite'**
  String get liveUnitFallback;

  /// No description provided for @liveUnknownTag.
  ///
  /// In tr, this message translates to:
  /// **'Tanınmayan küpe'**
  String get liveUnknownTag;

  /// No description provided for @liveWithholdUntil.
  ///
  /// In tr, this message translates to:
  /// **'Sütü ayır · arınma {date}'**
  String liveWithholdUntil(Object date);

  /// No description provided for @loginEmailInvalid.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta girin.'**
  String get loginEmailInvalid;

  /// No description provided for @loginEmailLabel.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailRequired.
  ///
  /// In tr, this message translates to:
  /// **'E-posta girin.'**
  String get loginEmailRequired;

  /// No description provided for @loginForgotPassword.
  ///
  /// In tr, this message translates to:
  /// **'Parolamı unuttum'**
  String get loginForgotPassword;

  /// No description provided for @loginHidePassword.
  ///
  /// In tr, this message translates to:
  /// **'Parolayı gizle'**
  String get loginHidePassword;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Parola'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In tr, this message translates to:
  /// **'Parola girin.'**
  String get loginPasswordRequired;

  /// No description provided for @loginResetIntro.
  ///
  /// In tr, this message translates to:
  /// **'E-posta adresinize yeni parola belirleme bağlantısı gönderelim.'**
  String get loginResetIntro;

  /// No description provided for @loginResetSend.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı gönder'**
  String get loginResetSend;

  /// No description provided for @loginShowPassword.
  ///
  /// In tr, this message translates to:
  /// **'Parolayı göster'**
  String get loginShowPassword;

  /// No description provided for @loginSubmit.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yap'**
  String get loginSubmit;

  /// No description provided for @loginTagline.
  ///
  /// In tr, this message translates to:
  /// **'İşletmenizin sağım takibi'**
  String get loginTagline;

  /// No description provided for @milkersDurationMinutesSeconds.
  ///
  /// In tr, this message translates to:
  /// **'{m} dk {s} sn'**
  String milkersDurationMinutesSeconds(Object m, Object s);

  /// No description provided for @milkersDurationSeconds.
  ///
  /// In tr, this message translates to:
  /// **'{s} sn'**
  String milkersDurationSeconds(Object s);

  /// No description provided for @milkersEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Bu dönemde sağım yok.'**
  String get milkersEmpty;

  /// No description provided for @milkersLast30Days.
  ///
  /// In tr, this message translates to:
  /// **'Son 30 gün'**
  String get milkersLast30Days;

  /// No description provided for @milkersLast7Days.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 gün'**
  String get milkersLast7Days;

  /// No description provided for @milkersLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Sağımcı özeti yüklenemedi'**
  String get milkersLoadFailed;

  /// No description provided for @milkersNote.
  ///
  /// In tr, this message translates to:
  /// **'Sağımcı, oturumu açan ya da hayvanı noktaya bağlayan kişidir. Düşük debi çoğu zaman hayvandan ya da başlıktan gelir; oran bakılacak yeri gösterir, kişiyi puanlamaz.'**
  String get milkersNote;

  /// No description provided for @milkersStats.
  ///
  /// In tr, this message translates to:
  /// **'Ortalama sağım {duration} · düşük debi %{pct}'**
  String milkersStats(Object duration, Object pct);

  /// No description provided for @milkersSummary.
  ///
  /// In tr, this message translates to:
  /// **'{sessions} oturum · {milkings} sağım · {volume}'**
  String milkersSummary(Object sessions, Object milkings, Object volume);

  /// No description provided for @milkersTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sağımcılar'**
  String get milkersTitle;

  /// No description provided for @milkersUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Sağımcısı bilinmeyen'**
  String get milkersUnknown;

  /// No description provided for @milkersUnknownHint.
  ///
  /// In tr, this message translates to:
  /// **'RFID ile açılan ya da eşleştireni silinmiş sağımlar'**
  String get milkersUnknownHint;

  /// No description provided for @modelAnimalStatusActive.
  ///
  /// In tr, this message translates to:
  /// **'Sağmal'**
  String get modelAnimalStatusActive;

  /// No description provided for @modelAnimalStatusDead.
  ///
  /// In tr, this message translates to:
  /// **'Öldü'**
  String get modelAnimalStatusDead;

  /// No description provided for @modelAnimalStatusDry.
  ///
  /// In tr, this message translates to:
  /// **'Kuruda'**
  String get modelAnimalStatusDry;

  /// No description provided for @modelAnimalStatusSlaughtered.
  ///
  /// In tr, this message translates to:
  /// **'Kesildi'**
  String get modelAnimalStatusSlaughtered;

  /// No description provided for @modelAnimalStatusSold.
  ///
  /// In tr, this message translates to:
  /// **'Satıldı'**
  String get modelAnimalStatusSold;

  /// No description provided for @modelBreedingInsemination.
  ///
  /// In tr, this message translates to:
  /// **'Tohumlama'**
  String get modelBreedingInsemination;

  /// No description provided for @modelBreedingPregnancyCheck.
  ///
  /// In tr, this message translates to:
  /// **'Gebelik kontrolü · {result}'**
  String modelBreedingPregnancyCheck(Object result);

  /// No description provided for @modelBreedingResultOpen.
  ///
  /// In tr, this message translates to:
  /// **'boş'**
  String get modelBreedingResultOpen;

  /// No description provided for @modelBreedingResultPregnant.
  ///
  /// In tr, this message translates to:
  /// **'gebe'**
  String get modelBreedingResultPregnant;

  /// No description provided for @modelPregnancyInseminated.
  ///
  /// In tr, this message translates to:
  /// **'Tohumlandı · kontrol bekliyor'**
  String get modelPregnancyInseminated;

  /// No description provided for @modelPregnancyOpen.
  ///
  /// In tr, this message translates to:
  /// **'Boş'**
  String get modelPregnancyOpen;

  /// No description provided for @modelPregnancyPregnant.
  ///
  /// In tr, this message translates to:
  /// **'Gebe'**
  String get modelPregnancyPregnant;

  /// No description provided for @modelProfileUndefined.
  ///
  /// In tr, this message translates to:
  /// **'Profil tanımsız'**
  String get modelProfileUndefined;

  /// No description provided for @modelProtocolUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmiyor'**
  String get modelProtocolUnknown;

  /// No description provided for @modelUpcomingCalving.
  ///
  /// In tr, this message translates to:
  /// **'Beklenen doğum'**
  String get modelUpcomingCalving;

  /// No description provided for @modelUpcomingDryOff.
  ///
  /// In tr, this message translates to:
  /// **'Kuruya çıkar'**
  String get modelUpcomingDryOff;

  /// No description provided for @pushChannelDescription.
  ///
  /// In tr, this message translates to:
  /// **'Düşük debi, düşük verim ve cihaz uyarıları.'**
  String get pushChannelDescription;

  /// No description provided for @pushChannelName.
  ///
  /// In tr, this message translates to:
  /// **'Sağım uyarıları'**
  String get pushChannelName;

  /// No description provided for @roleOperator.
  ///
  /// In tr, this message translates to:
  /// **'Operatör'**
  String get roleOperator;

  /// No description provided for @roleOperatorHint.
  ///
  /// In tr, this message translates to:
  /// **'Sağımı yürütür: oturum açar, hayvan eşleştirir.'**
  String get roleOperatorHint;

  /// No description provided for @roleOwner.
  ///
  /// In tr, this message translates to:
  /// **'İşletme sahibi'**
  String get roleOwner;

  /// No description provided for @rolePlatformAdmin.
  ///
  /// In tr, this message translates to:
  /// **'Platform yöneticisi'**
  String get rolePlatformAdmin;

  /// No description provided for @roleViewer.
  ///
  /// In tr, this message translates to:
  /// **'Görüntüleyici'**
  String get roleViewer;

  /// No description provided for @roleViewerHint.
  ///
  /// In tr, this message translates to:
  /// **'Veteriner, danışman: görür ve not yazar, değiştiremez.'**
  String get roleViewerHint;

  /// No description provided for @sessionSummaryLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Oturum özeti alınamadı'**
  String get sessionSummaryLoadFailed;

  /// No description provided for @sessionSummaryLowFlow.
  ///
  /// In tr, this message translates to:
  /// **'Düşük debi: {n}'**
  String sessionSummaryLowFlow(Object n);

  /// No description provided for @sessionSummaryLowYield.
  ///
  /// In tr, this message translates to:
  /// **'Düşük verim: {n}'**
  String sessionSummaryLowYield(Object n);

  /// No description provided for @sessionSummaryNoneNotMilked.
  ///
  /// In tr, this message translates to:
  /// **'Sağmal hayvanların hepsi sağıldı.'**
  String get sessionSummaryNoneNotMilked;

  /// No description provided for @sessionSummaryNotMilked.
  ///
  /// In tr, this message translates to:
  /// **'Sağılmayan sağmal: {n}'**
  String sessionSummaryNotMilked(Object n);

  /// No description provided for @sessionSummaryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oturum özeti'**
  String get sessionSummaryTitle;

  /// No description provided for @sessionSummaryTotals.
  ///
  /// In tr, this message translates to:
  /// **'{n, plural, other{{n} hayvan sağıldı}} · {amount}'**
  String sessionSummaryTotals(int n, Object amount);

  /// No description provided for @shellTabDashboard.
  ///
  /// In tr, this message translates to:
  /// **'Dashboard'**
  String get shellTabDashboard;

  /// No description provided for @shellTabDevices.
  ///
  /// In tr, this message translates to:
  /// **'Cihazlar'**
  String get shellTabDevices;

  /// No description provided for @shellTabHistory.
  ///
  /// In tr, this message translates to:
  /// **'Geçmiş'**
  String get shellTabHistory;

  /// No description provided for @shellTabLive.
  ///
  /// In tr, this message translates to:
  /// **'Canlı'**
  String get shellTabLive;

  /// No description provided for @speciesCow.
  ///
  /// In tr, this message translates to:
  /// **'İnek'**
  String get speciesCow;

  /// No description provided for @speciesGoat.
  ///
  /// In tr, this message translates to:
  /// **'Keçi'**
  String get speciesGoat;

  /// No description provided for @speciesSheep.
  ///
  /// In tr, this message translates to:
  /// **'Koyun'**
  String get speciesSheep;

  /// No description provided for @supportCall.
  ///
  /// In tr, this message translates to:
  /// **'Ara'**
  String get supportCall;

  /// No description provided for @supportOpenFailed.
  ///
  /// In tr, this message translates to:
  /// **'Açılamadı: {target}'**
  String supportOpenFailed(Object target);

  /// No description provided for @supportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Destek'**
  String get supportTitle;

  /// No description provided for @supportWhatsAppText.
  ///
  /// In tr, this message translates to:
  /// **'Merhaba, Milk Trace hakkında destek istiyorum.'**
  String get supportWhatsAppText;

  /// No description provided for @supportWhatsAppVersion.
  ///
  /// In tr, this message translates to:
  /// **' (Uygulama {version})'**
  String supportWhatsAppVersion(Object version);

  /// No description provided for @teamActionFailed.
  ///
  /// In tr, this message translates to:
  /// **'İşlem yapılamadı: {error}'**
  String teamActionFailed(Object error);

  /// No description provided for @teamActivate.
  ///
  /// In tr, this message translates to:
  /// **'Etkinleştir'**
  String get teamActivate;

  /// No description provided for @teamActivateHint.
  ///
  /// In tr, this message translates to:
  /// **'Yeniden giriş yapabilir.'**
  String get teamActivateHint;

  /// No description provided for @teamAddFailed.
  ///
  /// In tr, this message translates to:
  /// **'Eklenemedi: {error}'**
  String teamAddFailed(Object error);

  /// No description provided for @teamAddUser.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı ekle'**
  String get teamAddUser;

  /// No description provided for @teamDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'{name} kalıcı olarak silinecek; geri alınamaz. Yazdığı hayvan notları kalır, yazarı \"Silinmiş kullanıcı\" görünür.\n\nYalnızca erişimi kesmek için \"Askıya al\"ı kullanın.'**
  String teamDeleteBody(Object name);

  /// No description provided for @teamDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcıyı sil'**
  String get teamDeleteTitle;

  /// No description provided for @teamEmailInvalid.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir e-posta girin.'**
  String get teamEmailInvalid;

  /// No description provided for @teamEmailLabel.
  ///
  /// In tr, this message translates to:
  /// **'E-posta'**
  String get teamEmailLabel;

  /// No description provided for @teamFullNameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ad soyad'**
  String get teamFullNameLabel;

  /// No description provided for @teamFullNameRequired.
  ///
  /// In tr, this message translates to:
  /// **'Ad soyad girin.'**
  String get teamFullNameRequired;

  /// No description provided for @teamKiosk.
  ///
  /// In tr, this message translates to:
  /// **'Sağımhane tableti'**
  String get teamKiosk;

  /// No description provided for @teamKioskHint.
  ///
  /// In tr, this message translates to:
  /// **'Sağımhanedeki ortak tablet için: yalnızca canlı sağım açılır, ekran kararmaz. Tablete bu e-posta ve parolayla girilir.'**
  String get teamKioskHint;

  /// No description provided for @teamLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcılar yüklenemedi'**
  String get teamLoadFailed;

  /// No description provided for @teamMakeRole.
  ///
  /// In tr, this message translates to:
  /// **'{role} yap'**
  String teamMakeRole(Object role);

  /// No description provided for @teamNote.
  ///
  /// In tr, this message translates to:
  /// **'Operatör sağımı yürütür; görüntüleyici (veteriner, danışman) görür ve not yazar. İşletme sahibi eklemek için Milk Trace desteğine başvurun.'**
  String get teamNote;

  /// No description provided for @teamPasswordTooShort.
  ///
  /// In tr, this message translates to:
  /// **'En az 8 karakter.'**
  String get teamPasswordTooShort;

  /// No description provided for @teamSuspend.
  ///
  /// In tr, this message translates to:
  /// **'Askıya al'**
  String get teamSuspend;

  /// No description provided for @teamSuspendHint.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yapamaz; açık oturumu en geç 15 dakikada kapanır.'**
  String get teamSuspendHint;

  /// No description provided for @teamSuspended.
  ///
  /// In tr, this message translates to:
  /// **'Askıda'**
  String get teamSuspended;

  /// No description provided for @teamTabletPassword.
  ///
  /// In tr, this message translates to:
  /// **'Tablet parolası'**
  String get teamTabletPassword;

  /// No description provided for @teamTabletPasswordHelper.
  ///
  /// In tr, this message translates to:
  /// **'Tablete bu parolayla girilir; en az 8 karakter.'**
  String get teamTabletPasswordHelper;

  /// No description provided for @teamTabletPasswordRequired.
  ///
  /// In tr, this message translates to:
  /// **'Tablet için parola girin.'**
  String get teamTabletPasswordRequired;

  /// No description provided for @teamTempPassword.
  ///
  /// In tr, this message translates to:
  /// **'Geçici parola (isteğe bağlı)'**
  String get teamTempPassword;

  /// No description provided for @teamTempPasswordHelper.
  ///
  /// In tr, this message translates to:
  /// **'Boş bırakırsanız e-postayla davet gider.'**
  String get teamTempPasswordHelper;

  /// No description provided for @teamTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcılar'**
  String get teamTitle;

  /// No description provided for @thresholdsAlertHold.
  ///
  /// In tr, this message translates to:
  /// **'Uyarı bekleme'**
  String get thresholdsAlertHold;

  /// No description provided for @thresholdsCalibrationNote.
  ///
  /// In tr, this message translates to:
  /// **'Varsayılanlar tahmini başlangıç değerleridir. Irk, laktasyon dönemi ve işletmeye göre çok değişir; saha verisi ve ziraat mühendisi/veteriner görüşüyle kalibre edilmelidir.'**
  String get thresholdsCalibrationNote;

  /// No description provided for @thresholdsClassGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'7 günlük ortalama alt eşiğin altındaysa kuruya aday, üst eşiğin üstündeyse yüksek verimli (§6.4).'**
  String get thresholdsClassGroupHint;

  /// No description provided for @thresholdsClassGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sınıflandırma eşikleri'**
  String get thresholdsClassGroupTitle;

  /// No description provided for @thresholdsConductivity.
  ///
  /// In tr, this message translates to:
  /// **'İletkenlik artışı'**
  String get thresholdsConductivity;

  /// No description provided for @thresholdsDecline.
  ///
  /// In tr, this message translates to:
  /// **'Düşüş eşiği'**
  String get thresholdsDecline;

  /// No description provided for @thresholdsDensity.
  ///
  /// In tr, this message translates to:
  /// **'Yoğunluk'**
  String get thresholdsDensity;

  /// No description provided for @thresholdsDensityGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'İşletme miktarları kilogram gösteriyorsa litre bu katsayıyla çevrilir (1 L inek sütü ≈ 1,03 kg). Eşikler yine litre girilir.'**
  String get thresholdsDensityGroupHint;

  /// No description provided for @thresholdsDensityGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Süt yoğunluğu'**
  String get thresholdsDensityGroupTitle;

  /// No description provided for @thresholdsDryOff.
  ///
  /// In tr, this message translates to:
  /// **'Kuruya çıkma alt eşiği'**
  String get thresholdsDryOff;

  /// No description provided for @thresholdsEndFlow.
  ///
  /// In tr, this message translates to:
  /// **'Bitiş debisi'**
  String get thresholdsEndFlow;

  /// No description provided for @thresholdsEndGrace.
  ///
  /// In tr, this message translates to:
  /// **'Bekleme'**
  String get thresholdsEndGrace;

  /// No description provided for @thresholdsEndGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'Debi bu değerin altında bu süre kalırsa hayvanın sağımı kapanır (§6.1).'**
  String get thresholdsEndGroupHint;

  /// No description provided for @thresholdsEndGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sağım kapanışı'**
  String get thresholdsEndGroupTitle;

  /// No description provided for @thresholdsErrorAboveDryOff.
  ///
  /// In tr, this message translates to:
  /// **'Kuruya çıkma eşiğinden büyük olmalı'**
  String get thresholdsErrorAboveDryOff;

  /// No description provided for @thresholdsErrorAboveLower.
  ///
  /// In tr, this message translates to:
  /// **'Alt eşikten büyük olmalı'**
  String get thresholdsErrorAboveLower;

  /// No description provided for @thresholdsErrorAboveNoMilk.
  ///
  /// In tr, this message translates to:
  /// **'Boş sağım sınırından büyük olmalı'**
  String get thresholdsErrorAboveNoMilk;

  /// No description provided for @thresholdsErrorAboveRed.
  ///
  /// In tr, this message translates to:
  /// **'Kırmızı eşiğinden büyük olmalı'**
  String get thresholdsErrorAboveRed;

  /// No description provided for @thresholdsErrorBelowExpected.
  ///
  /// In tr, this message translates to:
  /// **'Sağım başına beklenenden küçük olmalı'**
  String get thresholdsErrorBelowExpected;

  /// No description provided for @thresholdsErrorBelowGreen.
  ///
  /// In tr, this message translates to:
  /// **'Yeşil eşiğinden küçük olmalı'**
  String get thresholdsErrorBelowGreen;

  /// No description provided for @thresholdsErrorBelowHighYield.
  ///
  /// In tr, this message translates to:
  /// **'Yüksek verim eşiğinden küçük olmalı'**
  String get thresholdsErrorBelowHighYield;

  /// No description provided for @thresholdsErrorBelowUpper.
  ///
  /// In tr, this message translates to:
  /// **'Üst eşikten küçük olmalı'**
  String get thresholdsErrorBelowUpper;

  /// No description provided for @thresholdsErrorConductivityRange.
  ///
  /// In tr, this message translates to:
  /// **'5–100 arasında olmalı'**
  String get thresholdsErrorConductivityRange;

  /// No description provided for @thresholdsErrorDensityRange.
  ///
  /// In tr, this message translates to:
  /// **'0,90–1,20 arasında olmalı'**
  String get thresholdsErrorDensityRange;

  /// No description provided for @thresholdsErrorInteger.
  ///
  /// In tr, this message translates to:
  /// **'Tam sayı girin'**
  String get thresholdsErrorInteger;

  /// No description provided for @thresholdsErrorMax.
  ///
  /// In tr, this message translates to:
  /// **'En çok {max} olabilir'**
  String thresholdsErrorMax(Object max);

  /// No description provided for @thresholdsErrorNegative.
  ///
  /// In tr, this message translates to:
  /// **'Negatif olamaz'**
  String get thresholdsErrorNegative;

  /// No description provided for @thresholdsErrorNumber.
  ///
  /// In tr, this message translates to:
  /// **'Sayı girin'**
  String get thresholdsErrorNumber;

  /// No description provided for @thresholdsErrorZero.
  ///
  /// In tr, this message translates to:
  /// **'Sıfır olamaz'**
  String get thresholdsErrorZero;

  /// No description provided for @thresholdsExpectedPerMilking.
  ///
  /// In tr, this message translates to:
  /// **'Sağım başına beklenen'**
  String get thresholdsExpectedPerMilking;

  /// No description provided for @thresholdsFalseAlarmGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'Sağımın ilk saniyelerinde kırmızı üretilmez; kırmızı durum bu süre boyunca sürmeden uyarı gönderilmez (§6.2).'**
  String get thresholdsFalseAlarmGroupHint;

  /// No description provided for @thresholdsFalseAlarmGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yanlış alarm koruması'**
  String get thresholdsFalseAlarmGroupTitle;

  /// No description provided for @thresholdsFlowGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'Altında kırmızı, üstünde yeşil; arası sarı (§6.2).'**
  String get thresholdsFlowGroupHint;

  /// No description provided for @thresholdsFlowGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Anlık debi bantları'**
  String get thresholdsFlowGroupTitle;

  /// No description provided for @thresholdsFresh.
  ///
  /// In tr, this message translates to:
  /// **'Taze laktasyon'**
  String get thresholdsFresh;

  /// No description provided for @thresholdsGreenLimit.
  ///
  /// In tr, this message translates to:
  /// **'Yeşil eşiği'**
  String get thresholdsGreenLimit;

  /// No description provided for @thresholdsHighYield.
  ///
  /// In tr, this message translates to:
  /// **'Yüksek verim üst eşiği'**
  String get thresholdsHighYield;

  /// No description provided for @thresholdsLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Eşikler yüklenemedi'**
  String get thresholdsLoadFailed;

  /// No description provided for @thresholdsLowerLimit.
  ///
  /// In tr, this message translates to:
  /// **'Alt eşik'**
  String get thresholdsLowerLimit;

  /// No description provided for @thresholdsMastitisGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'Sayaç iletkenlik ölçüyorsa: sağımın iletkenliği hayvanın kendi 7 günlük ortalamasının bu oran kadar üstündeyse uyarı. Teşhis değildir; veteriner kontrolü için işarettir.'**
  String get thresholdsMastitisGroupHint;

  /// No description provided for @thresholdsMastitisGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Mastitis şüphesi'**
  String get thresholdsMastitisGroupTitle;

  /// No description provided for @thresholdsNoMilk.
  ///
  /// In tr, this message translates to:
  /// **'Boş sağım sınırı'**
  String get thresholdsNoMilk;

  /// No description provided for @thresholdsNoMilkCount.
  ///
  /// In tr, this message translates to:
  /// **'Bakılan son sağım'**
  String get thresholdsNoMilkCount;

  /// No description provided for @thresholdsNoSpecies.
  ///
  /// In tr, this message translates to:
  /// **'Tanımlı tür eşiği yok'**
  String get thresholdsNoSpecies;

  /// No description provided for @thresholdsRampUp.
  ///
  /// In tr, this message translates to:
  /// **'Isınma süresi'**
  String get thresholdsRampUp;

  /// No description provided for @thresholdsReadOnly.
  ///
  /// In tr, this message translates to:
  /// **'Eşikleri yalnızca işletme sahibi değiştirebilir.'**
  String get thresholdsReadOnly;

  /// No description provided for @thresholdsRedLimit.
  ///
  /// In tr, this message translates to:
  /// **'Kırmızı eşiği'**
  String get thresholdsRedLimit;

  /// No description provided for @thresholdsRulesGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'7 günlük ortalama 30 günlükten bu oranda fazla düşükse düşüşte. Son sağımların hepsi boş sağım sınırının altındaysa süt vermiyor. Buzağılamadan sonraki taze laktasyon günlerinde düşüşte ve kuruya aday denmez (§6.4).'**
  String get thresholdsRulesGroupHint;

  /// No description provided for @thresholdsRulesGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Sınıflandırma kuralları'**
  String get thresholdsRulesGroupTitle;

  /// No description provided for @thresholdsSaved.
  ///
  /// In tr, this message translates to:
  /// **'{species} eşikleri kaydedildi'**
  String thresholdsSaved(Object species);

  /// No description provided for @thresholdsSaving.
  ///
  /// In tr, this message translates to:
  /// **'Kaydediliyor…'**
  String get thresholdsSaving;

  /// No description provided for @thresholdsSpeciesLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Türler yüklenemedi'**
  String get thresholdsSpeciesLoadFailed;

  /// No description provided for @thresholdsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Eşik ayarları'**
  String get thresholdsTitle;

  /// No description provided for @thresholdsUnitDays.
  ///
  /// In tr, this message translates to:
  /// **'gün'**
  String get thresholdsUnitDays;

  /// No description provided for @thresholdsUnitFlow.
  ///
  /// In tr, this message translates to:
  /// **'L/dk'**
  String get thresholdsUnitFlow;

  /// No description provided for @thresholdsUnitMilkings.
  ///
  /// In tr, this message translates to:
  /// **'sağım'**
  String get thresholdsUnitMilkings;

  /// No description provided for @thresholdsUnitPerDay.
  ///
  /// In tr, this message translates to:
  /// **'L/gün'**
  String get thresholdsUnitPerDay;

  /// No description provided for @thresholdsUnitSec.
  ///
  /// In tr, this message translates to:
  /// **'sn'**
  String get thresholdsUnitSec;

  /// No description provided for @thresholdsUpperLimit.
  ///
  /// In tr, this message translates to:
  /// **'Üst eşik'**
  String get thresholdsUpperLimit;

  /// No description provided for @thresholdsYieldGroupHint.
  ///
  /// In tr, this message translates to:
  /// **'Alınan sütün beklenene oranı (§6.3). Geçmişi olmayan hayvanda beklenen, sağım başına bu değerdir.'**
  String get thresholdsYieldGroupHint;

  /// No description provided for @thresholdsYieldGroupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oturum verimi bantları'**
  String get thresholdsYieldGroupTitle;

  /// No description provided for @treatmentAdd.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi ekle'**
  String get treatmentAdd;

  /// No description provided for @treatmentDeleteBody.
  ///
  /// In tr, this message translates to:
  /// **'Yalnızca yanlış girilen kaydı silin; silinen kayıt arınmayı da kaldırır.'**
  String get treatmentDeleteBody;

  /// No description provided for @treatmentDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi kaydı silinsin mi?'**
  String get treatmentDeleteTitle;

  /// No description provided for @treatmentDrug.
  ///
  /// In tr, this message translates to:
  /// **'İlaç'**
  String get treatmentDrug;

  /// No description provided for @treatmentDrugRequired.
  ///
  /// In tr, this message translates to:
  /// **'İlaç adını girin.'**
  String get treatmentDrugRequired;

  /// No description provided for @treatmentEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi kaydı yok. Antibiyotik verilen hayvanın arınma süresini girin: süre boyunca canlı ekranda \"Sütü ayır\" uyarısı çıkar.'**
  String get treatmentEmpty;

  /// No description provided for @treatmentLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Tedaviler alınamadı'**
  String get treatmentLoadFailed;

  /// No description provided for @treatmentPlusDays.
  ///
  /// In tr, this message translates to:
  /// **'{n, plural, other{+{n} gün}}'**
  String treatmentPlusDays(int n);

  /// No description provided for @treatmentRange.
  ///
  /// In tr, this message translates to:
  /// **'{start} → arınma {until}'**
  String treatmentRange(Object start, Object until);

  /// No description provided for @treatmentSaveFailed.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi kaydedilemedi: {error}'**
  String treatmentSaveFailed(Object error);

  /// No description provided for @treatmentSaved.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi kaydedildi'**
  String get treatmentSaved;

  /// No description provided for @treatmentStart.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç: {date}'**
  String treatmentStart(Object date);

  /// No description provided for @treatmentStartHelp.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi başlangıcı'**
  String get treatmentStartHelp;

  /// No description provided for @treatmentTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tedavi ve arınma'**
  String get treatmentTitle;

  /// No description provided for @treatmentUntil.
  ///
  /// In tr, this message translates to:
  /// **'Arınma bitişi: {date}'**
  String treatmentUntil(Object date);

  /// No description provided for @treatmentUntilHelp.
  ///
  /// In tr, this message translates to:
  /// **'Sütün ayrılacağı son gün'**
  String get treatmentUntilHelp;

  /// No description provided for @treatmentWithdrawalBanner.
  ///
  /// In tr, this message translates to:
  /// **'Arınmada: sütü {date} dahil tanka katmayın.'**
  String treatmentWithdrawalBanner(Object date);

  /// No description provided for @unmatchedAssign.
  ///
  /// In tr, this message translates to:
  /// **'Hayvana ata'**
  String get unmatchedAssign;

  /// No description provided for @unmatchedAssigned.
  ///
  /// In tr, this message translates to:
  /// **'Küpe {earTag} kaydına eklendi'**
  String unmatchedAssigned(Object earTag);

  /// No description provided for @unmatchedChooseAnimal.
  ///
  /// In tr, this message translates to:
  /// **'{rfid} · hayvan seç'**
  String unmatchedChooseAnimal(Object rfid);

  /// No description provided for @unmatchedEmpty.
  ///
  /// In tr, this message translates to:
  /// **'Tanınmayan küpe yok'**
  String get unmatchedEmpty;

  /// No description provided for @unmatchedIgnore.
  ///
  /// In tr, this message translates to:
  /// **'Yok say'**
  String get unmatchedIgnore;

  /// No description provided for @unmatchedIgnoreBody.
  ///
  /// In tr, this message translates to:
  /// **'{rfid} listeden kalkar ve yeniden okunsa da dönmez. Başka çiftliğin hayvanı ya da bozuk okuma için.'**
  String unmatchedIgnoreBody(Object rfid);

  /// No description provided for @unmatchedIgnoreFailed.
  ///
  /// In tr, this message translates to:
  /// **'Yok sayılamadı: {error}'**
  String unmatchedIgnoreFailed(Object error);

  /// No description provided for @unmatchedIgnoreTitle.
  ///
  /// In tr, this message translates to:
  /// **'Küpe yok sayılsın mı?'**
  String get unmatchedIgnoreTitle;

  /// No description provided for @unmatchedIntro.
  ///
  /// In tr, this message translates to:
  /// **'Sağımda okunan ama hiçbir hayvana kayıtlı olmayan küpeler. Küpeyi hayvanına atayın; bir dahaki sağımda hayvan noktaya kendiliğinden eşleşir. Başka çiftliğin hayvanı ya da bozuk okumaysa yok sayın.'**
  String get unmatchedIntro;

  /// No description provided for @unmatchedLastSeenAt.
  ///
  /// In tr, this message translates to:
  /// **'Son: {spout}'**
  String unmatchedLastSeenAt(Object spout);

  /// No description provided for @unmatchedLoadFailed.
  ///
  /// In tr, this message translates to:
  /// **'Küpeler yüklenemedi'**
  String get unmatchedLoadFailed;

  /// No description provided for @unmatchedNoTag.
  ///
  /// In tr, this message translates to:
  /// **'küpesi yok'**
  String get unmatchedNoTag;

  /// No description provided for @unmatchedReadCount.
  ///
  /// In tr, this message translates to:
  /// **'{n, plural, other{{n} okuma}}'**
  String unmatchedReadCount(int n);

  /// No description provided for @unmatchedReplace.
  ///
  /// In tr, this message translates to:
  /// **'Değiştir'**
  String get unmatchedReplace;

  /// No description provided for @unmatchedReplaceBody.
  ///
  /// In tr, this message translates to:
  /// **'{animal} kaydındaki küpe {old}. Yerine {rfid} yazılacak; eski küpe artık tanınmaz.'**
  String unmatchedReplaceBody(Object animal, Object old, Object rfid);

  /// No description provided for @unmatchedReplaceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Küpe değiştirilsin mi?'**
  String get unmatchedReplaceTitle;

  /// No description provided for @unmatchedSearchHint.
  ///
  /// In tr, this message translates to:
  /// **'Küpe numarası veya ad'**
  String get unmatchedSearchHint;

  /// No description provided for @unmatchedTagValue.
  ///
  /// In tr, this message translates to:
  /// **'küpe {rfid}'**
  String unmatchedTagValue(Object rfid);

  /// No description provided for @unmatchedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tanınmayan küpeler'**
  String get unmatchedTitle;

  /// No description provided for @unmatchedUnknownSpout.
  ///
  /// In tr, this message translates to:
  /// **'bilinmeyen nokta'**
  String get unmatchedUnknownSpout;

  /// No description provided for @upcomingMore.
  ///
  /// In tr, this message translates to:
  /// **'ve {n} hayvan daha'**
  String upcomingMore(int n);

  /// No description provided for @upcomingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yaklaşanlar'**
  String get upcomingTitle;

  /// No description provided for @updateBodyAndroid.
  ///
  /// In tr, this message translates to:
  /// **'Milk Trace\'in bu sürümü artık desteklenmiyor. Sağım kayıtlarının doğru tutulması için uygulamayı Google Play\'den güncelleyin.'**
  String get updateBodyAndroid;

  /// No description provided for @updateBodyIos.
  ///
  /// In tr, this message translates to:
  /// **'Milk Trace\'in bu sürümü artık desteklenmiyor. Sağım kayıtlarının doğru tutulması için uygulamayı App Store\'dan güncelleyin.'**
  String get updateBodyIos;

  /// No description provided for @updatePlayButton.
  ///
  /// In tr, this message translates to:
  /// **'Google Play\'de güncelle'**
  String get updatePlayButton;

  /// No description provided for @updateTitle.
  ///
  /// In tr, this message translates to:
  /// **'Güncelleme gerekli'**
  String get updateTitle;

  /// No description provided for @widgetAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesap'**
  String get widgetAccount;

  /// No description provided for @widgetAlerts.
  ///
  /// In tr, this message translates to:
  /// **'Uyarılar'**
  String get widgetAlerts;

  /// No description provided for @widgetOfflineBanner.
  ///
  /// In tr, this message translates to:
  /// **'Çevrimdışı · son veri {when}. Değişiklikler bağlantı gelince yapılabilir.'**
  String widgetOfflineBanner(Object when);

  /// No description provided for @yieldChartAvg7.
  ///
  /// In tr, this message translates to:
  /// **'7 gün ort.'**
  String get yieldChartAvg7;

  /// No description provided for @yieldChartDaily.
  ///
  /// In tr, this message translates to:
  /// **'Günlük'**
  String get yieldChartDaily;

  /// No description provided for @yieldChartNotEnough.
  ///
  /// In tr, this message translates to:
  /// **'Grafik için yeterli geçmiş yok'**
  String get yieldChartNotEnough;

  /// No description provided for @yieldReportDescription.
  ///
  /// In tr, this message translates to:
  /// **'Hayvan başına günlük verim ({unit}), Excel dosyası. Veterinere ya da danışmana gönderebilirsiniz.'**
  String yieldReportDescription(Object unit);

  /// No description provided for @yieldReportFailed.
  ///
  /// In tr, this message translates to:
  /// **'Rapor alınamadı: {error}'**
  String yieldReportFailed(Object error);

  /// No description provided for @yieldReportKilogram.
  ///
  /// In tr, this message translates to:
  /// **'kilogram'**
  String get yieldReportKilogram;

  /// No description provided for @yieldReportLastDays.
  ///
  /// In tr, this message translates to:
  /// **'Son {n} gün'**
  String yieldReportLastDays(Object n);

  /// No description provided for @yieldReportLitre.
  ///
  /// In tr, this message translates to:
  /// **'litre'**
  String get yieldReportLitre;

  /// No description provided for @yieldReportShareSubject.
  ///
  /// In tr, this message translates to:
  /// **'Milk Trace verim raporu'**
  String get yieldReportShareSubject;

  /// No description provided for @yieldReportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Verim raporu'**
  String get yieldReportTitle;
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
