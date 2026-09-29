import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal_group.freezed.dart';
part 'animal_group.g.dart';

/// Hayvan grubu (backend ADR 0092): padok, rasyon ya da verim grubu.
@freezed
abstract class AnimalGroup with _$AnimalGroup {
  const factory AnimalGroup({
    required String id,
    required String name,

    /// Gruptaki sağmal hayvan sayısı.
    @Default(0) int animals,
  }) = _AnimalGroup;

  factory AnimalGroup.fromJson(Map<String, dynamic> json) =>
      _$AnimalGroupFromJson(json);
}
