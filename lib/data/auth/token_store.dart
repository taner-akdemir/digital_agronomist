import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:milktrace/data/models/auth_user.dart';

/// Token'ların kalıcı deposu.
///
/// shared_preferences DEĞİL: orada tutulan bir yenileme token'ı rootlanmış
/// bir cihazda düz metin okunabilir. Keychain/Keystore tarafı için
/// flutter_secure_storage (§15.2).
///
/// Kullanıcı bilgisi de saklanır ki uygulama açılışında /me çağrısını
/// BEKLEMEDEN selamlama gösterilebilsin; doğruluk kaynağı yine sunucudur.
class TokenStore {
  TokenStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _kAccess = 'mt.accessToken';
  static const _kRefresh = 'mt.refreshToken';
  static const _kUserEmail = 'mt.user.email';
  static const _kUserName = 'mt.user.fullName';
  static const _kUserId = 'mt.user.id';
  static const _kUserRole = 'mt.user.role';
  static const _kUserTenant = 'mt.user.tenantId';

  Future<AuthTokens?> readTokens() async {
    final access = await _storage.read(key: _kAccess);
    final refresh = await _storage.read(key: _kRefresh);
    if (access == null || refresh == null) return null;
    return AuthTokens(accessToken: access, refreshToken: refresh);
  }

  Future<void> writeTokens(AuthTokens t) async {
    await _storage.write(key: _kAccess, value: t.accessToken);
    await _storage.write(key: _kRefresh, value: t.refreshToken);
  }

  Future<AuthUser?> readUser() async {
    final id = await _storage.read(key: _kUserId);
    final email = await _storage.read(key: _kUserEmail);
    if (id == null || email == null) return null;
    return AuthUser(
      id: id,
      email: email,
      fullName: await _storage.read(key: _kUserName) ?? '',
      role: await _storage.read(key: _kUserRole) ?? '',
      tenantId: await _storage.read(key: _kUserTenant),
    );
  }

  Future<void> writeUser(AuthUser u) async {
    await _storage.write(key: _kUserId, value: u.id);
    await _storage.write(key: _kUserEmail, value: u.email);
    await _storage.write(key: _kUserName, value: u.fullName);
    await _storage.write(key: _kUserRole, value: u.role);
    await _storage.write(key: _kUserTenant, value: u.tenantId);
  }

  /// Her anahtarı TEK TEK siler, deleteAll() değil: deleteAll aynı uygulamanın
  /// başka amaçla yazdığı secure storage kayıtlarını da süpürür.
  Future<void> clear() async {
    for (final k in const [
      _kAccess,
      _kRefresh,
      _kUserId,
      _kUserEmail,
      _kUserName,
      _kUserRole,
      _kUserTenant,
    ]) {
      await _storage.delete(key: k);
    }
  }
}
