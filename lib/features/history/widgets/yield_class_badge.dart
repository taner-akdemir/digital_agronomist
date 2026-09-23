import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/widgets/milk_palette.dart';

/// Verim sınıfı rozeti (§6.4).
///
/// `normal` sınıf rozet GÖSTERMEZ (§6.4 UI sütununda "—"): sürünün çoğu
/// normaldir ve hepsini rozetlemek, gerçekten ilgilenilmesi gereken üç
/// hayvanı görünmez yapardı.
class YieldClassBadge extends StatelessWidget {
  const YieldClassBadge({
    super.key,
    required this.yieldClass,
    this.dense = false,
  });

  final YieldClass yieldClass;

  /// Liste satırında küçük, detay başlığında büyük.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    if (yieldClass == YieldClass.normal) return const SizedBox.shrink();

    final palette = MilkPalette.of(yieldClass.color).filled;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? AppSpacing.sm : AppSpacing.md,
        vertical: dense ? 2 : AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        yieldClass.label,
        style: TextStyle(
          fontSize: dense ? 11 : 13,
          fontWeight: FontWeight.w600,
          color: palette.foreground,
        ),
      ),
    );
  }
}
