import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_write.freezed.dart';
part 'pending_write.g.dart';

/// Kuyruğa girebilen yazma türleri (backend ADR 0140/1). Yalnızca YENİ
/// kayıt ekleyen, başka kaydı ezmeyen uçlar: eşleştirme, düzenleme, silme ve
/// ayarlar BİLEREK yok.
enum PendingKind {
  /// `POST /animals/{id}/notes`
  note,

  /// `POST /animals/{id}/breeding` (tohumlama, gebelik kontrolü, kızgınlık)
  breeding,

  /// `POST /animals/{id}/treatments`
  treatment,

  /// `POST /vaccinations`
  vaccination,

  /// `POST /animals/{id}/calving`
  calving,
}

/// Kuyruktaki kaydın durumu.
enum PendingState {
  /// Gönderilmeyi bekliyor (ağ ya da geçici sunucu hatası).
  pending,

  /// Gönderilemedi: sunucu reddetti, süresi doldu ya da deneme sınırı
  /// aşıldı. Kullanıcı yeniden dener ya da siler; sessizce atılmaz.
  failed,
}

/// Neden gönderilemedi.
enum PendingFailure {
  /// Sunucu reddetti (4xx); [PendingWrite.error] sunucunun mesajı.
  rejected,

  /// 7 günden eski (ADR 0140/10).
  expired,

  /// Sunucu hatası deneme sınırı aşıldı.
  retries,
}

/// Çevrimdışıyken kuyruğa alınmış bir yazma (backend ADR 0140).
///
/// [id] istemcide, ilk denemeden ÖNCE üretilir ve her denemede
/// `Idempotency-Key` olarak gider: cevabı yolda kaybolan istek yeniden
/// gönderildiğinde sunucu ikinci kaydı yazmasın.
@freezed
abstract class PendingWrite with _$PendingWrite {
  const factory PendingWrite({
    required String id,
    required PendingKind kind,

    /// Hayvana bağlı kayıtta hayvan; aşıda tek hayvan işaretlendiyse o.
    String? animalId,

    /// Listede gösterilecek konu: küpe / ad ya da "12 hayvan". Gönderilmez.
    @Default('') String subject,

    /// İsteğin alanları; biçimi [PendingPayload]'da. Gösterim için ek alan
    /// (aşı planının adı gibi) taşıyabilir, gönderen yalnızca bildiklerini
    /// okur.
    @Default(<String, dynamic>{}) Map<String, dynamic> payload,
    required DateTime createdAt,

    /// Kuyruktan yapılan deneme sayısı (ilk doğrudan istek sayılmaz).
    @Default(0) int attempts,

    /// Sunucu hatası sayısı; ağ hatası sayılmaz (ADR 0140/7).
    @Default(0) int serverErrors,

    /// Bundan önce yeniden denenmez (artan bekleme). Null: hemen.
    DateTime? nextAttemptAt,
    @Default(PendingState.pending) PendingState state,
    PendingFailure? failure,

    /// Sunucunun mesajı (reddedildiyse); olduğu gibi gösterilir.
    String? error,

    /// Gönderilemeyenlere düştüğü an (30 gün sonra silinir).
    DateTime? failedAt,
  }) = _PendingWrite;

  const PendingWrite._();

  bool get isPending => state == PendingState.pending;
  bool get isFailed => state == PendingState.failed;

  factory PendingWrite.fromJson(Map<String, dynamic> json) =>
      _$PendingWriteFromJson(json);
}
