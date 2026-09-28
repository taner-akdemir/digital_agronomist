import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery.freezed.dart';
part 'delivery.g.dart';

/// Tank teslimi ve sayaçlarla karşılaştırması (backend ADR 0089).
///
/// Karşılaştırmayı SUNUCU yapar: pencere önceki teslimden bu yana, ayrılan
/// süt hariç. `compared` false ise (ilk teslim, uzun ara, sayaç verisi yok)
/// fark alanları boştur.
@freezed
abstract class Delivery with _$Delivery {
  const factory Delivery({
    required String id,
    required DateTime deliveredOn,
    required int volumeMl,
    @Default('') String note,
    String? authorName,
    @Default(false) bool compared,
    DateTime? periodFrom,
    @Default(0) int meteredMl,
    @Default(0) int withheldMl,
    @Default(0) double diffPct,
    @Default(false) bool mismatch,
  }) = _Delivery;

  factory Delivery.fromJson(Map<String, dynamic> json) =>
      _$DeliveryFromJson(json);
}

/// `GET /deliveries` gövdesi: işletmenin fark eşiği ve son teslimler.
@freezed
abstract class Deliveries with _$Deliveries {
  const factory Deliveries({
    @Default(5) double tolerancePct,
    @Default([]) List<Delivery> items,
  }) = _Deliveries;

  factory Deliveries.fromJson(Map<String, dynamic> json) =>
      _$DeliveriesFromJson(json);
}

/// Sağımcının dönem özeti (backend ADR 0090, `GET /milkers`). `userId`
/// boşsa sağımcı bilinmiyor (eşleştiren yok ya da hesap silinmiş).
@freezed
abstract class Milker with _$Milker {
  const factory Milker({
    String? userId,
    @Default('') String name,
    @Default(0) int sessions,
    @Default(0) int milkings,
    @Default(0) int volumeMl,
    @Default(0) int avgDurationSec,
    @Default(0) int lowFlowMilkings,
  }) = _Milker;

  const Milker._();

  bool get isKnown => userId != null;

  /// Düşük debi uyarısı alan sağımların payı (%).
  double get lowFlowPct => milkings == 0 ? 0 : lowFlowMilkings * 100 / milkings;

  factory Milker.fromJson(Map<String, dynamic> json) => _$MilkerFromJson(json);
}
