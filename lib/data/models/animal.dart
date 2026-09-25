import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/domain/yield_class.dart';

part 'animal.freezed.dart';
part 'animal.g.dart';

/// Hayvan — küpe numarasıyla tanımlı birey (§4).
///
/// ESKİ MODELDEN FARKI: eski `Animal.name` "İnek" yazıyordu, yani türdü; ad
/// değildi ve küpe numarası hiç yoktu (§15.3/8). Ayrıca canlı ölçüm verisi
/// (`currentInfo`) hayvanın bir özelliği gibi gömülüydü — oysa canlı durum
/// NOKTAYA aittir, hayvana değil, ve artık SpoutUpdate'te durur.
@freezed
abstract class Animal with _$Animal {
  const factory Animal({
    required String id,
    required String speciesId,

    /// Küpe numarası — hayvanı tanımlayan alan (TÜRKVET formatı).
    required String earTag,

    /// RFID küpe; cihaz okuyabiliyorsa otomatik eşleştirme bununla yapılır.
    String? rfid,

    /// Çiftçinin verdiği ad ("Sarıkız"). Zorunlu değil.
    String? name,
    String? breed,
    DateTime? birthDate,
    DateTime? lastCalvingDate,
    @Default(0) int lactationNo,

    /// active | dry | sold | slaughtered | dead
    @Default('active') String status,

    /// §6.4 sınıflandırması. Analytics hesaplar, uygulama gösterir.
    ///
    /// Bilinmeyen değer `normal`'a düşer: backend ileride yeni bir sınıf
    /// eklerse (§6.4 "konfigüre edilebilir") uygulama parse hatası verip
    /// hayvan listesini komple kaybetmemeli.
    @Default(YieldClass.normal)
    @JsonKey(unknownEnumValue: YieldClass.normal)
    YieldClass yieldClass,

    /// Sınıfın hesaplandığı gün (backend ADR 0055). Gece hesabı yalnızca
    /// sağmal hayvanı güncellediği için sağmaldan çıkan hayvanda DONAR:
    /// etiket "o gün böyleydi" demektir. Null = hiç hesaplanmadı ya da
    /// tarihi bilinmiyor. Formdan GÖNDERİLMEZ (gövdeyi `animalBody` kuruyor);
    /// toJson'da durur ki çevrimdışı önbellek tarihi kaybetmesin.
    DateTime? yieldClassAt,
  }) = _Animal;

  const Animal._();

  /// Sağmal mı. Yalnızca sağmal hayvan eşleştirilir, sınıflandırılır ve
  /// panoda sayılır (backend: kurudaki ya da satılmış hayvanın eşleştirmesi
  /// reddedilir). Kurudaki/satılmış hayvanın sınıf etiketi ESKİDİR.
  bool get isMilking => status == 'active';

  /// Taze laktasyon süresinin VARSAYILANI: bu günlerde backend "düşüşte"
  /// ve "kuruya çıkarma adayı" etiketi vermez (backend ADR 0051). Asıl
  /// değer türün eşiğinde (`Thresholds.freshLactationDays`, ADR 0059);
  /// bu yalnızca eşik yüklenemezken kullanılır.
  static const freshLactationDays = 30;

  /// Laktasyonun kaçıncı günü: [today] ile son buzağılama arasındaki TAKVİM
  /// günü. Buzağılama tarihi yoksa ya da gelecekteyse null.
  int? daysInMilk(DateTime today) {
    final c = lastCalvingDate;
    if (c == null) return null;
    final d = DateTime.utc(
      today.year,
      today.month,
      today.day,
    ).difference(DateTime.utc(c.year, c.month, c.day)).inDays;
    return d < 0 ? null : d;
  }

  /// Durumun Türkçe adı; tanınmayan kod olduğu gibi.
  String get statusLabel => switch (status) {
    'active' => 'Sağmal',
    'dry' => 'Kuruda',
    'sold' => 'Satıldı',
    'slaughtered' => 'Kesildi',
    'dead' => 'Öldü',
    _ => status,
  };

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
}
