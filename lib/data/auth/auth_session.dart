import 'package:dio/dio.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/data/auth/auth_interceptor.dart';
import 'package:milktrace/data/auth/token_store.dart';
import 'package:milktrace/data/models/auth_user.dart';

/// Kimlik doğrulamalı HTTP yığını: üç Dio, bir interceptor, bir depo.
///
/// ÜÇ Dio olmasının sebebi, ikisinin de interceptor'ı OLMAMASI gerekmesi:
///
/// - `authed`  — uygulamanın kullandığı; token ekler, 401'de yeniler.
/// - `bare`    — /auth/* uçları için. Yenileme isteği 401 alırsa interceptor
///               yine yenilemeye kalkar ve sonsuz döngüye girerdi.
/// - `retry`   — yenileme sonrası başarısız isteği tekrar atmak için. `authed`
///               ile atılsaydı tekrar 401 gelmesi hâlinde zincir iç içe geçerdi.
class AuthSession {
  AuthSession._({
    required this.authed,
    required this.api,
    required this.store,
    required this.interceptor,
    required this._bare,
    required this._retry,
  });

  factory AuthSession({required String baseUrl, TokenStore? store}) {
    BaseOptions options() => BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      // Zarf her zaman JSON; dio'nun içerik tipini tahmin etmesine
      // bırakmıyoruz.
      contentType: Headers.jsonContentType,
    );

    final bare = Dio(options());
    final retry = Dio(options());
    final authed = Dio(options());

    final tokenStore = store ?? TokenStore();
    final api = AuthApi(dio: bare);

    final interceptor = AuthInterceptor(
      authApi: api,
      store: tokenStore,
      retryDio: retry,
    );
    authed.interceptors.add(interceptor);

    return AuthSession._(
      authed: authed,
      api: api,
      store: tokenStore,
      interceptor: interceptor,
      bare: bare,
      retry: retry,
    );
  }

  /// Uygulamanın veri istekleri bununla gider.
  final Dio authed;
  final AuthApi api;
  final TokenStore store;
  final AuthInterceptor interceptor;

  final Dio _bare;
  final Dio _retry;

  /// Token'ları hem belleğe (interceptor) hem diske (store) yazar.
  ///
  /// İkisi birlikte gitmek zorunda: yalnızca belleğe yazılsa uygulama
  /// kapanınca oturum kaybolur, yalnızca diske yazılsa o andaki istekler
  /// hâlâ eski token'ı taşır.
  Future<void> adopt(AuthTokens tokens) async {
    interceptor.setTokens(tokens);
    await store.writeTokens(tokens);
  }

  Future<void> forget() async {
    interceptor.setTokens(null);
    await store.clear();
  }

  void dispose() {
    interceptor.dispose();
    authed.close();
    _bare.close();
    _retry.close();
  }
}
