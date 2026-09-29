import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/features/history/breeding_card.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Önümüzdeki 30 günün doğum ve kuruya çıkarmaları (backend ADR 0088).
/// Boşken ya da okunamazsa HİÇ çizilmez: üreme kaydı tutmayan işletmenin
/// panosunda boş bir kart durmasın, hata günün özetini bastırmasın.
class UpcomingBreedingCard extends ConsumerWidget {
  const UpcomingBreedingCard({super.key});

  static const _shown = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(upcomingBreedingProvider).value ?? const [];
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      // Material: satırların dokunma dalgası kartın zemininde görünsün.
      child: Material(
        color: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
          side: BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.upcomingTitle,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              for (final u in items.take(_shown))
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    u.event == 'calving'
                        ? Icons.child_friendly_outlined
                        : Icons.pause_circle_outline,
                    color: AppColors.darkGreenColor,
                  ),
                  title: Text(
                    [
                      u.earTag,
                      if ((u.name ?? '').isNotEmpty) u.name!,
                    ].join(' · '),
                  ),
                  subtitle: Text(u.eventLabel),
                  trailing: Text(Fmt.dayMonthYear(u.date)),
                  onTap: () => context.push('/history/animal/${u.animalId}'),
                ),
              if (items.length > _shown)
                Text(
                  l10n.upcomingMore(items.length - _shown),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
