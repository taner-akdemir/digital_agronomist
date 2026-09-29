import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/animal_group.dart';
import 'package:milktrace/features/history/history_providers.dart';
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
        title: initial.isEmpty ? 'Yeni grup' : 'Grubun adı',
        label: 'Ad (ör. Padok 1, Yüksek verim)',
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
          content: Text(userMessage(e) ?? 'Kaydedilemedi: $e'),
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
        title: Text('"${g.name}" silinsin mi?'),
        content: const Text('Gruptaki hayvanlar silinmez, grupsuz kalır.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.flowRed),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sil'),
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
          tooltip: 'Geri',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/history'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Gruplar',
          style: TextStyle(
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
        label: const Text('Grup ekle'),
      ),
      body: AsyncView(
        value: groups,
        errorMessage: 'Gruplar yüklenemedi',
        onRetry: () => ref.invalidate(animalGroupsProvider),
        builder: (list) => ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            96,
          ),
          children: [
            const Text(
              'Her hayvanın en çok bir grubu olur; hayvan gruba düzenleme '
              'formundan atanır. Panoda grupların günlük toplamı görünür.',
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
            const SizedBox(height: AppSpacing.md),
            if (list.isEmpty)
              const Padding(
                padding: EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  'Henüz grup yok.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.onSurfaceMuted),
                ),
              ),
            for (final g in list)
              Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  title: Text(g.name),
                  subtitle: Text('${g.animals} sağmal hayvan'),
                  onTap: () => _rename(context, ref, g),
                  trailing: IconButton(
                    tooltip: 'Grubu sil',
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
