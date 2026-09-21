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
  }) = _Farm;

  factory Farm.fromJson(Map<String, dynamic> json) => _$FarmFromJson(json);
}
