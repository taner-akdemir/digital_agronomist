import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'two_factor_screen.g.dart';

/// İki adımlı doğrulama durumu (backend ADR 0102).
@riverpod
Future<bool> twoFactorEnabled(Ref ref) =>
    ref.watch(repositoryProvider).twoFactorEnabled();

/// İki adımlı doğrulama: kurulum (anahtar + doğrulama uygulaması bağlantısı →
/// kod → yedek kodlar) ve kapatma (parola + kod). Hesap kartından.
class TwoFactorScreen extends ConsumerWidget {
  const TwoFactorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(twoFactorEnabledProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.twoFactorTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: enabled,
        errorMessage: l10n.commonLoadFailed,
        onRetry: () => ref.invalidate(twoFactorEnabledProvider),
        builder: (on) => on ? const _Disable() : const _Setup(),
      ),
    );
  }
}

class _Setup extends ConsumerStatefulWidget {
  const _Setup();

  @override
  ConsumerState<_Setup> createState() => _SetupState();
}

class _SetupState extends ConsumerState<_Setup> {
  ({String secret, String uri})? _setup;
  List<String>? _backup;
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() body) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await body();
    } catch (e) {
      if (mounted) setState(() => _error = userMessage(e) ?? '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(repositoryProvider);
    final children = <Widget>[
      Text(
        l10n.twoFactorIntro,
        style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
      ),
      const SizedBox(height: AppSpacing.lg),
    ];
    if (_backup case final codes?) {
      children.addAll([
        Text(
          l10n.twoFactorBackupTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.twoFactorBackupBody),
        const SizedBox(height: AppSpacing.md),
        SelectableText(
          codes.join('\n'),
          style: const TextStyle(fontFamily: 'monospace', fontSize: 16),
        ),
        const SizedBox(height: AppSpacing.md),
        OutlinedButton.icon(
          onPressed: () =>
              Clipboard.setData(ClipboardData(text: codes.join('\n'))),
          icon: const Icon(Icons.copy),
          label: Text(l10n.twoFactorCopyCodes),
        ),
        const SizedBox(height: AppSpacing.sm),
        FilledButton(
          onPressed: () => ref.invalidate(twoFactorEnabledProvider),
          child: Text(l10n.twoFactorDone),
        ),
      ]);
    } else if (_setup case final s?) {
      children.addAll([
        Text(l10n.twoFactorStep1),
        const SizedBox(height: AppSpacing.sm),
        SelectableText(
          s.secret,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 16),
        ),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            TextButton.icon(
              onPressed: () => Clipboard.setData(ClipboardData(text: s.secret)),
              icon: const Icon(Icons.copy),
              label: Text(l10n.twoFactorCopyKey),
            ),
            // Aynı telefondaki doğrulama uygulaması otpauth adresini açar.
            TextButton.icon(
              onPressed: () =>
                  ref.read(supportLauncherProvider)(Uri.parse(s.uri)),
              icon: const Icon(Icons.open_in_new),
              label: Text(l10n.twoFactorOpenApp),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(l10n.twoFactorStep2),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _code,
          enabled: !_busy,
          keyboardType: TextInputType.number,
          autofillHints: const [AutofillHints.oneTimeCode],
          decoration: InputDecoration(
            labelText: l10n.twoFactorCode,
            border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        FilledButton(
          onPressed: _busy
              ? null
              : () => _run(() async {
                  final codes = await repo.twoFactorEnable(_code.text.trim());
                  if (mounted) setState(() => _backup = codes);
                }),
          child: Text(l10n.twoFactorEnable),
        ),
      ]);
    } else {
      children.add(
        FilledButton(
          onPressed: _busy
              ? null
              : () => _run(() async {
                  final s = await repo.twoFactorSetup();
                  if (mounted) setState(() => _setup = s);
                }),
          child: Text(l10n.twoFactorStart),
        ),
      );
    }
    if (_error != null) {
      children.addAll([
        const SizedBox(height: AppSpacing.md),
        Text(_error!, style: TextStyle(color: AppColors.darkRedColor)),
      ]);
    }
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: children,
    );
  }
}

class _Disable extends ConsumerStatefulWidget {
  const _Disable();

  @override
  ConsumerState<_Disable> createState() => _DisableState();
}

class _DisableState extends ConsumerState<_Disable> {
  final _password = TextEditingController();
  final _code = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _disable() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(repositoryProvider)
          .twoFactorDisable(password: _password.text, code: _code.text.trim());
      ref.invalidate(twoFactorEnabledProvider);
    } catch (e) {
      if (mounted) setState(() => _error = userMessage(e) ?? '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderRadius: AppRadius.mdAll);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Row(
          children: [
            Icon(Icons.verified_user, color: AppColors.darkGreenColor),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                l10n.twoFactorOn,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.twoFactorDisableHint,
          style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _password,
          enabled: !_busy,
          obscureText: true,
          decoration: InputDecoration(
            labelText: l10n.deleteAccountPassword,
            border: border,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: _code,
          enabled: !_busy,
          decoration: InputDecoration(
            labelText: l10n.twoFactorCodeOrBackup,
            border: border,
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(_error!, style: TextStyle(color: AppColors.darkRedColor)),
        ],
        const SizedBox(height: AppSpacing.lg),
        OutlinedButton(
          onPressed: _busy ? null : _disable,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkRedColor,
          ),
          child: Text(l10n.twoFactorDisable),
        ),
      ],
    );
  }
}
