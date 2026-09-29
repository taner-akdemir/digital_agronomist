import 'package:flutter/material.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Bildirim kanalı kodlarının Türkçe karşılıkları.
///
/// Kodlar BACKEND'İNDİR ve STRING'dir. Tanınmayan kod olduğu gibi
/// gösterilir: backend yeni bir sağlayıcı eklediğinde uygulama boş satır
/// değil ham kod gösterir (Cihazlar ekranındaki protocolLabel ile aynı kural).

String channelKindLabel(String kind) => switch (kind) {
  'email' => l10n.channelsKindEmail,
  'slack' => 'Slack',
  'teams' => 'Microsoft Teams',
  'webhook' => 'Webhook',
  'sms' => 'SMS',
  'ivr' => l10n.channelsKindVoiceCall,
  _ => kind,
};

IconData channelKindIcon(String kind) => switch (kind) {
  'email' => Icons.mail_outline,
  'slack' || 'teams' => Icons.forum_outlined,
  'webhook' => Icons.webhook,
  'sms' => Icons.sms_outlined,
  'ivr' => Icons.phone_in_talk_outlined,
  _ => Icons.notifications_none,
};

String channelProviderLabel(String provider) => switch (provider) {
  'smtp' => 'SMTP',
  'sendgrid' => 'SendGrid',
  'slack' => 'Slack',
  'teams' => 'Teams',
  'webhook' => 'Webhook',
  'twilio' => 'Twilio',
  'netgsm' => 'NetGSM',
  'iletimerkezi' => 'İleti Merkezi',
  'vonage' => 'Vonage',
  'jetsms' => 'JetSMS',
  _ => provider,
};

String severityLabel(String severity) => switch (severity) {
  'info' => l10n.channelsSeverityInfo,
  'warning' => l10n.channelsSeverityWarning,
  'critical' => l10n.channelsSeverityCritical,
  _ => severity,
};

/// Kaynaklar: kanal hangi bildirimleri alır.
String sourceLabel(String source) => switch (source) {
  'ops' => l10n.channelsSourceOps,
  'summary' => l10n.channelsSourceSummary,
  'weekly' => l10n.channelsSourceWeekly,
  'herd' => l10n.channelsSourceHerd,
  _ => source,
};

String sourceHint(String source) => switch (source) {
  'ops' => l10n.channelsSourceOpsHint,
  'summary' => l10n.channelsSourceSummaryHint,
  'weekly' => l10n.channelsSourceWeeklyHint,
  'herd' => l10n.channelsSourceHerdHint,
  _ => '',
};

/// Formda gösterilen kaynaklar, sırasıyla. Tek tek hayvan uyarıları
/// gürültülü, isteyen açıkça seçer (backend ile aynı varsayılan).
const channelSources = ['ops', 'summary', 'weekly', 'herd'];

/// Yeni kanal varsayılanı (backend ADR 0111): SMS/arama haftalık rapor
/// metnini almaz.
List<String> defaultChannelSources(String kind) =>
    kind == 'sms' || kind == 'ivr'
    ? const ['ops', 'summary']
    : const ['ops', 'summary', 'weekly'];

/// Ayar alanlarının etiketleri. Alan listesi backend'den gelir; burada
/// olmayan alan adıyla gösterilir.
String fieldLabel(String name) => switch (name) {
  'host' => l10n.channelsFieldHost,
  'port' => 'Port',
  'username' => l10n.channelsFieldUsername,
  'password' => l10n.channelsFieldPassword,
  'from' => l10n.channelsFieldFrom,
  'from_name' => l10n.channelsFieldFromName,
  'tls' => l10n.channelsFieldTls,
  'api_key' => l10n.channelsFieldApiKey,
  'api_secret' => l10n.channelsFieldApiSecret,
  'region' => l10n.channelsFieldRegion,
  'webhook_url' => l10n.channelsFieldWebhookUrl,
  'url' => l10n.channelsFieldUrl,
  'secret' => l10n.channelsFieldSecret,
  'bearer_token' => l10n.channelsFieldBearerToken,
  'account_sid' => 'Account SID',
  'auth_token' => 'Auth token',
  'messaging_service_sid' => 'Messaging Service SID',
  'usercode' => l10n.channelsFieldUserCode,
  'msgheader' => l10n.channelsFieldSmsHeader,
  'hash' => 'Hash',
  'sender' => l10n.channelsFieldSmsHeader,
  'user' => l10n.channelsFieldUsername,
  'originator' => l10n.channelsFieldSmsHeader,
  'voice' => l10n.channelsFieldVoice,
  'language' => l10n.channelsFieldLanguage,
  'application_id' => l10n.channelsFieldApplicationId,
  'private_key' => l10n.channelsFieldPrivateKey,
  _ => name,
};

/// Alanın altında gösterilen kısa ipucu; bilinmeyen alanda yok.
String? fieldHint(String name) => switch (name) {
  'from' => l10n.channelsHintFrom,
  'webhook_url' => l10n.channelsHintWebhookUrl,
  'url' => l10n.channelsHintUrl,
  'secret' => l10n.channelsHintSecret,
  'msgheader' || 'sender' || 'originator' => l10n.channelsHintSmsHeader,
  'region' => l10n.channelsHintRegion,
  'tls' => l10n.channelsHintTls,
  _ => null,
};

/// Çok satırlı alan: PEM anahtarı.
bool fieldMultiline(String name) => name == 'private_key';

/// Adres alanı: sır olsa da açık yazılır, URL klavyesiyle.
bool fieldUrl(String name) => name == 'url' || name == 'webhook_url';
