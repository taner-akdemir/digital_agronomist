import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/thresholds.dart';

/// Süt miktarının gösterimi, işletmenin biriminde (backend ADR 0086).
///
/// İçeride her şey mL (§3). İşletme kg seçtiyse miktar türün süt
/// yoğunluğuyla (kg/L, eşik ayarları) çarpılır; tür bilinmiyorsa 1,03.
class VolumeFormat {
  const VolumeFormat({this.unit = 'L', this.density = const {}});

  /// "L" ya da "kg".
  final String unit;

  /// Tür kimliği VE kodu → yoğunluk. Canlı kare türü kodla ("cow"),
  /// hayvan kaydı kimlikle taşıyor; ikisi de aranabilsin.
  final Map<String, double> density;

  static const litre = VolumeFormat();

  static const defaultDensity = 1.03;

  bool get isKg => unit == 'kg';

  /// Başlıklarda: "L" / "kg".
  String get label => isKg ? 'kg' : 'L';

  /// mL → birimde sayı.
  double value(int ml, {String? species}) {
    final l = ml / 1000;
    if (!isKg) return l;
    return l * (density[species] ?? defaultDensity);
  }

  /// "10.4" (birimsiz).
  String number(int ml, {String? species, int digits = 1}) =>
      value(ml, species: species).toStringAsFixed(digits);

  /// "10.4 L" / "10.7 kg".
  String amount(int ml, {String? species, int digits = 1}) =>
      '${number(ml, species: species, digits: digits)} $label';

  /// Eşik ve tür listesinden kurulur.
  factory VolumeFormat.from(
    String unit,
    List<Thresholds> thresholds,
    List<Species> species,
  ) {
    final byId = {for (final t in thresholds) t.speciesId: t.milkDensity};
    return VolumeFormat(
      unit: unit,
      density: {
        ...byId,
        for (final s in species)
          if (byId[s.id] != null) s.code: byId[s.id]!,
      },
    );
  }
}
