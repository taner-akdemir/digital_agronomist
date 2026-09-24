import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal_note.freezed.dart';
part 'animal_note.g.dart';

/// Hayvana düşülen not (§6.4, backend ADR 0050): "son veteriner kontrolü:
/// mastitis, tedavide". Sınıflandırma karar DESTEĞİDİR; not o kararın
/// bağlamı. Notlar düzenlenmez ve silinmez.
@freezed
abstract class AnimalNote with _$AnimalNote {
  const factory AnimalNote({
    required String id,
    required String animalId,
    required String note,

    /// Yazanın adı; kullanıcı silindiyse boş.
    String? authorName,
    required DateTime createdAt,
  }) = _AnimalNote;

  factory AnimalNote.fromJson(Map<String, dynamic> json) =>
      _$AnimalNoteFromJson(json);
}
