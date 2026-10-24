import 'package:milktrace/data/models/activity.dart';
import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_providers.g.dart';

/// Hayvanın aktivitesi: son 48 saat saatlik, 14 gün günlük (backend ADR 0145).
@riverpod
Future<AnimalActivity> animalActivity(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).animalActivity(animalId);

/// Aktivite cihazı bağlı hayvanlar, yükselişe göre azalan sırada; yükselişi
/// bilinmeyen (taban yok, veri yok) en sonda.
@riverpod
Future<List<ActivityOverviewRow>> activityOverview(Ref ref) async =>
    sortByRise(await ref.watch(repositoryProvider).activityOverview());

/// Bağlanabilecek aktivite cihazları: işletmenin, hayvana bağlı olmayan
/// tasma / pedometreleri.
@riverpod
Future<List<Device>> freeActivityDevices(Ref ref) async => [
  for (final d in await ref.watch(repositoryProvider).devices())
    if (d.isActivityTag && d.animalId == null) d,
];

/// Overview sırası: kızgınlık belirtisi en üstte görünsün diye yükseliş
/// azalan; eşitlikte küpe no ile kararlı.
List<ActivityOverviewRow> sortByRise(List<ActivityOverviewRow> rows) {
  final out = [...rows];
  out.sort((a, b) {
    final ra = a.risePct;
    final rb = b.risePct;
    if (ra == null && rb != null) return 1;
    if (ra != null && rb == null) return -1;
    if (ra != null && rb != null && ra != rb) return rb.compareTo(ra);
    return a.tag.compareTo(b.tag);
  });
  return out;
}
