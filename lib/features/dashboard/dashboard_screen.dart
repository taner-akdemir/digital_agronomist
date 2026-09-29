import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/alerts/alert_style.dart';
import 'package:milktrace/features/alerts/alerts_providers.dart';
import 'package:milktrace/features/dashboard/dashboard_providers.dart';
import 'package:milktrace/features/dashboard/upcoming_card.dart';
import 'package:milktrace/features/deliveries/deliveries_screen.dart';
import 'package:milktrace/features/deliveries/delivery_card.dart';
import 'package:milktrace/features/history/breeding_card.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/milk_palette.dart';

/// Günün özeti: toplam süt, tür bazında dağılım, sınıf dağılımı, açık
/// uyarılar (§15.1).
///
/// Ekran ÖZET ile LİSTEYİ ayrı uçlardan okur: sayılar `GET /dashboard`ten,
/// uyarı satırları `GET /alerts`ten. Uyarıları dashboard payload'ına da
/// koymak, kullanıcı bir uyarıyı okundu işaretledikten sonra burada eski
/// kopyanın kalması demekti.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(dashboardSummaryProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref
          ..invalidate(dashboardSummaryProvider)
          ..invalidate(alertListProvider)
          ..invalidate(upcomingBreedingProvider)
          ..invalidate(deliveriesProvider);
        await ref.read(dashboardSummaryProvider.future);
      },
      child: AsyncView(
        value: summary,
        errorMessage: 'Günün özeti alınamadı',
        onRetry: () => ref.invalidate(dashboardSummaryProvider),
        builder: (s) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _TodayCard(summary: s, volume: ref.watch(volumeFormatProvider)),
            const SizedBox(height: AppSpacing.md),
            _SpeciesCard(summary: s),
            const SizedBox(height: AppSpacing.md),
            _ClassCard(summary: s),
            if (s.byGroup.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              _GroupCard(
                groups: s.byGroup,
                volume: ref.watch(volumeFormatProvider),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            const _AlertsCard(),
            const DeliveryCard(),
            const UpcomingBreedingCard(),
          ],
        ),
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.summary, required this.volume});

  final DashboardSummary summary;
  final VolumeFormat volume;

  /// Günün toplamı işletmenin biriminde; kg'da tür bazında dönüştürülüp
  /// toplanır (her türün yoğunluğu ayrı, backend ADR 0086).
  String get _total {
    if (!volume.isKg || summary.bySpecies.isEmpty) {
      return volume.number(summary.totalMl);
    }
    final sum = summary.bySpecies.fold<double>(
      0,
      (acc, r) => acc + volume.value(r.totalMl, species: r.speciesId),
    );
    return sum.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Bugün toplanan süt',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
              ),
              if (summary.activeSessions > 0)
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.flowGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      '${summary.activeSessions} sağım sürüyor',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.flowGreen,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _total,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGreenColor,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                volume.label,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.onSurfaceMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            // "Günün özeti" tek bir sayıdan ibaret değil: kaç sağımdan ve
            // kaç hayvandan geldiği olmadan toplam yorumlanamaz.
            '${summary.milkingCount} sağım · ${summary.animalCount} hayvan',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeciesCard extends ConsumerWidget {
  const _SpeciesCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(speciesListProvider).value ?? const <Species>[];
    final nameById = {for (final s in species) s.id: s.nameTr};

    if (summary.bySpecies.isEmpty) {
      return const _Card(
        child: Text(
          'Bugün henüz sağım yapılmadı',
          style: TextStyle(color: AppColors.onSurfaceMuted),
        ),
      );
    }

    final max = summary.bySpecies
        .map((e) => e.totalMl)
        .reduce((a, b) => a > b ? a : b);

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tür bazında',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final row in summary.bySpecies) ...[
            _SpeciesRow(
              label: nameById[row.speciesId] ?? 'Tür',
              row: row,
              volume: ref.watch(volumeFormatProvider),
              ratio: max == 0 ? 0 : row.totalMl / max,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _SpeciesRow extends StatelessWidget {
  const _SpeciesRow({
    required this.label,
    required this.row,
    required this.ratio,
    required this.volume,
  });

  final String label;
  final VolumeFormat volume;
  final SpeciesTotal row;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$label · ${row.animalCount} hayvan',
                style: const TextStyle(fontSize: 13),
              ),
            ),
            Text(
              volume.amount(row.totalMl, species: row.speciesId),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreenColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        // Çubuk TEK renk: türler birbirinin rakibi değil, aynı ölçünün
        // parçaları. Her türe ayrı renk vermek, §6.2'nin renk anlamlarıyla
        // yarışan ikinci bir renk dili kurardı.
        ClipRRect(
          borderRadius: AppRadius.smAll,
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 6,
            backgroundColor: AppColors.veryLightGreyColor,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.chartPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ClassCard extends ConsumerWidget {
  const _ClassCard({required this.summary});

  final DashboardSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = {
      for (final c in summary.classDistribution) c.yieldClass: c.count,
    };
    final total = counts.values.fold(0, (a, b) => a + b);

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verim sınıfları · $total hayvan',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final c in YieldClass.values)
            if (c != YieldClass.normal || (counts[c] ?? 0) > 0)
              _ClassRow(
                yieldClass: c,
                count: counts[c] ?? 0,
                total: total,
                // Sayıya basmak Geçmiş sekmesini O SINIFA filtreler:
                // "3 hayvan kuruya aday" satırının ilk sorusu "hangileri?".
                onTap: (counts[c] ?? 0) == 0
                    ? null
                    : () {
                        ref
                            .read(animalFilterStateProvider.notifier)
                            .showOnly(c);
                        context.go('/history');
                      },
              ),
        ],
      ),
    );
  }
}

/// Grupların bugünkü toplamı (backend ADR 0092). Satıra basmak Geçmiş'i o
/// gruba filtreler.
class _GroupCard extends ConsumerWidget {
  const _GroupCard({required this.groups, required this.volume});

  final List<GroupTotal> groups;
  final VolumeFormat volume;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gruplar · bugün',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final g in groups)
            InkWell(
              borderRadius: AppRadius.smAll,
              onTap: () {
                ref
                    .read(animalFilterStateProvider.notifier)
                    .showGroup(g.groupId);
                context.go('/history');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            g.name,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${g.milked}/${g.animals} hayvan sağıldı',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.onSurfaceMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          volume.amount(g.totalMl),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        if (g.milked > 0)
                          Text(
                            'hayvan başı ${volume.amount(g.perAnimalMl)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.onSurfaceMuted,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ClassRow extends StatelessWidget {
  const _ClassRow({
    required this.yieldClass,
    required this.count,
    required this.total,
    this.onTap,
  });

  final YieldClass yieldClass;
  final int count;
  final int total;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final palette = MilkPalette.of(yieldClass.color);

    return InkWell(
      borderRadius: AppRadius.smAll,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: palette.foreground,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                yieldClass.label,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            Text(
              '$count',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 52,
              child: Text(
                total == 0 ? '' : Fmt.percent(count / total * 100),
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceMuted,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 18,
              color: onTap == null
                  ? Colors.transparent
                  : AppColors.lightGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertsCard extends ConsumerWidget {
  const _AlertsCard();

  /// Dashboard'da gösterilen açık uyarı sayısı. Tamamı bildirim merkezinde.
  static const int _limit = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertListProvider);
    final open = (alerts.value ?? const <Alert>[])
        .where((a) => !a.isAcknowledged)
        .toList(growable: false);

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Açık uyarılar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              if (open.isNotEmpty)
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                  ),
                  onPressed: () => context.push('/alerts'),
                  child: const Text('Tümü', style: TextStyle(fontSize: 12)),
                ),
            ],
          ),
          if (open.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text(
                'Açık uyarı yok',
                style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
              ),
            )
          else ...[
            for (final a in open.take(_limit)) _AlertRow(alert: a),
            if (open.length > _limit)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  '${open.length - _limit} uyarı daha',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  const _AlertRow({required this.alert});

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    final palette = MilkPalette.of(AlertStyle.color(alert.severity));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            AlertStyle.icon(alert.type),
            size: 18,
            color: palette.foreground,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              // Metin backend'den geldiği gibi; burada yalnızca KISALTILIR
              // (§16). Dashboard tam metni değil, "bir şey var" sinyalini
              // taşır; tamamı bildirim merkezinde.
              alert.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      border: Border.all(color: AppColors.border),
    ),
    child: child,
  );
}
