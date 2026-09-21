import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

/// Renkli nokta + etiket ("8 Aktif").
///
/// Eskiden kendi KÖKÜNDE Expanded döndürüyordu, yani yalnızca bir Row/Column
/// içinde çalışıyordu ve bu bağımlılık imzasında görünmüyordu. Artık sıradan
/// bir widget; esnetmek isteyen ÇAĞIRAN sarar.
class LightInfo extends StatelessWidget {
  const LightInfo({super.key, required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.darkGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
