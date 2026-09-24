import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_providers.g.dart';

/// Seçili sağım bölgesi.
///
/// Eski kodda bu seçim `_SpoutListScreenState` içinde bir alandı, seçili
/// SAYFA ise Riverpod'daydı ve ikisi birbirini göremiyordu (§15.3/19).
/// Artık tek doğruluk kaynağı burası.
@riverpod
class SelectedHall extends _$SelectedHall {
  @override
  String? build() => null;

  void select(String hallId) => state = hallId;
}

/// Seçili bölge yoksa ilk bölgeye düşer.
@riverpod
Future<Hall?> effectiveHall(Ref ref) async {
  final halls = await ref.watch(hallsProvider.future);
  if (halls.isEmpty) return null;

  final selected = ref.watch(selectedHallProvider);
  if (selected == null) return halls.first;

  return halls.firstWhere((h) => h.id == selected, orElse: () => halls.first);
}

@riverpod
Future<List<Vacuum>> vacuumsByHall(Ref ref, String hallId) =>
    ref.watch(repositoryProvider).vacuums(hallId: hallId);

/// Bölgedeki tüm noktalar.
///
/// Eski ekran "pasif nokta sayısı"nı iki ayrı Future'ın bitiş sırasına
/// bakarak hesaplıyordu ve sonuç yarış koşuluna bağlıydı; tesadüfen doğru
/// çalışıyordu çünkü biri 1 sn, diğeri 2 sn bekliyordu (§15.3/9).
/// Burada iki çağrı birlikte beklenir.
@riverpod
Future<List<Spout>> spoutsByHall(Ref ref, String hallId) async {
  final repo = ref.watch(repositoryProvider);
  final vacuums = await repo.vacuums(hallId: hallId);

  final lists = await Future.wait(
    vacuums.map((v) => repo.spouts(vacuumId: v.id)),
  );
  return lists.expand((e) => e).toList(growable: false);
}

/// Bölgenin canlı sağım durumu.
///
/// İlk yükleme `GET /sessions/{id}/live`, sonrası WebSocket akışı (§8.5).
/// Gelen her güncelleme nokta kimliğine göre yerine yazılır.
@riverpod
class LiveBoard extends _$LiveBoard {
  @override
  Future<LiveSession> build(String hallId) async {
    final repo = ref.watch(repositoryProvider);
    final live = await repo.liveSession(hallId: hallId);

    // OTURUM DA DÖNER, yalnızca noktalar değil: ekranın "Sağımı Başlat" mı
    // "Sağımı Bitir" mi göstereceğini ve eşleştirmenin hangi oturuma
    // yazılacağını bilmesi gerekiyor.
    if (live.session.id.isEmpty) return live;

    final bySpout = {for (final u in live.updates) u.spoutId: u};

    final sub = repo.watchSession(live.session.id).listen(
      (u) {
        bySpout[u.spoutId] = u;
        state = AsyncData(
          live.copyWith(updates: bySpout.values.toList(growable: false)),
        );
      },
      // Akış BİTTİYSE oturum kapanmıştır (session.ended). Tahtayı yeniden
      // kurmak "oturum yok" durumuna geçirir; aksi hâlde ekran kapanmış bir
      // sağımın son karesini sonsuza dek gösterirdi.
      //
      // Kimliği boş oturumda akış zaten anında biter; o yüzden yukarıda
      // erken dönülüyor, yoksa burası sonsuz döngü kurardı.
      onDone: ref.invalidateSelf,
    );
    ref.onDispose(sub.cancel);

    return live;
  }
}

/// Sağım kontrolü: başlat, eşleştir, bitir (§15.1).
///
/// Komutlar CANLI TAHTAYI DEĞİL provider'ı tazeler: tahta WebSocket'ten
/// besleniyor ve komuttan sonra gelen ilk kare zaten doğru durumu taşıyor.
/// Yine de oturumun KENDİSİ değiştiği için (yeni kimlik, kapanma) akışın
/// baştan kurulması gerekiyor.
@riverpod
class MilkingControl extends _$MilkingControl {
  @override
  bool build() => false; // true = bir komut sürüyor

  /// Bölgede sağım başlatır.
  Future<void> start({required String hallId, required String type}) => _run(
    () => ref.read(repositoryProvider).startSession(hallId: hallId, type: type),
  );

  /// Noktaya hayvan eşleştirir.
  Future<void> assign({
    required String sessionId,
    required String spoutId,
    required String animalId,
  }) => _run(
    () => ref
        .read(repositoryProvider)
        .assignAnimal(
          sessionId: sessionId,
          spoutId: spoutId,
          animalId: animalId,
        ),
  );

  /// Yanlış eşleştirmeyi geri alır.
  Future<void> unassign({required String sessionId, required String spoutId}) =>
      _run(
        () => ref
            .read(repositoryProvider)
            .unassignAnimal(sessionId: sessionId, spoutId: spoutId),
      );

  /// Sağımı bitirir.
  Future<void> end({required String sessionId}) =>
      _run(() => ref.read(repositoryProvider).endSession(sessionId));

  /// Komutu çalıştırır, sonra canlı tahtayı yeniden kurar.
  ///
  /// HATA YUKARI ATILIR: ekran backend'in Türkçe mesajını gösteriyor
  /// (§16), kendi metnini uydurmuyor. Bayrak finally'de düşüyor ki
  /// başarısız bir komuttan sonra düğmeler kilitli kalmasın.
  Future<void> _run(Future<void> Function() action) async {
    if (state) return; // çift dokunuş
    state = true;
    try {
      await action();
      ref.invalidate(liveBoardProvider);
    } finally {
      state = false;
    }
  }
}
