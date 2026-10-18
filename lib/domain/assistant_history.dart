import 'package:milktrace/data/models/assistant.dart';

/// Yardım asistanının geçmiş kuralları (backend ADR 0138). Sunucu durumsuz:
/// istemci geçmişin tamamını her istekte gönderir ve sunucu aynı kuralları
/// 422 ile uygular. Burada önceden denetlenir ki kullanıcı reddedilecek bir
/// soruyu yazıp beklemesin.
abstract final class AssistantLimits {
  /// Bir istekte en çok mesaj (10 soru + 9 cevap).
  static const maxMessages = 19;

  /// Soru başına en çok karakter.
  static const maxMessageChars = 2000;

  /// Geçmişte geri gönderilen asistan cevabı başına en çok karakter (cevap
  /// `max_tokens` 2000'e kadar uzar; sunucu cevaba bu kadar tanır).
  static const maxAnswerChars = 12000;

  /// Bir istekteki bütün mesajların toplamı.
  static const maxTotalChars = 120000;

  /// Sayaç bu uzunluktan sonra görünür.
  static const counterFrom = 1800;
}

const assistantUser = 'user';
const assistantRole = 'assistant';

/// Yeni sorunun neden gönderilemeyeceği; gönderilebiliyorsa null.
enum AssistantHistoryIssue {
  /// Soru boş.
  empty,

  /// Soru 2000 karakterden uzun.
  messageTooLong,

  /// Konuşma 19 mesaja ulaştı; yeni konuşma gerekir.
  tooManyMessages,

  /// Geçmiş + soru toplam sınırı aşıyor; yeni konuşma gerekir.
  totalTooLong,

  /// Roller sırayla değil ya da geçmiş kullanıcıyla bitmiyor (beklenen
  /// cevap gelmeden ikinci soru).
  badOrder,
}

/// Gönderilecek geçmiş: önceki mesajlar + yeni soru.
///
/// Asistan cevapları [AssistantLimits.maxAnswerChars]'a KIRPILIR: sınırdan
/// uzun cevap olduğu gibi geri gönderilseydi sonraki her soru 422 alırdı.
/// Bağlam için başı yeter.
List<AssistantMessage> assistantRequest(
  List<AssistantMessage> history,
  String question,
) => [
  for (final m in history)
    m.role == assistantRole && m.text.length > AssistantLimits.maxAnswerChars
        ? m.copyWith(text: m.text.substring(0, AssistantLimits.maxAnswerChars))
        : m,
  AssistantMessage(role: assistantUser, text: question.trim()),
];

/// Kurallar: kullanıcıyla başlar ve biter, roller sırayla, ≤ 19 mesaj,
/// soru başına ≤ 2000, cevap başına ≤ 12000, toplam ≤ 120000 karakter.
AssistantHistoryIssue? validateAssistantRequest(
  List<AssistantMessage> messages,
) {
  if (messages.isEmpty || messages.last.text.trim().isEmpty) {
    return AssistantHistoryIssue.empty;
  }
  for (var i = 0; i < messages.length; i++) {
    final want = i.isEven ? assistantUser : assistantRole;
    if (messages[i].role != want) return AssistantHistoryIssue.badOrder;
  }
  if (messages.last.role != assistantUser) {
    return AssistantHistoryIssue.badOrder;
  }
  if (messages.any(
    (m) =>
        m.text.length >
        (m.role == assistantRole
            ? AssistantLimits.maxAnswerChars
            : AssistantLimits.maxMessageChars),
  )) {
    return AssistantHistoryIssue.messageTooLong;
  }
  if (messages.length > AssistantLimits.maxMessages) {
    return AssistantHistoryIssue.tooManyMessages;
  }
  final total = messages.fold<int>(0, (s, m) => s + m.text.length);
  if (total > AssistantLimits.maxTotalChars) {
    return AssistantHistoryIssue.totalTooLong;
  }
  return null;
}

/// Bu geçmişe bir soru daha eklenebilir mi (giriş alanını kapatmak için)?
/// Yalnızca sayıya bakar; uzunluk gönderirken denetlenir.
bool assistantCanAskMore(List<AssistantMessage> history) =>
    history.length + 1 <= AssistantLimits.maxMessages;
