import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

/// Sağmal olmayan hayvanın durumu ("Kuruda", "Satıldı").
///
/// Sınıf rozetinin YERİNE çizilir: sağmal olmayan hayvanın sınıfı gece
/// hesabında güncellenmiyor ve rozet güncelmiş gibi okunurdu (backend ADR
/// 0049, 0055).
class AnimalStatusChip extends StatelessWidget {
  const AnimalStatusChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
    decoration: const BoxDecoration(
      color: AppColors.background,
      borderRadius: AppRadius.smAll,
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceMuted),
    ),
  );
}
