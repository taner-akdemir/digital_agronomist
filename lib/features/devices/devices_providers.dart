import 'package:milktrace/data/models/device.dart';
import 'package:milktrace/data/models/device_profile.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'devices_providers.g.dart';

/// Bir sağım noktası ve ona takılı sayaç. Sayaç null ise nokta boştur.
typedef SpoutNode = ({Spout spout, Device? device});

/// Bir ünite ve üzerindeki noktalar.
typedef VacuumNode = ({Vacuum vacuum, List<SpoutNode> spouts});

/// Bir bölge ve içindeki üniteler.
typedef HallNode = ({Hall hall, List<VacuumNode> vacuums});

/// Cihazlar sekmesinin tamamı: bölge → ünite → nokta ağacı, takılı olmayan
/// sayaçlar ve durum sayıları (§15.1).
typedef DeviceTree = ({
  List<HallNode> halls,
  List<Device> unassigned,
  int online,
  int offline,
  int emptySpouts,

  /// Tesisteki veri KAYNAKLARI: profil + o profili konuşan takılı sayaç
  /// adedi, çoktan aza sıralı (§9.0).
  ///
  /// PROTOKOLE GÖRE DEĞİL PROFİLE göre gruplanır. Faz 5'in demosu "native
  /// MQTT + üretici MQTT + Modbus" (§17) ve ilk ikisi aynı protokolü
  /// konuşuyor; protokole göre sayılsaydı üç kaynak iki satıra düşer ve
  /// demonun asıl noktası olan üretici ayrımı kaybolurdu.
  List<DeviceSource> sources,

  /// Protokol kodu → adet. Satırdaki protokol etiketi bundan besleniyor.
  Map<String, int> protocols,

  /// Profili atanmamış takılı sayaç: karantinada bekliyor demektir (§8.4)
  /// ve verisi işlenmiyor. Sessizce gizlenmesi, eksik verinin sebebini
  /// aramayı imkânsız kılardı.
  int unprofiled,
});

/// Bir profil ve onu konuşan sayaç adedi.
typedef DeviceSource = ({DeviceProfile profile, int count});

/// Tesiste birden fazla kaynak var mı.
///
/// Tek kaynaklı tesiste profil/protokol etiketi her satırda tekrarlanır ve
/// hiçbir şey ayırt etmezdi; yalnızca KARIŞIK tesiste gösteriliyor.
bool hasMixedSources(DeviceTree tree) => tree.sources.length > 1;

/// Ağacı tek seferde kurar.
///
/// Dört çağrı BİRLİKTE beklenir. Sırayla beklenseydi ekran dört kez
/// yeniden çizilir ve ara karelerde yarım bir ağaç görünürdü; eski
/// spout_list_screen'in sayımları iki Future'ın bitiş SIRASINA bağlıydı ve
/// tesadüfen doğru çalışıyordu (§15.3/9).
@riverpod
Future<DeviceTree> deviceTree(Ref ref) async {
  final repo = ref.watch(repositoryProvider);
  final (halls, vacuums, spouts, devices) = await (
    repo.halls(),
    repo.vacuums(),
    repo.spouts(),
    repo.devices(),
  ).wait;

  final deviceBySpout = {for (final d in devices) ?d.spoutId: d};

  final spoutsByVacuum = <String, List<Spout>>{};
  for (final s in spouts) {
    (spoutsByVacuum[s.vacuumId] ??= []).add(s);
  }
  for (final list in spoutsByVacuum.values) {
    list.sort((a, b) => a.positionNo.compareTo(b.positionNo));
  }

  final vacuumsByHall = <String, List<Vacuum>>{};
  for (final v in vacuums) {
    (vacuumsByHall[v.hallId] ??= []).add(v);
  }

  final tree = <HallNode>[
    for (final hall in halls)
      (
        hall: hall,
        vacuums: [
          for (final v in vacuumsByHall[hall.id] ?? const <Vacuum>[])
            (
              vacuum: v,
              spouts: [
                for (final s in spoutsByVacuum[v.id] ?? const <Spout>[])
                  (spout: s, device: deviceBySpout[s.id]),
              ],
            ),
        ],
      ),
  ];

  final protocols = <String, int>{};
  final byProfile = <String, DeviceSource>{};
  var unprofiled = 0;

  for (final d in deviceBySpout.values) {
    final profile = d.profile;
    if (profile == null) {
      unprofiled++;
      continue;
    }
    if (profile.protocol.isNotEmpty) {
      protocols.update(profile.protocol, (v) => v + 1, ifAbsent: () => 1);
    }
    final seen = byProfile[profile.id];
    byProfile[profile.id] = (profile: profile, count: (seen?.count ?? 0) + 1);
  }

  final sources = byProfile.values.toList()
    ..sort((a, b) => b.count.compareTo(a.count));

  return (
    halls: tree,
    unassigned: [
      for (final d in devices)
        if (d.spoutId == null) d,
    ],
    online: devices.where((d) => d.status == 'online').length,
    offline: devices.where((d) => d.status == 'offline').length,
    emptySpouts: spouts.where((s) => !deviceBySpout.containsKey(s.id)).length,
    sources: List<DeviceSource>.unmodifiable(sources),
    protocols: Map<String, int>.unmodifiable(protocols),
    unprofiled: unprofiled,
  );
}
