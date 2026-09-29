import 'package:freezed_annotation/freezed_annotation.dart';

part 'farm.freezed.dart';
part 'farm.g.dart';

/// Tesis — bir işletmenin fiziksel tesisi (§4).
@freezed
abstract class Farm with _$Farm {
  const factory Farm({
    required String id,
    required String name,
    String? tenantId,
    String? city,
    String? district,

    /// Konum (backend ADR 0119): ısı stresi tahmininin girdisi; ikisi
    /// birlikte dolu ya da boş.
    double? latitude,
    double? longitude,
  }) = _Farm;

  factory Farm.fromJson(Map<String, dynamic> json) => _$FarmFromJson(json);
}
