import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/unmatched_tag_row.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Tanınmayan küpeler (backend ADR 0056): sağımda okunmuş ama hiçbir
/// hayvana kayıtlı olmayan küpeler. İşletme sahibi küpeyi hayvanına atar ya
/// da yok sayar.
///
/// OTOMATİK ÖĞRENME YOK (ADR 0052): küpe hiçbir zaman kendiliğinden bir
/// hayvana yazılmaz; yanlış eşleşme kalıcı olarak yanlış hayvanın sütünü
/// sayardı. Atama işletme sahibinin açık kararı.
class UnmatchedTagsScreen extends ConsumerWidget {
  const UnmatchedTagsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(unmatchedTagsProvider);
    final labels = ref.watch(spoutLabelsProvider).value ?? const {};

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.unmatchedTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: tags,
        errorMessage: l10n.unmatchedLoadFailed,
        builder: (list) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              l10n.unmatchedIntro,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.onSurfaceMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Center(child: Text(l10n.unmatchedEmpty)),
              ),
            for (final t in list)
              _TagTile(tag: t, spout: labels[t.lastSpoutId]),
          ],
        ),
      ),
    );
  }
}

class _TagTile extends ConsumerWidget {
  const _TagTile({required this.tag, this.spout});

  final UnmatchedTagRow tag;
  final String? spout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seen = tag.lastSeenAt;
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.nfc, color: AppColors.darkAmberColor),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    tag.rfid,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              [
                l10n.unmatchedLastSeenAt(spout ?? l10n.unmatchedUnknownSpout),
                '${Fmt.dayMonth(seen)} ${Fmt.time(seen)}',
                l10n.unmatchedReadCount(tag.readCount),
              ].join(' · '),
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _dismiss(context, ref),
                  child: Text(l10n.unmatchedIgnore),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilledButton(
                  onPressed: () => _assign(context, ref),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.darkGreenColor,
                  ),
                  child: Text(l10n.unmatchedAssign),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _assign(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final animal = await showModalBottomSheet<Animal>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _AnimalChooser(rfid: tag.rfid),
    );
    if (animal == null || !context.mounted) return;

    // Hayvanın zaten bir küpesi varsa değiştirmek bilinçli olmalı: eski
    // küpe o andan itibaren tanınmaz olur.
    if (animal.rfid case final old?) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.unmatchedReplaceTitle),
          content: Text(
            l10n.unmatchedReplaceBody(
              animal.name ?? animal.earTag,
              old,
              tag.rfid,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.unmatchedReplace),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }

    try {
      await ref
          .read(repositoryProvider)
          .saveAnimal(animal.copyWith(rfid: tag.rfid));
      ref
        ..invalidate(animalsProvider)
        ..invalidate(unmatchedTagsProvider);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.unmatchedAssigned(animal.earTag)),
          backgroundColor: AppColors.darkGreenColor,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed('$e')),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }

  Future<void> _dismiss(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.unmatchedIgnoreTitle),
        content: Text(l10n.unmatchedIgnoreBody(tag.rfid)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.unmatchedIgnore),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await ref.read(repositoryProvider).dismissUnmatchedTag(tag.rfid);
      ref.invalidate(unmatchedTagsProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.unmatchedIgnoreFailed('$e')),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }
}

/// Küpenin atanacağı hayvan. Küpesi OLMAYANLAR üstte: yeni küpe çoğunlukla
/// henüz küpesi girilmemiş bir hayvana aittir.
class _AnimalChooser extends ConsumerStatefulWidget {
  const _AnimalChooser({required this.rfid});

  final String rfid;

  @override
  ConsumerState<_AnimalChooser> createState() => _AnimalChooserState();
}

class _AnimalChooserState extends ConsumerState<_AnimalChooser> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final animals = ref.watch(animalsProvider);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.unmatchedChooseAnimal(widget.rfid),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextField(
                    decoration: InputDecoration(
                      hintText: l10n.unmatchedSearchHint,
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                      border: const OutlineInputBorder(
                        borderRadius: AppRadius.smAll,
                      ),
                    ),
                    onChanged: (v) => setState(() => _query = v.trim()),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AsyncView(
                value: animals,
                errorMessage: l10n.historyAnimalsLoadFailed,
                builder: (list) {
                  final q = _query.toLowerCase();
                  final matches =
                      [
                        for (final a in list)
                          if (q.isEmpty ||
                              a.earTag.toLowerCase().contains(q) ||
                              (a.name?.toLowerCase().contains(q) ?? false))
                            a,
                      ]..sort((a, b) {
                        final ra = a.rfid == null ? 0 : 1;
                        final rb = b.rfid == null ? 0 : 1;
                        return ra != rb
                            ? ra - rb
                            : a.earTag.compareTo(b.earTag);
                      });
                  return ListView.builder(
                    itemCount: matches.length,
                    itemBuilder: (_, i) {
                      final a = matches[i];
                      return ListTile(
                        title: Text(a.name ?? a.earTag),
                        subtitle: Text(
                          [
                            a.earTag,
                            a.rfid == null
                                ? l10n.unmatchedNoTag
                                : l10n.unmatchedTagValue(a.rfid!),
                            if (!a.isMilking) a.statusLabel,
                          ].join(' · '),
                        ),
                        onTap: () => Navigator.of(context).pop(a),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
