import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/quiet_hours.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiet_hours_screen.g.dart';

/// Kişinin sessiz saati (backend ADR 0107).
@riverpod
Future<QuietHours> quietHours(Ref ref) =>
    ref.watch(repositoryProvider).quietHours();

/// "22:00".
String minuteLabel(int m) =>
    '${(m ~/ 60).toString().padLeft(2, '0')}:'
    '${(m % 60).toString().padLeft(2, '0')}';

/// Sessiz saat: bu saatlerde kritik olmayan uyarılar çalmaz. Hesap
/// kartından, bütün rollere; ayar kişiye aittir, işletmeye değil.
class QuietHoursScreen extends ConsumerWidget {
  const QuietHoursScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiet = ref.watch(quietHoursProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.quietTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: quiet,
        errorMessage: l10n.commonLoadFailed,
        onRetry: () => ref.invalidate(quietHoursProvider),
        builder: (q) => _Form(initial: q),
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.initial});

  final QuietHours initial;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  late bool _enabled = widget.initial.enabled;
  late int _start = widget.initial.startMinute;
  late int _end = widget.initial.endMinute;
  bool _busy = false;

  Future<void> _pick(bool start) async {
    final current = start ? _start : _end;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: current ~/ 60, minute: current % 60),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return;
    final v = picked.hour * 60 + picked.minute;
    setState(() => start ? _start = v : _end = v);
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    if (_enabled && _start == _end) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.quietSameTime),
          backgroundColor: AppColors.dangerFill,
        ),
      );
      return;
    }
    setState(() => _busy = true);
    try {
      await ref
          .read(repositoryProvider)
          .setQuietHours(
            QuietHours(enabled: _enabled, startMinute: _start, endMinute: _end),
          );
      ref.invalidate(quietHoursProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.quietSaved)));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed('$e')),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _time(String label, int value, bool start) => ListTile(
    contentPadding: EdgeInsets.zero,
    enabled: _enabled && !_busy,
    title: Text(label),
    trailing: Text(
      minuteLabel(value),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    leading: const Icon(Icons.schedule),
    onTap: () => _pick(start),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          l10n.quietIntro,
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
        ),
        const SizedBox(height: AppSpacing.md),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.quietEnabled),
          value: _enabled,
          onChanged: _busy ? null : (v) => setState(() => _enabled = v),
        ),
        _time(l10n.quietStart, _start, true),
        _time(l10n.quietEnd, _end, false),
        const SizedBox(height: AppSpacing.xl),
        FilledButton(
          onPressed: _busy ? null : _save,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.brandFill,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          ),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
