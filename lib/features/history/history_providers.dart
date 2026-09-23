import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/domain/yield_class.dart';
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

/// Bir hayvanın trendi ve sınıfı.
@riverpod
Future<AnimalTrend> animalTrend(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).animalTrend(animalId);

/// Hayvan listesi filtreleri (§15.1: "filtre: tür, sınıf").
///
/// Tek bir nesnede tutuluyor: iki ayrı provider olsaydı filtre değişiminde
/// liste iki kez yeniden hesaplanırdı.
typedef AnimalFilter = ({String? speciesId, YieldClass? yieldClass});

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
  AnimalFilter build() => (speciesId: null, yieldClass: null);

  /// Aynı değere tekrar basmak filtreyi KALDIRIR — çipler böyle çalışır.
  void toggleSpecies(String id) => state = (
    speciesId: state.speciesId == id ? null : id,
    yieldClass: state.yieldClass,
  );

  void toggleClass(YieldClass c) => state = (
    speciesId: state.speciesId,
    yieldClass: state.yieldClass == c ? null : c,
  );

  /// Filtreyi TEK bir sınıfa sabitler.
  ///
  /// toggleClass'tan farkı: aynı sınıfa ikinci kez gelince kaldırmaz.
  /// Dashboard'dan "3 hayvan kuruya aday" satırına basıldığında filtrenin
  /// kalkması, kullanıcıyı 30 hayvanlık tam listeye düşürürdü.
  void showOnly(YieldClass c) => state = (speciesId: null, yieldClass: c);

  void clear() => state = (speciesId: null, yieldClass: null);
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

  final out = all
      .where((a) => f.speciesId == null || a.speciesId == f.speciesId)
      .where((a) => f.yieldClass == null || a.yieldClass == f.yieldClass)
      .toList();

  out.sort((a, b) {
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
