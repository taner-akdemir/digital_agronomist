import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/api_key.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/text_prompt_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_keys_screen.g.dart';

/// İşletmenin etkin API anahtarları (backend ADR 0126). Önbelleklenmez.
@riverpod
Future<List<ApiKey>> apiKeys(Ref ref) =>
    ref.watch(repositoryProvider).apiKeys();

/// API anahtarları: hesap kartından, YALNIZCA işletme sahibine (backend
/// diğer rollere 403). Anahtar SALT OKUNUR ve yalnızca gateway'in izin
/// verdiği uçlarda geçer; tam anahtar yalnızca oluşturulunca bir kez
/// gösterilir — sunucu onu saklamıyor.
class ApiKeysScreen extends ConsumerWidget {
  const ApiKeysScreen({super.key});

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final name = await showTextPrompt(
      context,
      title: l10n.apiKeysCreate,
      label: l10n.apiKeysNameLabel,
      helper: l10n.apiKeysNameHelper,
      maxLength: 60,
    );
    if (name == null || name.isEmpty || !context.mounted) return;
    try {
      final created = await ref.read(repositoryProvider).createApiKey(name);
      ref.invalidate(apiKeysProvider);
      if (!context.mounted) return;
      await showDialog<void>(
        context: context,
        // Dışarı dokunarak kapanmasın: anahtar bir daha gösterilmez.
        barrierDismissible: false,
        builder: (_) => _TokenDialog(token: created.token),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    }
  }

  Future<void> _revoke(BuildContext context, WidgetRef ref, ApiKey k) async {
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.apiKeysRevokeTitle),
        content: Text(l10n.apiKeysRevokeBody(k.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.dangerFill,
            ),
            child: Text(l10n.apiKeysRevoke),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await ref.read(repositoryProvider).revokeApiKey(k.id);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.apiKeysRevoked),
          backgroundColor: AppColors.brandFill,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonDeleteFailed(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    } finally {
      ref.invalidate(apiKeysProvider);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(apiKeysProvider);
    final muted = TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.apiKeysTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _create(context, ref),
        backgroundColor: AppColors.brandFill,
        foregroundColor: AppColors.onFill,
        icon: const Icon(Icons.key),
        label: Text(l10n.apiKeysCreate),
      ),
      body: AsyncView(
        value: list,
        errorMessage: l10n.commonLoadFailed,
        onRetry: () => ref.invalidate(apiKeysProvider),
        builder: (keys) => ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            96,
          ),
          children: [
            Text(l10n.apiKeysIntro, style: muted),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: AppRadius.smAll,
                border: Border.all(color: AppColors.border),
              ),
              child: SelectableText(
                l10n.apiKeysUsage,
                style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (keys.isEmpty) Text(l10n.apiKeysEmpty, style: muted),
            for (final k in keys)
              Card(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ListTile(
                  leading: Icon(Icons.key, color: AppColors.darkGreenColor),
                  title: Text(k.name),
                  subtitle: Text(
                    [
                      k.masked,
                      l10n.apiKeysCreatedBy(
                        k.createdBy.isEmpty ? '—' : k.createdBy,
                        k.createdAt == null
                            ? '—'
                            : Fmt.dayMonthYear(k.createdAt!),
                      ),
                      if (k.lastUsedAt case final t?)
                        l10n.apiKeysLastUsed(Fmt.since(t))
                      else
                        l10n.apiKeysNeverUsed,
                    ].join('\n'),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip: l10n.apiKeysRevoke,
                    icon: Icon(Icons.block, color: AppColors.darkRedColor),
                    onPressed: () => _revoke(context, ref, k),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Tam anahtar, BİR KEZ: kopyalama düğmesi ve uyarı.
class _TokenDialog extends StatelessWidget {
  const _TokenDialog({required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    return AlertDialog(
      title: Text(l10n.apiKeysCreatedTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.apiKeysShownOnce,
            style: TextStyle(fontSize: 13, color: AppColors.darkAmberColor),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: AppRadius.smAll,
              border: Border.all(color: AppColors.border),
            ),
            child: SelectableText(
              token,
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: token));
              messenger.showSnackBar(
                SnackBar(content: Text(l10n.apiKeysCopied)),
              );
            },
            icon: const Icon(Icons.copy),
            label: Text(l10n.apiKeysCopy),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.darkGreenColor,
            ),
          ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          style: FilledButton.styleFrom(backgroundColor: AppColors.brandFill),
          child: Text(l10n.apiKeysDone),
        ),
      ],
    );
  }
}
