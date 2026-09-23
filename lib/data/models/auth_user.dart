import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// Giriş yapmış kullanıcı (§5).
///
/// `tenantId` platform yöneticisinde BOŞTUR; onun bir işletmesi yoktur.
/// Bu uygulama işletme kullanıcısı içindir, yani pratikte hep doludur —
/// ama tip bunu yalan söylemesin diye nullable.
@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    required String fullName,
    required String role,
    String? tenantId,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

/// Erişim + yenileme token çifti.
///
/// Erişim token'ı kısa ömürlüdür ve her istekte gider; yenileme token'ı
/// DÖNERdir — her kullanımda sunucu yenisini verir ve eskisini geçersiz kılar
/// (auth servisi tekrar kullanımı tespit edip kullanıcının tüm oturumlarını
/// kapatır). Bu yüzden yenileme yanıtındaki İKİ token da saklanmak zorundadır;
/// yalnızca erişim token'ını yazmak sonraki yenilemeyi çökertir.
@freezed
abstract class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String accessToken,
    required String refreshToken,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

/// POST /auth/login yanıtı.
@freezed
abstract class LoginResult with _$LoginResult {
  const factory LoginResult({
    required String accessToken,
    required String refreshToken,
    required AuthUser user,
  }) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
}
