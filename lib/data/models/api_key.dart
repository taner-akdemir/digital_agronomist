import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_key.freezed.dart';
part 'api_key.g.dart';

/// İşletme API anahtarı (backend ADR 0126), SIRSIZ kayıt. Tam anahtar
/// `mtk_<önek>_<sır>` yalnızca oluşturulunca bir kez döner ([ApiKeyCreated]).
@freezed
abstract class ApiKey with _$ApiKey {
  const factory ApiKey({
    required String id,
    required String name,
    required String prefix,
    DateTime? createdAt,
    DateTime? lastUsedAt,
    @Default('') String createdBy,
  }) = _ApiKey;

  const ApiKey._();

  /// Listede tanınsın diye: "mtk_ab12cd34_…".
  String get masked => 'mtk_${prefix}_…';

  factory ApiKey.fromJson(Map<String, dynamic> json) => _$ApiKeyFromJson(json);
}

/// `POST /api-keys` cevabı: kayıt ve TAM anahtar (bir kez).
@freezed
abstract class ApiKeyCreated with _$ApiKeyCreated {
  const factory ApiKeyCreated({required ApiKey key, required String token}) =
      _ApiKeyCreated;

  factory ApiKeyCreated.fromJson(Map<String, dynamic> json) =>
      _$ApiKeyCreatedFromJson(json);
}
