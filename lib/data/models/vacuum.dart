import 'package:freezed_annotation/freezed_annotation.dart';

part 'vacuum.freezed.dart';
part 'vacuum.g.dart';

/// Sağım Ünitesi — bir vakum hattı; üzerinde N sağım noktası bulunur (§4).
@freezed
abstract class Vacuum with _$Vacuum {
  const factory Vacuum({
    required String id,
    required String hallId,
    required String name,
    @Default(0) int totalSpouts,
  }) = _Vacuum;

  factory Vacuum.fromJson(Map<String, dynamic> json) => _$VacuumFromJson(json);
}
