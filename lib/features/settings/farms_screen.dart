import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/farm_summary.dart';
import 'package:milktrace/features/auth/role_labels.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'farms_screen.g.dart';

/// Çiftliklerim (backend ADR 0116).
@riverpod
Future<List<FarmSummary>> myFarms(Ref ref) =>
    ref.watch(repositoryProvider).myFarms();

/// Birden çok işletmenin üyesi (veteriner, danışman) için bütün
/// işletmelerin bugünkü özeti; satıra dokunmak o işletmeye geçer ve panoyu
/// açar. Hesap kartından.
class FarmsScreen extends ConsumerWidget {
  const FarmsScreen({super.key});

  Future<void> _open(BuildContext context, WidgetRef ref, FarmSummary f) async {
    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (f.tenantId != ref.read(authProvider).user?.tenantId) {
      try {
        await ref.read(authProvider.notifier).switchTenant(f.tenantId);
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(userMessage(e) ?? l10n.accountSwitchFarmFailed(e)),
            backgroundColor: AppColors.dangerFill,
          ),
        );
        return;
      }
    }
    router.go('/dashboard');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farms = ref.watch(myFarmsProvider);
    final current = ref.watch(authProvider).user?.tenantId;
    final volume = ref.watch(volumeFormatProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.farmsTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myFarmsProvider.future),
        child: AsyncView(
          value: farms,
          errorMessage: l10n.farmsLoadFailed,
          onRetry: () => ref.invalidate(myFarmsProvider),
          builder: (list) => ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(
                l10n.farmsIntro,
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final f in list)
                Card(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  color: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppRadius.mdAll,
                    side: BorderSide(
                      color: f.tenantId == current
                          ? AppColors.darkGreenColor
                          : AppColors.border,
                    ),
                  ),
                  child: ListTile(
                    onTap: () => _open(context, ref, f),
                    title: Text(
                      f.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${roleLabel(f.role)}'
                          '${f.tenantId == current ? ' · ${l10n.farmsCurrent}' : ''}',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.onSurfaceMuted,
                          ),
                        ),
                        // Birim ve yoğunluk seçili işletmeninki; öteki
                        // işletmeler yaklaşık (tür bilinmiyor: 1,03).
                        Text(
                          l10n.farmsLine(
                            volume.amount(f.todayMl, digits: 0),
                            f.todayAnimals,
                          ),
                        ),
                        if (f.openAlerts > 0 || f.vaccinationsDue > 0)
                          Text(
                            [
                              if (f.openAlerts > 0)
                                l10n.farmsAlerts(f.openAlerts),
                              if (f.vaccinationsDue > 0)
                                l10n.farmsVaccines(f.vaccinationsDue),
                            ].join(' · '),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkAmberColor,
                            ),
                          ),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
