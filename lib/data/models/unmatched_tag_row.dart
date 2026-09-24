import 'package:freezed_annotation/freezed_annotation.dart';

part 'unmatched_tag_row.freezed.dart';
part 'unmatched_tag_row.g.dart';

/// Hiçbir hayvana kayıtlı olmayan, sağımda okunmuş bir küpe (backend ADR
/// 0056, GET /unmatched-tags).
///
/// Canlı karedeki `UnmatchedTag`tan farkı: o sağım sürerken yaşıyor, bu
/// sağımdan SONRA işletme sahibinin küpeyi hayvana ataması için kalıcı.
/// Küpe bir hayvanın kaydına girilince backend listeden düşürür.
@freezed
abstract class UnmatchedTagRow with _$UnmatchedTagRow {
  const factory UnmatchedTagRow({
    required String rfid,
    String? lastSessionId,

    /// En son okunduğu nokta; ekranda "Ünite A-1 · Nokta 7" olarak çizilir.
    String? lastSpoutId,
    required DateTime firstSeenAt,
    required DateTime lastSeenAt,
    @Default(1) int readCount,
  }) = _UnmatchedTagRow;

  factory UnmatchedTagRow.fromJson(Map<String, dynamic> json) =>
      _$UnmatchedTagRowFromJson(json);
}
