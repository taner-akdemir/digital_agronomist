import 'package:freezed_annotation/freezed_annotation.dart';

part 'hall.freezed.dart';
part 'hall.g.dart';

/// Sağım Bölgesi — tesis içindeki sağım alanı (A, B, C…) (§4).
///
/// Eski modelde bu sınıf ünitenin İÇİNE gömülüydü ve aynı bilgi iki yerde
/// (hallID + hall objesi) tutulduğu için çelişebiliyordu. Artık yalnızca
/// yabancı anahtar var.
@freezed
abstract class Hall with _$Hall {
  const factory Hall({
    required String id,
    required String name,
    String? farmId,
  }) = _Hall;

  factory Hall.fromJson(Map<String, dynamic> json) => _$HallFromJson(json);
}
