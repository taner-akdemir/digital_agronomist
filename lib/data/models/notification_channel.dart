import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_channel.freezed.dart';
part 'notification_channel.g.dart';

/// Bildirim kanalı: e-posta, Slack, Teams, webhook, SMS ya da sesli arama
/// (backend docs/adr/0028). İşletme sahibi kendi kanallarını yönetir.
///
/// `kind`, `provider`, `minSeverity` ve `sources` STRING'dir, enum değil:
/// backend yeni bir sağlayıcı ya da kaynak eklediğinde liste komple parse
/// edilemez hâle gelmemeli (uyarıdaki `type` ile aynı kural).
///
/// SIRLAR GELMEZ: `config` yalnızca sır olmayan ayarları taşır; sırların
/// (parola, API anahtarı, webhook adresi) yalnızca ayarlı olup olmadığı
/// `secrets`'ta. Sırrı ekranda göstermek, ekran görüntüsüyle kanala mesaj
/// yazma yetkisi vermek olurdu.
@freezed
abstract class NotificationChannel with _$NotificationChannel {
  const factory NotificationChannel({
    required String id,
    required String name,

    /// email | slack | teams | webhook | sms | ivr
    required String kind,

    /// smtp | sendgrid | slack | teams | webhook | twilio | netgsm | ...
    required String provider,
    String? tenantId,
    @Default(<String, String>{}) Map<String, String> config,
    @Default(<String, bool>{}) Map<String, bool> secrets,

    /// E-posta adresleri ya da E.164 numaralar; Slack/Teams/webhook'ta boş.
    @Default(<String>[]) List<String> recipients,

    /// info | warning | critical: bu kanala gidecek en düşük önem.
    @Default('warning') String minSeverity,
    @Default(true) bool sendResolved,
    @Default(true) bool enabled,

    /// ops (sistem alarmları) | summary (sağım özeti) | herd (her sürü
    /// uyarısı ayrı)
    @Default(<String>['ops', 'summary']) List<String> sources,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationChannel;

  factory NotificationChannel.fromJson(Map<String, dynamic> json) =>
      _$NotificationChannelFromJson(json);
}

/// Bir sağlayıcının tanımı (GET /notification-providers): hangi ayarları
/// istediği ve alıcı türü. Form bu listeden çizilir; yeni bir sağlayıcı
/// uygulama güncellenmeden de eklenebilsin.
@freezed
abstract class NotificationProvider with _$NotificationProvider {
  const factory NotificationProvider({
    required String kind,
    required String provider,

    /// email | phone | none
    @Default('none') String recipients,
    @Default(<ProviderField>[]) List<ProviderField> fields,
  }) = _NotificationProvider;

  factory NotificationProvider.fromJson(Map<String, dynamic> json) =>
      _$NotificationProviderFromJson(json);
}

@freezed
abstract class ProviderField with _$ProviderField {
  const factory ProviderField({
    required String name,
    @Default(false) bool required,
    @Default(false) bool secret,
  }) = _ProviderField;

  factory ProviderField.fromJson(Map<String, dynamic> json) =>
      _$ProviderFieldFromJson(json);
}

/// Oluşturma/güncelleme gövdesi.
///
/// GÜNCELLEMEDE `config` KISMİDİR: gönderilmeyen ayar eski değerini korur.
/// Bu yüzden boş bırakılan sır alanı gövdeye HİÇ konmaz; boş dize göndermek
/// backend'de "sil" anlamına gelir ve kayıtlı parolayı silerdi.
class NotificationChannelDraft {
  const NotificationChannelDraft({
    required this.name,
    required this.kind,
    required this.provider,
    required this.config,
    required this.recipients,
    required this.minSeverity,
    required this.sendResolved,
    required this.enabled,
    required this.sources,
  });

  final String name;
  final String kind;
  final String provider;
  final Map<String, String> config;
  final List<String> recipients;
  final String minSeverity;
  final bool sendResolved;
  final bool enabled;
  final List<String> sources;

  Map<String, dynamic> toJson() => {
    'name': name,
    'kind': kind,
    'provider': provider,
    'config': config,
    'recipients': recipients,
    'minSeverity': minSeverity,
    'sendResolved': sendResolved,
    'enabled': enabled,
    'sources': sources,
  };
}
