import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/activity.dart';
import 'package:milktrace/features/activity/activity_providers.dart';
import 'package:milktrace/features/activity/activity_status.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/list_detail.dart';

/// Aktivite listesi (backend ADR 0145 overview): tasmalı hayvanlar,
/// yükselişe göre sıralı. Panodan ve Sürü'den açılır; sekme kabuğunun
/// dışında, tam ekran.
///
/// Tablette liste–detay: hayvana dokunmak detayını sağ bölmede açar.
class ActivityScreen extends ConsumerStatefulWidget {
  const ActivityScreen({super.key});

  @override
  ConsumerState<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends ConsumerState<ActivityScreen> {
  /// Sağ bölmede açık hayvan (yalnızca iki bölmede).
  String? _animalId;

  @override
  Widget build(BuildContext context) {
    final rows = ref.watch(activityOverviewProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/history'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.activityTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: ListDetail(
        detail: switch (_animalId) {
          null => null,
          final id => AnimalDetailScreen(key: ValueKey(id), animalId: id),
        },
        placeholder: DetailPlaceholder(
          icon: Icons.directions_walk,
          text: l10n.activitySelectAnimal,
        ),
        list: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(activityOverviewProvider);
            await ref.read(activityOverviewProvider.future);
          },
          child: AsyncView(
            value: rows,
            errorMessage: l10n.activityLoadFailed,
            onRetry: () => ref.invalidate(activityOverviewProvider),
            builder: (list) => list.isEmpty
                ? ListView(
                    // Kaydırılabilir kalsın: boş listede de yenilenir.
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    children: [
                      Icon(
                        Icons.directions_walk,
                        size: 40,
                        color: AppColors.lightGreyColor,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.activityScreenEmpty,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.onSurfaceMuted),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: list.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, i) => ActivityRowTile(
                      row: list[i],
                      selected: list[i].animalId == _animalId,
                      onTap: () {
                        final id = list[i].animalId;
                        if (ListDetailScope.isTwoPane(context)) {
                          setState(() => _animalId = id);
                        } else {
                          context.push('/history/animal/$id');
                        }
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// Overview satırı: küpe · ad, durum rozeti, yükseliş, cihaz ve son veri.
class ActivityRowTile extends StatelessWidget {
  const ActivityRowTile({
    super.key,
    required this.row,
    required this.onTap,
    this.selected = false,
  });

  final ActivityOverviewRow row;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final rise = row.risePct;
    final details = [
      if (rise == null)
        l10n.activityRiseUnknown
      else
        l10n.activityRise('${rise >= 0 ? '+' : ''}${Fmt.percent(rise)}'),
      if (row.lastHeatDetectedAt case final t?)
        l10n.activityLastHeat(Fmt.since(t)),
      if (row.serial.isNotEmpty) row.serial,
      if (row.lastSeen case final t?) Fmt.sinceShort(t),
    ];

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: BorderSide(
          color: selected ? AppColors.darkGreenColor : AppColors.border,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      [
                        row.tag,
                        if ((row.name ?? '').isNotEmpty) row.name!,
                      ].join(' · '),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      details.join(' · '),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              ActivityStatusChip(status: row.status),
            ],
          ),
        ),
      ),
    );
  }
}
