import 'package:dio/dio.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/assistant.dart';
import 'package:milktrace/domain/assistant_history.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assistant_providers.g.dart';

/// Asistan açık mı (backend ADR 0138)? Açıksa durum, değilse null.
///
/// null — giriş HİÇ görünmez: sunucu kapalı (`enabled: false`), çağrı
/// düştü (çevrimdışı, eski backend, 403) ya da kullanıcı mandıra/tablet
/// hesabı (gateway zaten 403 döner). keepAlive: oturum değişince
/// (authProvider) ya da 503 gelince yeniden sorulur.
@Riverpod(keepAlive: true)
Future<AssistantStatus?> assistantStatus(Ref ref) async {
  final user = ref.watch(authProvider).user;
  if (user == null || user.isDairy || user.kiosk) return null;
  try {
    final s = await ref.watch(repositoryProvider).assistantStatus();
    return s.enabled ? s : null;
  } on Object {
    return null;
  }
}

/// Hata türü: ekran neyi kapatacağını buna göre seçer.
enum AssistantFailureKind {
  /// 503: asistan kapalı ya da ulaşılamıyor.
  unavailable,

  /// 422 ya da istemcinin kendi denetimi: geçmiş sınırı aştı, yeni
  /// konuşma önerilir.
  rejected,

  /// 401/403: yetki.
  unauthorized,

  /// Ağ ve diğerleri: yeniden denenebilir.
  other,
}

typedef AssistantFailure = ({AssistantFailureKind kind, String message});

/// Hatayı kullanıcı metnine çevirir. 503 için kendi dostça metnimiz
/// (sunucunun kod dili kullanıcıya bir şey söylemiyor); 422'de sunucunun
/// mesajı + yeni konuşma önerisi; diğerlerinde sunucunun mesajı.
AssistantFailure assistantFailureOf(Object error) {
  final status = switch (error) {
    final ApiException e => e.status,
    final DioException e => e.response?.statusCode,
    _ => null,
  };
  final server = userMessage(error);
  return switch (status) {
    503 => (
      kind: AssistantFailureKind.unavailable,
      message: l10n.assistantUnavailable,
    ),
    422 => (
      kind: AssistantFailureKind.rejected,
      message: server == null
          ? l10n.assistantTotalTooLong
          : l10n.assistantRejected(server),
    ),
    401 || 403 => (
      kind: AssistantFailureKind.unauthorized,
      message: server ?? l10n.assistantUnavailable,
    ),
    _ => (
      kind: AssistantFailureKind.other,
      message: server ?? l10n.assistantFailed('$error'),
    ),
  };
}

/// İstemcinin kendi denetiminin metni.
AssistantFailure assistantIssueFailure(AssistantHistoryIssue issue) => (
  kind: AssistantFailureKind.rejected,
  message: switch (issue) {
    AssistantHistoryIssue.messageTooLong => l10n.assistantMessageTooLong,
    AssistantHistoryIssue.tooManyMessages => l10n.assistantLimitReached,
    AssistantHistoryIssue.totalTooLong ||
    AssistantHistoryIssue.badOrder ||
    AssistantHistoryIssue.empty => l10n.assistantTotalTooLong,
  },
);

/// Konuşmanın bir satırı: mesaj ve (asistan cevabıysa) kaynakları.
typedef AssistantEntry = ({
  AssistantMessage message,
  List<AssistantSource> sources,
  bool handoff,
});

/// Ekranın durumu. Geçmiş YALNIZCA bellekte, ekran açıkken (KVKK): ekran
/// kapanınca sağlayıcı atılır ve metin hiçbir yere yazılmaz.
class AssistantChatState {
  const AssistantChatState({
    this.entries = const [],
    this.pending,
    this.failure,
  });

  final List<AssistantEntry> entries;

  /// Gönderilen, cevabı beklenen soru. Geçmişe cevapla birlikte girer:
  /// düşerse geçmiş kullanıcıyla bitmez ve sonraki istek bozulmaz.
  final String? pending;

  final AssistantFailure? failure;

  bool get busy => pending != null;

  List<AssistantMessage> get history => [for (final e in entries) e.message];

  /// 19 mesaj sınırı: bir soru daha sığar mı?
  bool get canAskMore => assistantCanAskMore(history);

  /// Kapalı asistan: bu ekranda soru gönderilmez.
  bool get blocked => failure?.kind == AssistantFailureKind.unavailable;
}

@riverpod
class AssistantChat extends _$AssistantChat {
  @override
  AssistantChatState build() => const AssistantChatState();

  /// Soruyu gönderir; gönderildiyse true (ekran giriş alanını temizler).
  Future<bool> send(String text) async {
    final s = state;
    if (s.busy || s.blocked) return false;
    final request = assistantRequest(s.history, text);
    if (validateAssistantRequest(request) case final issue?) {
      if (issue != AssistantHistoryIssue.empty) {
        state = AssistantChatState(
          entries: s.entries,
          failure: assistantIssueFailure(issue),
        );
      }
      return false;
    }
    final question = request.last;
    state = AssistantChatState(entries: s.entries, pending: question.text);
    try {
      final reply = await ref.read(repositoryProvider).askAssistant(request);
      if (!ref.mounted) return false;
      state = AssistantChatState(
        entries: [
          ...s.entries,
          (message: question, sources: const [], handoff: false),
          (
            message: AssistantMessage(role: assistantRole, text: reply.text),
            sources: reply.sources,
            handoff: reply.handoff,
          ),
        ],
      );
      return true;
    } catch (e) {
      if (!ref.mounted) return false;
      final failure = assistantFailureOf(e);
      state = AssistantChatState(entries: s.entries, failure: failure);
      // Kapalı asistan: hesap kartındaki giriş de gizlensin.
      if (failure.kind == AssistantFailureKind.unavailable) {
        ref.invalidate(assistantStatusProvider);
      }
      return false;
    }
  }

  /// "Yeni konuşma": geçmiş silinir. Kapalılık sürer.
  void newConversation() {
    final s = state;
    if (s.busy) return;
    state = AssistantChatState(failure: s.blocked ? s.failure : null);
  }
}
