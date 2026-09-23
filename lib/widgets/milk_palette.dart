import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/domain/flow_color.dart';

/// Bir §6.2 renginin arayüzdeki üç tonu.
///
/// Canlı kart, verim sınıfı rozeti ve geçmiş satırları AYNI eşlemeyi
/// kullanır: aynı kırmızının iki ekranda iki farklı ton çıkması, rengin
/// anlamını ("§6.2'ye göre düşük") zayıflatırdı.
class MilkPalette {
  const MilkPalette(this.foreground, this.surface, this.border);

  /// Metin, ikon ve gösterge rengi.
  final Color foreground;

  /// Kart/rozet arka planı.
  final Color surface;
  final Color border;

  static MilkPalette of(MilkColor color) => switch (color) {
    MilkColor.green => const MilkPalette(
      AppColors.flowGreen,
      AppColors.surface,
      AppColors.lightGreenColor,
    ),
    MilkColor.yellow => const MilkPalette(
      AppColors.flowYellow,
      AppColors.surface,
      AppColors.lightAmberColor,
    ),
    MilkColor.red => const MilkPalette(
      AppColors.flowRed,
      AppColors.flowRedSurface,
      AppColors.lightRedColor,
    ),
    MilkColor.grey => const MilkPalette(
      AppColors.flowGrey,
      AppColors.surfaceAlt,
      AppColors.border,
    ),
  };

  /// Rozet gibi RENKLİ zemin isteyen yerler için yumuşak dolgu.
  MilkPalette get filled => MilkPalette(foreground, border, border);
}
