import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/activity/activity_providers.dart';
import 'package:milktrace/features/activity/activity_screen.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Panodaki Aktivite özeti (backend ADR 0145): kızgınlık belirtisi ve
/// artıştaki hayvan sayısı, en çok artan üç hayvan.
///
/// Bakılacak hayvan (kızgınlık / artış) yoksa ya da okunamazsa HİÇ
/// çizilmez: pano dikkat isteyeni gösterir; bütün liste Sürü → Aktivite'de.
class ActivityDashboardCard extends ConsumerWidget {
  const ActivityDashboardCard({super.key});

  static const _shown = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final all = ref.watch(activityOverviewProvider).value ?? const [];
    final rows = [
      for (final r in all)
        if (r.status == 'heat' || r.status == 'rising') r,
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    final heat = rows.where((r) => r.status == 'heat').length;
    final rising = rows.length - heat;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
          side: BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.activityTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push('/activity'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkGreenColor,
                    ),
                    child: Text(l10n.activitySeeAll),
                  ),
                ],
              ),
              Text(
                l10n.activityDashboardSummary(heat, rising),
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final r in rows.take(_shown)) ...[
                ActivityRowTile(
                  row: r,
                  onTap: () => context.push('/history/animal/${r.animalId}'),
                ),
                const SizedBox(height: AppSpacing.xs),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
