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

    /// Erişimin son günü (backend ADR 0103); o gün dahil girer. null =
    /// süresiz.
    DateTime? accessUntil,
  }) = _TeamMember;

  const TeamMember._();

  /// Erişim süresi doldu mu (son gün dahil).
  bool accessExpired(DateTime now) {
    final u = accessUntil;
    if (u == null) return false;
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).isAfter(DateTime(u.year, u.month, u.day));
  }

  /// Sahibin yönetebildiği satır (sahip ekleme ve değiştirme platformda).
  bool get isManageable => role == 'tenant_operator' || role == 'tenant_viewer';

  bool get isSuspended => status == 'suspended';

  factory TeamMember.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberFromJson(json);
}

/// Ekleme sonucu: kayıt ve sunucunun Türkçe mesajı ("davet e-postası
/// gönderildi" / "gönderilemedi") — kullanıcıya olduğu gibi gösterilir.
typedef TeamAddResult = ({TeamMember member, String message});
