import 'package:dio/dio.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Backend'in §16 hata zarfının Dart karşılığı.
///
/// Zarf: `{"error": {"code": "INVALID_CREDENTIALS", "message": "..."}}`
/// `message` Türkçe ve kullanıcıya DOĞRUDAN gösterilebilir; ekranlar kendi
/// metnini uydurmaz, çünkü hangi doğrulamanın düştüğünü sunucu bilir.
class ApiException implements Exception {
  const ApiException({required this.code, required this.message, this.status});

  /// Makine tarafı: `INVALID_CREDENTIALS`, `SESSION_NOT_FOUND`, ...
  final String code;

  /// Kullanıcıya gösterilecek Türkçe metin.
  final String message;

  /// HTTP durumu; ağ hatasında null.
  final int? status;

  bool get isUnauthorized => status == 401;

  /// DioException'ı zarfa göre çevirir; zarf yoksa taşıma katmanına bakar.
  ///
  /// Sunucu mesajını ASLA kendi metnimizle değiştirmeyiz: yalnızca zarf
  /// okunamadığında devreye giren yedek metinler vardır. Aksi hâlde
  /// backend'in doğrulama mesajları kullanıcıya hiç ulaşmaz.
  factory ApiException.from(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final err = data['error'];
      if (err is Map && err['message'] is String) {
        return ApiException(
          code: err['code'] as String? ?? 'UNKNOWN',
          message: err['message'] as String,
          status: e.response?.statusCode,
        );
      }
    }

    final message = switch (e.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => l10n.coreErrorTimeout,
      DioExceptionType.connectionError => l10n.coreErrorConnection,
      DioExceptionType.badCertificate => l10n.coreErrorBadCertificate,
      DioExceptionType.cancel => l10n.coreErrorCancelled,
      DioExceptionType.badResponse => l10n.coreErrorBadResponse,
      // dio 5.11: yanıt geldi ama çözümlenmesi süre sınırını aştı. Sınır
      // koymuyoruz; sunucuya ulaşıldığı için ağ hatası da sayılmaz
      // (isNetworkError).
      DioExceptionType.transformTimeout => l10n.coreErrorTransform,
      DioExceptionType.unknown => l10n.coreErrorUnknown,
    };

    return ApiException(
      code: 'NETWORK',
      message: message,
      status: e.response?.statusCode,
    );
  }

  @override
  String toString() => 'ApiException($code, $status): $message';
}

/// Hatanın kullanıcıya gösterilecek metni; API hatası değilse null.
///
/// ApiRepository DioException fırlatır (dönüşüm yalnızca giriş ucundaydı).
/// Ekranlar yalnızca `is ApiException`'a baktığı için gerçek API'de
/// backend'in Türkçe mesajı hiç görünmüyor, yerine "DioException [bad
/// response]..." yazıyordu. İkisi de burada çözülür.
String? userMessage(Object? error) => switch (error) {
  final ApiException e => e.message,
  final DioException e => ApiException.from(e).message,
  _ => null,
};
