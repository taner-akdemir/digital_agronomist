import 'package:dio/dio.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Kimlik uçları (§8.5: /auth/login, /auth/refresh, /auth/logout, /me).
///
/// Kendi Dio'su vardır ve o Dio'da kimlik interceptor'ı YOKTUR. Olsaydı:
/// yenileme isteği 401 alınca interceptor yine yenilemeye kalkar ve sonsuz
/// döngüye girerdi.
class AuthApi {
  AuthApi({required this._dio});

  final Dio _dio;

  Map<String, dynamic> _data(Response<dynamic> r) =>
      (r.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;

  Future<T> _call<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on DioException catch (e) {
      throw ApiException.from(e);
    }
  }

  Future<LoginResult> login({
    required String email,
    required String password,
  }) => _call(() async {
    final r = await _dio.post<dynamic>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = _data(r);
    // İki adımlı doğrulama açık (backend ADR 0102): oturum henüz yok.
    if (data['mfaRequired'] == true) {
      throw MfaRequired(data['mfaToken'] as String);
    }
    return LoginResult.fromJson(data);
  });

  /// Girişin ikinci adımı: 6 haneli kod ya da yedek kod (backend ADR 0102).
  Future<LoginResult> loginSecondFactor({
    required String mfaToken,
    required String code,
  }) => _call(() async {
    final r = await _dio.post<dynamic>(
      '/auth/login/2fa',
      data: {'mfaToken': mfaToken, 'code': code},
    );
    return LoginResult.fromJson(_data(r));
  });

  /// Üyesi olunan başka işletmeye geçer (backend ADR 0081): o işletmenin
  /// rolüyle yeni oturum; bırakılan yenileme anahtarı sunucuda iptal edilir.
  Future<LoginResult> switchTenant({
    required String accessToken,
    required String refreshToken,
    required String tenantId,
  }) => _call(() async {
    final r = await _dio.post<dynamic>(
      '/auth/switch',
      data: {'tenantId': tenantId, 'refreshToken': refreshToken},
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
    return LoginResult.fromJson(_data(r));
  });

  Future<AuthTokens> refresh(String refreshToken) => _call(() async {
    final r = await _dio.post<dynamic>(
      '/auth/refresh',
      data: {'refreshToken': refreshToken},
    );
    return AuthTokens.fromJson(_data(r));
  });

  /// Sunucudaki yenileme token'ını iptal eder.
  ///
  /// Hata YUTULUR: kullanıcı çıkışa bastıysa cihazdaki token'lar her hâlükârda
  /// silinir. Ağ yoksa çıkışın başarısız olması kullanıcıyı oturumda tutmaktan
  /// çok daha kötü olurdu.
  Future<void> logout(String refreshToken) async {
    try {
      await _dio.post<dynamic>(
        '/auth/logout',
        data: {'refreshToken': refreshToken},
      );
    } on DioException {
      // yoksay
    }
  }

  /// E-postaya parola sıfırlama bağlantısı ister (backend ADR 0074).
  ///
  /// Sunucu kayıtlı olsun olmasın aynı cevabı verir; dönen Türkçe metin
  /// olduğu gibi gösterilir (§16). Posta kapalıysa 503 ApiException.
  Future<String> requestPasswordReset(String email) => _call(() async {
    final r = await _dio.post<dynamic>(
      '/auth/password-reset',
      data: {'email': email},
    );
    return ((r.data as Map<String, dynamic>)['msg'] as String?) ??
        l10n.coreResetLinkSentFallback;
  });

  /// Destek numaraları (backend ADR 0077, kimlik doğrulamasız). Alan boşsa
  /// o düğme gösterilmez.
  Future<SupportInfo> support() => _call(() async {
    final r = await _dio.get<dynamic>('/auth/support');
    final d = _data(r);
    String? nonEmpty(Object? v) => v is String && v.isNotEmpty ? v : null;
    return (phone: nonEmpty(d['phone']), whatsapp: nonEmpty(d['whatsapp']));
  });

  Future<AuthUser> me(String accessToken) => _call(() async {
    final r = await _dio.get<dynamic>(
      '/me',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
    return AuthUser.fromJson(_data(r));
  });
}

/// Destek iletişimi; E.164 (+905…).
typedef SupportInfo = ({String? phone, String? whatsapp});

/// Parola doğru ama iki adımlı doğrulama açık: giriş ekranı kod ister
/// (backend ADR 0102). [token] ikinci adımın kısa ömürlü anahtarı.
class MfaRequired implements Exception {
  const MfaRequired(this.token);

  final String token;
}
