import 'dart:async';

import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/data/auth/auth_session.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

/// HTTP yığını. keepAlive: token'lar ve süren yenileme burada yaşıyor;
/// ekran değiştiğinde yeniden kurulursa kullanıcı oturumdan düşerdi.
@Riverpod(keepAlive: true)
AuthSession authSession(Ref ref) {
  final session = AuthSession(baseUrl: Env.apiBaseUrl);
  ref.onDispose(session.dispose);
  return session;
}

/// Oturum durumu.
@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  late final AuthSession _session;

  @override
  AuthState build() {
    _session = ref.watch(authSessionProvider);

    // Token'ı sunucu reddettiğinde interceptor haber verir. Kullanıcı bunu
    // ekranda bir hata olarak değil, giriş ekranına dönerek görür.
    final sub = _session.interceptor.onForcedSignOut.listen((_) {
      state = AuthState.signedOut;
    });
    ref.onDispose(sub.cancel);

    // Mock modda kimlik sunucusu YOKTUR. Giriş ekranını göstermek
    // kullanıcıyı asla geçemeyeceği bir kapıya çarptırırdı; demo kullanıcısı
    // ile doğrudan içeri alınır (§15.2 mock/gerçek bayrağı).
    if (Env.apiMode == ApiMode.mock) {
      return const AuthState(status: AuthStatus.signedIn, user: _mockUser);
    }

    unawaited(_restore());
    return AuthState.restoring;
  }

  /// Diskteki token'la oturumu geri yükler.
  ///
  /// /me çağrısı ZORUNLU: token'ın diskte durması geçerli olduğu anlamına
  /// gelmez (süresi dolmuş, kullanıcı silinmiş, parola değişmiş olabilir).
  /// Sunucuya sormadan içeri alsaydık kullanıcı ilk veri isteğinde
  /// açıklamasız bir hata görürdü.
  Future<void> _restore() async {
    final tokens = await _session.store.readTokens();
    if (tokens == null) {
      state = AuthState.signedOut;
      return;
    }

    _session.interceptor.setTokens(tokens);

    try {
      final user = await _session.api.me(tokens.accessToken);
      await _session.store.writeUser(user);
      state = AuthState(status: AuthStatus.signedIn, user: user);
    } on ApiException catch (e) {
      if (e.isUnauthorized) {
        // Erişim token'ının süresi dolmuş olabilir; yenilemeyi dene.
        await _restoreByRefresh(tokens.refreshToken);
        return;
      }
      // Ağ hatası: token'ı ATMA. Ahırda kapsama sık kopuyor; kullanıcıyı
      // her sinyal kaybında giriş ekranına atmak kabul edilemez. Saklanan
      // kullanıcıyla devam edilir, ilk başarılı istek durumu düzeltir.
      final cached = await _session.store.readUser();
      state = cached == null
          ? AuthState.signedOut
          : AuthState(status: AuthStatus.signedIn, user: cached);
    }
  }

  Future<void> _restoreByRefresh(String refreshToken) async {
    try {
      final next = await _session.api.refresh(refreshToken);
      await _session.adopt(next);
      final user = await _session.api.me(next.accessToken);
      await _session.store.writeUser(user);
      state = AuthState(status: AuthStatus.signedIn, user: user);
    } on ApiException {
      await _session.forget();
      state = AuthState.signedOut;
    }
  }

  /// Giriş. Hata ApiException olarak YUKARI atılır — ekran sunucunun
  /// Türkçe mesajını gösterir, kendi metnini uydurmaz.
  Future<void> signIn({required String email, required String password}) async {
    final result = await _session.api.login(email: email, password: password);

    await _session.adopt(AuthTokens(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    ));
    await _session.store.writeUser(result.user);
    state = AuthState(status: AuthStatus.signedIn, user: result.user);
  }

  Future<void> signOut() async {
    if (Env.apiMode == ApiMode.mock) return;

    final tokens = await _session.store.readTokens();
    if (tokens != null) {
      await _session.api.logout(tokens.refreshToken);
    }
    await _session.forget();
    state = AuthState.signedOut;
  }
}

/// Mock modun sabit kullanıcısı; seed'deki demo çiftçiyle aynı.
const _mockUser = AuthUser(
  id: '0192a1f0-00a0-7000-8000-000000000002',
  email: 'ciftci@milktrace.local',
  fullName: 'Demo Çiftçi',
  role: 'tenant_owner',
  tenantId: '0192a1f0-0001-7000-8000-000000000001',
);
