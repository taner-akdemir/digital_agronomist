import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_error.freezed.dart';
part 'device_error.g.dart';

/// Sayacın bildirdiği son hata (backend ADR 0044).
///
/// Sağım sırasında olsun olmasın yazılır: sağım dışındaki arıza sağımcıya
/// uyarı üretmiyor ama sabah sağımından önce görülmeli.
@freezed
abstract class DeviceError with _$DeviceError {
  const factory DeviceError({
    /// Üreticinin hata kodu (E17 gibi), backend'in süzdüğü hâliyle.
    required String code,

    /// Kodun anlamı, profilin hata kodu tablosundan (backend ADR 0043);
    /// tabloda yoksa null ve kod ham gösterilir. Uygulama kendi metnini
    /// uydurmaz (§16).
    String? description,
    required DateTime at,
  }) = _DeviceError;

  factory DeviceError.fromJson(Map<String, dynamic> json) =>
      _$DeviceErrorFromJson(json);
}
