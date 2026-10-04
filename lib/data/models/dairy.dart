import 'package:freezed_annotation/freezed_annotation.dart';

part 'dairy.freezed.dart';
part 'dairy.g.dart';

/// Süt alan mandıra (backend ADR 0137); platform kaydı, panelden açılır.
@freezed
abstract class Dairy with _$Dairy {
  const factory Dairy({
    required String id,
    required String name,
    @Default('') String city,
    @Default('active') String status,
  }) = _Dairy;

  factory Dairy.fromJson(Map<String, dynamic> json) => _$DairyFromJson(json);
}

/// Çiftçinin mandıraya verdiği veri paylaşım onayı (backend ADR 0137).
/// Geçmiş silinmez: iptal edilen ve süresi dolan da listede kalır.
@freezed
abstract class DairyShare with _$DairyShare {
  const factory DairyShare({
    required String id,
    required String dairyId,
    required String dairyName,
    @Default('') String dairyCity,
    required DateTime grantedAt,
    @Default('') String grantedBy,

    /// null = süresiz.
    DateTime? expiresAt,
    DateTime? revokedAt,

    /// active, expired ya da revoked — SUNUCU hesaplar.
    @Default('active') String status,
  }) = _DairyShare;

  const DairyShare._();

  bool get isActive => status == 'active';

  factory DairyShare.fromJson(Map<String, dynamic> json) =>
      _$DairyShareFromJson(json);
}

/// Paylaşım süresi; [code] sunucunun beklediği kod.
enum SharePeriod {
  threeMonths('3m'),
  oneYear('1y'),
  unlimited('unlimited');

  const SharePeriod(this.code);
  final String code;
}
