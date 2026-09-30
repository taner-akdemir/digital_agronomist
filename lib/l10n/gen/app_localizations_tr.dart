// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get accountApiKeys => 'API anahtarları';

  @override
  String get accountAuditLog => 'İşlem kaydı';

  @override
  String get accountDefaultName => 'Kullanıcı';

  @override
  String get accountFarmLocation => 'Tesis konumu';

  @override
  String get accountMilkUnit => 'Süt birimi';

  @override
  String get accountMilkers => 'Sağımcılar';

  @override
  String get accountMilkingSchedule => 'Sağım saatleri';

  @override
  String get accountMockMode => 'Demo verisiyle çalışıyorsunuz (mock mod).';

  @override
  String get accountNotificationChannels => 'Bildirim kanalları';

  @override
  String get accountPickFarm => 'İşletme seçin';

  @override
  String get accountPushUnavailable =>
      'Bu telefonda bildirim kapalı: izin verilmedi ya da bildirim servisi henüz bağlanmadı. Uyarılar bildirim merkezinde görünmeye devam eder.';

  @override
  String get accountQuietHours => 'Sessiz saat';

  @override
  String get accountSessions => 'Oturumlar';

  @override
  String get accountSignOut => 'Çıkış yap';

  @override
  String get accountSwitchFarm => 'İşletme değiştir';

  @override
  String accountSwitchFarmFailed(Object error) {
    return 'İşletme değiştirilemedi: $error';
  }

  @override
  String get accountTestPush => 'Bu telefona test bildirimi';

  @override
  String accountTestPushFailed(Object error) {
    return 'Test bildirimi gönderilemedi: $error';
  }

  @override
  String get accountTestPushNone => 'Test bildirimi hiçbir telefona ulaşmadı';

  @override
  String get accountTestPushSending => 'Gönderiliyor…';

  @override
  String accountTestPushSent(Object count) {
    return 'Test bildirimi gönderildi ($count telefon)';
  }

  @override
  String get accountThresholds => 'Eşik ayarları';

  @override
  String get accountTwoFactor => 'İki adımlı doğrulama';

  @override
  String get accountTwoFactorOn => 'İki adımlı doğrulama açık';

  @override
  String get accountUnitKilogram => 'Kilogram';

  @override
  String get accountUnitLitre => 'Litre';

  @override
  String get accountUsers => 'Kullanıcılar';

  @override
  String get alertsAcknowledged => 'okundu';

  @override
  String alertsBackOnlineAt(Object time) {
    return 'geri geldi $time';
  }

  @override
  String get alertsEmpty => 'Açık uyarı yok';

  @override
  String get alertsLoadFailed => 'Uyarılar yüklenemedi';

  @override
  String get alertsMarkRead => 'Okundu';

  @override
  String alertsRecoveredAt(Object time) {
    return 'düzeldi $time';
  }

  @override
  String get alertsTitle => 'Uyarılar';

  @override
  String get animalDetailAddNote => 'Not ekle';

  @override
  String get animalDetailAvg30 => '30 gün ort.';

  @override
  String get animalDetailAvg7 => '7 gün ort.';

  @override
  String get animalDetailBreed => 'Irk';

  @override
  String get animalDetailCalved => 'Buzağıladı';

  @override
  String get animalDetailCalvingAlreadyToday =>
      'Bugün için buzağılama zaten kayıtlı';

  @override
  String get animalDetailCalvingConfirmTitle => 'Buzağılama kaydedilsin mi?';

  @override
  String get animalDetailCalvingDate => 'Buzağılama tarihi';

  @override
  String animalDetailCalvingLactation(Object current, Object next) {
    return 'Laktasyon $current → $next';
  }

  @override
  String get animalDetailCalvingSaved => 'Buzağılama kaydedildi';

  @override
  String animalDetailCalvingStatus(Object status) {
    return 'Durum $status → Sağmal';
  }

  @override
  String get animalDetailDaysInMilk => 'Laktasyon günü';

  @override
  String get animalDetailDisclaimer =>
      'Bu bir öneridir, teşhis değildir. Gebelik, laktasyon dönemi ve hastalık verimi düşürebilir; veteriner kontrolü gerekir.';

  @override
  String animalDetailFreshLactation(Object days) {
    return 'Taze laktasyon: ilk $days günde \"düşüşte\" ve \"kuruya çıkarma adayı\" etiketi verilmez; verim henüz yükseliyor.';
  }

  @override
  String get animalDetailFrozenClassNote =>
      'Sağmal olmayan hayvan sınıflandırılmaz; bu etiket sağmalken yapılan son hesaptan kalmadır.';

  @override
  String get animalDetailGroup => 'Grup';

  @override
  String get animalDetailHistoryFailed => 'Sağım geçmişi alınamadı';

  @override
  String get animalDetailLactation => 'Laktasyon';

  @override
  String get animalDetailLastCalving => 'Son buzağılama';

  @override
  String animalDetailLastClass(Object label) {
    return 'Son sınıf: $label';
  }

  @override
  String get animalDetailLoadFailed => 'Hayvan bilgisi yüklenemedi';

  @override
  String animalDetailMoreNotes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n not daha',
    );
    return '$_temp0';
  }

  @override
  String get animalDetailNoMilkings => 'Bu hayvana ait sağım kaydı yok';

  @override
  String get animalDetailNoNotes =>
      'Henüz not yok. Veteriner kontrolü, gebelik ya da tedavi bilgisi sınıf etiketini yorumlamaya yardım eder.';

  @override
  String get animalDetailNotRegistered => 'Bu hayvan kayıtlı değil';

  @override
  String animalDetailNoteAddFailed(Object error) {
    return 'Not eklenemedi: $error';
  }

  @override
  String get animalDetailNoteAdded => 'Not eklendi';

  @override
  String get animalDetailNoteHint =>
      'Örn. Son veteriner kontrolü: mastitis, tedavide.';

  @override
  String get animalDetailNotes => 'Notlar';

  @override
  String get animalDetailNotesFailed => 'Notlar alınamadı';

  @override
  String animalDetailOrdinal(Object n) {
    return '$n.';
  }

  @override
  String get animalDetailRecentMilkings => 'Son sağımlar';

  @override
  String animalDetailShownOfTotal(Object total, Object limit) {
    return '$total sağımın ilk $limit tanesi gösteriliyor';
  }

  @override
  String animalDetailStaleClass(Object date) {
    return 'Sınıf $date hesabından: gece hesabı yalnızca son 30 günde sağılan hayvanı yeniler.';
  }

  @override
  String get animalDetailTitleFallback => 'Hayvan';

  @override
  String get animalDetailTrend30 => '30 günlük eğilim';

  @override
  String get animalDetailTrendFailed => 'Trend alınamadı';

  @override
  String get animalDetailYieldTrend => 'Verim trendi';

  @override
  String get animalFormAdded => 'Hayvan eklendi';

  @override
  String get animalFormAnimalFailed => 'Hayvan yüklenemedi';

  @override
  String get animalFormBirthDate => 'Doğum tarihi';

  @override
  String get animalFormBreed => 'Irk (isteğe bağlı)';

  @override
  String animalFormClearDate(Object label) {
    return '$label temizle';
  }

  @override
  String get animalFormEarTag => 'Küpe numarası';

  @override
  String get animalFormEarTagHelper =>
      'Hayvanı tanımlayan alan; işletmede tekil.';

  @override
  String get animalFormEarTagRequired => 'Küpe numarası zorunlu';

  @override
  String get animalFormEditTitle => 'Hayvanı düzenle';

  @override
  String get animalFormGroup => 'Grup';

  @override
  String get animalFormLactationNo => 'Laktasyon sırası';

  @override
  String get animalFormLastCalving => 'Son buzağılama';

  @override
  String get animalFormName => 'Ad (isteğe bağlı)';

  @override
  String get animalFormNewTitle => 'Yeni hayvan';

  @override
  String get animalFormNoGroup => 'Grupsuz';

  @override
  String get animalFormNotEntered => 'Girilmedi';

  @override
  String get animalFormNotFound => 'Hayvan bulunamadı';

  @override
  String animalFormPickDate(Object label) {
    return '$label seç';
  }

  @override
  String get animalFormRfid => 'RFID (isteğe bağlı)';

  @override
  String get animalFormRfidHelper =>
      'Küpedeki çipin numarası; sayaç okursa hayvan noktaya kendiliğinden eşleşir.';

  @override
  String get animalFormSaving => 'Kaydediliyor…';

  @override
  String get animalFormSpecies => 'Tür';

  @override
  String get animalFormSpeciesFailed => 'Türler yüklenemedi';

  @override
  String get animalFormSpeciesRequired => 'Tür seçin';

  @override
  String get animalFormStatus => 'Durum';

  @override
  String get animalFormStatusHelper =>
      'Yalnızca sağmal hayvan sağıma eşleştirilir ve sınıflandırılır.';

  @override
  String get animalFormUpdated => 'Hayvan güncellendi';

  @override
  String animalImportAddN(Object n) {
    return '$n hayvanı ekle';
  }

  @override
  String animalImportAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n hayvan eklendi',
    );
    return '$_temp0';
  }

  @override
  String animalImportChange(Object field, Object from, Object to) {
    return '$field: $from → $to';
  }

  @override
  String get animalImportColumns =>
      'Sütunlar: Küpe No (zorunlu) · Tür · Adı · Irkı · RFID · Doğum Tarihi · Son Buzağılama · Laktasyon · Durumu · Grup · Anne Küpe · Baba';

  @override
  String animalImportCountCreate(Object n) {
    return '$n eklenecek';
  }

  @override
  String animalImportCountErrors(Object n) {
    return '$n hatalı, atlanacak';
  }

  @override
  String animalImportCountExists(Object n) {
    return '$n zaten kayıtlı';
  }

  @override
  String animalImportCountUnchanged(Object n) {
    return '$n değişmeyecek';
  }

  @override
  String animalImportCountUpdate(Object n) {
    return '$n güncellenecek';
  }

  @override
  String get animalImportDefaultSpecies => 'Türü yazılmamış satırlar';

  @override
  String animalImportFailed(Object error) {
    return 'İçe aktarılamadı: $error';
  }

  @override
  String get animalImportFieldBirthDate => 'Doğum tarihi';

  @override
  String get animalImportFieldBreed => 'Irk';

  @override
  String get animalImportFieldCalvingDate => 'Son buzağılama';

  @override
  String get animalImportFieldGroup => 'Grup';

  @override
  String get animalImportFieldLactationNo => 'Laktasyon';

  @override
  String get animalImportFieldName => 'Ad';

  @override
  String get animalImportFieldRfid => 'RFID';

  @override
  String get animalImportFieldStatus => 'Durum';

  @override
  String animalImportIgnoredColumns(Object columns) {
    return 'Alınmayan sütunlar: $columns';
  }

  @override
  String get animalImportIntro =>
      'Veterinerden, Birlik\'ten ya da Hayvan Bilgi Sistemi\'nden aldığınız listeyi yükleyin (Excel .xlsx ya da CSV). İlk satır sütun başlıkları olmalı; tarihler gün önde (03.04.2021).';

  @override
  String animalImportNewGroups(Object groups) {
    return 'Oluşturulacak gruplar: $groups';
  }

  @override
  String get animalImportNothingToAdd => 'Eklenecek hayvan yok';

  @override
  String get animalImportNothingToSave =>
      'Eklenecek ya da güncellenecek hayvan yok';

  @override
  String get animalImportPickFile => 'Dosya seç';

  @override
  String get animalImportPickOtherFile => 'Başka dosya seç';

  @override
  String animalImportReadFailed(Object error) {
    return 'Dosya okunamadı: $error';
  }

  @override
  String get animalImportRules =>
      'Küpesi zaten kayıtlı hayvanlar, güncelleme açılmadıkça değiştirilmez. Hatalı satırlar atlanır; dosyayı düzeltip yeniden yüklemek güvenlidir.';

  @override
  String animalImportSaveN(Object added, Object updated) {
    return '$added ekle · $updated güncelle';
  }

  @override
  String animalImportSaved(Object added, Object updated) {
    return '$added hayvan eklendi, $updated güncellendi';
  }

  @override
  String get animalImportSectionCreate => 'Eklenecek';

  @override
  String get animalImportSectionErrors => 'Hatalı satırlar';

  @override
  String get animalImportSectionExists => 'Zaten kayıtlı (değiştirilmez)';

  @override
  String get animalImportSectionUnchanged => 'Değişmeyecek';

  @override
  String get animalImportSectionUpdate => 'Güncellenecek';

  @override
  String get animalImportSectionWarnings => 'Uyarılar';

  @override
  String get animalImportSpeciesLoadFailed => 'Türler yüklenemedi';

  @override
  String get animalImportTitle => 'Listeden içe aktar';

  @override
  String get animalImportUpdateHint =>
      'Yalnızca dosyadaki dolu hücreler yazılır; boş hücre kayıtlı bilgiyi silmez. Tür değişmez.';

  @override
  String get animalImportUpdateSwitch => 'Kayıtlı hayvanları güncelle';

  @override
  String get apiKeysCopied => 'Anahtar kopyalandı';

  @override
  String get apiKeysCopy => 'Kopyala';

  @override
  String get apiKeysCreate => 'Anahtar oluştur';

  @override
  String apiKeysCreatedBy(Object who, Object date) {
    return '$who · $date';
  }

  @override
  String get apiKeysCreatedTitle => 'Anahtar oluşturuldu';

  @override
  String get apiKeysDone => 'Kaydettim';

  @override
  String get apiKeysEmpty => 'Henüz anahtar yok.';

  @override
  String get apiKeysIntro =>
      'Yem programı, muhasebe ya da kooperatif sistemi verinizi otomatik alabilsin diye. Anahtar SALT OKUNUR: hayvan listesi, tank teslimleri ve günlük verim okunur; notlar, tedaviler ve her türlü yazma kapalıdır.';

  @override
  String apiKeysLastUsed(Object when) {
    return 'Son kullanım $when';
  }

  @override
  String get apiKeysNameHelper => 'Hangi sistem kullanacak? Ör. Yem programı';

  @override
  String get apiKeysNameLabel => 'Anahtar adı';

  @override
  String get apiKeysNeverUsed => 'Hiç kullanılmadı';

  @override
  String get apiKeysRevoke => 'İptal et';

  @override
  String apiKeysRevokeBody(Object name) {
    return '\"$name\" anahtarıyla bağlanan sistem en geç 1 dakika içinde erişimini kaybeder. Geri alınamaz.';
  }

  @override
  String get apiKeysRevokeTitle => 'Anahtar iptal edilsin mi?';

  @override
  String get apiKeysRevoked => 'Anahtar iptal edildi';

  @override
  String get apiKeysShownOnce =>
      'Bu anahtar bir daha gösterilmez. Şimdi kopyalayıp bağlanacak sisteme girin; kaybederseniz iptal edip yenisini oluşturun.';

  @override
  String get apiKeysTitle => 'API anahtarları';

  @override
  String get apiKeysUsage =>
      'Günlük verim:\nGET /api/v1/exports/daily?from=YYYY-MM-DD&to=YYYY-MM-DD\nBaşlık: Authorization: Bearer <anahtar>';

  @override
  String get auditAnimalCalving => 'Buzağılama kaydedildi';

  @override
  String get auditAnimalCreate => 'Hayvan eklendi';

  @override
  String get auditAnimalImport => 'Listeden içe aktarma';

  @override
  String get auditAnimalUpdate => 'Hayvan kaydı değişti';

  @override
  String get auditApiKeyCreate => 'API anahtarı oluşturuldu';

  @override
  String get auditApiKeyRevoke => 'API anahtarı iptal edildi';

  @override
  String get auditBreedingAdd => 'Üreme kaydı eklendi';

  @override
  String get auditBreedingDelete => 'Üreme kaydı silindi';

  @override
  String get auditChannelCreate => 'Bildirim kanalı eklendi';

  @override
  String get auditChannelDelete => 'Bildirim kanalı silindi';

  @override
  String get auditChannelUpdate => 'Bildirim kanalı değişti';

  @override
  String get auditDeletedUser => 'Silinmiş kullanıcı';

  @override
  String get auditDeliveryAdd => 'Tank teslimi girildi';

  @override
  String get auditDeliveryDelete => 'Tank teslimi silindi';

  @override
  String get auditEmpty => 'Son 90 günde kayıtlı değişiklik yok.';

  @override
  String get auditIntro =>
      'Son 90 gün: eşik, hayvan kaydı, eşleştirme, kullanıcı ve bildirim kanalı değişiklikleri.';

  @override
  String get auditLoadFailed => 'İşlem kaydı yüklenemedi';

  @override
  String get auditMeterCheck => 'Sayaç kontrolü';

  @override
  String get auditSettingsUpdate => 'İşletme ayarı değişti';

  @override
  String get auditSpoutUnassign => 'Eşleştirme kaldırıldı';

  @override
  String get auditTagDismiss => 'Tanınmayan küpe yok sayıldı';

  @override
  String get auditTeamAdd => 'Kullanıcı eklendi';

  @override
  String get auditTeamRemove => 'Kullanıcı çıkarıldı';

  @override
  String get auditTeamUpdate => 'Kullanıcı değişti';

  @override
  String get auditThresholdsUpdate => 'Eşikler değişti';

  @override
  String get auditTitle => 'İşlem kaydı';

  @override
  String get auditTreatmentAdd => 'Tedavi eklendi';

  @override
  String get auditTreatmentDelete => 'Tedavi silindi';

  @override
  String get auditVaccinationAdd => 'Aşı uygulandı';

  @override
  String get auditVaccinationDelete => 'Aşı kaydı silindi';

  @override
  String get auditVaccinePlanCreate => 'Aşı planı eklendi';

  @override
  String get auditVaccinePlanDelete => 'Aşı planı silindi';

  @override
  String get auditVaccinePlanUpdate => 'Aşı planı değişti';

  @override
  String get breedingAddRecord => 'Kayıt ekle';

  @override
  String get breedingAdded => 'Üreme kaydı eklendi';

  @override
  String get breedingDeleteBody =>
      'Yalnızca yanlış girilen kaydı silin; durum ve tarihler yeniden hesaplanır.';

  @override
  String get breedingDeleteTitle => 'Üreme kaydı silinsin mi?';

  @override
  String get breedingDialogTitle => 'Üreme kaydı';

  @override
  String breedingDryOff(Object date) {
    return 'Önerilen kuruya çıkarma: $date';
  }

  @override
  String get breedingEmpty =>
      'Kayıt yok. Tohumlama ve gebelik kontrolünü girin: beklenen doğum ve kuruya çıkarma tarihi hesaplanır.';

  @override
  String breedingExpectedCalving(Object date) {
    return 'Beklenen doğum: $date';
  }

  @override
  String get breedingHeat => 'Kızgınlık';

  @override
  String breedingHeatExpected(Object from, Object to) {
    return 'Kızgınlık bekleniyor: $from – $to';
  }

  @override
  String get breedingHeatExpectedShort => 'Kızgınlık bekleniyor';

  @override
  String get breedingHeatHint =>
      'Kızgınlık görüldü. Tohumlanmazsa bir sonraki 18–24. gün beklenir; o zaman hatırlatılır.';

  @override
  String get breedingInsemination => 'Tohumlama';

  @override
  String breedingKpiDays(Object days) {
    return '$days gün';
  }

  @override
  String get breedingKpiDaysOpen => 'Buzağılamadan gebeliğe';

  @override
  String get breedingKpiFirstService => 'İlk tohumlamada gebelik';

  @override
  String get breedingKpiInterval => 'Buzağılama aralığı';

  @override
  String get breedingKpiNone => '—';

  @override
  String breedingKpiPct(Object pct) {
    return '%$pct';
  }

  @override
  String breedingKpiSample(int count) {
    return '$count kayıt';
  }

  @override
  String get breedingKpiTitle => 'Üreme · son 12 ay';

  @override
  String get breedingLoadFailed => 'Üreme kayıtları alınamadı';

  @override
  String get breedingOpen => 'Boş';

  @override
  String get breedingPregnancyCheck => 'Gebelik kontrolü';

  @override
  String get breedingPregnant => 'Gebe';

  @override
  String get breedingSireLabel => 'Boğa/teke ya da sperma kodu (isteğe bağlı)';

  @override
  String get breedingTitle => 'Üreme';

  @override
  String get channelsAdd => 'Kanal ekle';

  @override
  String get channelsAdded => 'Kanal eklendi';

  @override
  String channelsCardDailyLimit(Object n) {
    return 'günde en çok $n';
  }

  @override
  String channelsCardStatus(Object severity, Object sources) {
    return '$severity ve üstü · $sources';
  }

  @override
  String get channelsChannelLoadFailed => 'Kanal yüklenemedi';

  @override
  String get channelsConnectionSection => 'Bağlantı ayarları';

  @override
  String get channelsDailyLimit => 'Günlük sınır';

  @override
  String channelsDailyLimitHelperDefault(Object n) {
    return 'Boş bırakılırsa $n. Sınırdan sonrakiler gönderilmez; sayaç gece yarısı sıfırlanır.';
  }

  @override
  String get channelsDailyLimitHelperUnlimited =>
      'Boş bırakılırsa sınırsız. Sınırdan sonrakiler gönderilmez; sayaç gece yarısı sıfırlanır.';

  @override
  String get channelsDailyLimitRange => '1 ile 10000 arasında olmalı';

  @override
  String get channelsDelete => 'Kanalı sil';

  @override
  String channelsDeleteBody(Object name) {
    return '\"$name\" kanalına artık bildirim gitmeyecek. Bu işlem geri alınamaz.';
  }

  @override
  String get channelsDeleteFailed => 'Silinemedi';

  @override
  String get channelsDeleteTitle => 'Kanal silinsin mi?';

  @override
  String get channelsDeleted => 'Kanal silindi';

  @override
  String get channelsEditTitle => 'Kanalı düzenle';

  @override
  String get channelsEmailAddresses => 'E-posta adresleri';

  @override
  String get channelsEmailHelper => 'Her satıra bir adres';

  @override
  String get channelsEmptyBody =>
      'E-posta ya da SMS ile de uyarı almak için kanal ekleyin.';

  @override
  String get channelsEmptyTitle => 'Henüz kanal yok';

  @override
  String get channelsEnabled => 'Kanal açık';

  @override
  String get channelsEscalation => 'Eskalasyon (dk)';

  @override
  String get channelsEscalationHelper =>
      'Kritik uyarı (ör. sayaç çevrimdışı) bu kadar dakika okunmazsa bu kanala da gider. 0: kapalı.';

  @override
  String get channelsEscalationRange => '0 ile 240 arasında olmalı';

  @override
  String get channelsFieldApiKey => 'API anahtarı';

  @override
  String get channelsFieldApiSecret => 'API sırrı';

  @override
  String get channelsFieldApplicationId => 'Uygulama kimliği';

  @override
  String get channelsFieldBearerToken => 'Bearer jetonu';

  @override
  String get channelsFieldFrom => 'Gönderen';

  @override
  String get channelsFieldFromName => 'Gönderen adı';

  @override
  String get channelsFieldHost => 'SMTP sunucusu';

  @override
  String get channelsFieldLanguage => 'Dil';

  @override
  String get channelsFieldPassword => 'Parola';

  @override
  String get channelsFieldPrivateKey => 'Özel anahtar (PEM)';

  @override
  String get channelsFieldRegion => 'Bölge';

  @override
  String channelsFieldRequired(Object field) {
    return '$field gerekli';
  }

  @override
  String get channelsFieldSecret => 'İmza sırrı';

  @override
  String get channelsFieldSmsHeader => 'SMS başlığı';

  @override
  String get channelsFieldTls => 'Şifreleme (starttls, tls)';

  @override
  String get channelsFieldUrl => 'Adres (https)';

  @override
  String get channelsFieldUserCode => 'Kullanıcı kodu';

  @override
  String get channelsFieldUsername => 'Kullanıcı adı';

  @override
  String get channelsFieldVoice => 'Ses';

  @override
  String get channelsFieldWebhookUrl => 'Webhook adresi';

  @override
  String get channelsHintFrom => 'ornek@alanadi.com.tr';

  @override
  String get channelsHintRegion => 'Boş bırakılabilir (eu: AB veri yerleşimi)';

  @override
  String get channelsHintSecret => 'Verilirse istek HMAC ile imzalanır';

  @override
  String get channelsHintSmsHeader =>
      'Sağlayıcıda onaylı gönderici adı (en çok 11 karakter)';

  @override
  String get channelsHintTls => 'Boş bırakılırsa starttls';

  @override
  String get channelsHintUrl => 'Bildirim JSON olarak bu adrese POST edilir';

  @override
  String get channelsHintWebhookUrl =>
      'Slack / Teams\'in verdiği gelen webhook adresi';

  @override
  String channelsInvalidEmail(Object value) {
    return 'Geçersiz e-posta: $value';
  }

  @override
  String channelsInvalidPhone(Object value) {
    return 'Uluslararası biçimde olmalı (+905…): $value';
  }

  @override
  String get channelsKindEmail => 'E-posta';

  @override
  String get channelsKindPickerTitle => 'Kanal türü';

  @override
  String get channelsKindVoiceCall => 'Sesli arama';

  @override
  String get channelsKindsLoadFailed => 'Kanal türleri yüklenemedi';

  @override
  String get channelsLanguage => 'Bildirim dili';

  @override
  String get channelsLanguageHelper =>
      'Bu kanala giden uyarı, özet ve haftalık e-posta bu dilde.';

  @override
  String get channelsLoadFailed => 'Kanallar yüklenemedi';

  @override
  String get channelsMinSeverity => 'En düşük önem';

  @override
  String get channelsName => 'Kanal adı';

  @override
  String get channelsNameRequired => 'Kanal adı gerekli';

  @override
  String get channelsNewTitle => 'Yeni kanal';

  @override
  String get channelsNotFound => 'Kanal bulunamadı';

  @override
  String get channelsOff => 'Kapalı';

  @override
  String get channelsPhoneHelper =>
      'Her satıra bir numara, ülke koduyla: +905xxxxxxxxx';

  @override
  String get channelsPhoneNumbers => 'Telefon numaraları';

  @override
  String get channelsPushNote =>
      'Uyarılar telefon bildirimi olarak her zaman gelir. Buradaki kanallar ek olarak e-posta, Slack, SMS gibi yollarla da gönderir.';

  @override
  String get channelsRecipientMax => 'En fazla 50 alıcı';

  @override
  String get channelsRecipientRequired => 'En az bir alıcı gerekli';

  @override
  String get channelsSaveFailed => 'Kaydedilemedi';

  @override
  String get channelsSaved => 'Kanal kaydedildi';

  @override
  String get channelsSaving => 'Kaydediliyor…';

  @override
  String get channelsSecretSaved =>
      'Kayıtlı. Değiştirmek için yeni değeri yazın; boş bırakılırsa korunur.';

  @override
  String get channelsSendFailed => 'Gönderilemedi';

  @override
  String get channelsSendResolved => 'Çözüldüğünde de bildir';

  @override
  String get channelsSendTest => 'Deneme bildirimi gönder';

  @override
  String get channelsSeverityCritical => 'Kritik';

  @override
  String get channelsSeverityInfo => 'Bilgi';

  @override
  String get channelsSeverityWarning => 'Uyarı';

  @override
  String get channelsSourceHerd => 'Her sürü uyarısı';

  @override
  String get channelsSourceHerdHint =>
      'Düşük debi olan her hayvan için ayrı mesaj (kalabalık olabilir)';

  @override
  String get channelsSourceOps => 'Sistem alarmları';

  @override
  String get channelsSourceOpsHint =>
      'Sayaç kutusu sustu, veri kaybı gibi sistem sorunları';

  @override
  String get channelsSourceRequired => 'En az bir bildirim türü seçin';

  @override
  String get channelsSourceSummary => 'Sağım özeti';

  @override
  String get channelsSourceSummaryHint =>
      'Sağım bitince tek mesaj (toplam süt, düşük verim ve düşük debi olan hayvanlar)';

  @override
  String get channelsSourceWeekly => 'Haftalık özet';

  @override
  String get channelsSourceWeeklyHint =>
      'Pazartesi sabahı haftanın özeti: toplam süt, önceki haftaya göre değişim, düşüşteki hayvanlar (e-postada Excel raporu ekli)';

  @override
  String get channelsTestSent => 'Deneme bildirimi gönderildi';

  @override
  String get channelsTitle => 'Bildirim kanalları';

  @override
  String channelsUnsupported(Object kind, Object provider) {
    return 'Bu kanal türü desteklenmiyor: $kind/$provider';
  }

  @override
  String get channelsWhenSection => 'Ne zaman gönderilsin';

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
  String get coreErrorBadCertificate => 'Sunucu sertifikası doğrulanamadı.';

  @override
  String get coreErrorBadResponse => 'Sunucu beklenmeyen bir yanıt verdi.';

  @override
  String get coreErrorCancelled => 'İstek iptal edildi.';

  @override
  String get coreErrorConnection =>
      'Sunucuya ulaşılamıyor. Bağlantınızı kontrol edin.';

  @override
  String get coreErrorTimeout =>
      'Sunucu yanıt vermiyor. Bağlantınızı kontrol edin.';

  @override
  String get coreErrorTransform => 'Sunucunun yanıtı işlenemedi.';

  @override
  String get coreErrorUnknown => 'Beklenmeyen bir hata oluştu.';

  @override
  String get coreMemberAddedFallback => 'Kullanıcı eklendi.';

  @override
  String get coreResetLinkSentFallback => 'Sıfırlama bağlantısı gönderildi.';

  @override
  String get coreRouteNotFound => 'Sayfa bulunamadı';

  @override
  String coreRouteNotFoundBody(Object uri) {
    return 'Aradığınız sayfa bulunamadı:\n$uri';
  }

  @override
  String dashboardActiveSessions(int n) {
    return '$n sağım sürüyor';
  }

  @override
  String get dashboardBySpecies => 'Tür bazında';

  @override
  String dashboardGroupMilked(Object milked, Object animals) {
    return '$milked/$animals hayvan sağıldı';
  }

  @override
  String get dashboardGroupsToday => 'Gruplar · bugün';

  @override
  String get dashboardLoadFailed => 'Günün özeti alınamadı';

  @override
  String dashboardMilkingsAnimals(Object milkings, Object animals) {
    return '$milkings sağım · $animals hayvan';
  }

  @override
  String dashboardMoreAlerts(int n) {
    return '$n uyarı daha';
  }

  @override
  String get dashboardNoMilkingToday => 'Bugün henüz sağım yapılmadı';

  @override
  String get dashboardNoOpenAlerts => 'Açık uyarı yok';

  @override
  String get dashboardOpenAlerts => 'Açık uyarılar';

  @override
  String dashboardPerAnimal(Object amount) {
    return 'hayvan başı $amount';
  }

  @override
  String dashboardSpeciesAnimals(Object species, Object n) {
    return '$species · $n hayvan';
  }

  @override
  String get dashboardSpeciesFallback => 'Tür';

  @override
  String get dashboardTodayMilk => 'Bugün toplanan süt';

  @override
  String dashboardYieldClasses(Object n) {
    return 'Verim sınıfları · $n hayvan';
  }

  @override
  String get deleteAccountBody =>
      'Hesabınız ve oturumlarınız kalıcı olarak silinir; geri alınamaz. İşletmenin sağım ve hayvan kayıtları işletmede kalır, notlarınız \"Silinmiş kullanıcı\" adıyla görünür. Bir işletmenin tek sahibiyseniz önce destekle iletişime geçin.';

  @override
  String get deleteAccountConfirm => 'Kalıcı olarak sil';

  @override
  String get deleteAccountPassword => 'Parolanız';

  @override
  String get deleteAccountPasswordRequired => 'Onay için parolanızı girin.';

  @override
  String get deleteAccountTitle => 'Hesabımı sil';

  @override
  String deliveriesAmountLabel(Object unit) {
    return 'Teslim edilen ($unit)';
  }

  @override
  String get deliveriesCardHint =>
      'Tanker fişini girin: sayaçların ölçtüğüyle karşılaştırılır, fark büyükse uyarı gelir.';

  @override
  String deliveriesDay(Object date) {
    return 'Gün: $date';
  }

  @override
  String deliveriesDeleteBody(Object date, Object amount) {
    return '$date · $amount\nYalnızca yanlış girilen kaydı silin; doğrusunu yeniden girin.';
  }

  @override
  String get deliveriesDeleteTitle => 'Teslim silinsin mi?';

  @override
  String deliveriesDiffOver(Object pct) {
    return '+%$pct · sayaçlar fazla';
  }

  @override
  String deliveriesDiffUnder(Object pct) {
    return '−%$pct · sayaçlar eksik';
  }

  @override
  String get deliveriesEmpty =>
      'Henüz teslim girilmedi. İlk teslim karşılaştırılmaz; fark ikinci teslimden itibaren hesaplanır.';

  @override
  String get deliveriesEnter => 'Teslim gir';

  @override
  String get deliveriesEnterAmount => 'Tanker fişindeki miktarı girin.';

  @override
  String deliveriesExplainer(Object pct) {
    return 'Tanker fişi, önceki teslimden bu yana sayaçların ölçtüğüyle karşılaştırılır (ayrılan süt hariç). Fark %$pct üstündeyse uyarı.';
  }

  @override
  String get deliveriesLoadFailed => 'Teslimler yüklenemedi';

  @override
  String deliveriesMetered(
    Object span,
    Object date,
    Object amount,
    Object withheld,
  ) {
    return 'Sayaçlar $span$date: $amount$withheld';
  }

  @override
  String get deliveriesNotCompared =>
      'Karşılaştırılmadı (önceki teslim ya da sayaç verisi yok)';

  @override
  String get deliveriesSaved => 'Teslim kaydedildi';

  @override
  String deliveriesSavedMismatch(Object diff) {
    return 'Teslim kaydedildi — sayaçlarla fark var: $diff';
  }

  @override
  String get deliveriesTankDelivery => 'Tank teslimi';

  @override
  String deliveriesTankerLine(Object date, Object amount) {
    return '$date · tanker $amount';
  }

  @override
  String get deliveriesTitle => 'Tank teslimleri';

  @override
  String get deliveriesToleranceHelper =>
      'Sayaçlar ile tanker bundan fazla ayrışırsa uyarı.';

  @override
  String get deliveriesToleranceLabel => 'Uyarı için fark (%)';

  @override
  String get deliveriesToleranceTitle => 'Fark eşiği';

  @override
  String deliveriesWithheld(Object amount) {
    return ' (ayrılan $amount hariç)';
  }

  @override
  String get devicesCalibrationNoRecord => 'Kayıt yok (kurulum ekibi girer)';

  @override
  String devicesCalibrationOverdue(Object date) {
    return '$date — zamanı geldi, kurulum ekibini arayın';
  }

  @override
  String get devicesDetailCalibratedAt => 'Son kalibrasyon';

  @override
  String get devicesDetailCalibration => 'Kalibrasyon katsayısı';

  @override
  String get devicesDetailCalibrationDue => 'Sonraki kalibrasyon';

  @override
  String get devicesDetailFirmware => 'Yazılım sürümü';

  @override
  String get devicesDetailLastError => 'Son hata';

  @override
  String get devicesDetailLastSeen => 'Son görülme';

  @override
  String get devicesDetailProfile => 'Profil';

  @override
  String get devicesDetailProtocol => 'Protokol';

  @override
  String devicesEmptySpoutsCount(Object n) {
    return '$n Sayaçsız nokta';
  }

  @override
  String devicesErrorShort(Object code, Object since) {
    return 'Hata $code · $since';
  }

  @override
  String devicesFirmwareShort(Object version) {
    return 'Yazılım $version';
  }

  @override
  String get devicesHallNoVacuums => 'Bu bölgede tanımlı ünite yok';

  @override
  String devicesHallTitle(Object name) {
    return '$name Bölgesi';
  }

  @override
  String get devicesLoadFailed => 'Cihazlar yüklenemedi';

  @override
  String get devicesNoProfile => 'Profilsiz';

  @override
  String get devicesNoRecord => 'Kayıt yok';

  @override
  String devicesOfflineCount(Object n) {
    return '$n Çevrimdışı';
  }

  @override
  String devicesOnlineCount(Object n) {
    return '$n Çevrimiçi';
  }

  @override
  String get devicesProfileUnassigned => 'Atanmamış (karantinada)';

  @override
  String get devicesSimulated => 'Simülatör cihazı';

  @override
  String get devicesSourcesLabel => 'Kaynaklar:';

  @override
  String devicesSpoutLabel(Object no) {
    return 'Nokta $no';
  }

  @override
  String get devicesStatusCalibrationDue => 'Kalibrasyon zamanı';

  @override
  String get devicesStatusNoMeter => 'Sayaç takılı değil';

  @override
  String get devicesStatusOffline => 'Çevrimdışı';

  @override
  String get devicesStatusOnline => 'Çevrimiçi';

  @override
  String get devicesStatusReportedError => 'Hata bildirdi';

  @override
  String get devicesUnassignedHint => 'Bir sağım noktasına bağlı değil.';

  @override
  String get devicesUnassignedTitle => 'Takılı olmayan sayaçlar';

  @override
  String get devicesUnknown => 'Bilinmiyor';

  @override
  String devicesUnprofiledCount(Object n) {
    return '$n Profilsiz sayaç';
  }

  @override
  String devicesVacuumAllOnline(Object points) {
    return '$points nokta · tümü çevrimiçi';
  }

  @override
  String devicesVacuumProblems(Object points, Object problems) {
    return '$points nokta · $problems ilgilenilmeli';
  }

  @override
  String devicesVacuumTitle(Object name) {
    return 'Ünite $name';
  }

  @override
  String get domainClassDeclining => 'Düşüşte';

  @override
  String get domainClassDecliningExplanation =>
      'Son 30 günde belirgin düşüş var. Gebelik, laktasyon dönemi veya hastalık olabilir; takip listesinde.';

  @override
  String get domainClassDryOffCandidate => 'Kuruya Çıkma Adayı';

  @override
  String get domainClassDryOffCandidateExplanation =>
      'Son 7 günün ortalaması tür alt eşiğinin altında. Kuruya çıkarma zamanı gelmiş olabilir.';

  @override
  String get domainClassHigh => 'Yüksek Verimli';

  @override
  String get domainClassHighExplanation =>
      'Son 7 günün ortalaması tür üst eşiğinin üzerinde. Bu hayvan sürünün en verimlileri arasında.';

  @override
  String get domainClassNoMilk => 'Süt Vermiyor';

  @override
  String get domainClassNoMilkExplanation =>
      'Son sağımlarda süt alınamadı. Değerlendirme gerekli.';

  @override
  String get domainClassNormal => 'Normal';

  @override
  String get domainClassNormalExplanation =>
      'Verim beklenen aralıkta, eğim stabil.';

  @override
  String get exitReasonAccident => 'Kaza';

  @override
  String get exitReasonAge => 'Yaşlılık';

  @override
  String get exitReasonDisease => 'Hastalık';

  @override
  String get exitReasonFeet => 'Ayak/tırnak';

  @override
  String get exitReasonFertility => 'Üreme sorunu';

  @override
  String get exitReasonLabel => 'Çıkış nedeni';

  @override
  String get exitReasonLowYield => 'Düşük verim';

  @override
  String get exitReasonMastitis => 'Mastitis';

  @override
  String get exitReasonOther => 'Diğer';

  @override
  String get exitReasonRequired => 'Çıkış nedenini seçin';

  @override
  String get exitReasonUnknown => 'Belirtilmedi';

  @override
  String exitsTitle(int count) {
    return 'Sürüden çıkış · son 12 ay ($count)';
  }

  @override
  String get farmLocationClear => 'Konumu sil';

  @override
  String get farmLocationCoordinates => 'Koordinat (enlem, boylam)';

  @override
  String get farmLocationIntro =>
      'Isı stresi uyarısı için hava tahmini tesisin konumundan alınır. Google Haritalar\'da tesise uzun basın, üstte çıkan koordinatı (39.9208, 32.8541) buraya yapıştırın. Sunucu hava servisine yalnızca bu koordinatı gönderir.';

  @override
  String get farmLocationInvalid =>
      'Enlem, boylam biçiminde girin (ör. 39.9208, 32.8541)';

  @override
  String get farmLocationSaved => 'Tesis konumu kaydedildi';

  @override
  String get farmLocationTitle => 'Tesis konumu';

  @override
  String farmsAlerts(int count) {
    return '$count okunmamış uyarı';
  }

  @override
  String get farmsCurrent => 'Şu an bu işletmedesiniz';

  @override
  String get farmsIntro =>
      'Üye olduğunuz bütün işletmelerin bugünkü özeti. Dokununca o işletmeye geçer.';

  @override
  String farmsLine(Object amount, int animals) {
    return 'Bugün $amount · $animals hayvan';
  }

  @override
  String get farmsLoadFailed => 'Çiftlikler yüklenemedi';

  @override
  String get farmsTitle => 'Çiftliklerim';

  @override
  String farmsVaccines(int count) {
    return '$count aşı zamanı';
  }

  @override
  String get feedbackAddScreenshot => 'Ekran görüntüsü ekle';

  @override
  String get feedbackIntro =>
      'Bir sorun, öneri ya da istek yazın. Uygulama sürümü ve telefon modeli kendiliğinden eklenir.';

  @override
  String get feedbackMessageHint => 'Ne oldu, hangi ekranda? Ne bekliyordunuz?';

  @override
  String get feedbackMessageLabel => 'Mesajınız';

  @override
  String get feedbackMessageRequired => 'Bir mesaj yazın.';

  @override
  String get feedbackRemoveScreenshot => 'Görüntüyü kaldır';

  @override
  String get feedbackScreenshotTooLarge => 'Görüntü en çok 2 MB olabilir.';

  @override
  String get feedbackScreenshotType =>
      'PNG, JPEG ya da WebP bir görüntü seçin.';

  @override
  String get feedbackSend => 'Gönder';

  @override
  String feedbackSendFailed(Object error) {
    return 'Gönderilemedi: $error';
  }

  @override
  String get feedbackSent => 'Geri bildiriminiz alındı, teşekkürler.';

  @override
  String get feedbackTitle => 'Geri bildirim';

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
  String get groupsAdd => 'Grup ekle';

  @override
  String get groupsDeleteBody => 'Gruptaki hayvanlar silinmez, grupsuz kalır.';

  @override
  String groupsDeleteTitle(Object name) {
    return '\"$name\" silinsin mi?';
  }

  @override
  String get groupsDeleteTooltip => 'Grubu sil';

  @override
  String get groupsEmpty => 'Henüz grup yok.';

  @override
  String get groupsIntro =>
      'Her hayvanın en çok bir grubu olur; hayvan gruba düzenleme formundan atanır. Panoda grupların günlük toplamı görünür.';

  @override
  String get groupsLoadFailed => 'Gruplar yüklenemedi';

  @override
  String groupsMilkingCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n sağmal hayvan',
    );
    return '$_temp0';
  }

  @override
  String get groupsNameLabel => 'Ad (ör. Padok 1, Yüksek verim)';

  @override
  String get groupsNew => 'Yeni grup';

  @override
  String get groupsRenameTitle => 'Grubun adı';

  @override
  String get groupsTitle => 'Gruplar';

  @override
  String get historyAddAnimal => 'Hayvan ekle';

  @override
  String historyAnimalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hayvan',
    );
    return '$_temp0';
  }

  @override
  String get historyAnimalsLoadFailed => 'Hayvanlar yüklenemedi';

  @override
  String get historyFilterGroup => 'Grup';

  @override
  String get historyFilterSlow => 'Yavaş sağılanlar';

  @override
  String get historyFilterSpecies => 'Tür';

  @override
  String get historyFromList => 'Listeden';

  @override
  String get historyGroups => 'Gruplar';

  @override
  String historyLactationNo(Object n) {
    return '$n. laktasyon';
  }

  @override
  String get historyNoAnimalsForFilter => 'Bu filtreye uyan hayvan yok';

  @override
  String get historyNoSessions => 'Kayıtlı sağım oturumu yok';

  @override
  String get historyReport => 'Rapor';

  @override
  String get historySessionAutoStarted => 'otomatik açıldı';

  @override
  String get historySessionRunning => 'Sürüyor';

  @override
  String get historySessionStartUnknown => 'Başlangıç bilinmiyor';

  @override
  String historySessionTitle(Object hall, Object type) {
    return '$hall Bölgesi · $type Sağımı';
  }

  @override
  String get historySessionsLoadFailed => 'Oturumlar yüklenemedi';

  @override
  String historySpoutLabel(Object vacuum, Object n) {
    return '$vacuum · Nokta $n';
  }

  @override
  String get historyTabAnimals => 'Hayvanlar';

  @override
  String get historyTabSessions => 'Oturumlar';

  @override
  String get historyUnknownVacuum => 'Ünite';

  @override
  String historyUnmatchedBanner(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n tanınmayan küpe',
    );
    return '$_temp0';
  }

  @override
  String get historyUnmatchedBannerHint => 'Sağımda okundu; hayvanına atayın';

  @override
  String get historyVaccines => 'Aşılar';

  @override
  String get kioskExitBody =>
      'Yeniden girmek için tablet hesabının e-postası ve parolası gerekir.';

  @override
  String get kioskExitTitle => 'Tabletten çıkılsın mı?';

  @override
  String get kioskSignOut => 'Çıkış';

  @override
  String get kioskTitle => 'Milk Trace · Sağımhane';

  @override
  String lactationActual(Object amount, int days) {
    return 'Ölçülen: $amount ($days. gün)';
  }

  @override
  String lactationComplete(Object amount) {
    return '305 gün tamamlandı: $amount';
  }

  @override
  String get lactationHint =>
      'Tahmin hayvanın kendi eğrisinden (Wood); ölçülmeyen günler sıfır sayılır.';

  @override
  String get lactationNoProjection =>
      'Tahmin en az 30 günlük veriyle ve sağmal hayvanda yapılır.';

  @override
  String lactationProjected(Object amount) {
    return '305 gün tahmini: $amount';
  }

  @override
  String get lactationTitle => 'Bu laktasyon · 305 gün';

  @override
  String get languageAuto => 'Cihaz dili';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTitle => 'Dil';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get lineageDam => 'Anne';

  @override
  String get lineageNoDam => 'Anne kayıtlı değil';

  @override
  String get lineageOffspring => 'Yavrular';

  @override
  String get lineageRegisterCalf => 'Yavruyu kaydet';

  @override
  String get lineageSire => 'Baba (boğa/sperma kodu)';

  @override
  String get lineageSireHelper => 'Tohumlama kaydındaki kodla aynı biçimde';

  @override
  String get lineageSireTooLong => 'En çok 60 karakter';

  @override
  String liveActionFailed(Object error) {
    return 'İşlem tamamlanamadı: $error';
  }

  @override
  String liveActiveCount(Object n) {
    return '$n Aktif';
  }

  @override
  String get liveClearBodyEmpty => 'Bu sağım silinecek.';

  @override
  String liveClearBodyMeasured(Object amount) {
    return 'Bu sağımdaki ölçüm ($amount) silinecek ve hiçbir hayvana yazılmayacak.';
  }

  @override
  String get liveClearConfirm => 'Kaldır';

  @override
  String get liveClearTitle => 'Eşleştirme kaldırılsın mı?';

  @override
  String get liveDataFailed => 'Canlı veri alınamadı';

  @override
  String get liveEndConfirm => 'Bitir';

  @override
  String get liveEndDialogBody =>
      'Açık kalan hayvan sağımları kapatılacak ve oturum özetleri hesaplanacak. Bu işlem geri alınamaz.';

  @override
  String get liveEndDialogTitle => 'Sağımı bitir';

  @override
  String get liveEndMilking => 'Sağımı Bitir';

  @override
  String get liveFlowRate => 'Akış oranı';

  @override
  String get liveFlowUnit => 'L/dk';

  @override
  String liveHallName(Object name) {
    return '$name Bölgesi';
  }

  @override
  String get liveHallsLoadFailed => 'Bölgeler yüklenemedi';

  @override
  String get liveLowFlow => 'Düşük Debi';

  @override
  String get liveNoHalls => 'Tanımlı sağım bölgesi yok';

  @override
  String get liveNoOpenSession =>
      'Bu bölgede açık sağım yok.\nBaşlatmak için yukarıdaki düğmeyi kullanın.';

  @override
  String get liveNoSpouts => 'Bu bölgede sağım noktası bulunamadı';

  @override
  String get liveNoTarget => 'Hedef tanımsız';

  @override
  String get liveNotAssigned => 'Hayvan eşleştirilmedi';

  @override
  String get liveNow => 'Şu an';

  @override
  String livePassiveCount(Object n) {
    return '$n Pasif';
  }

  @override
  String get livePickerClear => 'Eşleştirmeyi kaldır';

  @override
  String livePickerClearHint(Object animal) {
    return '$animal yanlış bağlandıysa';
  }

  @override
  String get livePickerElsewhere => 'başka noktada';

  @override
  String get livePickerLoadFailed => 'Hayvanlar yüklenemedi';

  @override
  String get livePickerNoMatch => 'Eşleşen hayvan yok';

  @override
  String livePickerNotMilking(Object message) {
    return '$message: listede yok. Yanlışlıkla girdiyse başlığı çıkarın; sağılacaksa önce hayvanın durumunu değiştirin.';
  }

  @override
  String get livePickerPrevHere => 'önceki sağımda bu noktadaydı';

  @override
  String get livePickerPrevMilked => 'önceki sağımda sağıldı';

  @override
  String get livePickerSearchHint => 'Küpe numarası, ad veya RFID';

  @override
  String livePickerTitle(Object spout) {
    return '$spout · hayvan seç';
  }

  @override
  String livePickerUnknownTag(Object message) {
    return '$message. Hayvanı aşağıdan seçin.';
  }

  @override
  String livePickerWithhold(Object date) {
    return 'Sütü ayır\n$date';
  }

  @override
  String get liveRedAlertOff => 'Kırmızı uyarısını kapat';

  @override
  String get liveRedAlertOn => 'Kırmızı uyarısını aç';

  @override
  String liveReplaceBody(Object who, Object amount) {
    return '$who için bu noktada $amount ölçüldü.\n\nSağıldıysa ölçüm ona yazılır. Eşleştirme yanlışsa ölçüm silinir.';
  }

  @override
  String get liveReplaceMilked => 'Sağıldı';

  @override
  String get liveReplaceMistaken => 'Yanlış eşleştirme';

  @override
  String get liveReplaceTitle => 'Önceki hayvan sağıldı mı?';

  @override
  String get liveSessionTypeTitle => 'Sağım tipi';

  @override
  String get liveSpout => 'Nokta';

  @override
  String liveSpoutTitle(Object unit, Object no) {
    return '$unit · Nokta $no';
  }

  @override
  String get liveStartMilking => 'Sağımı Başlat';

  @override
  String get liveTarget => 'Hedef';

  @override
  String get liveTitle => 'Canlı Veriler';

  @override
  String get liveUnitFallback => 'Ünite';

  @override
  String get liveUnknownTag => 'Tanınmayan küpe';

  @override
  String liveWithholdUntil(Object date) {
    return 'Sütü ayır · arınma $date';
  }

  @override
  String get loginEmailInvalid => 'Geçerli bir e-posta girin.';

  @override
  String get loginEmailLabel => 'E-posta';

  @override
  String get loginEmailRequired => 'E-posta girin.';

  @override
  String get loginForgotPassword => 'Parolamı unuttum';

  @override
  String get loginHidePassword => 'Parolayı gizle';

  @override
  String get loginMfaCode => 'Doğrulama kodu';

  @override
  String get loginMfaCodeRequired => 'Kodu girin.';

  @override
  String get loginMfaHint =>
      'Doğrulama uygulamanızdaki 6 haneli kodu ya da bir yedek kodu girin.';

  @override
  String get loginPasswordLabel => 'Parola';

  @override
  String get loginPasswordRequired => 'Parola girin.';

  @override
  String get loginResetIntro =>
      'E-posta adresinize yeni parola belirleme bağlantısı gönderelim.';

  @override
  String get loginResetSend => 'Bağlantı gönder';

  @override
  String get loginShowPassword => 'Parolayı göster';

  @override
  String get loginSubmit => 'Giriş yap';

  @override
  String get loginTagline => 'İşletmenizin sağım takibi';

  @override
  String meterCheckAmountLabel(Object unit) {
    return 'Ölçülen süt ($unit)';
  }

  @override
  String get meterCheckCalibrate =>
      'Sapma sürüyor: kurulum ekibinden kalibrasyon isteyin.';

  @override
  String get meterCheckEnterAmount => 'Ölçülen miktarı girin';

  @override
  String meterCheckIntro(Object when, Object metered) {
    return '$when · sayaç $metered ölçtü. Bu sağımın sütünü tartın ya da ölçün; sayaçla karşılaştırılır, katsayı değişmez.';
  }

  @override
  String meterCheckResult(Object dev, int n, Object avg) {
    return 'Sayaç %$dev · son $n kontrol ortalaması %$avg';
  }

  @override
  String meterCheckRow(Object date, Object tag, Object metered, Object manual) {
    return '$date · $tag · sayaç $metered / elle $manual';
  }

  @override
  String meterCheckRowPct(Object pct) {
    return '%$pct';
  }

  @override
  String get meterCheckTapHint =>
      'Sayacı denetlemek için sağıma dokunup tartılan sütü girin.';

  @override
  String get meterCheckTitle => 'Elle ölçüm';

  @override
  String meterDriftShort(Object pct) {
    return 'Kontrol sapması %$pct';
  }

  @override
  String get meterSectionCalibrate =>
      'Ortalama sapma %5\'i aşıyor: kurulum ekibinden kalibrasyon isteyin.';

  @override
  String get meterSectionEmpty =>
      'Henüz elle ölçüm yok. Hayvan detayındaki son sağımlardan girilir.';

  @override
  String get meterSectionFew =>
      'Kalibrasyon kararı için en az 3 kontrol gerekir.';

  @override
  String meterSectionSummary(Object n, Object avg) {
    return 'Son $n kontrol ortalaması %$avg';
  }

  @override
  String get meterSectionTitle => 'Sayaç kontrolü';

  @override
  String milkersDurationMinutesSeconds(Object m, Object s) {
    return '$m dk $s sn';
  }

  @override
  String milkersDurationSeconds(Object s) {
    return '$s sn';
  }

  @override
  String get milkersEmpty => 'Bu dönemde sağım yok.';

  @override
  String get milkersLast30Days => 'Son 30 gün';

  @override
  String get milkersLast7Days => 'Son 7 gün';

  @override
  String get milkersLoadFailed => 'Sağımcı özeti yüklenemedi';

  @override
  String get milkersNote =>
      'Sağımcı, oturumu açan ya da hayvanı noktaya bağlayan kişidir. Düşük debi çoğu zaman hayvandan ya da başlıktan gelir; oran bakılacak yeri gösterir, kişiyi puanlamaz.';

  @override
  String milkersStats(Object duration, Object pct) {
    return 'Ortalama sağım $duration · düşük debi %$pct';
  }

  @override
  String milkersSummary(Object sessions, Object milkings, Object volume) {
    return '$sessions oturum · $milkings sağım · $volume';
  }

  @override
  String get milkersTitle => 'Sağımcılar';

  @override
  String get milkersUnknown => 'Sağımcısı bilinmeyen';

  @override
  String get milkersUnknownHint =>
      'RFID ile açılan ya da eşleştireni silinmiş sağımlar';

  @override
  String get modelAnimalStatusActive => 'Sağmal';

  @override
  String get modelAnimalStatusDead => 'Öldü';

  @override
  String get modelAnimalStatusDry => 'Kuruda';

  @override
  String get modelAnimalStatusSlaughtered => 'Kesildi';

  @override
  String get modelAnimalStatusSold => 'Satıldı';

  @override
  String get modelBreedingInsemination => 'Tohumlama';

  @override
  String modelBreedingPregnancyCheck(Object result) {
    return 'Gebelik kontrolü · $result';
  }

  @override
  String get modelBreedingResultOpen => 'boş';

  @override
  String get modelBreedingResultPregnant => 'gebe';

  @override
  String get modelPregnancyInseminated => 'Tohumlandı · kontrol bekliyor';

  @override
  String get modelPregnancyOpen => 'Boş';

  @override
  String get modelPregnancyPregnant => 'Gebe';

  @override
  String get modelProfileUndefined => 'Profil tanımsız';

  @override
  String get modelProtocolUnknown => 'Bilinmiyor';

  @override
  String get modelUpcomingCalving => 'Beklenen doğum';

  @override
  String get modelUpcomingDryOff => 'Kuruya çıkar';

  @override
  String get pushChannelDescription =>
      'Düşük debi, düşük verim ve cihaz uyarıları.';

  @override
  String get pushChannelName => 'Sağım uyarıları';

  @override
  String get pushQuietChannelDescription =>
      'Sessiz saatte gelen, kritik olmayan uyarılar; ses çıkarmaz.';

  @override
  String get pushQuietChannelName => 'Sessiz saatteki uyarılar';

  @override
  String get qualityBacteria => 'Bakteri (bin/mL)';

  @override
  String qualityBacteriaPart(Object v) {
    return 'Bakteri $v';
  }

  @override
  String get qualityFat => 'Yağ (%)';

  @override
  String qualityFatPart(Object v) {
    return 'Yağ %$v';
  }

  @override
  String qualityHighScc(int limit) {
    return 'Somatik hücre sınırın üstünde ($limit bin/mL)';
  }

  @override
  String get qualityInvalid => 'Geçerli bir sayı girin';

  @override
  String get qualityOptional => 'İsteğe bağlı; fişte yazıyorsa girin.';

  @override
  String get qualityProtein => 'Protein (%)';

  @override
  String qualityProteinPart(Object v) {
    return 'Protein %$v';
  }

  @override
  String get qualityScc => 'Somatik hücre (bin/mL)';

  @override
  String get qualitySccLimit => 'Somatik hücre sınırı (bin/mL)';

  @override
  String get qualitySccLimitHelper => 'Aşılırsa uyarı gelir. Yaygın sınır 400.';

  @override
  String get qualitySccLimitRange => '50 ile 2000 arasında olmalı';

  @override
  String qualitySccPart(Object v) {
    return 'Hücre $v';
  }

  @override
  String get qualityTitle => 'Mandıra analizi';

  @override
  String get qualityTrendEmpty => 'Grafik için en az iki analiz gerekli.';

  @override
  String get qualityTrendTitle => 'Son 90 gün';

  @override
  String get quietEnabled => 'Sessiz saat açık';

  @override
  String get quietEnd => 'Bitiş';

  @override
  String get quietIntro =>
      'Bu saatlerde uyarılar telefonunuzu çaldırmaz; bildirim yine gelir ve uyarı listesinde durur. Kritik uyarılar (ör. sayaç çevrimdışı) her zaman çalar. Ayar yalnızca sizin içindir.';

  @override
  String get quietSameTime => 'Başlangıç ve bitiş aynı olamaz.';

  @override
  String get quietSaved => 'Sessiz saat kaydedildi';

  @override
  String get quietStart => 'Başlangıç';

  @override
  String get quietTitle => 'Sessiz saat';

  @override
  String get roleOperator => 'Operatör';

  @override
  String get roleOperatorHint =>
      'Sağımı yürütür: oturum açar, hayvan eşleştirir.';

  @override
  String get roleOwner => 'İşletme sahibi';

  @override
  String get rolePlatformAdmin => 'Platform yöneticisi';

  @override
  String get roleViewer => 'Görüntüleyici';

  @override
  String get roleViewerHint =>
      'Veteriner, danışman: görür ve not yazar, değiştiremez.';

  @override
  String get scheduleChangeTime => 'Saati değiştir';

  @override
  String get scheduleEvening => 'Akşam sağımı';

  @override
  String get scheduleGrace => 'Gecikme payı';

  @override
  String scheduleGraceMinutes(Object n) {
    return '$n dk';
  }

  @override
  String get scheduleIntro =>
      'Saatten gecikme payı kadar sonra oturumu açılmamış bölge için uyarı gelir (son iki haftada kullanılan bölgeler). Sayaç akışla oturumu kendisi açtıysa uyarı gitmez.';

  @override
  String get scheduleMorning => 'Sabah sağımı';

  @override
  String get scheduleOff => 'Kapalı';

  @override
  String get scheduleSaved => 'Sağım saatleri kaydedildi';

  @override
  String get scheduleTitle => 'Sağım saatleri';

  @override
  String get sessionSummaryLoadFailed => 'Oturum özeti alınamadı';

  @override
  String sessionSummaryLowFlow(Object n) {
    return 'Düşük debi: $n';
  }

  @override
  String sessionSummaryLowYield(Object n) {
    return 'Düşük verim: $n';
  }

  @override
  String get sessionSummaryNoneNotMilked => 'Sağmal hayvanların hepsi sağıldı.';

  @override
  String sessionSummaryNotMilked(Object n) {
    return 'Sağılmayan sağmal: $n';
  }

  @override
  String get sessionSummaryTitle => 'Oturum özeti';

  @override
  String sessionSummaryTotals(int n, Object amount) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n hayvan sağıldı',
    );
    return '$_temp0 · $amount';
  }

  @override
  String get sessionsApp => 'Milk Trace uygulaması';

  @override
  String get sessionsAppAndroid => 'Milk Trace · Android';

  @override
  String get sessionsAppIos => 'Milk Trace · iPhone';

  @override
  String get sessionsBrowser => 'Tarayıcı (panel)';

  @override
  String get sessionsIntro =>
      'Hesabınızın açık olduğu cihazlar. Tanımadığınız ya da kaybolan bir cihazı buradan kapatın; o cihaz en geç 15 dakika içinde çıkar.';

  @override
  String sessionsLastUsed(Object when) {
    return 'son kullanım $when';
  }

  @override
  String get sessionsSignOut => 'Bu oturumu kapat';

  @override
  String get sessionsSignOutOthers => 'Diğer bütün cihazlardan çık';

  @override
  String get sessionsThisDevice => 'bu cihaz';

  @override
  String get sessionsTitle => 'Oturumlar';

  @override
  String get setupAnimals => 'Hayvanları ekleyin ya da listeden içe aktarın';

  @override
  String get setupChannel => 'E-posta ya da SMS bildirim kanalı ekleyin';

  @override
  String get setupDismiss => 'Listeyi kapat';

  @override
  String get setupLocation => 'Isı stresi uyarısı için tesis konumunu girin';

  @override
  String get setupSchedule => 'Sağım saatlerini girin';

  @override
  String get setupTeam => 'Sağımcıları ve veterineri kullanıcı olarak ekleyin';

  @override
  String setupTitle(int done, int total) {
    return 'Kuruluma başlayın ($done/$total)';
  }

  @override
  String get shellTabDashboard => 'Dashboard';

  @override
  String get shellTabDevices => 'Cihazlar';

  @override
  String get shellTabHistory => 'Geçmiş';

  @override
  String get shellTabLive => 'Canlı';

  @override
  String get speciesCow => 'İnek';

  @override
  String get speciesGoat => 'Keçi';

  @override
  String get speciesSheep => 'Koyun';

  @override
  String get speedAvgFlow => 'Ortalama debi';

  @override
  String get speedDuration => 'Ortalama süre';

  @override
  String speedFlowValue(Object v) {
    return '$v L/dk';
  }

  @override
  String speedHerd(Object v, Object n) {
    return 'Sürü ortalaması $v L/dk · $n sağım';
  }

  @override
  String get speedPeakFlow => 'Tepe debi';

  @override
  String speedSlow(Object pct) {
    return 'Yavaş sağılıyor: sürü ortalamasının %$pct altında. Üniteyi uzun tutar; sağım sırasında dikkate alın.';
  }

  @override
  String get speedTitle => 'Sağım hızı · son 30 gün';

  @override
  String spoutLowFlowDetail(Object pct, Object avg, Object unit) {
    return 'Son 7 günde ünitenin diğer noktalarından %$pct düşük debi ölçüyor (ort. $avg L/dk, ünite $unit L/dk). Başlık, pulsatör ve süt hortumunu kontrol edin.';
  }

  @override
  String spoutLowFlowShort(Object pct) {
    return 'Düşük debi · %$pct';
  }

  @override
  String get supportCall => 'Ara';

  @override
  String supportOpenFailed(Object target) {
    return 'Açılamadı: $target';
  }

  @override
  String get supportTitle => 'Destek';

  @override
  String get supportWhatsAppText =>
      'Merhaba, Milk Trace hakkında destek istiyorum.';

  @override
  String supportWhatsAppVersion(Object version) {
    return ' (Uygulama $version)';
  }

  @override
  String get teamAccessExpired => 'erişim süresi doldu';

  @override
  String get teamAccessPickDate => 'Gün seç';

  @override
  String get teamAccessTitle => 'Erişim bitişi';

  @override
  String get teamAccessUnlimited => 'Süresiz';

  @override
  String teamAccessUntil(Object date) {
    return 'erişim $date dahil';
  }

  @override
  String teamActionFailed(Object error) {
    return 'İşlem yapılamadı: $error';
  }

  @override
  String get teamActivate => 'Etkinleştir';

  @override
  String get teamActivateHint => 'Yeniden giriş yapabilir.';

  @override
  String teamAddFailed(Object error) {
    return 'Eklenemedi: $error';
  }

  @override
  String get teamAddUser => 'Kullanıcı ekle';

  @override
  String teamDeleteBody(Object name) {
    return '$name kalıcı olarak silinecek; geri alınamaz. Yazdığı hayvan notları kalır, yazarı \"Silinmiş kullanıcı\" görünür.\n\nYalnızca erişimi kesmek için \"Askıya al\"ı kullanın.';
  }

  @override
  String get teamDeleteTitle => 'Kullanıcıyı sil';

  @override
  String get teamEmailInvalid => 'Geçerli bir e-posta girin.';

  @override
  String get teamEmailLabel => 'E-posta';

  @override
  String get teamFullNameLabel => 'Ad soyad';

  @override
  String get teamFullNameRequired => 'Ad soyad girin.';

  @override
  String get teamKiosk => 'Sağımhane tableti';

  @override
  String get teamKioskHint =>
      'Sağımhanedeki ortak tablet için: yalnızca canlı sağım açılır, ekran kararmaz. Tablete bu e-posta ve parolayla girilir.';

  @override
  String get teamLoadFailed => 'Kullanıcılar yüklenemedi';

  @override
  String teamMakeRole(Object role) {
    return '$role yap';
  }

  @override
  String get teamNote =>
      'Operatör sağımı yürütür; görüntüleyici (veteriner, danışman) görür ve not yazar. İşletme sahibi eklemek için Milk Trace desteğine başvurun.';

  @override
  String get teamPasswordTooShort => 'En az 8 karakter.';

  @override
  String get teamSuspend => 'Askıya al';

  @override
  String get teamSuspendHint =>
      'Giriş yapamaz; açık oturumu en geç 15 dakikada kapanır.';

  @override
  String get teamSuspended => 'Askıda';

  @override
  String get teamTabletPassword => 'Tablet parolası';

  @override
  String get teamTabletPasswordHelper =>
      'Tablete bu parolayla girilir; en az 8 karakter.';

  @override
  String get teamTabletPasswordRequired => 'Tablet için parola girin.';

  @override
  String get teamTempPassword => 'Geçici parola (isteğe bağlı)';

  @override
  String get teamTempPasswordHelper =>
      'Boş bırakırsanız e-postayla davet gider.';

  @override
  String get teamTitle => 'Kullanıcılar';

  @override
  String get themeDark => 'Karanlık';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeSystem => 'Cihaz';

  @override
  String get themeTitle => 'Tema';

  @override
  String get thresholdsAlertHold => 'Uyarı bekleme';

  @override
  String get thresholdsCalibrationNote =>
      'Varsayılanlar tahmini başlangıç değerleridir. Irk, laktasyon dönemi ve işletmeye göre çok değişir; saha verisi ve ziraat mühendisi/veteriner görüşüyle kalibre edilmelidir.';

  @override
  String get thresholdsClassGroupHint =>
      '7 günlük ortalama alt eşiğin altındaysa kuruya aday, üst eşiğin üstündeyse yüksek verimli (§6.4).';

  @override
  String get thresholdsClassGroupTitle => 'Sınıflandırma eşikleri';

  @override
  String get thresholdsConductivity => 'İletkenlik artışı';

  @override
  String get thresholdsDecline => 'Düşüş eşiği';

  @override
  String get thresholdsDensity => 'Yoğunluk';

  @override
  String get thresholdsDensityGroupHint =>
      'İşletme miktarları kilogram gösteriyorsa litre bu katsayıyla çevrilir (1 L inek sütü ≈ 1,03 kg). Eşikler yine litre girilir.';

  @override
  String get thresholdsDensityGroupTitle => 'Süt yoğunluğu';

  @override
  String get thresholdsDryOff => 'Kuruya çıkma alt eşiği';

  @override
  String get thresholdsEndFlow => 'Bitiş debisi';

  @override
  String get thresholdsEndGrace => 'Bekleme';

  @override
  String get thresholdsEndGroupHint =>
      'Debi bu değerin altında bu süre kalırsa hayvanın sağımı kapanır (§6.1).';

  @override
  String get thresholdsEndGroupTitle => 'Sağım kapanışı';

  @override
  String get thresholdsErrorAboveDryOff =>
      'Kuruya çıkma eşiğinden büyük olmalı';

  @override
  String get thresholdsErrorAboveLower => 'Alt eşikten büyük olmalı';

  @override
  String get thresholdsErrorAboveNoMilk => 'Boş sağım sınırından büyük olmalı';

  @override
  String get thresholdsErrorAboveRed => 'Kırmızı eşiğinden büyük olmalı';

  @override
  String get thresholdsErrorBelowExpected =>
      'Sağım başına beklenenden küçük olmalı';

  @override
  String get thresholdsErrorBelowGreen => 'Yeşil eşiğinden küçük olmalı';

  @override
  String get thresholdsErrorBelowHighYield =>
      'Yüksek verim eşiğinden küçük olmalı';

  @override
  String get thresholdsErrorBelowUpper => 'Üst eşikten küçük olmalı';

  @override
  String get thresholdsErrorConductivityRange => '5–100 arasında olmalı';

  @override
  String get thresholdsErrorDensityRange => '0,90–1,20 arasında olmalı';

  @override
  String get thresholdsErrorInteger => 'Tam sayı girin';

  @override
  String thresholdsErrorMax(Object max) {
    return 'En çok $max olabilir';
  }

  @override
  String get thresholdsErrorNegative => 'Negatif olamaz';

  @override
  String get thresholdsErrorNumber => 'Sayı girin';

  @override
  String get thresholdsErrorZero => 'Sıfır olamaz';

  @override
  String get thresholdsExpectedPerMilking => 'Sağım başına beklenen';

  @override
  String get thresholdsFalseAlarmGroupHint =>
      'Sağımın ilk saniyelerinde kırmızı üretilmez; kırmızı durum bu süre boyunca sürmeden uyarı gönderilmez (§6.2).';

  @override
  String get thresholdsFalseAlarmGroupTitle => 'Yanlış alarm koruması';

  @override
  String get thresholdsFlowGroupHint =>
      'Altında kırmızı, üstünde yeşil; arası sarı (§6.2).';

  @override
  String get thresholdsFlowGroupTitle => 'Anlık debi bantları';

  @override
  String get thresholdsFresh => 'Taze laktasyon';

  @override
  String get thresholdsGreenLimit => 'Yeşil eşiği';

  @override
  String get thresholdsHighYield => 'Yüksek verim üst eşiği';

  @override
  String get thresholdsLoadFailed => 'Eşikler yüklenemedi';

  @override
  String get thresholdsLowerLimit => 'Alt eşik';

  @override
  String get thresholdsMastitisGroupHint =>
      'Sayaç iletkenlik ölçüyorsa: sağımın iletkenliği hayvanın kendi 7 günlük ortalamasının bu oran kadar üstündeyse uyarı. Teşhis değildir; veteriner kontrolü için işarettir.';

  @override
  String get thresholdsMastitisGroupTitle => 'Mastitis şüphesi';

  @override
  String get thresholdsNoMilk => 'Boş sağım sınırı';

  @override
  String get thresholdsNoMilkCount => 'Bakılan son sağım';

  @override
  String get thresholdsNoSpecies => 'Tanımlı tür eşiği yok';

  @override
  String get thresholdsRampUp => 'Isınma süresi';

  @override
  String get thresholdsReadOnly =>
      'Eşikleri yalnızca işletme sahibi değiştirebilir.';

  @override
  String get thresholdsRedLimit => 'Kırmızı eşiği';

  @override
  String get thresholdsRulesGroupHint =>
      '7 günlük ortalama 30 günlükten bu oranda fazla düşükse düşüşte. Son sağımların hepsi boş sağım sınırının altındaysa süt vermiyor. Buzağılamadan sonraki taze laktasyon günlerinde düşüşte ve kuruya aday denmez (§6.4).';

  @override
  String get thresholdsRulesGroupTitle => 'Sınıflandırma kuralları';

  @override
  String thresholdsSaved(Object species) {
    return '$species eşikleri kaydedildi';
  }

  @override
  String get thresholdsSaving => 'Kaydediliyor…';

  @override
  String get thresholdsSpeciesLoadFailed => 'Türler yüklenemedi';

  @override
  String get thresholdsTitle => 'Eşik ayarları';

  @override
  String get thresholdsUnitDays => 'gün';

  @override
  String get thresholdsUnitFlow => 'L/dk';

  @override
  String get thresholdsUnitMilkings => 'sağım';

  @override
  String get thresholdsUnitPerDay => 'L/gün';

  @override
  String get thresholdsUnitSec => 'sn';

  @override
  String get thresholdsUpperLimit => 'Üst eşik';

  @override
  String get thresholdsYieldGroupHint =>
      'Alınan sütün beklenene oranı (§6.3). Geçmişi olmayan hayvanda beklenen, sağım başına bu değerdir.';

  @override
  String get thresholdsYieldGroupTitle => 'Oturum verimi bantları';

  @override
  String get treatmentAdd => 'Tedavi ekle';

  @override
  String get treatmentDeleteBody =>
      'Yalnızca yanlış girilen kaydı silin; silinen kayıt arınmayı da kaldırır.';

  @override
  String get treatmentDeleteTitle => 'Tedavi kaydı silinsin mi?';

  @override
  String get treatmentDrug => 'İlaç';

  @override
  String get treatmentDrugRequired => 'İlaç adını girin.';

  @override
  String get treatmentEmpty =>
      'Tedavi kaydı yok. Antibiyotik verilen hayvanın arınma süresini girin: süre boyunca canlı ekranda \"Sütü ayır\" uyarısı çıkar.';

  @override
  String get treatmentLoadFailed => 'Tedaviler alınamadı';

  @override
  String treatmentPlusDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '+$n gün',
    );
    return '$_temp0';
  }

  @override
  String treatmentRange(Object start, Object until) {
    return '$start → arınma $until';
  }

  @override
  String treatmentSaveFailed(Object error) {
    return 'Tedavi kaydedilemedi: $error';
  }

  @override
  String get treatmentSaved => 'Tedavi kaydedildi';

  @override
  String treatmentStart(Object date) {
    return 'Başlangıç: $date';
  }

  @override
  String get treatmentStartHelp => 'Tedavi başlangıcı';

  @override
  String get treatmentTitle => 'Tedavi ve arınma';

  @override
  String treatmentUntil(Object date) {
    return 'Arınma bitişi: $date';
  }

  @override
  String get treatmentUntilHelp => 'Sütün ayrılacağı son gün';

  @override
  String treatmentWithdrawalBanner(Object date) {
    return 'Arınmada: sütü $date dahil tanka katmayın.';
  }

  @override
  String get twoFactorBackupBody =>
      'Telefonunuz kaybolursa bunlarla girersiniz; her biri bir kez geçer. Yalnızca şimdi gösteriliyor — güvenli bir yere kaydedin.';

  @override
  String get twoFactorBackupTitle => 'Yedek kodlar';

  @override
  String get twoFactorCode => '6 haneli kod';

  @override
  String get twoFactorCodeOrBackup => 'Kod ya da yedek kod';

  @override
  String get twoFactorCopyCodes => 'Kodları kopyala';

  @override
  String get twoFactorCopyKey => 'Anahtarı kopyala';

  @override
  String get twoFactorDisable => 'İki adımlı doğrulamayı kapat';

  @override
  String get twoFactorDisableHint =>
      'Kapatmak için parolanızı ve doğrulama kodunu (ya da bir yedek kodu) girin.';

  @override
  String get twoFactorDone => 'Kaydettim';

  @override
  String get twoFactorEnable => 'Doğrula ve aç';

  @override
  String get twoFactorIntro =>
      'Girişte parolanın yanında telefonunuzdaki doğrulama uygulamasının (Google Authenticator, Microsoft Authenticator vb.) ürettiği 6 haneli kod istenir. Parolanız ele geçse bile hesabınıza girilemez.';

  @override
  String get twoFactorOn => 'İki adımlı doğrulama açık';

  @override
  String get twoFactorOpenApp => 'Uygulamada aç';

  @override
  String get twoFactorStart => 'Kurulumu başlat';

  @override
  String get twoFactorStep1 =>
      '1. Doğrulama uygulamasında \"hesap ekle\" → \"kurulum anahtarı gir\" ile bu anahtarı ekleyin (hesap adı: Milk Trace):';

  @override
  String get twoFactorStep2 => '2. Uygulamanın gösterdiği 6 haneli kodu girin:';

  @override
  String get twoFactorTitle => 'İki adımlı doğrulama';

  @override
  String get unmatchedAssign => 'Hayvana ata';

  @override
  String unmatchedAssigned(Object earTag) {
    return 'Küpe $earTag kaydına eklendi';
  }

  @override
  String unmatchedChooseAnimal(Object rfid) {
    return '$rfid · hayvan seç';
  }

  @override
  String get unmatchedEmpty => 'Tanınmayan küpe yok';

  @override
  String get unmatchedIgnore => 'Yok say';

  @override
  String unmatchedIgnoreBody(Object rfid) {
    return '$rfid listeden kalkar ve yeniden okunsa da dönmez. Başka çiftliğin hayvanı ya da bozuk okuma için.';
  }

  @override
  String unmatchedIgnoreFailed(Object error) {
    return 'Yok sayılamadı: $error';
  }

  @override
  String get unmatchedIgnoreTitle => 'Küpe yok sayılsın mı?';

  @override
  String get unmatchedIntro =>
      'Sağımda okunan ama hiçbir hayvana kayıtlı olmayan küpeler. Küpeyi hayvanına atayın; bir dahaki sağımda hayvan noktaya kendiliğinden eşleşir. Başka çiftliğin hayvanı ya da bozuk okumaysa yok sayın.';

  @override
  String unmatchedLastSeenAt(Object spout) {
    return 'Son: $spout';
  }

  @override
  String get unmatchedLoadFailed => 'Küpeler yüklenemedi';

  @override
  String get unmatchedNoTag => 'küpesi yok';

  @override
  String unmatchedReadCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n okuma',
    );
    return '$_temp0';
  }

  @override
  String get unmatchedReplace => 'Değiştir';

  @override
  String unmatchedReplaceBody(Object animal, Object old, Object rfid) {
    return '$animal kaydındaki küpe $old. Yerine $rfid yazılacak; eski küpe artık tanınmaz.';
  }

  @override
  String get unmatchedReplaceTitle => 'Küpe değiştirilsin mi?';

  @override
  String get unmatchedSearchHint => 'Küpe numarası veya ad';

  @override
  String unmatchedTagValue(Object rfid) {
    return 'küpe $rfid';
  }

  @override
  String get unmatchedTitle => 'Tanınmayan küpeler';

  @override
  String get unmatchedUnknownSpout => 'bilinmeyen nokta';

  @override
  String upcomingMore(int n) {
    return 've $n hayvan daha';
  }

  @override
  String get upcomingTitle => 'Yaklaşanlar';

  @override
  String get updateBodyAndroid =>
      'Milk Trace\'in bu sürümü artık desteklenmiyor. Sağım kayıtlarının doğru tutulması için uygulamayı Google Play\'den güncelleyin.';

  @override
  String get updateBodyIos =>
      'Milk Trace\'in bu sürümü artık desteklenmiyor. Sağım kayıtlarının doğru tutulması için uygulamayı App Store\'dan güncelleyin.';

  @override
  String get updatePlayButton => 'Google Play\'de güncelle';

  @override
  String get updateTitle => 'Güncelleme gerekli';

  @override
  String get vaccineAllSpecies => 'Bütün türler';

  @override
  String get vaccineCardEmpty => 'Bu hayvanın girdiği aşı planı yok.';

  @override
  String get vaccineCardLoadFailed => 'Aşılar yüklenemedi';

  @override
  String get vaccineCardTitle => 'Aşılar';

  @override
  String get vaccineDeleteBody => 'Yanlış girilen uygulama kaydı silinir.';

  @override
  String get vaccineDeleteTitle => 'Aşı kaydı silinsin mi?';

  @override
  String get vaccineDueEmpty => 'Zamanı gelen hayvan yok.';

  @override
  String get vaccineDueIntro =>
      'Zamanı geçmiş, 30 gün içinde gelecek ya da hiç kaydı olmayan hayvanlar.';

  @override
  String get vaccineDueLoadFailed => 'Zamanı gelenler yüklenemedi';

  @override
  String vaccineDueOn(Object date) {
    return 'zamanı $date';
  }

  @override
  String get vaccineEmpty => 'Henüz aşı planı yok.';

  @override
  String get vaccineEmptyOwner =>
      'Henüz aşı planı yok. \"Plan ekle\" ile başlayın; ardından mevcut durumu girin.';

  @override
  String get vaccineGiven => 'Uygulandı';

  @override
  String get vaccineIntro =>
      'Şap, brusella, parazit gibi tekrarlayan uygulamalar. Sağmal ve kurudaki hayvanlar plana girer; hiç kaydı olmayan hayvanın zamanı gelmiş sayılır. Zamanı gelen hayvanlar için uyarı sunucudan gelir.';

  @override
  String vaccineLastGiven(Object date) {
    return 'son $date';
  }

  @override
  String get vaccineLoadFailed => 'Aşı planları yüklenemedi';

  @override
  String vaccineMarkDate(Object date) {
    return 'Uygulama günü: $date';
  }

  @override
  String get vaccineMarkHelp => 'Uygulama günü';

  @override
  String vaccineMarkSelected(int count) {
    return 'Uygulandı olarak işaretle ($count)';
  }

  @override
  String get vaccineMarkTitle => 'Uygulandı olarak işaretle';

  @override
  String vaccineMarked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hayvan işaretlendi',
    );
    return '$_temp0';
  }

  @override
  String get vaccineMarkedNone =>
      'Yeni kayıt yazılmadı: aynı gün zaten kayıtlı ya da hayvan plana girmiyor.';

  @override
  String get vaccineNever => 'kayıt yok';

  @override
  String vaccineNext(Object date) {
    return 'sonraki $date';
  }

  @override
  String vaccineOverdue(Object date) {
    return 'gecikti · $date';
  }

  @override
  String get vaccinePlanAdd => 'Plan ekle';

  @override
  String vaccinePlanCounts(int animals, int dueSoon, int never) {
    return '$animals hayvan · $dueSoon zamanı yakın · $never kayıt yok';
  }

  @override
  String get vaccinePlanDeleteBody =>
      'Plan ve bütün uygulama kayıtları silinir.';

  @override
  String vaccinePlanDeleteTitle(Object name) {
    return '$name silinsin mi?';
  }

  @override
  String get vaccinePlanEdit => 'Planı düzenle';

  @override
  String vaccinePlanEvery(int days) {
    return '$days günde bir';
  }

  @override
  String get vaccinePlanInterval => 'Tekrar aralığı (gün)';

  @override
  String get vaccinePlanIntervalRange => '7 ile 1095 gün arasında olmalı.';

  @override
  String get vaccinePlanName => 'Ad (ör. Şap)';

  @override
  String get vaccinePlanNameRequired => 'Plan adını girin.';

  @override
  String get vaccinePlanSaved => 'Plan kaydedildi';

  @override
  String get vaccinePlanSpecies => 'Tür';

  @override
  String get vaccineRecent => 'Son uygulamalar';

  @override
  String get vaccineSelectAll => 'Tümünü seç';

  @override
  String get vaccineSelectNone => 'Seçimi kaldır';

  @override
  String get vaccineTitle => 'Aşı takvimi';

  @override
  String get whatsNewItem1 =>
      'Web paneli: bilgisayardan milktrace.com.tr/giris adresinden aynı hesapla girin.';

  @override
  String get whatsNewItem2 =>
      'Sayaç kontrolü: son sağımlarda \"Elle ölçüm\" ile sayacın sapmasını görün.';

  @override
  String get whatsNewItem3 =>
      'Sağım hızı: hayvan detayında ortalama debi ve süre; Hayvanlar\'da \"Yavaş sağılanlar\" süzgeci.';

  @override
  String get whatsNewItem4 =>
      'API anahtarları: yem ve muhasebe programları sürü verisini okuyabilsin (yalnızca sahip).';

  @override
  String get whatsNewItem5 =>
      'Aşı uyarısına dokununca o planın zamanı gelen hayvanları açılır.';

  @override
  String get whatsNewOk => 'Tamam';

  @override
  String get whatsNewTitle => 'Yenilikler';

  @override
  String get widgetAccount => 'Hesap';

  @override
  String get widgetAlerts => 'Uyarılar';

  @override
  String widgetOfflineBanner(Object when) {
    return 'Çevrimdışı · son veri $when. Değişiklikler bağlantı gelince yapılabilir.';
  }

  @override
  String get yieldChartAvg7 => '7 gün ort.';

  @override
  String get yieldChartDaily => 'Günlük';

  @override
  String get yieldChartHeat => 'Isı stresi günü (THI ≥ 72)';

  @override
  String get yieldChartNotEnough => 'Grafik için yeterli geçmiş yok';

  @override
  String yieldReportDescription(Object unit) {
    return 'Hayvan başına günlük verim ($unit), Excel dosyası. Veterinere ya da danışmana gönderebilirsiniz.';
  }

  @override
  String yieldReportFailed(Object error) {
    return 'Rapor alınamadı: $error';
  }

  @override
  String get yieldReportKilogram => 'kilogram';

  @override
  String yieldReportLastDays(Object n) {
    return 'Son $n gün';
  }

  @override
  String get yieldReportLitre => 'litre';

  @override
  String get yieldReportShareSubject => 'Milk Trace verim raporu';

  @override
  String get yieldReportTitle => 'Verim raporu';
}
