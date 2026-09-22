import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/domain/flow_color.dart';

part 'animal_milking.freezed.dart';
part 'animal_milking.g.dart';

/// Hayvan Sağımı — bir hayvanın bir oturumdaki tekil sağımı (§4, §8.4).
///
/// `GET /animals/{id}/history` bunların listesini döndürür. Canlı ekrandaki
/// [SpoutUpdate]'in KAPANMIŞ hâlidir: orada değerler her saniye değişir,
/// burada sağım bittiğinde dondurulmuş özet durur.
@freezed
abstract class AnimalMilking with _$AnimalMilking {
  const factory AnimalMilking({
    required String id,
    required String sessionId,
    required String animalId,
    String? spoutId,
    DateTime? startedAt,
    DateTime? endedAt,

    /// Alınan hacim, mL (TAMSAYI — §3'teki birim kuralı).
    @Default(0) int volumeMl,

    /// Beklenen hacim, mL. 0 = beklenti yok (yeni hayvan, veri yok).
    @Default(0) int expectedMl,

    /// L/dk.
    @Default(0) double peakFlow,
    @Default(0) double avgFlow,

    /// volumeMl / expectedMl yüzdesi. Backend hesaplar (§6.3).
    @Default(0) double yieldPct,

    /// Oturum verimi rengi (§6.3). Uygulama AYNALAMAZ, olduğu gibi kullanır.
    @Default(MilkColor.grey) MilkColor color,

    /// Oturum tipi: morning | evening | other.
    ///
    /// Oturumdan KOPYALANIR. Geçmiş listesinde her satır için ayrı oturum
    /// sorgusu yapmamak için; beklenen verim de oturum tipine göre ayrışır
    /// (§6.3), yani sabah/akşam ayrımı olmadan satırlar karşılaştırılamaz.
    @Default('morning') String sessionType,

    /// Sağımın neden kapandığı: flow_stopped | detached | session_end.
    String? endReason,
  }) = _AnimalMilking;

  factory AnimalMilking.fromJson(Map<String, dynamic> json) =>
      _$AnimalMilkingFromJson(json);
}
