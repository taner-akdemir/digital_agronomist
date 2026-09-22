import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_profile.freezed.dart';
part 'device_profile.g.dart';

/// Cihaz profili — bir üretici/model/protokol üçlüsünün sözleşmesi
/// (§9.0, §8.4 device_profiles).
///
/// Uygulamaya HAFİF hâliyle gelir: çözümleme kuralları (`match`, `points`,
/// `events`) backend'in işi, telefonun onlarla yapacağı bir şey yok.
/// `spout.update` içindeki hayvan referansıyla aynı mantık.
///
/// §16/1: marka/model adı KODA GÖMÜLMEZ. Buradaki `vendor` ve `model` birer
/// VERİDİR; uygulama onları gösterir, hiçbir yerde `if (vendor == '...')`
/// yazmaz. Üretici farkı yalnızca profil verisidir.
@freezed
abstract class DeviceProfile with _$DeviceProfile {
  const factory DeviceProfile({
    required String id,

    /// Üretici kodu, ör. `MILKTRACE`, `ORNEK-URETICI`.
    @Default('') String vendor,
    @Default('') String model,

    /// mqtt | modbus-rtu | modbus-tcp | http (§9.0)
    @Default('') String protocol,
    @Default(1) int version,

    /// approved | draft | deprecated
    @Default('approved') String status,
  }) = _DeviceProfile;

  const DeviceProfile._();

  factory DeviceProfile.fromJson(Map<String, dynamic> json) =>
      _$DeviceProfileFromJson(json);

  /// Arayüzde görünen protokol adı.
  ///
  /// Eşleme PROTOKOL üzerinedir, üretici üzerine değil (§16/1): yeni bir
  /// üretici eklendiğinde burada değişecek hiçbir şey yok. Tanınmayan
  /// protokol kodu olduğu gibi gösterilir — boş bırakmak, cihazın
  /// protokolsüz olduğu izlenimi verirdi.
  String get protocolLabel => switch (protocol) {
        'mqtt' => 'MQTT',
        'modbus-rtu' => 'Modbus RTU',
        'modbus-tcp' => 'Modbus TCP',
        'http' => 'HTTP',
        '' => 'Bilinmiyor',
        _ => protocol,
      };

  /// "ORNEK-URETICI MM-200 · v1"
  String get title {
    final name = [vendor, model].where((s) => s.isNotEmpty).join(' ');
    return name.isEmpty ? 'Profil tanımsız' : '$name · v$version';
  }
}
