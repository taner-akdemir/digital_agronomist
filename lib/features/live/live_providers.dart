import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_providers.g.dart';

/// Bölge listesi.
///
/// Bir kez yüklenir ve seçili bölgeden BAĞIMSIZDIR. Eski ekranda her bölge
/// değişiminde bölge listesi de yeniden çekiliyordu ve açılır menü kısa süre
/// kayboluyordu (§15.3/11).
@riverpod
Future<List<Hall>> halls(Ref ref) => ref.watch(repositoryProvider).halls();

@riverpod
Future<List<Species>> speciesList(Ref ref) =>
    ref.watch(repositoryProvider).species();

@riverpod
Future<List<Thresholds>> thresholdsList(Ref ref) =>
    ref.watch(repositoryProvider).thresholds();

@riverpod
Future<List<Animal>> animals(Ref ref) =>
    ref.watch(repositoryProvider).animals();

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
  Future<List<SpoutUpdate>> build(String hallId) async {
    final repo = ref.watch(repositoryProvider);
    final live = await repo.liveSession(hallId: hallId);

    final bySpout = {for (final u in live.updates) u.spoutId: u};

    final sub = repo.watchSession(live.session.id).listen((u) {
      bySpout[u.spoutId] = u;
      state = AsyncData(bySpout.values.toList(growable: false));
    });
    ref.onDispose(sub.cancel);

    return live.updates;
  }
}
