import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/features/live/live_providers.dart';
import 'package:milktrace/features/live/widgets/live_info_card.dart';
import 'package:milktrace/widgets/light_info.dart';

/// Canlı sağım ekranı (§15.1).
///
/// Bölge seçimi → o bölgedeki sağım noktalarının canlı kartları.
class LiveBoardScreen extends ConsumerWidget {
  const LiveBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hall = ref.watch(effectiveHallProvider);

    return hall.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _ErrorView(message: 'Bölgeler yüklenemedi', detail: '$e'),
      data: (h) => h == null
          ? const Center(child: Text('Tanımlı sağım bölgesi yok'))
          : _Board(hall: h),
    );
  }
}

class _Board extends ConsumerWidget {
  const _Board({required this.hall});

  final Hall hall;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(liveBoardProvider(hall.id));
    final spouts = ref.watch(spoutsByHallProvider(hall.id));
    final vacuums = ref.watch(vacuumsByHallProvider(hall.id));

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(liveBoardProvider(hall.id));
        await ref.read(liveBoardProvider(hall.id).future);
      },
      // Tek bir CustomScrollView. Eski ekran ListView içinde shrinkWrap'li
      // bir GridView barındırıyordu ve her build'de YENİ bir ScrollController
      // yaratıyordu (§15.3/13).
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Header(hall: hall, updates: board.value ?? const []),
          ),
          switch (board) {
            AsyncLoading() => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              ),
            AsyncError(:final error) => SliverFillRemaining(
                hasScrollBody: false,
                child: _ErrorView(
                    message: 'Canlı veri alınamadı', detail: '$error'),
              ),
            AsyncData(:final value) => _Grid(
                updates: value,
                spouts: spouts.value ?? const [],
                vacuums: vacuums.value ?? const [],
              ),
          },
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
        ],
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.hall, required this.updates});

  final Hall hall;
  final List<SpoutUpdate> updates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final halls = ref.watch(hallsProvider).value ?? const <Hall>[];

    final active = updates.where((u) => u.state == SpoutState.milking).length;
    final passive = updates.length - active;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Canlı Veriler',
              style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted)),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: hall.id,
                    isExpanded: true,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreenColor,
                    ),
                    items: [
                      for (final h in halls)
                        DropdownMenuItem(
                          value: h.id,
                          child: Text('${h.name} Bölgesi'),
                        ),
                    ],
                    onChanged: (id) {
                      if (id != null) {
                        ref.read(selectedHallProvider.notifier).select(id);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              LightInfo(color: AppColors.flowGreen, label: '$active Aktif'),
              const SizedBox(width: AppSpacing.sm),
              LightInfo(color: AppColors.flowGrey, label: '$passive Pasif'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.updates,
    required this.spouts,
    required this.vacuums,
  });

  final List<SpoutUpdate> updates;
  final List<Spout> spouts;
  final List<Vacuum> vacuums;

  @override
  Widget build(BuildContext context) {
    if (updates.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text('Bu bölgede aktif sağım yok')),
      );
    }

    final spoutById = {for (final s in spouts) s.id: s};
    final vacuumById = {for (final v in vacuums) v.id: v};

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      // mainAxisExtent: kart yüksekliği SABİT. Eski ekran childAspectRatio'yu
      // (ekran yüksekliği - 300) üzerinden hesaplıyordu; küçük ekranda kart
      // taşıyor, büyük ekranda altında boşluk kalıyordu (§15.3/12).
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 240,
          mainAxisExtent: 252,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: updates.length,
          (context, index) {
            final u = updates[index];
            final spout = spoutById[u.spoutId];
            final vacuum = spout == null ? null : vacuumById[spout.vacuumId];

            return LiveInfoCard(
              update: u,
              title: spout == null
                  ? 'Nokta'
                  : '${vacuum?.name ?? 'Ünite'} · Nokta ${spout.positionNo}',
            );
          },
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.detail});

  final String message;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppColors.flowRed, size: 40),
          const SizedBox(height: AppSpacing.sm),
          Text(message,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: AppSpacing.xs),
          Text(detail,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.onSurfaceMuted)),
        ],
      ),
    );
  }
}
