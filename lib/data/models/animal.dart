import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/data/models/breeding.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/l10n/l10n.dart';

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

    /// Arınma süresinin son günü (backend ADR 0084): o güne kadar sütü
    /// tanka katılmaz. Tedavi kaydından gelir; formdan GÖNDERİLMEZ.
    DateTime? withdrawalUntil,

    /// Üreme durumu (backend ADR 0088); hiç kayıt yoksa null. Formdan
    /// GÖNDERİLMEZ.
    Pregnancy? pregnancy,

    /// Grubu (backend ADR 0092); en çok bir. PUT tam kayıt olduğu için
    /// formdan HER ZAMAN gider — null göndermek grubu kaldırır.
    String? groupId,

    /// Grubun adı; yalnızca okunur.
    String? groupName,

    /// Soy (backend ADR 0114): anne sürüdeki hayvan, baba boğa/sperma
    /// kodu. PUT tam kayıt: formdan HER ZAMAN gider, null kaldırır.
    /// `damEarTag` yalnızca okunur. Yavrular listeden süzülür (`damId`).
    String? damId,
    String? damEarTag,
    String? sireCode,

    /// Sürüden çıkış nedeni (backend ADR 0122); yalnızca satıldı, kesildi,
    /// öldü. Formdan gider; `exitedOn` sunucunun, yalnızca okunur.
    String? exitReason,
    DateTime? exitedOn,
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

  /// Sürüden çıkmış mı (satıldı, kesildi, öldü).
  bool get hasExited =>
      status == 'sold' || status == 'slaughtered' || status == 'dead';

  /// Durumun Türkçe adı; tanınmayan kod olduğu gibi.
  String get statusLabel => switch (status) {
    'active' => l10n.modelAnimalStatusActive,
    'dry' => l10n.modelAnimalStatusDry,
    'sold' => l10n.modelAnimalStatusSold,
    'slaughtered' => l10n.modelAnimalStatusSlaughtered,
    'dead' => l10n.modelAnimalStatusDead,
    _ => status,
  };

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
}

/// Sürüden çıkış nedenleri (backend ADR 0122), sırasıyla.
const exitReasons = [
  'low_yield',
  'mastitis',
  'fertility',
  'feet',
  'age',
  'accident',
  'disease',
  'other',
];

/// Çıkış nedeninin adı; tanınmayan kod olduğu gibi, null "Belirtilmedi".
String exitReasonLabel(String? code) => switch (code) {
  'low_yield' => l10n.exitReasonLowYield,
  'mastitis' => l10n.exitReasonMastitis,
  'fertility' => l10n.exitReasonFertility,
  'feet' => l10n.exitReasonFeet,
  'age' => l10n.exitReasonAge,
  'accident' => l10n.exitReasonAccident,
  'disease' => l10n.exitReasonDisease,
  'other' => l10n.exitReasonOther,
  null || 'unknown' => l10n.exitReasonUnknown,
  _ => code,
};
