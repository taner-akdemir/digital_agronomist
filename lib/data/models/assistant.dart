import 'package:freezed_annotation/freezed_annotation.dart';

part 'assistant.freezed.dart';
part 'assistant.g.dart';

/// Yardım asistanının durumu (backend ADR 0138, `GET /assistant/status`).
///
/// `enabled` false: sunucuda anahtar yok ya da aylık harcama tavanı doldu —
/// istemci asistan girişini GİZLER.
@freezed
abstract class AssistantStatus with _$AssistantStatus {
  const factory AssistantStatus({
    @Default(false) bool enabled,
    @Default(0) int limit,
    @Default(0) int remainingToday,
  }) = _AssistantStatus;

  factory AssistantStatus.fromJson(Map<String, dynamic> json) =>
      _$AssistantStatusFromJson(json);
}

/// Konuşmanın bir mesajı. `role` "user" ya da "assistant"; sunucu durumsuz
/// olduğu için geçmişin tamamı her istekte gider.
@freezed
abstract class AssistantMessage with _$AssistantMessage {
  const factory AssistantMessage({required String role, required String text}) =
      _AssistantMessage;

  factory AssistantMessage.fromJson(Map<String, dynamic> json) =>
      _$AssistantMessageFromJson(json);
}

/// Cevabın dayandığı yardım merkezi makalesi (`/yardim/<slug>`).
@freezed
abstract class AssistantSource with _$AssistantSource {
  const factory AssistantSource({
    @Default('') String slug,
    @Default('') String title,
    @Default('') String url,
  }) = _AssistantSource;

  factory AssistantSource.fromJson(Map<String, dynamic> json) =>
      _$AssistantSourceFromJson(json);
}

/// Asistanın cevabı (`POST /assistant/messages`). `text` bağlantılı
/// markdown; `handoff` asistanın cevap veremediğini ya da kullanıcının
/// insan desteği istediğini söyler (ADR 0138 madde 8).
@freezed
abstract class AssistantReply with _$AssistantReply {
  const factory AssistantReply({
    @Default('') String text,
    @Default(<AssistantSource>[]) List<AssistantSource> sources,
    @Default(false) bool handoff,
    @Default(0) int remainingToday,
  }) = _AssistantReply;

  factory AssistantReply.fromJson(Map<String, dynamic> json) =>
      _$AssistantReplyFromJson(json);
}
