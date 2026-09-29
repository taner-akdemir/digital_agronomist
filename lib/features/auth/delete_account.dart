import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

/// Hesabı kalıcı siler (backend ADR 0098): parola onayı, sonra çıkış. Tek
/// sahip silemez; sunucu nedenini söyler ve pencere açık kalır.
Future<void> showDeleteAccount(BuildContext context) => showDialog<void>(
  context: context,
  builder: (_) => const _DeleteAccountDialog(),
);

class _DeleteAccountDialog extends ConsumerStatefulWidget {
  const _DeleteAccountDialog();

  @override
  ConsumerState<_DeleteAccountDialog> createState() =>
      _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<_DeleteAccountDialog> {
  final _password = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _delete() async {
    if (_password.text.isEmpty) {
      setState(() => _error = l10n.deleteAccountPasswordRequired);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(repositoryProvider).deleteMyAccount(_password.text);
      if (!mounted) return;
      Navigator.of(context).pop();
      // Hesap yok: yerel oturum ve önbellek silinir, giriş ekranına dönülür.
      await ref.read(authProvider.notifier).signOut();
    } catch (e) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = userMessage(e) ?? l10n.commonDeleteFailed('$e');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(l10n.deleteAccountTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.deleteAccountBody),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _password,
              enabled: !_busy,
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: l10n.deleteAccountPassword,
                border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                _error!,
                style: const TextStyle(color: AppColors.darkRedColor),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: AppColors.flowRed),
          onPressed: _busy ? null : _delete,
          child: Text(l10n.deleteAccountConfirm),
        ),
      ],
    );
  }
}
