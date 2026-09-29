import 'package:json_annotation/json_annotation.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Hayvanın verim sınıfı (§6.4).
///
/// Değerler backend'in `animals.yield_class` sütunuyla birebir aynıdır
/// (§8.4). Sınıfı ANALYTICS hesaplar, uygulama yalnızca gösterir — renk
/// kuralında olduğu gibi (§6.2) karar backend'indir.
enum YieldClass {
  /// 7 gün ort. ≥ tür üst eşiği.
  @JsonValue('high')
  high,

  @JsonValue('normal')
  normal,

  /// 30 günde eşikten fazla düşüş.
  @JsonValue('declining')
  declining,

  /// 7 gün ort. < tür alt eşiği.
  @JsonValue('dry_off_candidate')
  dryOffCandidate,

  /// Son N sağımda ~0 L.
  @JsonValue('no_milk')
  noMilk;

  /// Arayüzde görünen ad (kodda İngilizce, arayüzde Türkçe — §4).
  ///
  /// "Kesim" kelimesi BİLEREK geçmiyor (§18/5): sistem karar destek
  /// aracıdır, kesim kararı vermez. Yüksek verimli bir hayvanın bu listeye
  /// düşmemesi projenin çıkış noktası (§6.4).
  String get label => switch (this) {
    YieldClass.high => l10n.domainClassHigh,
    YieldClass.normal => l10n.domainClassNormal,
    YieldClass.declining => l10n.domainClassDeclining,
    YieldClass.dryOffCandidate => l10n.domainClassDryOffCandidate,
    YieldClass.noMilk => l10n.domainClassNoMilk,
  };

  /// Rozet rengi (§6.4 UI sütunu).
  ///
  /// `normal` GRİdİR, yeşil değil: sürünün çoğu normaldir ve hepsini yeşil
  /// boyamak, gerçekten yüksek verimli olan üç hayvanı görünmez yapardı.
  MilkColor get color => switch (this) {
    YieldClass.high => MilkColor.green,
    YieldClass.normal => MilkColor.grey,
    YieldClass.declining => MilkColor.yellow,
    YieldClass.dryOffCandidate => MilkColor.red,
    YieldClass.noMilk => MilkColor.red,
  };

  /// Sınıfın ne anlama geldiği — hayvan detayında rozetin altında görünür.
  String get explanation => switch (this) {
    YieldClass.high => l10n.domainClassHighExplanation,
    YieldClass.normal => l10n.domainClassNormalExplanation,
    YieldClass.declining => l10n.domainClassDecliningExplanation,
    YieldClass.dryOffCandidate => l10n.domainClassDryOffCandidateExplanation,
    YieldClass.noMilk => l10n.domainClassNoMilkExplanation,
  };
}
