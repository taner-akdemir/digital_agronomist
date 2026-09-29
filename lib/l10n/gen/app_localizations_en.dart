// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get accountApiKeys => 'API keys';

  @override
  String get accountAuditLog => 'Activity log';

  @override
  String get accountDefaultName => 'User';

  @override
  String get accountFarmLocation => 'Farm location';

  @override
  String get accountMilkUnit => 'Milk unit';

  @override
  String get accountMilkers => 'Milkers';

  @override
  String get accountMilkingSchedule => 'Milking times';

  @override
  String get accountMockMode => 'You are working with demo data (mock mode).';

  @override
  String get accountNotificationChannels => 'Notification channels';

  @override
  String get accountPickFarm => 'Choose a farm';

  @override
  String get accountPushUnavailable =>
      'Notifications are off on this phone: permission was not granted or the notification service is not connected yet. Alerts still appear in the notification center.';

  @override
  String get accountQuietHours => 'Quiet hours';

  @override
  String get accountSessions => 'Sessions';

  @override
  String get accountSignOut => 'Sign out';

  @override
  String get accountSwitchFarm => 'Switch farm';

  @override
  String accountSwitchFarmFailed(Object error) {
    return 'Could not switch farm: $error';
  }

  @override
  String get accountTestPush => 'Send a test notification to this phone';

  @override
  String accountTestPushFailed(Object error) {
    return 'Could not send the test notification: $error';
  }

  @override
  String get accountTestPushNone =>
      'The test notification did not reach any phone';

  @override
  String get accountTestPushSending => 'Sending…';

  @override
  String accountTestPushSent(Object count) {
    return 'Test notification sent (phones: $count)';
  }

  @override
  String get accountThresholds => 'Threshold settings';

  @override
  String get accountTwoFactor => 'Two-step verification';

  @override
  String get accountTwoFactorOn => 'Two-step verification is on';

  @override
  String get accountUnitKilogram => 'Kilogram';

  @override
  String get accountUnitLitre => 'Litre';

  @override
  String get accountUsers => 'Users';

  @override
  String get alertsAcknowledged => 'read';

  @override
  String alertsBackOnlineAt(Object time) {
    return 'back online $time';
  }

  @override
  String get alertsEmpty => 'No open alerts';

  @override
  String get alertsLoadFailed => 'Could not load alerts';

  @override
  String get alertsMarkRead => 'Mark read';

  @override
  String alertsRecoveredAt(Object time) {
    return 'recovered $time';
  }

  @override
  String get alertsTitle => 'Alerts';

  @override
  String get animalDetailAddNote => 'Add note';

  @override
  String get animalDetailAvg30 => '30-day avg.';

  @override
  String get animalDetailAvg7 => '7-day avg.';

  @override
  String get animalDetailBreed => 'Breed';

  @override
  String get animalDetailCalved => 'Calved';

  @override
  String get animalDetailCalvingAlreadyToday =>
      'A calving is already recorded for today';

  @override
  String get animalDetailCalvingConfirmTitle => 'Record calving?';

  @override
  String get animalDetailCalvingDate => 'Calving date';

  @override
  String animalDetailCalvingLactation(Object current, Object next) {
    return 'Lactation $current → $next';
  }

  @override
  String get animalDetailCalvingSaved => 'Calving recorded';

  @override
  String animalDetailCalvingStatus(Object status) {
    return 'Status $status → Lactating';
  }

  @override
  String get animalDetailDaysInMilk => 'Days in milk';

  @override
  String get animalDetailDisclaimer =>
      'This is a suggestion, not a diagnosis. Pregnancy, lactation stage and illness can lower yield; a vet check is needed.';

  @override
  String animalDetailFreshLactation(Object days) {
    return 'Fresh lactation: the \"declining\" and \"dry-off candidate\" labels are not given in the first $days days; yield is still rising.';
  }

  @override
  String get animalDetailFrozenClassNote =>
      'Animals that are not lactating are not classified; this label is from the last calculation while it was lactating.';

  @override
  String get animalDetailGroup => 'Group';

  @override
  String get animalDetailHistoryFailed => 'Could not load milking history';

  @override
  String get animalDetailLactation => 'Lactation';

  @override
  String get animalDetailLastCalving => 'Last calving';

  @override
  String animalDetailLastClass(Object label) {
    return 'Last class: $label';
  }

  @override
  String get animalDetailLoadFailed => 'Could not load animal details';

  @override
  String animalDetailMoreNotes(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n more notes',
      one: '$n more note',
    );
    return '$_temp0';
  }

  @override
  String get animalDetailNoMilkings => 'No milkings recorded for this animal';

  @override
  String get animalDetailNoNotes =>
      'No notes yet. Vet checks, pregnancy or treatment details help interpret the class label.';

  @override
  String get animalDetailNotRegistered => 'This animal is not registered';

  @override
  String animalDetailNoteAddFailed(Object error) {
    return 'Could not add note: $error';
  }

  @override
  String get animalDetailNoteAdded => 'Note added';

  @override
  String get animalDetailNoteHint =>
      'E.g. Last vet check: mastitis, under treatment.';

  @override
  String get animalDetailNotes => 'Notes';

  @override
  String get animalDetailNotesFailed => 'Could not load notes';

  @override
  String animalDetailOrdinal(Object n) {
    return '$n';
  }

  @override
  String get animalDetailRecentMilkings => 'Recent milkings';

  @override
  String animalDetailShownOfTotal(Object total, Object limit) {
    return 'Showing the first $limit of $total milkings';
  }

  @override
  String animalDetailStaleClass(Object date) {
    return 'Class from the $date calculation: the nightly calculation only refreshes animals milked in the last 30 days.';
  }

  @override
  String get animalDetailTitleFallback => 'Animal';

  @override
  String get animalDetailTrend30 => '30-day trend';

  @override
  String get animalDetailTrendFailed => 'Could not load the trend';

  @override
  String get animalDetailYieldTrend => 'Yield trend';

  @override
  String get animalFormAdded => 'Animal added';

  @override
  String get animalFormAnimalFailed => 'Could not load animal';

  @override
  String get animalFormBirthDate => 'Birth date';

  @override
  String get animalFormBreed => 'Breed (optional)';

  @override
  String animalFormClearDate(Object label) {
    return 'Clear $label';
  }

  @override
  String get animalFormEarTag => 'Ear tag number';

  @override
  String get animalFormEarTagHelper =>
      'Identifies the animal; unique within the farm.';

  @override
  String get animalFormEarTagRequired => 'Ear tag number is required';

  @override
  String get animalFormEditTitle => 'Edit animal';

  @override
  String get animalFormGroup => 'Group';

  @override
  String get animalFormLactationNo => 'Lactation number';

  @override
  String get animalFormLastCalving => 'Last calving';

  @override
  String get animalFormName => 'Name (optional)';

  @override
  String get animalFormNewTitle => 'New animal';

  @override
  String get animalFormNoGroup => 'No group';

  @override
  String get animalFormNotEntered => 'Not entered';

  @override
  String get animalFormNotFound => 'Animal not found';

  @override
  String animalFormPickDate(Object label) {
    return 'Pick $label';
  }

  @override
  String get animalFormRfid => 'RFID (optional)';

  @override
  String get animalFormRfidHelper =>
      'The number of the chip in the ear tag; if the meter reads it, the animal is matched to the milking point automatically.';

  @override
  String get animalFormSaving => 'Saving…';

  @override
  String get animalFormSpecies => 'Species';

  @override
  String get animalFormSpeciesFailed => 'Could not load species';

  @override
  String get animalFormSpeciesRequired => 'Select a species';

  @override
  String get animalFormStatus => 'Status';

  @override
  String get animalFormStatusHelper =>
      'Only lactating animals are matched to milkings and classified.';

  @override
  String get animalFormUpdated => 'Animal updated';

  @override
  String animalImportAddN(Object n) {
    return 'Add animals ($n)';
  }

  @override
  String animalImportAdded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n animals added',
      one: '$n animal added',
    );
    return '$_temp0';
  }

  @override
  String animalImportChange(Object field, Object from, Object to) {
    return '$field: $from → $to';
  }

  @override
  String get animalImportColumns =>
      'Columns (Turkish headers): Küpe No (ear tag, required) · Tür (species) · Adı (name) · Irkı (breed) · RFID · Doğum Tarihi (birth date) · Son Buzağılama (last calving) · Laktasyon (lactation) · Durumu (status) · Grup (group)';

  @override
  String animalImportCountCreate(Object n) {
    return '$n to add';
  }

  @override
  String animalImportCountErrors(Object n) {
    return '$n invalid, will be skipped';
  }

  @override
  String animalImportCountExists(Object n) {
    return '$n already registered';
  }

  @override
  String animalImportCountUnchanged(Object n) {
    return '$n unchanged';
  }

  @override
  String animalImportCountUpdate(Object n) {
    return '$n to update';
  }

  @override
  String get animalImportDefaultSpecies => 'Rows without a species';

  @override
  String animalImportFailed(Object error) {
    return 'Import failed: $error';
  }

  @override
  String get animalImportFieldBirthDate => 'Birth date';

  @override
  String get animalImportFieldBreed => 'Breed';

  @override
  String get animalImportFieldCalvingDate => 'Last calving';

  @override
  String get animalImportFieldGroup => 'Group';

  @override
  String get animalImportFieldLactationNo => 'Lactation';

  @override
  String get animalImportFieldName => 'Name';

  @override
  String get animalImportFieldRfid => 'RFID';

  @override
  String get animalImportFieldStatus => 'Status';

  @override
  String animalImportIgnoredColumns(Object columns) {
    return 'Ignored columns: $columns';
  }

  @override
  String get animalImportIntro =>
      'Upload the list you got from your vet, the breeders\' union or the national animal registry (Excel .xlsx or CSV). The first row must be column headers; dates day first (03.04.2021).';

  @override
  String animalImportNewGroups(Object groups) {
    return 'Groups to create: $groups';
  }

  @override
  String get animalImportNothingToAdd => 'No animals to add';

  @override
  String get animalImportNothingToSave => 'No animals to add or update';

  @override
  String get animalImportPickFile => 'Choose file';

  @override
  String get animalImportPickOtherFile => 'Choose another file';

  @override
  String animalImportReadFailed(Object error) {
    return 'Could not read file: $error';
  }

  @override
  String get animalImportRules =>
      'Animals whose ear tag is already registered are not changed unless updating is turned on. Invalid rows are skipped; it is safe to fix the file and upload it again.';

  @override
  String animalImportSaveN(Object added, Object updated) {
    return 'Add $added · update $updated';
  }

  @override
  String animalImportSaved(Object added, Object updated) {
    return '$added animals added, $updated updated';
  }

  @override
  String get animalImportSectionCreate => 'To add';

  @override
  String get animalImportSectionErrors => 'Invalid rows';

  @override
  String get animalImportSectionExists => 'Already registered (not changed)';

  @override
  String get animalImportSectionUnchanged => 'Unchanged';

  @override
  String get animalImportSectionUpdate => 'To update';

  @override
  String get animalImportSectionWarnings => 'Warnings';

  @override
  String get animalImportSpeciesLoadFailed => 'Could not load species';

  @override
  String get animalImportTitle => 'Import from list';

  @override
  String get animalImportUpdateHint =>
      'Only filled cells in the file are written; an empty cell never clears saved data. Species is not changed.';

  @override
  String get animalImportUpdateSwitch => 'Update registered animals';

  @override
  String get apiKeysCopied => 'Key copied';

  @override
  String get apiKeysCopy => 'Copy';

  @override
  String get apiKeysCreate => 'Create key';

  @override
  String apiKeysCreatedBy(Object who, Object date) {
    return '$who · $date';
  }

  @override
  String get apiKeysCreatedTitle => 'Key created';

  @override
  String get apiKeysDone => 'I saved it';

  @override
  String get apiKeysEmpty => 'No keys yet.';

  @override
  String get apiKeysIntro =>
      'So a feed program, accounting or cooperative system can fetch your data automatically. Keys are READ-ONLY: the animal list, tank deliveries and daily yield can be read; notes, treatments and any writes are closed.';

  @override
  String apiKeysLastUsed(Object when) {
    return 'Last used $when';
  }

  @override
  String get apiKeysNameHelper => 'Which system will use it? E.g. Feed program';

  @override
  String get apiKeysNameLabel => 'Key name';

  @override
  String get apiKeysNeverUsed => 'Never used';

  @override
  String get apiKeysRevoke => 'Revoke';

  @override
  String apiKeysRevokeBody(Object name) {
    return 'The system connected with \"$name\" loses access within 1 minute at most. This cannot be undone.';
  }

  @override
  String get apiKeysRevokeTitle => 'Revoke this key?';

  @override
  String get apiKeysRevoked => 'Key revoked';

  @override
  String get apiKeysShownOnce =>
      'This key will not be shown again. Copy it now into the system that will connect; if you lose it, revoke it and create a new one.';

  @override
  String get apiKeysTitle => 'API keys';

  @override
  String get apiKeysUsage =>
      'Daily yield:\nGET /api/v1/exports/daily?from=YYYY-MM-DD&to=YYYY-MM-DD\nHeader: Authorization: Bearer <key>';

  @override
  String get auditAnimalCalving => 'Calving recorded';

  @override
  String get auditAnimalCreate => 'Animal added';

  @override
  String get auditAnimalImport => 'Import from list';

  @override
  String get auditAnimalUpdate => 'Animal record changed';

  @override
  String get auditApiKeyCreate => 'API key created';

  @override
  String get auditApiKeyRevoke => 'API key revoked';

  @override
  String get auditBreedingAdd => 'Breeding record added';

  @override
  String get auditBreedingDelete => 'Breeding record deleted';

  @override
  String get auditChannelCreate => 'Notification channel added';

  @override
  String get auditChannelDelete => 'Notification channel deleted';

  @override
  String get auditChannelUpdate => 'Notification channel changed';

  @override
  String get auditDeletedUser => 'Deleted user';

  @override
  String get auditDeliveryAdd => 'Tank delivery entered';

  @override
  String get auditDeliveryDelete => 'Tank delivery deleted';

  @override
  String get auditEmpty => 'No recorded changes in the last 90 days.';

  @override
  String get auditIntro =>
      'Last 90 days: changes to thresholds, animal records, matching, users and notification channels.';

  @override
  String get auditLoadFailed => 'Could not load the activity log';

  @override
  String get auditMeterCheck => 'Meter check';

  @override
  String get auditSettingsUpdate => 'Farm setting changed';

  @override
  String get auditSpoutUnassign => 'Matching removed';

  @override
  String get auditTagDismiss => 'Unrecognized ear tag dismissed';

  @override
  String get auditTeamAdd => 'User added';

  @override
  String get auditTeamRemove => 'User removed';

  @override
  String get auditTeamUpdate => 'User changed';

  @override
  String get auditThresholdsUpdate => 'Thresholds changed';

  @override
  String get auditTitle => 'Activity log';

  @override
  String get auditTreatmentAdd => 'Treatment added';

  @override
  String get auditTreatmentDelete => 'Treatment deleted';

  @override
  String get auditVaccinationAdd => 'Vaccination given';

  @override
  String get auditVaccinationDelete => 'Vaccination record deleted';

  @override
  String get auditVaccinePlanCreate => 'Vaccination plan added';

  @override
  String get auditVaccinePlanDelete => 'Vaccination plan deleted';

  @override
  String get auditVaccinePlanUpdate => 'Vaccination plan changed';

  @override
  String get breedingAddRecord => 'Add record';

  @override
  String get breedingAdded => 'Breeding record added';

  @override
  String get breedingDeleteBody =>
      'Only delete a record entered by mistake; status and dates are recalculated.';

  @override
  String get breedingDeleteTitle => 'Delete breeding record?';

  @override
  String get breedingDialogTitle => 'Breeding record';

  @override
  String breedingDryOff(Object date) {
    return 'Suggested dry-off: $date';
  }

  @override
  String get breedingEmpty =>
      'No records. Enter inseminations and pregnancy checks: the expected calving and dry-off dates are calculated.';

  @override
  String breedingExpectedCalving(Object date) {
    return 'Expected calving: $date';
  }

  @override
  String get breedingHeat => 'Heat';

  @override
  String breedingHeatExpected(Object from, Object to) {
    return 'Heat expected: $from – $to';
  }

  @override
  String get breedingHeatExpectedShort => 'Heat expected';

  @override
  String get breedingHeatHint =>
      'Heat observed. If not inseminated, the next is expected on day 18–24; you will be reminded then.';

  @override
  String get breedingInsemination => 'Insemination';

  @override
  String breedingKpiDays(Object days) {
    return '$days days';
  }

  @override
  String get breedingKpiDaysOpen => 'Calving to conception';

  @override
  String get breedingKpiFirstService => 'First-service conception';

  @override
  String get breedingKpiInterval => 'Calving interval';

  @override
  String get breedingKpiNone => '—';

  @override
  String breedingKpiPct(Object pct) {
    return '$pct%';
  }

  @override
  String breedingKpiSample(int count) {
    return '$count records';
  }

  @override
  String get breedingKpiTitle => 'Breeding · last 12 months';

  @override
  String get breedingLoadFailed => 'Could not load breeding records';

  @override
  String get breedingOpen => 'Open';

  @override
  String get breedingPregnancyCheck => 'Pregnancy check';

  @override
  String get breedingPregnant => 'Pregnant';

  @override
  String get breedingSireLabel => 'Bull/buck or semen code (optional)';

  @override
  String get breedingTitle => 'Breeding';

  @override
  String get channelsAdd => 'Add channel';

  @override
  String get channelsAdded => 'Channel added';

  @override
  String channelsCardDailyLimit(Object n) {
    return 'at most $n per day';
  }

  @override
  String channelsCardStatus(Object severity, Object sources) {
    return '$severity and above · $sources';
  }

  @override
  String get channelsChannelLoadFailed => 'Could not load channel';

  @override
  String get channelsConnectionSection => 'Connection settings';

  @override
  String get channelsDailyLimit => 'Daily limit';

  @override
  String channelsDailyLimitHelperDefault(Object n) {
    return 'If left empty, $n. Messages beyond the limit are not sent; the counter resets at midnight.';
  }

  @override
  String get channelsDailyLimitHelperUnlimited =>
      'If left empty, unlimited. Messages beyond the limit are not sent; the counter resets at midnight.';

  @override
  String get channelsDailyLimitRange => 'Must be between 1 and 10000';

  @override
  String get channelsDelete => 'Delete channel';

  @override
  String channelsDeleteBody(Object name) {
    return 'Notifications will no longer be sent to \"$name\". This cannot be undone.';
  }

  @override
  String get channelsDeleteFailed => 'Could not delete';

  @override
  String get channelsDeleteTitle => 'Delete channel?';

  @override
  String get channelsDeleted => 'Channel deleted';

  @override
  String get channelsEditTitle => 'Edit channel';

  @override
  String get channelsEmailAddresses => 'Email addresses';

  @override
  String get channelsEmailHelper => 'One address per line';

  @override
  String get channelsEmptyBody =>
      'Add a channel to also receive alerts by email or SMS.';

  @override
  String get channelsEmptyTitle => 'No channels yet';

  @override
  String get channelsEnabled => 'Channel enabled';

  @override
  String get channelsEscalation => 'Escalation (min)';

  @override
  String get channelsEscalationHelper =>
      'If a critical alert (e.g. meter offline) stays unread this many minutes, it is also sent to this channel. 0: off.';

  @override
  String get channelsEscalationRange => 'Must be between 0 and 240';

  @override
  String get channelsFieldApiKey => 'API key';

  @override
  String get channelsFieldApiSecret => 'API secret';

  @override
  String get channelsFieldApplicationId => 'Application ID';

  @override
  String get channelsFieldBearerToken => 'Bearer token';

  @override
  String get channelsFieldFrom => 'Sender';

  @override
  String get channelsFieldFromName => 'Sender name';

  @override
  String get channelsFieldHost => 'SMTP server';

  @override
  String get channelsFieldLanguage => 'Language';

  @override
  String get channelsFieldPassword => 'Password';

  @override
  String get channelsFieldPrivateKey => 'Private key (PEM)';

  @override
  String get channelsFieldRegion => 'Region';

  @override
  String channelsFieldRequired(Object field) {
    return '$field is required';
  }

  @override
  String get channelsFieldSecret => 'Signing secret';

  @override
  String get channelsFieldSmsHeader => 'SMS sender ID';

  @override
  String get channelsFieldTls => 'Encryption (starttls, tls)';

  @override
  String get channelsFieldUrl => 'URL (https)';

  @override
  String get channelsFieldUserCode => 'User code';

  @override
  String get channelsFieldUsername => 'Username';

  @override
  String get channelsFieldVoice => 'Voice';

  @override
  String get channelsFieldWebhookUrl => 'Webhook URL';

  @override
  String get channelsHintFrom => 'name@example.com';

  @override
  String get channelsHintRegion => 'Can be left empty (eu: EU data residency)';

  @override
  String get channelsHintSecret => 'If given, the request is signed with HMAC';

  @override
  String get channelsHintSmsHeader =>
      'Sender name approved by the provider (at most 11 characters)';

  @override
  String get channelsHintTls => 'starttls if left empty';

  @override
  String get channelsHintUrl =>
      'The notification is POSTed to this URL as JSON';

  @override
  String get channelsHintWebhookUrl =>
      'The incoming webhook URL provided by Slack / Teams';

  @override
  String channelsInvalidEmail(Object value) {
    return 'Invalid email: $value';
  }

  @override
  String channelsInvalidPhone(Object value) {
    return 'Must be in international format (+905…): $value';
  }

  @override
  String get channelsKindEmail => 'Email';

  @override
  String get channelsKindPickerTitle => 'Channel type';

  @override
  String get channelsKindVoiceCall => 'Voice call';

  @override
  String get channelsKindsLoadFailed => 'Could not load channel types';

  @override
  String get channelsLanguage => 'Notification language';

  @override
  String get channelsLanguageHelper =>
      'Alerts, summaries and the weekly email go to this channel in this language.';

  @override
  String get channelsLoadFailed => 'Could not load channels';

  @override
  String get channelsMinSeverity => 'Minimum severity';

  @override
  String get channelsName => 'Channel name';

  @override
  String get channelsNameRequired => 'Channel name is required';

  @override
  String get channelsNewTitle => 'New channel';

  @override
  String get channelsNotFound => 'Channel not found';

  @override
  String get channelsOff => 'Off';

  @override
  String get channelsPhoneHelper =>
      'One number per line, with country code: +905xxxxxxxxx';

  @override
  String get channelsPhoneNumbers => 'Phone numbers';

  @override
  String get channelsPushNote =>
      'Alerts always arrive as phone notifications. The channels here also send them by email, Slack, SMS and similar.';

  @override
  String get channelsRecipientMax => 'At most 50 recipients';

  @override
  String get channelsRecipientRequired => 'At least one recipient is required';

  @override
  String get channelsSaveFailed => 'Could not save';

  @override
  String get channelsSaved => 'Channel saved';

  @override
  String get channelsSaving => 'Saving…';

  @override
  String get channelsSecretSaved =>
      'Saved. Type a new value to change it; if left empty it is kept.';

  @override
  String get channelsSendFailed => 'Could not send';

  @override
  String get channelsSendResolved => 'Also notify when resolved';

  @override
  String get channelsSendTest => 'Send test notification';

  @override
  String get channelsSeverityCritical => 'Critical';

  @override
  String get channelsSeverityInfo => 'Info';

  @override
  String get channelsSeverityWarning => 'Warning';

  @override
  String get channelsSourceHerd => 'Every herd alert';

  @override
  String get channelsSourceHerdHint =>
      'A separate message for each animal with low flow rate (can be noisy)';

  @override
  String get channelsSourceOps => 'System alarms';

  @override
  String get channelsSourceOpsHint =>
      'System problems such as a silent meter box or data loss';

  @override
  String get channelsSourceRequired => 'Select at least one notification type';

  @override
  String get channelsSourceSummary => 'Milking summary';

  @override
  String get channelsSourceSummaryHint =>
      'A single message when milking ends (total milk, animals with low yield and low flow rate)';

  @override
  String get channelsSourceWeekly => 'Weekly summary';

  @override
  String get channelsSourceWeeklyHint =>
      'Monday morning summary of the week: total milk, change from the previous week, declining animals (Excel report attached in email)';

  @override
  String get channelsTestSent => 'Test notification sent';

  @override
  String get channelsTitle => 'Notification channels';

  @override
  String channelsUnsupported(Object kind, Object provider) {
    return 'This channel type is not supported: $kind/$provider';
  }

  @override
  String get channelsWhenSection => 'When to send';

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
  String get coreErrorBadCertificate =>
      'The server certificate could not be verified.';

  @override
  String get coreErrorBadResponse =>
      'The server returned an unexpected response.';

  @override
  String get coreErrorCancelled => 'The request was cancelled.';

  @override
  String get coreErrorConnection =>
      'Can\'t reach the server. Check your connection.';

  @override
  String get coreErrorTimeout =>
      'The server is not responding. Check your connection.';

  @override
  String get coreErrorTransform =>
      'The server\'s response could not be processed.';

  @override
  String get coreErrorUnknown => 'An unexpected error occurred.';

  @override
  String get coreMemberAddedFallback => 'User added.';

  @override
  String get coreResetLinkSentFallback => 'Reset link sent.';

  @override
  String get coreRouteNotFound => 'Page not found';

  @override
  String coreRouteNotFoundBody(Object uri) {
    return 'The page you\'re looking for wasn\'t found:\n$uri';
  }

  @override
  String dashboardActiveSessions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n milkings in progress',
      one: '$n milking in progress',
    );
    return '$_temp0';
  }

  @override
  String get dashboardBySpecies => 'By species';

  @override
  String dashboardGroupMilked(Object milked, Object animals) {
    return '$milked/$animals animals milked';
  }

  @override
  String get dashboardGroupsToday => 'Groups · today';

  @override
  String get dashboardLoadFailed => 'Could not load today\'s summary';

  @override
  String dashboardMilkingsAnimals(Object milkings, Object animals) {
    return '$milkings milkings · $animals animals';
  }

  @override
  String dashboardMoreAlerts(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n more alerts',
      one: '$n more alert',
    );
    return '$_temp0';
  }

  @override
  String get dashboardNoMilkingToday => 'No milking yet today';

  @override
  String get dashboardNoOpenAlerts => 'No open alerts';

  @override
  String get dashboardOpenAlerts => 'Open alerts';

  @override
  String dashboardPerAnimal(Object amount) {
    return 'per animal $amount';
  }

  @override
  String dashboardSpeciesAnimals(Object species, Object n) {
    return '$species · $n animals';
  }

  @override
  String get dashboardSpeciesFallback => 'Species';

  @override
  String get dashboardTodayMilk => 'Milk collected today';

  @override
  String dashboardYieldClasses(Object n) {
    return 'Yield classes · $n animals';
  }

  @override
  String get deleteAccountBody =>
      'Your account and sessions are deleted permanently; this cannot be undone. The farm\'s milking and animal records stay with the farm, and your notes appear as \"Deleted user\". If you are the only owner of a farm, contact support first.';

  @override
  String get deleteAccountConfirm => 'Delete permanently';

  @override
  String get deleteAccountPassword => 'Your password';

  @override
  String get deleteAccountPasswordRequired => 'Enter your password to confirm.';

  @override
  String get deleteAccountTitle => 'Delete my account';

  @override
  String deliveriesAmountLabel(Object unit) {
    return 'Delivered ($unit)';
  }

  @override
  String get deliveriesCardHint =>
      'Enter the tanker slip: it is compared with what the meters measured, and you get an alert if the difference is large.';

  @override
  String deliveriesDay(Object date) {
    return 'Day: $date';
  }

  @override
  String deliveriesDeleteBody(Object date, Object amount) {
    return '$date · $amount\nOnly delete a wrongly entered record; then enter the correct one again.';
  }

  @override
  String get deliveriesDeleteTitle => 'Delete delivery?';

  @override
  String deliveriesDiffOver(Object pct) {
    return '+$pct% · meters over';
  }

  @override
  String deliveriesDiffUnder(Object pct) {
    return '−$pct% · meters under';
  }

  @override
  String get deliveriesEmpty =>
      'No deliveries recorded yet. The first delivery is not compared; the difference is calculated from the second delivery on.';

  @override
  String get deliveriesEnter => 'Record delivery';

  @override
  String get deliveriesEnterAmount => 'Enter the amount on the tanker slip.';

  @override
  String deliveriesExplainer(Object pct) {
    return 'The tanker slip is compared with what the meters measured since the previous delivery (excluding withheld milk). Alert if the difference is above $pct%.';
  }

  @override
  String get deliveriesLoadFailed => 'Could not load deliveries';

  @override
  String deliveriesMetered(
    Object span,
    Object date,
    Object amount,
    Object withheld,
  ) {
    return 'Meters $span$date: $amount$withheld';
  }

  @override
  String get deliveriesNotCompared =>
      'Not compared (no previous delivery or meter data)';

  @override
  String get deliveriesSaved => 'Delivery saved';

  @override
  String deliveriesSavedMismatch(Object diff) {
    return 'Delivery saved — differs from the meters: $diff';
  }

  @override
  String get deliveriesTankDelivery => 'Tank delivery';

  @override
  String deliveriesTankerLine(Object date, Object amount) {
    return '$date · tanker $amount';
  }

  @override
  String get deliveriesTitle => 'Tank deliveries';

  @override
  String get deliveriesToleranceHelper =>
      'Alert if the meters and the tanker differ by more than this.';

  @override
  String get deliveriesToleranceLabel => 'Difference for alert (%)';

  @override
  String get deliveriesToleranceTitle => 'Difference threshold';

  @override
  String deliveriesWithheld(Object amount) {
    return ' (excluding $amount withheld milk)';
  }

  @override
  String get devicesCalibrationNoRecord =>
      'No record (entered by the installation team)';

  @override
  String devicesCalibrationOverdue(Object date) {
    return '$date — due now, call the installation team';
  }

  @override
  String get devicesDetailCalibratedAt => 'Last calibration';

  @override
  String get devicesDetailCalibration => 'Calibration factor';

  @override
  String get devicesDetailCalibrationDue => 'Next calibration';

  @override
  String get devicesDetailFirmware => 'Firmware version';

  @override
  String get devicesDetailLastError => 'Last error';

  @override
  String get devicesDetailLastSeen => 'Last seen';

  @override
  String get devicesDetailProfile => 'Profile';

  @override
  String get devicesDetailProtocol => 'Protocol';

  @override
  String devicesEmptySpoutsCount(Object n) {
    return '$n Points without meter';
  }

  @override
  String devicesErrorShort(Object code, Object since) {
    return 'Error $code · $since';
  }

  @override
  String devicesFirmwareShort(Object version) {
    return 'Firmware $version';
  }

  @override
  String get devicesHallNoVacuums => 'No milking units defined in this area';

  @override
  String devicesHallTitle(Object name) {
    return 'Milking area $name';
  }

  @override
  String get devicesLoadFailed => 'Could not load devices';

  @override
  String get devicesNoProfile => 'No profile';

  @override
  String get devicesNoRecord => 'No record';

  @override
  String devicesOfflineCount(Object n) {
    return '$n Offline';
  }

  @override
  String devicesOnlineCount(Object n) {
    return '$n Online';
  }

  @override
  String get devicesProfileUnassigned => 'Unassigned (quarantined)';

  @override
  String get devicesSimulated => 'Simulator device';

  @override
  String get devicesSourcesLabel => 'Sources:';

  @override
  String devicesSpoutLabel(Object no) {
    return 'Point $no';
  }

  @override
  String get devicesStatusCalibrationDue => 'Calibration due';

  @override
  String get devicesStatusNoMeter => 'No meter installed';

  @override
  String get devicesStatusOffline => 'Offline';

  @override
  String get devicesStatusOnline => 'Online';

  @override
  String get devicesStatusReportedError => 'Reported an error';

  @override
  String get devicesUnassignedHint => 'Not attached to a milking point.';

  @override
  String get devicesUnassignedTitle => 'Meters not installed';

  @override
  String get devicesUnknown => 'Unknown';

  @override
  String devicesUnprofiledCount(Object n) {
    return '$n Meters without profile';
  }

  @override
  String devicesVacuumAllOnline(Object points) {
    return '$points points · all online';
  }

  @override
  String devicesVacuumProblems(Object points, Object problems) {
    return '$points points · $problems need attention';
  }

  @override
  String devicesVacuumTitle(Object name) {
    return 'Milking unit $name';
  }

  @override
  String get domainClassDeclining => 'Declining';

  @override
  String get domainClassDecliningExplanation =>
      'Yield has dropped noticeably over the last 30 days. Pregnancy, lactation stage or illness may be the cause; it is on the watch list.';

  @override
  String get domainClassDryOffCandidate => 'Dry-off candidate';

  @override
  String get domainClassDryOffCandidateExplanation =>
      'The 7-day average is below the species\' lower threshold. It may be time for dry-off.';

  @override
  String get domainClassHigh => 'High yield';

  @override
  String get domainClassHighExplanation =>
      'The 7-day average is above the species\' upper threshold. This animal is among the highest-yielding in the herd.';

  @override
  String get domainClassNoMilk => 'No milk';

  @override
  String get domainClassNoMilkExplanation =>
      'No milk was obtained in recent milkings. Needs assessment.';

  @override
  String get domainClassNormal => 'Normal';

  @override
  String get domainClassNormalExplanation =>
      'Yield is in the expected range and the trend is stable.';

  @override
  String get exitReasonAccident => 'Accident';

  @override
  String get exitReasonAge => 'Old age';

  @override
  String get exitReasonDisease => 'Disease';

  @override
  String get exitReasonFeet => 'Feet/hooves';

  @override
  String get exitReasonFertility => 'Fertility problem';

  @override
  String get exitReasonLabel => 'Exit reason';

  @override
  String get exitReasonLowYield => 'Low yield';

  @override
  String get exitReasonMastitis => 'Mastitis';

  @override
  String get exitReasonOther => 'Other';

  @override
  String get exitReasonRequired => 'Select the exit reason';

  @override
  String get exitReasonUnknown => 'Not given';

  @override
  String exitsTitle(int count) {
    return 'Herd exits · last 12 months ($count)';
  }

  @override
  String get farmLocationClear => 'Remove location';

  @override
  String get farmLocationCoordinates => 'Coordinate (latitude, longitude)';

  @override
  String get farmLocationIntro =>
      'The heat stress alert uses the weather forecast for the farm\'s location. Long-press the farm in Google Maps and paste the coordinate shown at the top (39.9208, 32.8541) here. The server sends only this coordinate to the weather service.';

  @override
  String get farmLocationInvalid =>
      'Enter as latitude, longitude (e.g. 39.9208, 32.8541)';

  @override
  String get farmLocationSaved => 'Farm location saved';

  @override
  String get farmLocationTitle => 'Farm location';

  @override
  String farmsAlerts(int count) {
    return '$count unread alerts';
  }

  @override
  String get farmsCurrent => 'You are in this farm now';

  @override
  String get farmsIntro =>
      'Today\'s summary for every farm you belong to. Tap to switch to it.';

  @override
  String farmsLine(Object amount, int animals) {
    return 'Today $amount · $animals animals';
  }

  @override
  String get farmsLoadFailed => 'Farms could not be loaded';

  @override
  String get farmsTitle => 'My farms';

  @override
  String farmsVaccines(int count) {
    return '$count vaccinations due';
  }

  @override
  String get feedbackAddScreenshot => 'Add screenshot';

  @override
  String get feedbackIntro =>
      'Describe a problem, suggestion or request. The app version and phone model are added automatically.';

  @override
  String get feedbackMessageHint =>
      'What happened, on which screen? What did you expect?';

  @override
  String get feedbackMessageLabel => 'Your message';

  @override
  String get feedbackMessageRequired => 'Please write a message.';

  @override
  String get feedbackRemoveScreenshot => 'Remove image';

  @override
  String get feedbackScreenshotTooLarge => 'The image can be at most 2 MB.';

  @override
  String get feedbackScreenshotType => 'Choose a PNG, JPEG or WebP image.';

  @override
  String get feedbackSend => 'Send';

  @override
  String feedbackSendFailed(Object error) {
    return 'Could not send: $error';
  }

  @override
  String get feedbackSent => 'Your feedback has been received, thank you.';

  @override
  String get feedbackTitle => 'Feedback';

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
  String get groupsAdd => 'Add group';

  @override
  String get groupsDeleteBody =>
      'Animals in the group are not deleted; they are left with no group.';

  @override
  String groupsDeleteTitle(Object name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get groupsDeleteTooltip => 'Delete group';

  @override
  String get groupsEmpty => 'No groups yet.';

  @override
  String get groupsIntro =>
      'Each animal belongs to at most one group; an animal is assigned to a group from the edit form. The dashboard shows each group\'s daily total.';

  @override
  String get groupsLoadFailed => 'Could not load groups';

  @override
  String groupsMilkingCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n lactating animals',
      one: '$n lactating animal',
    );
    return '$_temp0';
  }

  @override
  String get groupsNameLabel => 'Name (e.g. Paddock 1, High yield)';

  @override
  String get groupsNew => 'New group';

  @override
  String get groupsRenameTitle => 'Group name';

  @override
  String get groupsTitle => 'Groups';

  @override
  String get historyAddAnimal => 'Add animal';

  @override
  String historyAnimalCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count animals',
      one: '$count animal',
    );
    return '$_temp0';
  }

  @override
  String get historyAnimalsLoadFailed => 'Could not load animals';

  @override
  String get historyFilterGroup => 'Group';

  @override
  String get historyFilterSlow => 'Slow milkers';

  @override
  String get historyFilterSpecies => 'Species';

  @override
  String get historyFromList => 'From list';

  @override
  String get historyGroups => 'Groups';

  @override
  String historyLactationNo(Object n) {
    return 'lactation $n';
  }

  @override
  String get historyNoAnimalsForFilter => 'No animals match this filter';

  @override
  String get historyNoSessions => 'No recorded milking sessions';

  @override
  String get historyReport => 'Report';

  @override
  String get historySessionAutoStarted => 'auto-started';

  @override
  String get historySessionRunning => 'In progress';

  @override
  String get historySessionStartUnknown => 'Start time unknown';

  @override
  String historySessionTitle(Object hall, Object type) {
    return 'Area $hall · $type milking';
  }

  @override
  String get historySessionsLoadFailed => 'Could not load sessions';

  @override
  String historySpoutLabel(Object vacuum, Object n) {
    return '$vacuum · Milking point $n';
  }

  @override
  String get historyTabAnimals => 'Animals';

  @override
  String get historyTabSessions => 'Sessions';

  @override
  String get historyUnknownVacuum => 'Unit';

  @override
  String historyUnmatchedBanner(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n unknown tags',
      one: '$n unknown tag',
    );
    return '$_temp0';
  }

  @override
  String get historyUnmatchedBannerHint =>
      'Read during milking; assign to an animal';

  @override
  String get historyVaccines => 'Vaccines';

  @override
  String get kioskExitBody =>
      'Signing back in requires the tablet account\'s email and password.';

  @override
  String get kioskExitTitle => 'Sign out of the tablet?';

  @override
  String get kioskSignOut => 'Sign out';

  @override
  String get kioskTitle => 'Milk Trace · Milking parlor';

  @override
  String lactationActual(Object amount, int days) {
    return 'Measured: $amount (day $days)';
  }

  @override
  String lactationComplete(Object amount) {
    return '305 days completed: $amount';
  }

  @override
  String get lactationHint =>
      'Projected from the animal\'s own curve (Wood); unmeasured days count as zero.';

  @override
  String get lactationNoProjection =>
      'A projection needs at least 30 days of data and a lactating animal.';

  @override
  String lactationProjected(Object amount) {
    return '305-day projection: $amount';
  }

  @override
  String get lactationTitle => 'This lactation · 305 days';

  @override
  String get languageAuto => 'Device language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get lineageDam => 'Dam';

  @override
  String get lineageNoDam => 'No dam recorded';

  @override
  String get lineageOffspring => 'Offspring';

  @override
  String get lineageRegisterCalf => 'Register the calf';

  @override
  String get lineageSire => 'Sire (bull/semen code)';

  @override
  String get lineageSireHelper => 'Same format as the insemination record';

  @override
  String get lineageSireTooLong => 'At most 60 characters';

  @override
  String liveActionFailed(Object error) {
    return 'Couldn\'t complete the action: $error';
  }

  @override
  String liveActiveCount(Object n) {
    return '$n Active';
  }

  @override
  String get liveClearBodyEmpty => 'This milking will be deleted.';

  @override
  String liveClearBodyMeasured(Object amount) {
    return 'The measurement from this milking ($amount) will be deleted and not credited to any animal.';
  }

  @override
  String get liveClearConfirm => 'Remove';

  @override
  String get liveClearTitle => 'Remove assignment?';

  @override
  String get liveDataFailed => 'Couldn\'t get live data';

  @override
  String get liveEndConfirm => 'End';

  @override
  String get liveEndDialogBody =>
      'Open animal milkings will be closed and session summaries calculated. This cannot be undone.';

  @override
  String get liveEndDialogTitle => 'End milking';

  @override
  String get liveEndMilking => 'End Milking';

  @override
  String get liveFlowRate => 'Flow rate';

  @override
  String get liveFlowUnit => 'L/min';

  @override
  String liveHallName(Object name) {
    return 'Area $name';
  }

  @override
  String get liveHallsLoadFailed => 'Couldn\'t load milking areas';

  @override
  String get liveLowFlow => 'Low Flow';

  @override
  String get liveNoHalls => 'No milking areas defined';

  @override
  String get liveNoOpenSession =>
      'No open milking in this area.\nUse the button above to start one.';

  @override
  String get liveNoSpouts => 'No milking points found in this area';

  @override
  String get liveNoTarget => 'No target';

  @override
  String get liveNotAssigned => 'No animal assigned';

  @override
  String get liveNow => 'Now';

  @override
  String livePassiveCount(Object n) {
    return '$n Idle';
  }

  @override
  String get livePickerClear => 'Remove assignment';

  @override
  String livePickerClearHint(Object animal) {
    return 'If $animal was assigned by mistake';
  }

  @override
  String get livePickerElsewhere => 'at another point';

  @override
  String get livePickerLoadFailed => 'Couldn\'t load animals';

  @override
  String get livePickerNoMatch => 'No matching animals';

  @override
  String livePickerNotMilking(Object message) {
    return '$message: not in the list. If it came in by mistake, remove the cluster; to milk it, change the animal\'s status first.';
  }

  @override
  String get livePickerPrevHere => 'at this point in the previous milking';

  @override
  String get livePickerPrevMilked => 'milked in the previous milking';

  @override
  String get livePickerSearchHint => 'Ear tag, name or RFID';

  @override
  String livePickerTitle(Object spout) {
    return '$spout · choose animal';
  }

  @override
  String livePickerUnknownTag(Object message) {
    return '$message. Choose the animal below.';
  }

  @override
  String livePickerWithhold(Object date) {
    return 'Withhold milk\n$date';
  }

  @override
  String get liveRedAlertOff => 'Turn off red alert';

  @override
  String get liveRedAlertOn => 'Turn on red alert';

  @override
  String liveReplaceBody(Object who, Object amount) {
    return '$amount was measured at this point for $who.\n\nIf it was milked, the measurement is credited to it. If the assignment was wrong, the measurement is deleted.';
  }

  @override
  String get liveReplaceMilked => 'Milked';

  @override
  String get liveReplaceMistaken => 'Wrong assignment';

  @override
  String get liveReplaceTitle => 'Was the previous animal milked?';

  @override
  String get liveSessionTypeTitle => 'Milking type';

  @override
  String get liveSpout => 'Point';

  @override
  String liveSpoutTitle(Object unit, Object no) {
    return '$unit · Point $no';
  }

  @override
  String get liveStartMilking => 'Start Milking';

  @override
  String get liveTarget => 'Target';

  @override
  String get liveTitle => 'Live data';

  @override
  String get liveUnitFallback => 'Unit';

  @override
  String get liveUnknownTag => 'Unknown tag';

  @override
  String liveWithholdUntil(Object date) {
    return 'Withhold milk · withdrawal $date';
  }

  @override
  String get loginEmailInvalid => 'Enter a valid email.';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailRequired => 'Enter your email.';

  @override
  String get loginForgotPassword => 'Forgot password';

  @override
  String get loginHidePassword => 'Hide password';

  @override
  String get loginMfaCode => 'Verification code';

  @override
  String get loginMfaCodeRequired => 'Enter the code.';

  @override
  String get loginMfaHint =>
      'Enter the 6-digit code from your authenticator app or a backup code.';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordRequired => 'Enter your password.';

  @override
  String get loginResetIntro =>
      'We will send a link to set a new password to your email address.';

  @override
  String get loginResetSend => 'Send link';

  @override
  String get loginShowPassword => 'Show password';

  @override
  String get loginSubmit => 'Sign in';

  @override
  String get loginTagline => 'Milking tracking for your farm';

  @override
  String meterCheckAmountLabel(Object unit) {
    return 'Measured milk ($unit)';
  }

  @override
  String get meterCheckCalibrate =>
      'The deviation persists: ask the installation team for calibration.';

  @override
  String get meterCheckEnterAmount => 'Enter the measured amount';

  @override
  String meterCheckIntro(Object when, Object metered) {
    return '$when · the meter read $metered. Weigh or measure this milking\'s milk; it is compared with the meter, the factor is not changed.';
  }

  @override
  String meterCheckResult(Object dev, Object n, Object avg) {
    return 'Meter $dev% · average of last $n checks $avg%';
  }

  @override
  String meterCheckRow(Object date, Object tag, Object metered, Object manual) {
    return '$date · $tag · meter $metered / manual $manual';
  }

  @override
  String meterCheckRowPct(Object pct) {
    return '$pct%';
  }

  @override
  String get meterCheckTapHint =>
      'To check a meter, tap a milking and enter the weighed milk.';

  @override
  String get meterCheckTitle => 'Manual measurement';

  @override
  String meterDriftShort(Object pct) {
    return 'Check deviation $pct%';
  }

  @override
  String get meterSectionCalibrate =>
      'Average deviation exceeds 5%: ask the installation team for calibration.';

  @override
  String get meterSectionEmpty =>
      'No manual measurements yet. They are entered from the recent milkings on the animal page.';

  @override
  String get meterSectionFew =>
      'At least 3 checks are needed for a calibration decision.';

  @override
  String meterSectionSummary(Object n, Object avg) {
    return 'Average of last $n checks $avg%';
  }

  @override
  String get meterSectionTitle => 'Meter check';

  @override
  String milkersDurationMinutesSeconds(Object m, Object s) {
    return '$m min $s s';
  }

  @override
  String milkersDurationSeconds(Object s) {
    return '$s s';
  }

  @override
  String get milkersEmpty => 'No milkings in this period.';

  @override
  String get milkersLast30Days => 'Last 30 days';

  @override
  String get milkersLast7Days => 'Last 7 days';

  @override
  String get milkersLoadFailed => 'Could not load the milker summary';

  @override
  String get milkersNote =>
      'The milker is the person who opened the session or matched the animal to the milking point. Low flow usually comes from the animal or the cluster; the rate shows where to look, it does not score the person.';

  @override
  String milkersStats(Object duration, Object pct) {
    return 'Average milking $duration · low flow $pct%';
  }

  @override
  String milkersSummary(Object sessions, Object milkings, Object volume) {
    return '$sessions sessions · $milkings milkings · $volume';
  }

  @override
  String get milkersTitle => 'Milkers';

  @override
  String get milkersUnknown => 'Unknown milker';

  @override
  String get milkersUnknownHint =>
      'Milkings opened via RFID or whose matcher was deleted';

  @override
  String get modelAnimalStatusActive => 'Lactating';

  @override
  String get modelAnimalStatusDead => 'Dead';

  @override
  String get modelAnimalStatusDry => 'Dry';

  @override
  String get modelAnimalStatusSlaughtered => 'Slaughtered';

  @override
  String get modelAnimalStatusSold => 'Sold';

  @override
  String get modelBreedingInsemination => 'Insemination';

  @override
  String modelBreedingPregnancyCheck(Object result) {
    return 'Pregnancy check · $result';
  }

  @override
  String get modelBreedingResultOpen => 'open';

  @override
  String get modelBreedingResultPregnant => 'pregnant';

  @override
  String get modelPregnancyInseminated => 'Inseminated · awaiting check';

  @override
  String get modelPregnancyOpen => 'Open';

  @override
  String get modelPregnancyPregnant => 'Pregnant';

  @override
  String get modelProfileUndefined => 'No profile';

  @override
  String get modelProtocolUnknown => 'Unknown';

  @override
  String get modelUpcomingCalving => 'Expected calving';

  @override
  String get modelUpcomingDryOff => 'Dry off';

  @override
  String get pushChannelDescription => 'Low flow, low yield and device alerts.';

  @override
  String get pushChannelName => 'Milking alerts';

  @override
  String get pushQuietChannelDescription =>
      'Non-critical alerts during quiet hours; no sound.';

  @override
  String get pushQuietChannelName => 'Alerts during quiet hours';

  @override
  String get qualityBacteria => 'Bacteria (thousand/mL)';

  @override
  String get qualityFat => 'Fat (%)';

  @override
  String qualityHighScc(int limit) {
    return 'Somatic cell count above the limit ($limit thousand/mL)';
  }

  @override
  String get qualityInvalid => 'Enter a valid number';

  @override
  String get qualityOptional => 'Optional; enter if it is on the receipt.';

  @override
  String get qualityProtein => 'Protein (%)';

  @override
  String get qualityScc => 'Somatic cells (thousand/mL)';

  @override
  String get qualitySccLimit => 'Somatic cell limit (thousand/mL)';

  @override
  String get qualitySccLimitHelper =>
      'An alert is sent above this. A common limit is 400.';

  @override
  String get qualitySccLimitRange => 'Must be between 50 and 2000';

  @override
  String qualitySummary(
    Object fat,
    Object protein,
    Object scc,
    Object bacteria,
  ) {
    return 'Fat $fat% · Protein $protein% · Cells $scc · Bacteria $bacteria';
  }

  @override
  String get qualityTitle => 'Dairy analysis';

  @override
  String get qualityTrendEmpty =>
      'At least two analyses are needed for the chart.';

  @override
  String get qualityTrendTitle => 'Last 90 days';

  @override
  String get quietEnabled => 'Quiet hours on';

  @override
  String get quietEnd => 'End';

  @override
  String get quietIntro =>
      'During these hours alerts don\'t make your phone ring; the notification still arrives and stays in the alert list. Critical alerts (e.g. meter offline) always ring. This setting is only for you.';

  @override
  String get quietSameTime => 'Start and end cannot be the same.';

  @override
  String get quietSaved => 'Quiet hours saved';

  @override
  String get quietStart => 'Start';

  @override
  String get quietTitle => 'Quiet hours';

  @override
  String get roleOperator => 'Operator';

  @override
  String get roleOperatorHint =>
      'Runs milking: opens sessions, matches animals.';

  @override
  String get roleOwner => 'Owner';

  @override
  String get rolePlatformAdmin => 'Platform administrator';

  @override
  String get roleViewer => 'Viewer';

  @override
  String get roleViewerHint =>
      'Vet, consultant: views and writes notes, cannot change anything.';

  @override
  String get scheduleChangeTime => 'Change time';

  @override
  String get scheduleEvening => 'Evening milking';

  @override
  String get scheduleGrace => 'Grace period';

  @override
  String scheduleGraceMinutes(Object n) {
    return '$n min';
  }

  @override
  String get scheduleIntro =>
      'If a milking area has no session this long after the set time, an alert is sent (areas used in the last two weeks). No alert if a meter opened the session automatically.';

  @override
  String get scheduleMorning => 'Morning milking';

  @override
  String get scheduleOff => 'Off';

  @override
  String get scheduleSaved => 'Milking times saved';

  @override
  String get scheduleTitle => 'Milking times';

  @override
  String get sessionSummaryLoadFailed => 'Could not load the session summary';

  @override
  String sessionSummaryLowFlow(Object n) {
    return 'Low flow rate: $n';
  }

  @override
  String sessionSummaryLowYield(Object n) {
    return 'Low yield: $n';
  }

  @override
  String get sessionSummaryNoneNotMilked =>
      'All lactating animals were milked.';

  @override
  String sessionSummaryNotMilked(Object n) {
    return 'Lactating, not milked: $n';
  }

  @override
  String get sessionSummaryTitle => 'Session summary';

  @override
  String sessionSummaryTotals(int n, Object amount) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n animals milked',
      one: '$n animal milked',
    );
    return '$_temp0 · $amount';
  }

  @override
  String get sessionsApp => 'Milk Trace app';

  @override
  String get sessionsAppAndroid => 'Milk Trace · Android';

  @override
  String get sessionsAppIos => 'Milk Trace · iPhone';

  @override
  String get sessionsBrowser => 'Browser (panel)';

  @override
  String get sessionsIntro =>
      'Devices where your account is signed in. Close a device you don\'t recognise or have lost; it is signed out within 15 minutes.';

  @override
  String sessionsLastUsed(Object when) {
    return 'last used $when';
  }

  @override
  String get sessionsSignOut => 'Close this session';

  @override
  String get sessionsSignOutOthers => 'Sign out of all other devices';

  @override
  String get sessionsThisDevice => 'this device';

  @override
  String get sessionsTitle => 'Sessions';

  @override
  String get setupAnimals => 'Add animals or import them from a list';

  @override
  String get setupChannel => 'Add an e-mail or SMS notification channel';

  @override
  String get setupDismiss => 'Close the list';

  @override
  String get setupLocation => 'Enter the farm location for heat stress alerts';

  @override
  String get setupSchedule => 'Enter the milking times';

  @override
  String get setupTeam => 'Add milkers and the vet as users';

  @override
  String setupTitle(int done, int total) {
    return 'Get started ($done/$total)';
  }

  @override
  String get shellTabDashboard => 'Dashboard';

  @override
  String get shellTabDevices => 'Devices';

  @override
  String get shellTabHistory => 'History';

  @override
  String get shellTabLive => 'Live';

  @override
  String get speciesCow => 'Cow';

  @override
  String get speciesGoat => 'Goat';

  @override
  String get speciesSheep => 'Sheep';

  @override
  String get speedAvgFlow => 'Average flow';

  @override
  String get speedDuration => 'Average duration';

  @override
  String speedFlowValue(Object v) {
    return '$v L/min';
  }

  @override
  String speedHerd(Object v, Object n) {
    return 'Herd average $v L/min · $n milkings';
  }

  @override
  String get speedPeakFlow => 'Peak flow';

  @override
  String speedSlow(Object pct) {
    return 'Slow milker: $pct% below the herd average. Keeps the unit busy longer; consider it in the milking order.';
  }

  @override
  String get speedTitle => 'Milking speed · last 30 days';

  @override
  String spoutLowFlowDetail(Object pct, Object avg, Object unit) {
    return 'Over the last 7 days this point read $pct% lower flow than the unit\'s other points (avg $avg L/min, unit $unit L/min). Check the cluster, pulsator and milk hose.';
  }

  @override
  String spoutLowFlowShort(Object pct) {
    return 'Low flow · $pct%';
  }

  @override
  String get supportCall => 'Call';

  @override
  String supportOpenFailed(Object target) {
    return 'Couldn\'t open: $target';
  }

  @override
  String get supportTitle => 'Support';

  @override
  String get supportWhatsAppText => 'Hello, I need support with Milk Trace.';

  @override
  String supportWhatsAppVersion(Object version) {
    return ' (App $version)';
  }

  @override
  String get teamAccessExpired => 'access expired';

  @override
  String get teamAccessPickDate => 'Pick a date';

  @override
  String get teamAccessTitle => 'Access ends';

  @override
  String get teamAccessUnlimited => 'No end date';

  @override
  String teamAccessUntil(Object date) {
    return 'access until $date';
  }

  @override
  String teamActionFailed(Object error) {
    return 'Action failed: $error';
  }

  @override
  String get teamActivate => 'Activate';

  @override
  String get teamActivateHint => 'Can sign in again.';

  @override
  String teamAddFailed(Object error) {
    return 'Could not add: $error';
  }

  @override
  String get teamAddUser => 'Add user';

  @override
  String teamDeleteBody(Object name) {
    return '$name will be permanently deleted; this cannot be undone. Animal notes they wrote remain, with the author shown as \"Deleted user\".\n\nTo only revoke access, use \"Suspend\".';
  }

  @override
  String get teamDeleteTitle => 'Delete user';

  @override
  String get teamEmailInvalid => 'Enter a valid email.';

  @override
  String get teamEmailLabel => 'Email';

  @override
  String get teamFullNameLabel => 'Full name';

  @override
  String get teamFullNameRequired => 'Enter a full name.';

  @override
  String get teamKiosk => 'Milking parlor tablet';

  @override
  String get teamKioskHint =>
      'For the shared tablet in the milking parlor: only live milking opens and the screen stays on. Sign in on the tablet with this email and password.';

  @override
  String get teamLoadFailed => 'Could not load users';

  @override
  String teamMakeRole(Object role) {
    return 'Make $role';
  }

  @override
  String get teamNote =>
      'The operator runs milking; the viewer (vet, consultant) views and writes notes. To add a farm owner, contact Milk Trace support.';

  @override
  String get teamPasswordTooShort => 'At least 8 characters.';

  @override
  String get teamSuspend => 'Suspend';

  @override
  String get teamSuspendHint =>
      'Cannot sign in; any open login ends within 15 minutes.';

  @override
  String get teamSuspended => 'Suspended';

  @override
  String get teamTabletPassword => 'Tablet password';

  @override
  String get teamTabletPasswordHelper =>
      'Used to sign in on the tablet; at least 8 characters.';

  @override
  String get teamTabletPasswordRequired => 'Enter a password for the tablet.';

  @override
  String get teamTempPassword => 'Temporary password (optional)';

  @override
  String get teamTempPasswordHelper =>
      'If left empty, an invitation is sent by email.';

  @override
  String get teamTitle => 'Users';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeLight => 'Light';

  @override
  String get themeSystem => 'Device';

  @override
  String get themeTitle => 'Theme';

  @override
  String get thresholdsAlertHold => 'Alert delay';

  @override
  String get thresholdsCalibrationNote =>
      'The defaults are estimated starting values. They vary greatly by breed, lactation stage and farm; they should be calibrated with field data and the advice of an agricultural engineer or veterinarian.';

  @override
  String get thresholdsClassGroupHint =>
      'If the 7-day average is below the lower threshold the animal is a dry-off candidate; above the upper threshold it is high-yielding (§6.4).';

  @override
  String get thresholdsClassGroupTitle => 'Classification thresholds';

  @override
  String get thresholdsConductivity => 'Conductivity rise';

  @override
  String get thresholdsDecline => 'Decline threshold';

  @override
  String get thresholdsDensity => 'Density';

  @override
  String get thresholdsDensityGroupHint =>
      'If the farm shows amounts in kilograms, litres are converted with this factor (1 L of cow milk ≈ 1.03 kg). Thresholds are still entered in litres.';

  @override
  String get thresholdsDensityGroupTitle => 'Milk density';

  @override
  String get thresholdsDryOff => 'Dry-off lower threshold';

  @override
  String get thresholdsEndFlow => 'End flow rate';

  @override
  String get thresholdsEndGrace => 'Wait';

  @override
  String get thresholdsEndGroupHint =>
      'If the flow rate stays below this value for this long, the animal\'s milking ends (§6.1).';

  @override
  String get thresholdsEndGroupTitle => 'Milking end';

  @override
  String get thresholdsErrorAboveDryOff =>
      'Must be greater than the dry-off threshold';

  @override
  String get thresholdsErrorAboveLower =>
      'Must be greater than the lower threshold';

  @override
  String get thresholdsErrorAboveNoMilk =>
      'Must be greater than the empty milking limit';

  @override
  String get thresholdsErrorAboveRed =>
      'Must be greater than the red threshold';

  @override
  String get thresholdsErrorBelowExpected =>
      'Must be less than the expected amount per milking';

  @override
  String get thresholdsErrorBelowGreen =>
      'Must be less than the green threshold';

  @override
  String get thresholdsErrorBelowHighYield =>
      'Must be less than the high yield threshold';

  @override
  String get thresholdsErrorBelowUpper =>
      'Must be less than the upper threshold';

  @override
  String get thresholdsErrorConductivityRange => 'Must be between 5 and 100';

  @override
  String get thresholdsErrorDensityRange => 'Must be between 0.90 and 1.20';

  @override
  String get thresholdsErrorInteger => 'Enter a whole number';

  @override
  String thresholdsErrorMax(Object max) {
    return 'Can be at most $max';
  }

  @override
  String get thresholdsErrorNegative => 'Cannot be negative';

  @override
  String get thresholdsErrorNumber => 'Enter a number';

  @override
  String get thresholdsErrorZero => 'Cannot be zero';

  @override
  String get thresholdsExpectedPerMilking => 'Expected per milking';

  @override
  String get thresholdsFalseAlarmGroupHint =>
      'No red is produced in the first seconds of milking; no alert is sent unless red persists for this long (§6.2).';

  @override
  String get thresholdsFalseAlarmGroupTitle => 'False-alarm protection';

  @override
  String get thresholdsFlowGroupHint =>
      'Red below, green above; yellow in between (§6.2).';

  @override
  String get thresholdsFlowGroupTitle => 'Live flow rate bands';

  @override
  String get thresholdsFresh => 'Fresh lactation';

  @override
  String get thresholdsGreenLimit => 'Green threshold';

  @override
  String get thresholdsHighYield => 'High yield upper threshold';

  @override
  String get thresholdsLoadFailed => 'Could not load thresholds';

  @override
  String get thresholdsLowerLimit => 'Lower threshold';

  @override
  String get thresholdsMastitisGroupHint =>
      'If the meter measures conductivity: alert when a milking\'s conductivity is this much above the animal\'s own 7-day average. This is not a diagnosis; it is a signal for a veterinary check.';

  @override
  String get thresholdsMastitisGroupTitle => 'Suspected mastitis';

  @override
  String get thresholdsNoMilk => 'Empty milking limit';

  @override
  String get thresholdsNoMilkCount => 'Recent milkings checked';

  @override
  String get thresholdsNoSpecies => 'No species thresholds defined';

  @override
  String get thresholdsRampUp => 'Warm-up time';

  @override
  String get thresholdsReadOnly => 'Only the owner can change thresholds.';

  @override
  String get thresholdsRedLimit => 'Red threshold';

  @override
  String get thresholdsRulesGroupHint =>
      'Declining if the 7-day average is lower than the 30-day average by more than this rate. Not giving milk if all recent milkings are below the empty milking limit. During the fresh lactation days after calving, an animal is not marked declining or a dry-off candidate (§6.4).';

  @override
  String get thresholdsRulesGroupTitle => 'Classification rules';

  @override
  String thresholdsSaved(Object species) {
    return '$species thresholds saved';
  }

  @override
  String get thresholdsSaving => 'Saving…';

  @override
  String get thresholdsSpeciesLoadFailed => 'Could not load species';

  @override
  String get thresholdsTitle => 'Threshold settings';

  @override
  String get thresholdsUnitDays => 'days';

  @override
  String get thresholdsUnitFlow => 'L/min';

  @override
  String get thresholdsUnitMilkings => 'milkings';

  @override
  String get thresholdsUnitPerDay => 'L/day';

  @override
  String get thresholdsUnitSec => 's';

  @override
  String get thresholdsUpperLimit => 'Upper threshold';

  @override
  String get thresholdsYieldGroupHint =>
      'Ratio of milk obtained to expected (§6.3). For an animal without history, the expected amount is this per-milking value.';

  @override
  String get thresholdsYieldGroupTitle => 'Session yield bands';

  @override
  String get treatmentAdd => 'Add treatment';

  @override
  String get treatmentDeleteBody =>
      'Only delete a record entered by mistake; deleting it also removes the withdrawal.';

  @override
  String get treatmentDeleteTitle => 'Delete treatment record?';

  @override
  String get treatmentDrug => 'Drug';

  @override
  String get treatmentDrugRequired => 'Enter the drug name.';

  @override
  String get treatmentEmpty =>
      'No treatments. Enter the withdrawal period for an animal given antibiotics: a \"Withhold milk\" warning shows on the live screen during that period.';

  @override
  String get treatmentLoadFailed => 'Could not load treatments';

  @override
  String treatmentPlusDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '+$n days',
      one: '+$n day',
    );
    return '$_temp0';
  }

  @override
  String treatmentRange(Object start, Object until) {
    return '$start → withdrawal $until';
  }

  @override
  String treatmentSaveFailed(Object error) {
    return 'Could not save treatment: $error';
  }

  @override
  String get treatmentSaved => 'Treatment saved';

  @override
  String treatmentStart(Object date) {
    return 'Start: $date';
  }

  @override
  String get treatmentStartHelp => 'Treatment start';

  @override
  String get treatmentTitle => 'Treatment and withdrawal';

  @override
  String treatmentUntil(Object date) {
    return 'Withdrawal ends: $date';
  }

  @override
  String get treatmentUntilHelp => 'Last day to withhold milk';

  @override
  String treatmentWithdrawalBanner(Object date) {
    return 'In withdrawal: keep the milk out of the tank through $date.';
  }

  @override
  String get twoFactorBackupBody =>
      'If you lose your phone you can sign in with these; each works once. Shown only now — keep them somewhere safe.';

  @override
  String get twoFactorBackupTitle => 'Backup codes';

  @override
  String get twoFactorCode => '6-digit code';

  @override
  String get twoFactorCodeOrBackup => 'Code or backup code';

  @override
  String get twoFactorCopyCodes => 'Copy codes';

  @override
  String get twoFactorCopyKey => 'Copy key';

  @override
  String get twoFactorDisable => 'Turn off two-step verification';

  @override
  String get twoFactorDisableHint =>
      'To turn it off, enter your password and a verification code (or a backup code).';

  @override
  String get twoFactorDone => 'I saved them';

  @override
  String get twoFactorEnable => 'Verify and turn on';

  @override
  String get twoFactorIntro =>
      'When signing in, besides your password you enter the 6-digit code from the authenticator app on your phone (Google Authenticator, Microsoft Authenticator, etc.). Even if your password leaks, nobody can sign in.';

  @override
  String get twoFactorOn => 'Two-step verification is on';

  @override
  String get twoFactorOpenApp => 'Open in app';

  @override
  String get twoFactorStart => 'Start setup';

  @override
  String get twoFactorStep1 =>
      '1. In the authenticator app choose \"add account\" → \"enter a setup key\" and add this key (account name: Milk Trace):';

  @override
  String get twoFactorStep2 => '2. Enter the 6-digit code the app shows:';

  @override
  String get twoFactorTitle => 'Two-step verification';

  @override
  String get unmatchedAssign => 'Assign to animal';

  @override
  String unmatchedAssigned(Object earTag) {
    return 'Tag added to $earTag';
  }

  @override
  String unmatchedChooseAnimal(Object rfid) {
    return '$rfid · choose animal';
  }

  @override
  String get unmatchedEmpty => 'No unknown tags';

  @override
  String get unmatchedIgnore => 'Ignore';

  @override
  String unmatchedIgnoreBody(Object rfid) {
    return '$rfid is removed from the list and won\'t come back even if read again. For another farm\'s animal or a bad read.';
  }

  @override
  String unmatchedIgnoreFailed(Object error) {
    return 'Could not ignore: $error';
  }

  @override
  String get unmatchedIgnoreTitle => 'Ignore the tag?';

  @override
  String get unmatchedIntro =>
      'Tags read during milking that are not registered to any animal. Assign the tag to its animal; at the next milking the animal is matched to the milking point automatically. Ignore it if it belongs to another farm\'s animal or is a bad read.';

  @override
  String unmatchedLastSeenAt(Object spout) {
    return 'Last: $spout';
  }

  @override
  String get unmatchedLoadFailed => 'Could not load tags';

  @override
  String get unmatchedNoTag => 'no tag';

  @override
  String unmatchedReadCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n reads',
      one: '$n read',
    );
    return '$_temp0';
  }

  @override
  String get unmatchedReplace => 'Replace';

  @override
  String unmatchedReplaceBody(Object animal, Object old, Object rfid) {
    return '$animal currently has tag $old. It will be replaced with $rfid; the old tag will no longer be recognized.';
  }

  @override
  String get unmatchedReplaceTitle => 'Replace the tag?';

  @override
  String get unmatchedSearchHint => 'Ear tag number or name';

  @override
  String unmatchedTagValue(Object rfid) {
    return 'tag $rfid';
  }

  @override
  String get unmatchedTitle => 'Unknown tags';

  @override
  String get unmatchedUnknownSpout => 'unknown milking point';

  @override
  String upcomingMore(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n more animals',
      one: '$n more animal',
    );
    return '$_temp0';
  }

  @override
  String get upcomingTitle => 'Upcoming';

  @override
  String get updateBodyAndroid =>
      'This version of Milk Trace is no longer supported. Update the app from Google Play to keep milking records accurate.';

  @override
  String get updateBodyIos =>
      'This version of Milk Trace is no longer supported. Update the app from the App Store to keep milking records accurate.';

  @override
  String get updatePlayButton => 'Update on Google Play';

  @override
  String get updateTitle => 'Update required';

  @override
  String get vaccineAllSpecies => 'All species';

  @override
  String get vaccineCardEmpty => 'This animal is not in any vaccination plan.';

  @override
  String get vaccineCardLoadFailed => 'Could not load vaccinations';

  @override
  String get vaccineCardTitle => 'Vaccinations';

  @override
  String get vaccineDeleteBody => 'The wrongly entered record will be deleted.';

  @override
  String get vaccineDeleteTitle => 'Delete vaccination record?';

  @override
  String get vaccineDueEmpty => 'No animals are due.';

  @override
  String get vaccineDueIntro =>
      'Animals that are overdue, due within 30 days or have no record.';

  @override
  String get vaccineDueLoadFailed => 'Could not load due animals';

  @override
  String vaccineDueOn(Object date) {
    return 'due $date';
  }

  @override
  String get vaccineEmpty => 'No vaccination plans yet.';

  @override
  String get vaccineEmptyOwner =>
      'No vaccination plans yet. Start with \"Add plan\", then enter the current state.';

  @override
  String get vaccineGiven => 'Given';

  @override
  String get vaccineIntro =>
      'Recurring treatments such as FMD, brucellosis or parasites. Lactating and dry animals are included; an animal with no record counts as due. Alerts for due animals come from the server.';

  @override
  String vaccineLastGiven(Object date) {
    return 'last $date';
  }

  @override
  String get vaccineLoadFailed => 'Could not load vaccination plans';

  @override
  String vaccineMarkDate(Object date) {
    return 'Given on: $date';
  }

  @override
  String get vaccineMarkHelp => 'Date given';

  @override
  String vaccineMarkSelected(int count) {
    return 'Mark as given ($count)';
  }

  @override
  String get vaccineMarkTitle => 'Mark as given';

  @override
  String vaccineMarked(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count animals marked',
      one: '$count animal marked',
    );
    return '$_temp0';
  }

  @override
  String get vaccineMarkedNone =>
      'No new record: already recorded that day or the animal is not in the plan.';

  @override
  String get vaccineNever => 'no record';

  @override
  String vaccineNext(Object date) {
    return 'next $date';
  }

  @override
  String vaccineOverdue(Object date) {
    return 'overdue · $date';
  }

  @override
  String get vaccinePlanAdd => 'Add plan';

  @override
  String vaccinePlanCounts(int animals, int dueSoon, int never) {
    return '$animals animals · $dueSoon due soon · $never no record';
  }

  @override
  String get vaccinePlanDeleteBody =>
      'The plan and all its records will be deleted.';

  @override
  String vaccinePlanDeleteTitle(Object name) {
    return 'Delete $name?';
  }

  @override
  String get vaccinePlanEdit => 'Edit plan';

  @override
  String vaccinePlanEvery(int days) {
    return 'every $days days';
  }

  @override
  String get vaccinePlanInterval => 'Repeat every (days)';

  @override
  String get vaccinePlanIntervalRange => 'Must be between 7 and 1095 days.';

  @override
  String get vaccinePlanName => 'Name (e.g. FMD)';

  @override
  String get vaccinePlanNameRequired => 'Enter a plan name.';

  @override
  String get vaccinePlanSaved => 'Plan saved';

  @override
  String get vaccinePlanSpecies => 'Species';

  @override
  String get vaccineRecent => 'Recent';

  @override
  String get vaccineSelectAll => 'Select all';

  @override
  String get vaccineSelectNone => 'Clear selection';

  @override
  String get vaccineTitle => 'Vaccination schedule';

  @override
  String get whatsNewItem1 =>
      'Quiet hours: non-critical alerts don\'t ring at night; unread critical alerts are repeated by SMS/call.';

  @override
  String get whatsNewItem2 =>
      'Vaccination schedule, heat tracking and dry-off/calving reminders.';

  @override
  String get whatsNewItem3 =>
      '305-day yield projection on the animal page; breeding indicators on the dashboard.';

  @override
  String get whatsNewItem4 =>
      'Heat stress alert: enter the farm location and hot days are marked on the chart.';

  @override
  String get whatsNewItem5 =>
      'Dark theme: Light / Dark / Device in the account sheet.';

  @override
  String get whatsNewOk => 'OK';

  @override
  String get whatsNewTitle => 'What\'s new';

  @override
  String get widgetAccount => 'Account';

  @override
  String get widgetAlerts => 'Alerts';

  @override
  String widgetOfflineBanner(Object when) {
    return 'Offline · last data $when. Changes can be made once the connection is back.';
  }

  @override
  String get yieldChartAvg7 => '7-day avg.';

  @override
  String get yieldChartDaily => 'Daily';

  @override
  String get yieldChartHeat => 'Heat stress day (THI ≥ 72)';

  @override
  String get yieldChartNotEnough => 'Not enough history for a chart';

  @override
  String yieldReportDescription(Object unit) {
    return 'Daily yield per animal ($unit), as an Excel file. You can send it to your vet or advisor.';
  }

  @override
  String yieldReportFailed(Object error) {
    return 'Could not get report: $error';
  }

  @override
  String get yieldReportKilogram => 'kilograms';

  @override
  String yieldReportLastDays(Object n) {
    return 'Last $n days';
  }

  @override
  String get yieldReportLitre => 'litres';

  @override
  String get yieldReportShareSubject => 'Milk Trace yield report';

  @override
  String get yieldReportTitle => 'Yield report';
}
