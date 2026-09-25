import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert.freezed.dart';
part 'alert.g.dart';

/// Uyarı (§8.4 alerts, §8.5 GET /alerts).
///
/// `type` ve `severity` STRING'dir, enum değil: §8.4 sütunları tanımlıyor ama
/// alacakları değerleri saymıyor. Kapalı bir enum yazmak, backend yeni bir
/// uyarı türü eklediğinde uygulamanın uyarı listesini komple parse
/// edememesi demekti. Gösterim tarafı bilmediği türe varsayılan ikon verir.
///
/// `message` Türkçedir ve kullanıcıya DOĞRUDAN gösterilir (§16): hangi
/// kuralın tetiklendiğini backend bilir, uygulama kendi metnini uydurmaz.
@freezed
abstract class Alert with _$Alert {
  const factory Alert({
    required String id,
    required String message,

    /// low_flow | low_yield | device_offline | ... (§7 mt.alerts.v1)
    @Default('') String type,

    /// info | warning | critical
    @Default('warning') String severity,
    String? animalId,
    String? sessionId,
    DateTime? createdAt,
    String? acknowledgedBy,
    DateTime? acknowledgedAt,

    /// Sorunun geçtiği an: sayaç geri geldi (ADR 0041) ya da hatası düzeldi
    /// (ADR 0058). Okundu
    /// bilgisinden BAĞIMSIZ — sağımcı görmeden sayaç dönmüş olabilir.
    DateTime? resolvedAt,
  }) = _Alert;

  const Alert._();

  /// Okundu işaretlenmiş mi. Zamanı bakılır, kullanıcıya DEĞİL: uyarıyı
  /// kimin kapattığı silinebilir ama kapanma anı kalır.
  bool get isAcknowledged => acknowledgedAt != null;

  /// Sorun geçti mi (sayaç geri geldi ya da hatası düzeldi).
  bool get isResolved => resolvedAt != null;

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);
}
