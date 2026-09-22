import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/features/history/widgets/yield_class_badge.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Geçmiş sekmesi (§15.1): oturum listesi + filtrelenebilir hayvan listesi.
///
/// Hayvan detayı ayrı bir ekran (`/history/animal/:id`), sekmenin içinde
/// değil: geri tuşu detaydan listeye dönmeli, Geçmiş sekmesinden çıkmamalı.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColors.darkGreenColor,
            unselectedLabelColor: AppColors.onSurfaceMuted,
            indicatorColor: AppColors.darkGreenColor,
            tabs: [
              Tab(text: 'Hayvanlar'),
              Tab(text: 'Oturumlar'),
            ],
          ),
          Expanded(
            child: TabBarView(children: [_AnimalsTab(), _SessionsTab()]),
          ),
        ],
      ),
    );
  }
}

class _AnimalsTab extends ConsumerWidget {
  const _AnimalsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animals = ref.watch(filteredAnimalsProvider);

    return Column(
      children: [
        const _Filters(),
        Expanded(
          child: AsyncView(
            value: animals,
            errorMessage: 'Hayvanlar yüklenemedi',
            builder: (list) => list.isEmpty
                ? const _Empty('Bu filtreye uyan hayvan yok')
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0,
                        AppSpacing.lg, AppSpacing.lg),
                    itemCount: list.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (_, i) => _AnimalTile(animal: list[i]),
                  ),
          ),
        ),
      ],
    );
  }
}

class _Filters extends ConsumerWidget {
  const _Filters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(speciesListProvider).value ?? const <Species>[];
    final filter = ref.watch(animalFilterStateProvider);
    final notifier = ref.read(animalFilterStateProvider.notifier);

    // Tek satır, YATAY kaydırmalı: beş sınıf + üç tür çipi dikey sarılsaydı
    // filtreler listenin yarısını yerdi.
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        children: [
          for (final s in species)
            _Chip(
              label: s.nameTr,
              selected: filter.speciesId == s.id,
              onTap: () => notifier.toggleSpecies(s.id),
            ),
          const VerticalDivider(width: AppSpacing.lg, indent: 10, endIndent: 10),
          for (final c in YieldClass.values)
            if (c != YieldClass.normal)
              _Chip(
                label: c.label,
                selected: filter.yieldClass == c,
                onTap: () => notifier.toggleClass(c),
              ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Center(
        child: FilterChip(
          label: Text(label, style: const TextStyle(fontSize: 12)),
          selected: selected,
          onSelected: (_) => onTap(),
          showCheckmark: false,
          backgroundColor: AppColors.surface,
          selectedColor: AppColors.lightGreenColor,
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}

class _AnimalTile extends StatelessWidget {
  const _AnimalTile({required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: () => context.go('/history/animal/${animal.id}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animal.name ?? animal.earTag,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      // Ad varsa küpe altta: ad boş olabilir ama küpe
                      // hayvanı TANIMLAYAN alandır, hep görünmeli (§4).
                      animal.name == null
                          ? '${animal.breed ?? ''} · ${animal.lactationNo}. laktasyon'
                          : animal.earTag,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.onSurfaceMuted),
                    ),
                  ],
                ),
              ),
              YieldClassBadge(yieldClass: animal.yieldClass, dense: true),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.chevron_right, color: AppColors.lightGreyColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionsTab extends ConsumerWidget {
  const _SessionsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(pastSessionsProvider);
    final halls = ref.watch(hallsProvider).value ?? const <Hall>[];
    final hallById = {for (final h in halls) h.id: h};

    return AsyncView(
      value: sessions,
      errorMessage: 'Oturumlar yüklenemedi',
      builder: (list) => list.isEmpty
          ? const _Empty('Kayıtlı sağım oturumu yok')
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (_, i) =>
                  _SessionTile(session: list[i], hall: hallById[list[i].hallId]),
            ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session, required this.hall});

  final MilkingSession session;
  final Hall? hall;

  @override
  Widget build(BuildContext context) {
    final active = session.status == 'active';
    final started = session.startedAt;
    final ended = session.endedAt;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: active ? AppColors.lightGreenColor : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            active ? Icons.play_circle_fill : Icons.check_circle_outline,
            color: active ? AppColors.flowGreen : AppColors.lightGreyColor,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${hall?.name ?? '?'} Bölgesi · '
                  '${Fmt.sessionType(session.type)} Sağımı',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  started == null
                      ? 'Başlangıç bilinmiyor'
                      : '${Fmt.dayMonth(started)} · ${Fmt.time(started)}'
                          '${ended == null ? '' : ' – ${Fmt.time(ended)}'}',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.onSurfaceMuted),
                ),
              ],
            ),
          ),
          if (active)
            const Text(
              'Sürüyor',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.flowGreen,
              ),
            )
          else if (started != null && ended != null)
            Text(
              Fmt.duration(ended.difference(started)),
              style: const TextStyle(
                  fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.onSurfaceMuted),
          ),
        ),
      );
}
