import 'package:freezed_annotation/freezed_annotation.dart';

part 'spout.freezed.dart';
part 'spout.g.dart';

/// Sağım Noktası (Musluk) — tek bir hayvana bağlanan başlık grubu (§4).
/// Ölçüm cihazı buraya takılır.
@freezed
abstract class Spout with _$Spout {
  const factory Spout({
    required String id,
    required String vacuumId,

    /// Ünite üzerindeki sıra numarası (§8.4 spouts.position_no).
    required int positionNo,
  }) = _Spout;

  factory Spout.fromJson(Map<String, dynamic> json) => _$SpoutFromJson(json);
}
