import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/animal_group.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/text_prompt_dialog.dart';

/// Hayvan grupları (backend ADR 0092): padok, rasyon ya da verim grubu.
/// Geçmiş → Hayvanlar → Gruplar; YALNIZCA işletme sahibine (backend de 403).
/// Hayvan gruba formdan atanır.
class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  Future<String?> _askName(BuildContext context, {String initial = ''}) =>
      showTextPrompt(
        context,
        title: initial.isEmpty ? l10n.groupsNew : l10n.groupsRenameTitle,
        label: l10n.groupsNameLabel,
        initial: initial,
        maxLength: 40,
      );

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() action,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      ref
        ..invalidate(animalGroupsProvider)
        // Hayvanların grup adı değişmiş olabilir.
        ..invalidate(animalsProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed('$e')),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final name = await _askName(context);
    if (name == null || name.isEmpty || !context.mounted) return;
    await _run(
      context,
      ref,
      () => ref.read(repositoryProvider).createGroup(name),
    );
  }

  Future<void> _rename(
    BuildContext context,
    WidgetRef ref,
    AnimalGroup g,
  ) async {
    final name = await _askName(context, initial: g.name);
    if (name == null || name.isEmpty || name == g.name || !context.mounted) {
      return;
    }
    await _run(
      context,
      ref,
      () => ref.read(repositoryProvider).renameGroup(g.id, name),
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    AnimalGroup g,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.groupsDeleteTitle(g.name)),
        content: Text(l10n.groupsDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.flowRed),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    await _run(
      context,
      ref,
      () => ref.read(repositoryProvider).deleteGroup(g.id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(animalGroupsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/history'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.groupsTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context, ref),
        backgroundColor: AppColors.darkGreenColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(l10n.groupsAdd),
      ),
      body: AsyncView(
        value: groups,
        errorMessage: l10n.groupsLoadFailed,
        onRetry: () => ref.invalidate(animalGroupsProvider),
        builder: (list) => ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            96,
          ),
          children: [
            Text(
              l10n.groupsIntro,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceMuted,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  l10n.groupsEmpty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.onSurfaceMuted),
                ),
              ),
            for (final g in list)
              Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  title: Text(g.name),
                  subtitle: Text(l10n.groupsMilkingCount(g.animals)),
                  onTap: () => _rename(context, ref, g),
                  trailing: IconButton(
                    tooltip: l10n.groupsDeleteTooltip,
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _delete(context, ref, g),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
