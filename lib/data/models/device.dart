import 'package:freezed_annotation/freezed_annotation.dart';
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
  }) = _Device;

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
}
