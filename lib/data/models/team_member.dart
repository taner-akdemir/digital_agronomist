import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_member.freezed.dart';
part 'team_member.g.dart';

/// İşletmenin kullanıcısı (backend ADR 0076, `GET /team`). Sahip yalnızca
/// sağımcı ve izleyicileri değiştirir; sahipler listede salt okunur.
@freezed
abstract class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    required String email,
    @Default('') String fullName,

    /// tenant_owner | tenant_operator | tenant_viewer. String: yeni rol
    /// listeyi düşürmesin.
    required String role,

    /// active | suspended.
    @Default('active') String status,

    /// Sağımhane tableti hesabı (backend ADR 0091).
    @Default(false) bool kiosk,
  }) = _TeamMember;

  const TeamMember._();

  /// Sahibin yönetebildiği satır (sahip ekleme ve değiştirme platformda).
  bool get isManageable => role == 'tenant_operator' || role == 'tenant_viewer';

  bool get isSuspended => status == 'suspended';

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
}

/// Ekleme sonucu: kayıt ve sunucunun Türkçe mesajı ("davet e-postası
/// gönderildi" / "gönderilemedi") — kullanıcıya olduğu gibi gösterilir.
typedef TeamAddResult = ({TeamMember member, String message});
