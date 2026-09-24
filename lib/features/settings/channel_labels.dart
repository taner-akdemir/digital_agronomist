import 'package:flutter/material.dart';

/// Bildirim kanalı kodlarının Türkçe karşılıkları.
///
/// Kodlar BACKEND'İNDİR ve STRING'dir. Tanınmayan kod olduğu gibi
/// gösterilir: backend yeni bir sağlayıcı eklediğinde uygulama boş satır
/// değil ham kod gösterir (Cihazlar ekranındaki protocolLabel ile aynı kural).

String channelKindLabel(String kind) => switch (kind) {
  'email' => 'E-posta',
  'slack' => 'Slack',
  'teams' => 'Microsoft Teams',
  'webhook' => 'Webhook',
  'sms' => 'SMS',
  'ivr' => 'Sesli arama',
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
  'info' => 'Bilgi',
  'warning' => 'Uyarı',
  'critical' => 'Kritik',
  _ => severity,
};

/// Kaynaklar: kanal hangi bildirimleri alır.
String sourceLabel(String source) => switch (source) {
  'ops' => 'Sistem alarmları',
  'herd' => 'Sürü uyarıları',
  _ => source,
};

String sourceHint(String source) => switch (source) {
  'ops' => 'Sayaç kutusu sustu, veri kaybı gibi sistem sorunları',
  'herd' => 'Düşük debi gibi sağım sırasındaki uyarılar',
  _ => '',
};

/// Ayar alanlarının etiketleri. Alan listesi backend'den gelir; burada
/// olmayan alan adıyla gösterilir.
String fieldLabel(String name) => switch (name) {
  'host' => 'SMTP sunucusu',
  'port' => 'Port',
  'username' => 'Kullanıcı adı',
  'password' => 'Parola',
  'from' => 'Gönderen',
  'from_name' => 'Gönderen adı',
  'tls' => 'Şifreleme (starttls, tls)',
  'api_key' => 'API anahtarı',
  'api_secret' => 'API sırrı',
  'region' => 'Bölge',
  'webhook_url' => 'Webhook adresi',
  'url' => 'Adres (https)',
  'secret' => 'İmza sırrı',
  'bearer_token' => 'Bearer jetonu',
  'account_sid' => 'Account SID',
  'auth_token' => 'Auth token',
  'messaging_service_sid' => 'Messaging Service SID',
  'usercode' => 'Kullanıcı kodu',
  'msgheader' => 'SMS başlığı',
  'hash' => 'Hash',
  'sender' => 'SMS başlığı',
  'user' => 'Kullanıcı adı',
  'originator' => 'SMS başlığı',
  'voice' => 'Ses',
  'language' => 'Dil',
  'application_id' => 'Uygulama kimliği',
  'private_key' => 'Özel anahtar (PEM)',
  _ => name,
};

/// Alanın altında gösterilen kısa ipucu; bilinmeyen alanda yok.
String? fieldHint(String name) => switch (name) {
  'from' => 'ornek@alanadi.com.tr',
  'webhook_url' => 'Slack / Teams\'in verdiği gelen webhook adresi',
  'url' => 'Bildirim JSON olarak bu adrese POST edilir',
  'secret' => 'Verilirse istek HMAC ile imzalanır',
  'msgheader' ||
  'sender' ||
  'originator' => 'Sağlayıcıda onaylı gönderici adı (en çok 11 karakter)',
  'region' => 'Boş bırakılabilir (eu: AB veri yerleşimi)',
  'tls' => 'Boş bırakılırsa starttls',
  _ => null,
};

/// Çok satırlı alan: PEM anahtarı.
bool fieldMultiline(String name) => name == 'private_key';
