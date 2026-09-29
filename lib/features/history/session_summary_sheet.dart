import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/session_summary.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_summary_sheet.g.dart';

/// Oturum özeti (backend ADR 0094).
@riverpod
Future<SessionSummary> sessionSummary(Ref ref, String sessionId) =>
    ref.watch(repositoryProvider).sessionSummary(sessionId);

/// Geçmişteki oturumun özeti: toplam, düşük verim, düşük debi ve sağmal olup
/// sağılmayanlar. Hayvana dokunmak detayını açar.
Future<void> showSessionSummary(BuildContext context, String sessionId) =>
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _SummarySheet(sessionId: sessionId),
    );

class _SummarySheet extends ConsumerWidget {
  const _SummarySheet({required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(sessionSummaryProvider(sessionId));
    final volume = ref.watch(volumeFormatProvider);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: AsyncView(
          value: summary,
          errorMessage: l10n.sessionSummaryLoadFailed,
          onRetry: () => ref.invalidate(sessionSummaryProvider(sessionId)),
          builder: (s) => ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              0,
              AppSpacing.xl,
              AppSpacing.xl,
            ),
            children: [
              Text(
                l10n.sessionSummaryTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.sessionSummaryTotals(s.animals, volume.amount(s.volumeMl)),
              ),
              _Section(
                title: l10n.sessionSummaryNotMilked(s.notMilked.length),
                items: s.notMilked,
                empty: l10n.sessionSummaryNoneNotMilked,
                warn: true,
              ),
              _Section(
                title: l10n.sessionSummaryLowYield(s.lowYield.length),
                items: s.lowYield,
              ),
              _Section(
                title: l10n.sessionSummaryLowFlow(s.lowFlow.length),
                items: s.lowFlow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.items,
    this.empty,
    this.warn = false,
  });

  final String title;
  final List<AnimalBrief> items;

  /// Liste boşken yazılan; null ise bölüm hiç çizilmez.
  final String? empty;
  final bool warn;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && empty == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: warn && items.isNotEmpty
                  ? AppColors.darkAmberColor
                  : AppColors.onSurface,
            ),
          ),
          if (items.isEmpty)
            Text(
              empty!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceMuted,
              ),
            ),
          for (final a in items)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              title: Text(a.label),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                context.go('/history/animal/${a.animalId}');
              },
            ),
        ],
      ),
    );
  }
}
