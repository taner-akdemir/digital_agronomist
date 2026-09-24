import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/domain/flow_color.dart';

part 'spout_update.freezed.dart';
part 'spout_update.g.dart';

/// Bir sağım noktasının canlı durumu — §8.5'teki WebSocket `spout.update`
/// payload'ının birebir karşılığı.
///
/// Mock dosyası (`assets/data/live_session.json`) da bu şekli kullanır;
/// MockRepository ile ApiRepository AYNI fromJson'dan geçer.
@freezed
abstract class SpoutUpdate with _$SpoutUpdate {
  const factory SpoutUpdate({
    required String sessionId,
    required String spoutId,

    /// Noktaya eşleştirilmiş hayvan; eşleşme yoksa null.
    SpoutAnimal? animal,

    /// Anlık debi, L/dk.
    @Default(0) double flowRate,

    /// Bu sağımda şu ana kadarki hacim, mL (TAMSAYI — float hatası olmasın).
    @Default(0) int volumeMl,

    /// Bu sağımda beklenen hacim, mL. 0 = beklenti yok.
    @Default(0) int expectedMl,

    /// volumeMl / expectedMl yüzdesi. Backend hesaplar.
    @Default(0) double yieldPct,

    /// Anlık debi rengi (§6.2). Backend hesaplar; uygulama AYNALAR.
    @Default(MilkColor.grey) MilkColor flowColor,

    /// Oturum verimi rengi (§6.3).
    @Default(MilkColor.grey) MilkColor yieldColor,
    @Default(SpoutState.idle) SpoutState state,
    DateTime? ts,

    /// Noktada okunan ama eşleştirilemeyen son küpe (kayıtlı değil ya da
    /// hayvan sağmal değil). Yeni sağım açılınca backend siler.
    UnmatchedTag? unmatchedTag,
  }) = _SpoutUpdate;

  factory SpoutUpdate.fromJson(Map<String, dynamic> json) =>
      _$SpoutUpdateFromJson(json);
}

/// `spout.update` içine gömülü hafif hayvan referansı (§8.5).
///
/// Tam `Animal` DEĞİLDİR: canlı ekranın çizmesi için gereken dört alanı
/// taşır ve her karede tüm hayvan kaydını göndermeyi önler.
@freezed
abstract class SpoutAnimal with _$SpoutAnimal {
  const factory SpoutAnimal({
    required String id,
    required String earTag,
    String? species,
    String? name,
  }) = _SpoutAnimal;

  factory SpoutAnimal.fromJson(Map<String, dynamic> json) =>
      _$SpoutAnimalFromJson(json);
}

/// Eşleştirilemeyen küpe okuması.
///
/// `message` backend'den geldiği gibi gösterilir (§16). `reason` string'dir,
/// enum değil: backend yeni bir sebep eklediğinde kare düşmesin.
@freezed
abstract class UnmatchedTag with _$UnmatchedTag {
  const factory UnmatchedTag({
    required String rfid,

    /// `unknown` (küpe kayıtlı değil) ya da `not_milking` (hayvan sağmal
    /// değil).
    required String reason,
    required String message,
    DateTime? at,
  }) = _UnmatchedTag;

  factory UnmatchedTag.fromJson(Map<String, dynamic> json) =>
      _$UnmatchedTagFromJson(json);
}
