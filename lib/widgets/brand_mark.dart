import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

/// Marka işareti (tool/brand): açık temada koyu yeşil damla, koyu temada
/// açık yeşil damla (`mark_dark`, backend ADR 0109) — koyu zeminde koyu
/// damla kayboluyordu. Tema değişince kök ağacı yeniden kurar.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, required this.size});

  final double size;

  /// Geçerli parlaklığın işaret dosyası.
  static String get asset => AppColors.brightness == Brightness.dark
      ? 'assets/brand/mark_dark.png'
      : 'assets/brand/mark.png';

  @override
  Widget build(BuildContext context) =>
      Image.asset(asset, height: size, width: size);
}
