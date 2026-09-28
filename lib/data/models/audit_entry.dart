import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_entry.freezed.dart';
part 'audit_entry.g.dart';

/// İşlem kaydının satırı (backend ADR 0082): kim, ne zaman, neyi değiştirdi.
@freezed
abstract class AuditEntry with _$AuditEntry {
  const factory AuditEntry({
    required String id,
    required DateTime at,

    /// "animal.update", "thresholds.update"... String: yeni olay listeyi
    /// düşürmesin; tanınmayan kod ham gösterilir.
    required String action,
    @Default('') String target,
    @Default('') String detail,

    /// Yapanın adı; boşsa kişi silinmiş.
    String? userName,
    @Default(false) bool userDeleted,
  }) = _AuditEntry;

  factory AuditEntry.fromJson(Map<String, dynamic> json) =>
      _$AuditEntryFromJson(json);
}
