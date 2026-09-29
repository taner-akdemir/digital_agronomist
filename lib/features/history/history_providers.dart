import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_group.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_note.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/milking_speed.dart';
import 'package:milktrace/data/models/unmatched_tag_row.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_providers.g.dart';

/// Geçmiş oturumlar (§8.5 GET /sessions).
@riverpod
Future<List<MilkingSession>> pastSessions(Ref ref) =>
    ref.watch(repositoryProvider).sessions();

/// Bir hayvanın sağım geçmişi.
@riverpod
Future<List<AnimalMilking>> animalHistory(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).animalHistory(animalId);

/// Bir hayvanın notları, en yeni üstte.
@riverpod
Future<List<AnimalNote>> animalNotes(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).animalNotes(animalId);

/// Hiçbir hayvana kayıtlı olmayan okunmuş küpeler (backend ADR 0056).
/// Yalnızca işletme sahibinin ekranında izlenir; backend başkasına 403.
@riverpod
Future<List<UnmatchedTagRow>> unmatchedTags(Ref ref) =>
    ref.watch(repositoryProvider).unmatchedTags();

/// Nokta kimliği → "A-1 · Nokta 7". Tanınmayan küpenin nerede okunduğunu
/// kimlikle değil sağımcının bildiği adla göstermek için.
@riverpod
Future<Map<String, String>> spoutLabels(Ref ref) async {
  final repo = ref.watch(repositoryProvider);
  final vacuums = {for (final v in await repo.vacuums()) v.id: v.name};
  return {
    for (final s in await repo.spouts())
      s.id: l10n.historySpoutLabel(
        vacuums[s.vacuumId] ?? l10n.historyUnknownVacuum,
        s.positionNo,
      ),
  };
}

/// İşletmenin hayvan grupları (backend ADR 0092).
@riverpod
Future<List<AnimalGroup>> animalGroups(Ref ref) =>
    ref.watch(repositoryProvider).animalGroups();

/// Bir hayvanın trendi ve sınıfı.
@riverpod
Future<AnimalTrend> animalTrend(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).animalTrend(animalId);

/// Sağım hızı (backend ADR 0125), hayvana göre. Okunamazsa BOŞ: detay ve
/// liste bu ek bilgi yüzünden düşmesin (kart gizlenir, süzgeç boş kalır).
@riverpod
Future<Map<String, MilkingSpeed>> milkingSpeed(Ref ref) async {
  try {
    final list = await ref.watch(repositoryProvider).milkingSpeed();
    return {for (final s in list) s.animalId: s};
  } catch (_) {
    return const {};
  }
}

/// Hayvan listesi filtreleri (§15.1: "filtre: tür, sınıf").
///
/// Tek bir nesnede tutuluyor: iki ayrı provider olsaydı filtre değişiminde
/// liste iki kez yeniden hesaplanırdı.
typedef AnimalFilter = ({
  String? speciesId,
  YieldClass? yieldClass,
  String? groupId,

  /// Yalnızca yavaş sağılanlar (backend ADR 0125).
  bool slow,
});

/// keepAlive: filtre, onu okuyan ekran YOKKEN de yaşamalı.
///
/// Dashboard'daki "3 hayvan kuruya aday" satırı Geçmiş ekranı kurulmadan
/// önce filtreyi ayarlıyor; autoDispose ile bu değer ekran açılmadan
/// siliniyor ve kullanıcı 30 hayvanın tamamını görüyordu. Ayrıca sekmeden
/// çıkıp dönünce seçimin durması beklenen davranış — kabuk zaten sekme
/// yığınını koruyor.
@Riverpod(keepAlive: true)
class AnimalFilterState extends _$AnimalFilterState {
  @override
  AnimalFilter build() =>
      (speciesId: null, yieldClass: null, groupId: null, slow: false);

  /// Aynı değere tekrar basmak filtreyi KALDIRIR — çipler böyle çalışır.
  void toggleSpecies(String id) => state = (
    speciesId: state.speciesId == id ? null : id,
    yieldClass: state.yieldClass,
    groupId: state.groupId,
    slow: state.slow,
  );

  void toggleClass(YieldClass c) => state = (
    speciesId: state.speciesId,
    yieldClass: state.yieldClass == c ? null : c,
    groupId: state.groupId,
    slow: state.slow,
  );

  /// Grup süzgeci (backend ADR 0092).
  void toggleGroup(String id) => state = (
    speciesId: state.speciesId,
    yieldClass: state.yieldClass,
    groupId: state.groupId == id ? null : id,
    slow: state.slow,
  );

  /// Yavaş sağılanlar süzgeci (backend ADR 0125).
  void toggleSlow() => state = (
    speciesId: state.speciesId,
    yieldClass: state.yieldClass,
    groupId: state.groupId,
    slow: !state.slow,
  );

  /// Filtreyi TEK bir sınıfa sabitler.
  ///
  /// toggleClass'tan farkı: aynı sınıfa ikinci kez gelince kaldırmaz.
  /// Dashboard'dan "3 hayvan kuruya aday" satırına basıldığında filtrenin
  /// kalkması, kullanıcıyı 30 hayvanlık tam listeye düşürürdü.
  void showOnly(YieldClass c) =>
      state = (speciesId: null, yieldClass: c, groupId: null, slow: false);

  /// Filtreyi TEK bir gruba sabitler (panodaki grup satırı).
  void showGroup(String id) =>
      state = (speciesId: null, yieldClass: null, groupId: id, slow: false);

  void clear() =>
      state = (speciesId: null, yieldClass: null, groupId: null, slow: false);
}

/// Filtreden geçmiş hayvan listesi.
///
/// Sıralama SINIFA göre: ilgilenilmesi gereken hayvan (süt vermiyor, kuruya
/// aday, düşüşte) listenin başında olmalı. Küpe numarasına göre sıralamak,
/// 30 hayvanlık bir sürüde bile sorunlu olanı aramak demekti.
@riverpod
Future<List<Animal>> filteredAnimals(Ref ref) async {
  final all = await ref.watch(animalsProvider.future);
  final f = ref.watch(animalFilterStateProvider);
  // Hız yalnızca süzgeç açıkken okunur: liste ona bağlı kalmasın.
  final speed = f.slow
      ? await ref.watch(milkingSpeedProvider.future)
      : const <String, MilkingSpeed>{};

  final out = all
      .where((a) => f.speciesId == null || a.speciesId == f.speciesId)
      .where((a) => f.groupId == null || a.groupId == f.groupId)
      .where((a) => !f.slow || (speed[a.id]?.slow ?? false))
      // Sınıf süzgecinde yalnızca SAĞMAL hayvan: pano sınıf dağılımını
      // sağmallardan sayıyor; dokununca açılan liste aynı sayıyı göstermeli.
      .where(
        (a) =>
            f.yieldClass == null ||
            (a.isMilking && a.yieldClass == f.yieldClass),
      )
      .toList();

  // Sağmal olmayanlar EN ALTTA: sınıfları eskidir ve "önce bak" sırasına
  // girmemeli.
  out.sort((a, b) {
    if (a.isMilking != b.isMilking) return a.isMilking ? -1 : 1;
    final byClass = _attention(
      a.yieldClass,
    ).compareTo(_attention(b.yieldClass));
    return byClass != 0 ? byClass : a.earTag.compareTo(b.earTag);
  });
  return List.unmodifiable(out);
}

/// Sınıfın "önce bak" sırası. Küçük = daha acil.
int _attention(YieldClass c) => switch (c) {
  YieldClass.noMilk => 0,
  YieldClass.dryOffCandidate => 1,
  YieldClass.declining => 2,
  YieldClass.high => 3,
  YieldClass.normal => 4,
};
