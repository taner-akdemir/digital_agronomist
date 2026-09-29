import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:milktrace/domain/yield_class.dart';

part 'dashboard_summary.freezed.dart';
part 'dashboard_summary.g.dart';

/// `GET /dashboard` yanıtı: günün özeti, tür ve sınıf dağılımı (§8.5, §15.1).
///
/// UYARILARIN KENDİSİ BURADA DEĞİL, yalnızca sayısı var. Dashboard'un uyarı
/// listesini de taşıması, aynı kaydın iki uçtan iki farklı zamanda gelmesi
/// demekti: kullanıcı bir uyarıyı okundu işaretledikten sonra dashboard hâlâ
/// eski kopyayı gösterirdi. Ekran listeyi `GET /alerts`ten okur.
@freezed
abstract class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    /// Özetin ait olduğu gün.
    DateTime? date,

    /// Bugün şu ana kadar alınan toplam süt, mL (§3 birim kuralı).
    @Default(0) int totalMl,

    /// Bugün kapanan hayvan sağımı sayısı ve sağılan ayrı hayvan sayısı.
    @Default(0) int milkingCount,
    @Default(0) int animalCount,

    /// Şu an açık olan sağım oturumu sayısı.
    @Default(0) int activeSessions,

    /// Okunmamış uyarı sayısı.
    @Default(0) int openAlerts,

    @Default(<SpeciesTotal>[]) List<SpeciesTotal> bySpecies,

    /// §6.4 sınıf dağılımı. Sayısı sıfır olan sınıflar da gelir ki ekran
    /// "bu sınıfta hiç yok" ile "bu sınıf hiç hesaplanmadı"yı ayırabilsin.
    @Default(<YieldClassCount>[]) List<YieldClassCount> classDistribution,

    /// Grupların bugünkü toplamı (backend ADR 0092); grup yoksa boş.
    @Default(<GroupTotal>[]) List<GroupTotal> byGroup,

    /// Son 12 ayın üreme verimliliği (backend ADR 0120); örnek yoksa null.
    BreedingKpi? breeding,
  }) = _DashboardSummary;

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);
}

/// Bir türün günlük toplamı.
@freezed
abstract class SpeciesTotal with _$SpeciesTotal {
  const factory SpeciesTotal({
    required String speciesId,
    @Default(0) int totalMl,
    @Default(0) int animalCount,
  }) = _SpeciesTotal;

  factory SpeciesTotal.fromJson(Map<String, dynamic> json) =>
      _$SpeciesTotalFromJson(json);
}

/// Bir verim sınıfındaki hayvan sayısı.
@freezed
abstract class YieldClassCount with _$YieldClassCount {
  const factory YieldClassCount({
    @JsonKey(unknownEnumValue: YieldClass.normal)
    required YieldClass yieldClass,
    @Default(0) int count,
  }) = _YieldClassCount;

  factory YieldClassCount.fromJson(Map<String, dynamic> json) =>
      _$YieldClassCountFromJson(json);
}

/// Bir hayvan grubunun bugünkü toplamı (backend ADR 0092).
@freezed
abstract class GroupTotal with _$GroupTotal {
  const factory GroupTotal({
    required String groupId,
    required String name,

    /// Gruptaki sağmal hayvan sayısı.
    @Default(0) int animals,

    /// Bugün sağılan.
    @Default(0) int milked,
    @Default(0) int totalMl,
  }) = _GroupTotal;

  const GroupTotal._();

  /// Sağılan hayvan başına mL; kimse sağılmadıysa 0.
  int get perAnimalMl => milked == 0 ? 0 : totalMl ~/ milked;

  factory GroupTotal.fromJson(Map<String, dynamic> json) =>
      _$GroupTotalFromJson(json);
}

/// Üreme göstergeleri (backend ADR 0120). Her değer örnek sayısıyla; örnek
/// yoksa değer null. Hesabı SUNUCU yapar.
@freezed
abstract class BreedingKpi with _$BreedingKpi {
  const factory BreedingKpi({
    double? calvingIntervalDays,
    @Default(0) int calvingIntervals,
    double? firstServicePct,
    @Default(0) int firstServices,
    double? daysOpen,
    @Default(0) int daysOpenN,
  }) = _BreedingKpi;

  factory BreedingKpi.fromJson(Map<String, dynamic> json) =>
      _$BreedingKpiFromJson(json);
}
