import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

/// Henüz yapılmamış bir ekranın yer tutucusu.
///
/// Boş bir GridView göstermek yerine ne olduğunu ve NE ZAMAN geleceğini
/// söyler — eski VacuumListScreen çocuksuz bir GridView'dı ve kullanıcıya
/// bozuk bir ekran gibi görünüyordu (§15.3/20).
class StubScreen extends StatelessWidget {
  const StubScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    this.phase,
  });

  final String title;
  final IconData icon;
  final String description;

  /// "Faz 3" gibi; yol haritasındaki yeri (§17).
  final String? phase;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: AppColors.lightGreyColor),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreenColor,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.onSurfaceMuted, height: 1.4),
            ),
            if (phase != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.veryLightGreyColor,
                  borderRadius: AppRadius.smAll,
                ),
                child: Text(
                  '$phase ile gelecek',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
