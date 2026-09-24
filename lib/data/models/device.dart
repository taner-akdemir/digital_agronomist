import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/data/models/device_error.dart';
import 'package:milktrace/data/models/device_profile.dart';

part 'device.freezed.dart';
part 'device.g.dart';

/// Sayaç / Cihaz — sağım noktasına takılı IoT debimetre (§4, §8.4).
@freezed
abstract class Device with _$Device {
  const factory Device({
    required String id,

    /// Seri numarası; cihazı tanımlayan tek alan (§9.2 topic'lerinde geçer).
    required String serialNo,

    /// Takılı olduğu nokta; stokta bekleyen cihazda null.
    String? spoutId,

    /// Cihazın konuştuğu sözleşme (§9.0). Profil atanmamış cihaz karantinada
    /// bekliyor demektir (§8.4 quarantine) ve verisi işlenmiyor.
    ///
    /// GÖMÜLÜ gelir, ayrı bir uçtan çekilmez: profiller platform geneli ve
    /// `/admin/*` altında; üretici kullanıcının o uçlara erişimi yok ama
    /// sayacının hangi protokolü konuştuğunu görmesi gerekiyor.
    DeviceProfile? profile,
    @Default('unknown') String status,
    String? firmware,
    @Default(1.0) double calibrationFactor,
    DateTime? lastSeenAt,
    @Default(false) bool isSimulated,

    /// Son hata (backend ADR 0044); hiç hata bildirmemiş sayaçta null.
    DeviceError? lastError,
  }) = _Device;

  const Device._();

  /// "Yakın zamanda" hata: son 24 saat. Sayaç hatanın geçtiğini
  /// bildirmiyor; daha eski bir kod hâlâ sürüyor da olabilir, çoktan geçmiş
  /// de — o yüzden eskisi detayda durur ama satırı ve üniteyi işaretlemez.
  static const recentErrorWindow = Duration(hours: 24);

  bool hasRecentError(DateTime now) {
    final e = lastError;
    return e != null && now.difference(e.at) < recentErrorWindow;
  }

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}
