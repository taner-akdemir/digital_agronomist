import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/delivery.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'milkers_screen.g.dart';

/// Sağımcı özeti (backend ADR 0090).
@riverpod
Future<List<Milker>> milkers(Ref ref, int days) =>
    ref.watch(repositoryProvider).milkers(days: days);

/// "6 dk 12 sn".
String durationLabel(int sec) {
  if (sec <= 0) return '—';
  final m = sec ~/ 60;
  final s = sec % 60;
  return m == 0 ? '$s sn' : '$m dk $s sn';
}

/// Kim sağdı: sağımcı başına oturum, sağım, süt, ortalama süre ve düşük
/// debi payı. Hesap kartından, YALNIZCA işletme sahibine.
class MilkersScreen extends ConsumerStatefulWidget {
  const MilkersScreen({super.key});

  @override
  ConsumerState<MilkersScreen> createState() => _MilkersScreenState();
}

class _MilkersScreenState extends ConsumerState<MilkersScreen> {
  int _days = 7;

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(milkersProvider(_days));
    final volume = ref.watch(volumeFormatProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Sağımcılar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(milkersProvider(_days).future),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 7, label: Text('Son 7 gün')),
                ButtonSegment(value: 30, label: Text('Son 30 gün')),
              ],
              selected: {_days},
              onSelectionChanged: (s) => setState(() => _days = s.first),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Sağımcı, oturumu açan ya da hayvanı noktaya bağlayan kişidir. '
              'Düşük debi çoğu zaman hayvandan ya da başlıktan gelir; oran '
              'bakılacak yeri gösterir, kişiyi puanlamaz.',
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
            const SizedBox(height: AppSpacing.md),
            AsyncView(
              value: list,
              errorMessage: 'Sağımcı özeti yüklenemedi',
              onRetry: () => ref.invalidate(milkersProvider(_days)),
              builder: (rows) => rows.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(AppSpacing.xl),
                      child: Text(
                        'Bu dönemde sağım yok.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.onSurfaceMuted),
                      ),
                    )
                  : Column(
                      children: [
                        for (final m in rows)
                          Container(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: AppRadius.mdAll,
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m.isKnown && m.name.isNotEmpty
                                      ? m.name
                                      : 'Sağımcısı bilinmeyen',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (!m.isKnown)
                                  const Text(
                                    'RFID ile açılan ya da eşleştireni '
                                    'silinmiş sağımlar',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.onSurfaceMuted,
                                    ),
                                  ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  '${m.sessions} oturum · ${m.milkings} sağım · '
                                  '${volume.amount(m.volumeMl, digits: 0)}',
                                ),
                                Text(
                                  'Ortalama sağım ${durationLabel(m.avgDurationSec)}'
                                  ' · düşük debi %${m.lowFlowPct.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.onSurfaceMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
