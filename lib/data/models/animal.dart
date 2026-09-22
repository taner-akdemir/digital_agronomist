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
  }) = _Animal;

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
}
