import 'dart:async';

import 'package:dio/dio.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/data/auth/token_store.dart';
import 'package:milktrace/data/models/auth_user.dart';

/// Her isteğe erişim token'ını ekler ve 401'de token'ı bir kez yeniler.
///
/// İki tuzak vardı, ikisi de buraya kodlandı:
///
/// 1. **Eşzamanlı yenileme.** Canlı ekran açılışta beş istek birden atar.
///    Token süresi dolmuşsa BEŞİ de 401 alır. Her biri ayrı yenileme
///    yaparsa dönen yenileme token'ı yüzünden ikincisi sunucuya TEKRAR
///    KULLANIM gibi görünür ve auth servisi kullanıcının bütün oturumlarını
///    kapatır — yani kullanıcı hiç yoktan dışarı atılır. Bu yüzden aynı anda
///    yalnızca BİR yenileme koşar, diğerleri onu bekler.
///
/// 2. **Yenileme yanıtındaki iki token.** Sunucu yenilemede hem yeni erişim
///    hem yeni yenileme token'ı döner ve eskisini geçersiz kılar. İkisi de
///    yazılmazsa bir sonraki yenileme kesin düşer.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required AuthApi authApi,
    required TokenStore store,
    required Dio retryDio,
  }) : _authApi = authApi,
       _store = store,
       _retryDio = retryDio;

  final AuthApi _authApi;
  final TokenStore _store;

  /// Yeniden denemeyi ÜZERİNDE interceptor olmayan bir Dio ile yaparız;
  /// yoksa tekrar 401 gelirse yenileme zinciri iç içe geçer.
  final Dio _retryDio;

  /// Zorunlu çıkış bildirimi.
  ///
  /// Geri çağırım DEĞİL akış: geri çağırım olsaydı dio interceptor'ı
  /// oturum notifier'ına, notifier da dio'ya bağlı olurdu ve provider'lar
  /// döngüye girerdi. Akışla bağımlılık tek yönlü kalıyor — interceptor
  /// kimin dinlediğini bilmez.
  final _forcedSignOut = StreamController<void>.broadcast();

  Stream<void> get onForcedSignOut => _forcedSignOut.stream;

  Future<void> _signOut() async {
    _tokens = null;
    await _store.clear();
    if (!_forcedSignOut.isClosed) _forcedSignOut.add(null);
  }

  void dispose() => _forcedSignOut.close();

  AuthTokens? _tokens;

  /// Süren yenileme. null değilse başka bir istek zaten yeniliyor demektir.
  Completer<AuthTokens?>? _refreshing;

  /// Bellekteki token'ları ayarlar. Giriş/çıkışta AuthNotifier çağırır.
  void setTokens(AuthTokens? t) => _tokens = t;

  /// Geçerli erişim token'ı; yoksa null.
  ///
  /// WEBSOCKET İÇİN VAR: dio'nun interceptor'ı yalnızca HTTP isteklerine
  /// başlık ekliyor, el sıkışmayı web_socket_channel yapıyor ve başlığı
  /// kendisi koymak zorunda. Token'ı ikinci bir yerde saklamak yerine tek
  /// kaynaktan okutuyoruz — iki kopya kaçınılmaz olarak ayrışırdı.
  String? get accessToken => _tokens?.accessToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _tokens?.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final isAuthEndpoint = err.requestOptions.path.startsWith('/auth/');
    if (err.response?.statusCode != 401 || isAuthEndpoint) {
      handler.next(err);
      return;
    }

    // Bu isteği daha önce yenileyip tekrar denediysek ikinci kez deneme:
    // token gerçekten geçersiz ya da kullanıcının yetkisi yok.
    if (err.requestOptions.extra['mt.retried'] == true) {
      await _signOut();
      handler.next(err);
      return;
    }

    final fresh = await _refreshOnce();
    if (fresh == null) {
      handler.next(err);
      return;
    }

    final opts = err.requestOptions
      ..extra['mt.retried'] = true
      ..headers['Authorization'] = 'Bearer ${fresh.accessToken}';

    try {
      final r = await _retryDio.fetch<dynamic>(opts);
      handler.resolve(r);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  /// Yenilemeyi tekilleştirir: ilk çağıran işi yapar, kalanlar sonucu bekler.
  Future<AuthTokens?> _refreshOnce() {
    final current = _refreshing;
    if (current != null) return current.future;

    final completer = Completer<AuthTokens?>();
    _refreshing = completer;

    unawaited(() async {
      try {
        final refreshToken = _tokens?.refreshToken;
        if (refreshToken == null) {
          completer.complete(null);
          return;
        }

        final next = await _authApi.refresh(refreshToken);
        _tokens = next;
        await _store.writeTokens(next);
        completer.complete(next);
      } catch (_) {
        // Yenileme düştü: token gerçekten ölmüş. Oturumu kapat.
        await _signOut();
        completer.complete(null);
      } finally {
        _refreshing = null;
      }
    }());

    return completer.future;
  }
}
