import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/write_queue/pending_write.dart';
import 'package:milktrace/features/write_queue/pending_writes.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/write_queue_providers.dart';

/// Gönderilmeyi bekleyen ve gönderilemeyen kayıtlar (backend ADR 0140).
/// Bekleyenler "Şimdi gönder" ile hemen denenir; gönderilemeyenler yeniden
/// denenir ya da onayla silinir — hiçbiri sessizce atılmaz.
class PendingWritesScreen extends ConsumerWidget {
  const PendingWritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(writeQueueProvider);
    final pending = [
      for (final w in items)
        if (w.isPending) w,
    ];
    final failed = [
      for (final w in items)
        if (w.isFailed) w,
    ];
    final queue = ref.read(writeQueueProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.writeQueueTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.writeQueueIntro,
            style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
              child: Center(child: Text(l10n.writeQueueEmpty)),
            ),
          if (pending.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.writeQueuePendingSection,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => unawaited(queue.flush(force: true)),
                  icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                  label: Text(l10n.writeQueueSendNow),
                ),
              ],
            ),
            for (final w in pending) _WriteTile(write: w),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (failed.isNotEmpty) ...[
            Text(
              l10n.writeQueueFailedSection,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            for (final w in failed)
              _WriteTile(
                write: w,
                actions: [
                  TextButton(
                    onPressed: () => unawaited(queue.retry(w.id)),
                    child: Text(l10n.writeQueueRetry),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkRedColor,
                    ),
                    onPressed: () => _discard(context, ref, w),
                    child: Text(l10n.writeQueueDiscard),
                  ),
                ],
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _discard(
    BuildContext context,
    WidgetRef ref,
    PendingWrite w,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.writeQueueDiscardTitle),
        content: Text('${pendingTitle(w)}\n\n${l10n.writeQueueDiscardBody}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.dangerFill,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.writeQueueDiscard),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(writeQueueProvider.notifier).discard(w.id);
  }
}

class _WriteTile extends StatelessWidget {
  const _WriteTile({required this.write, this.actions = const []});

  final PendingWrite write;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final detail = pendingDetail(write);
    final reason = pendingReason(write);
    final local = write.createdAt.toLocal();
    return Card(
      margin: const EdgeInsets.only(top: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    pendingTitle(write),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                PendingChip(write: write),
              ],
            ),
            if (detail.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(detail, maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.writeQueueEnteredAt(
                '${Fmt.dayMonth(local)} ${Fmt.time(local)}',
              ),
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
            if (reason != null && reason.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                reason,
                style: TextStyle(fontSize: 12, color: AppColors.darkRedColor),
              ),
            ],
            if (actions.isEmpty)
              const SizedBox(height: AppSpacing.sm)
            else
              Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
          ],
        ),
      ),
    );
  }
}
