import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';
part 'user_session.g.dart';

/// Kişinin açık oturumu (backend ADR 0105): bir cihaz ya da tarayıcı.
@freezed
abstract class UserSession with _$UserSession {
  const factory UserSession({
    required String id,
    @Default('') String userAgent,
    @Default('') String ip,
    DateTime? startedAt,
    DateTime? lastUsedAt,

    /// Bu isteği yapan oturum ("bu cihaz").
    @Default(false) bool current,
  }) = _UserSession;

  const UserSession._();

  /// Uygulama mı, tarayıcı (panel) mı; uygulamada platform.
  ({bool app, String? platform}) get kind {
    final m = RegExp(r'^MilkTrace/[^ ]* \((\w+)\)').firstMatch(userAgent);
    if (m != null) return (app: true, platform: m.group(1));
    return (app: false, platform: null);
  }

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);
}
