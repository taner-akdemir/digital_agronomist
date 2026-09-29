import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/milking_schedule.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'milking_schedule_screen.g.dart';

/// Sağım saatleri (backend ADR 0099).
@riverpod
Future<MilkingSchedule> milkingSchedule(Ref ref) =>
    ref.watch(repositoryProvider).milkingSchedule();

/// Sabah ve akşam sağım saati; saatten gecikme payı kadar sonra oturumu
/// açılmamış bölge için uyarı gelir. Hesap kartından, yalnızca sahibe.
class MilkingScheduleScreen extends ConsumerWidget {
  const MilkingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(milkingScheduleProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.scheduleTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: schedule,
        errorMessage: l10n.commonLoadFailed,
        onRetry: () => ref.invalidate(milkingScheduleProvider),
        builder: (s) => _Form(initial: s),
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.initial});

  final MilkingSchedule initial;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  late String _morning = widget.initial.morningAt;
  late String _evening = widget.initial.eveningAt;
  late int _grace = widget.initial.graceMinutes;
  bool _busy = false;

  static const _graces = [30, 45, 60, 90, 120];

  Future<void> _pick(bool morning) async {
    final current = morning ? _morning : _evening;
    final parts = current.split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: current.isEmpty
          ? TimeOfDay(hour: morning ? 6 : 17, minute: 0)
          : TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return;
    final v =
        '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';
    setState(() => morning ? _morning = v : _evening = v);
  }

  Future<void> _save() async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(repositoryProvider)
          .setMilkingSchedule(
            MilkingSchedule(
              morningAt: _morning,
              eveningAt: _evening,
              graceMinutes: _grace,
            ),
          );
      ref.invalidate(milkingScheduleProvider);
      messenger.showSnackBar(SnackBar(content: Text(l10n.scheduleSaved)));
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

  Widget _slot(String label, String value, bool morning) => SwitchListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(label),
    subtitle: Text(value.isEmpty ? l10n.scheduleOff : value),
    value: value.isNotEmpty,
    onChanged: _busy
        ? null
        : (on) {
            if (on) {
              _pick(morning);
            } else {
              setState(() => morning ? _morning = '' : _evening = '');
            }
          },
    secondary: IconButton(
      tooltip: l10n.scheduleChangeTime,
      icon: const Icon(Icons.schedule),
      onPressed: _busy ? null : () => _pick(morning),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          l10n.scheduleIntro,
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
        ),
        const SizedBox(height: AppSpacing.md),
        _slot(l10n.scheduleMorning, _morning, true),
        _slot(l10n.scheduleEvening, _evening, false),
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<int>(
          initialValue: _graces.contains(_grace) ? _grace : 45,
          decoration: InputDecoration(
            labelText: l10n.scheduleGrace,
            border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
          ),
          items: [
            for (final g in _graces)
              DropdownMenuItem(
                value: g,
                child: Text(l10n.scheduleGraceMinutes(g)),
              ),
          ],
          onChanged: _busy ? null : (v) => setState(() => _grace = v ?? _grace),
        ),
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
