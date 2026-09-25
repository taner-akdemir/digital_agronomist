import 'package:dio/dio.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/auth_user.dart';

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

  Future<AuthUser> me(String accessToken) => _call(() async {
    final r = await _dio.get<dynamic>(
      '/me',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
    return AuthUser.fromJson(_data(r));
  });
}
