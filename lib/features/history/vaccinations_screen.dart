import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/vaccination.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vaccinations_screen.g.dart';

/// Aşı ve ilaç takvimi (backend ADR 0112).
@riverpod
Future<List<VaccinePlan>> vaccinePlans(Ref ref) =>
    ref.watch(repositoryProvider).vaccinePlans();

/// Zamanı geçmiş, 30 gün içinde gelecek ya da hiç uygulanmamış olanlar.
@riverpod
Future<List<VaccinationDue>> dueVaccinations(Ref ref) =>
    ref.watch(repositoryProvider).dueVaccinations();

/// Hayvan detayındaki "Aşılar" kartının verisi.
@riverpod
Future<AnimalVaccinations> animalVaccinations(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).animalVaccinations(animalId);

/// "kayıt yok" / "gecikti · 3 Eki" / "zamanı 3 Eki" ve rengi.
({String text, bool alarm}) dueLabel(
  VaccinationDue d,
  DateTime today, {
  bool next = false,
}) {
  final due = d.dueOn;
  if (due == null) return (text: l10n.vaccineNever, alarm: true);
  // Başka yıldaysa yılıyla: yıllık planda bugün uygulanan dozun sonraki
  // günü de "22 Eyl" çıkıyor ve bugünle karışıyordu.
  final shown = vaccineDay(due);
  final day = shown.year == today.year
      ? Fmt.dayMonth(shown)
      : Fmt.dayMonthYear(shown);
  if (d.overdueOn(today)) return (text: l10n.vaccineOverdue(day), alarm: true);
  return (
    text: next ? l10n.vaccineNext(day) : l10n.vaccineDueOn(day),
    alarm: false,
  );
}

/// "Uygulandı olarak işaretle": gün (varsayılan bugün, gelecek yok) ve not
/// sorar, kaydeder, ilgili listeleri tazeler. Kaydedilirse true.
Future<bool> markVaccinated(
  BuildContext context,
  WidgetRef ref, {
  required String planId,
  required List<String> animalIds,
  DateTime? today,
}) async {
  final draft = await showDialog<_MarkDraft>(
    context: context,
    builder: (_) => _MarkDialog(today: today ?? DateTime.now()),
  );
  if (draft == null || !context.mounted) return false;
  final messenger = ScaffoldMessenger.of(context);
  try {
    final n = await ref
        .read(repositoryProvider)
        .addVaccinations(
          planId: planId,
          animalIds: animalIds,
          givenOn: draft.day,
          note: draft.note,
        );
    ref
      ..invalidate(vaccinePlansProvider)
      ..invalidate(dueVaccinationsProvider)
      ..invalidate(animalVaccinationsProvider);
    messenger.showSnackBar(
      SnackBar(
        content: Text(n > 0 ? l10n.vaccineMarked(n) : l10n.vaccineMarkedNone),
        backgroundColor: n > 0 ? AppColors.brandFill : AppColors.warningFill,
      ),
    );
    return n > 0;
  } catch (e) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
        backgroundColor: AppColors.dangerFill,
      ),
    );
    return false;
  }
}

/// Aşı takvimi: planlar ve sayıları. BÜTÜN roller görür ve işaretler
/// (veteriner görüntüleyicidir); planı yalnızca sahip ekler/düzenler/siler.
class VaccinationsScreen extends ConsumerWidget {
  const VaccinationsScreen({super.key, this.today});

  /// Test için; null ise bugün.
  final DateTime? today;

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref, {
    VaccinePlan? plan,
  }) async {
    final species = ref.read(speciesListProvider).value ?? const <Species>[];
    final draft = await showDialog<_PlanDraft>(
      context: context,
      builder: (_) => _PlanDialog(plan: plan, species: species),
    );
    if (draft == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(repositoryProvider)
          .saveVaccinePlan(
            id: plan?.id,
            name: draft.name,
            intervalDays: draft.intervalDays,
            speciesId: draft.speciesId,
            note: draft.note,
          );
      ref
        ..invalidate(vaccinePlansProvider)
        ..invalidate(dueVaccinationsProvider)
        ..invalidate(animalVaccinationsProvider);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.vaccinePlanSaved),
          backgroundColor: AppColors.brandFill,
        ),
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

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    VaccinePlan plan,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.vaccinePlanDeleteTitle(plan.name)),
        content: Text(l10n.vaccinePlanDeleteBody),
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
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).deleteVaccinePlan(plan.id);
      ref
        ..invalidate(vaccinePlansProvider)
        ..invalidate(dueVaccinationsProvider)
        ..invalidate(animalVaccinationsProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonDeleteFailed(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    }
  }

  void _open(BuildContext context, VaccinePlan plan) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => VaccinePlanDueScreen(plan: plan, today: today),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(vaccinePlansProvider);
    final isOwner = ref.watch(authProvider).user?.role == 'tenant_owner';
    final species = ref.watch(speciesListProvider).value ?? const <Species>[];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/history'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.vaccineTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      floatingActionButton: isOwner
          ? FloatingActionButton.extended(
              onPressed: () => _edit(context, ref),
              backgroundColor: AppColors.brandFill,
              foregroundColor: AppColors.onFill,
              icon: const Icon(Icons.add),
              label: Text(l10n.vaccinePlanAdd),
            )
          : null,
      body: AsyncView(
        value: plans,
        errorMessage: l10n.vaccineLoadFailed,
        onRetry: () => ref.invalidate(vaccinePlansProvider),
        builder: (list) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(vaccinePlansProvider);
            await ref.read(vaccinePlansProvider.future);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              96,
            ),
            children: [
              Text(
                l10n.vaccineIntro,
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
              ),
              const SizedBox(height: AppSpacing.md),
              if (list.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Text(
                    isOwner ? l10n.vaccineEmptyOwner : l10n.vaccineEmpty,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.onSurfaceMuted),
                  ),
                ),
              for (final p in list)
                _PlanTile(
                  plan: p,
                  speciesName: species
                      .where((s) => s.id == p.speciesId)
                      .firstOrNull
                      ?.displayName,
                  onTap: () => _open(context, p),
                  onEdit: isOwner ? () => _edit(context, ref, plan: p) : null,
                  onDelete: isOwner ? () => _delete(context, ref, p) : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.plan,
    required this.speciesName,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final VaccinePlan plan;
  final String? speciesName;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final alarm = plan.dueSoon > 0;
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: BorderSide(
          color: alarm ? AppColors.amberColor : AppColors.border,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.vaccines_outlined,
          color: alarm ? AppColors.darkAmberColor : AppColors.darkGreenColor,
        ),
        title: Text(
          plan.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          [
            [
              l10n.vaccinePlanEvery(plan.intervalDays),
              speciesName ?? l10n.vaccineAllSpecies,
            ].join(' · '),
            l10n.vaccinePlanCounts(plan.animals, plan.dueSoon, plan.never),
            if (plan.note.isNotEmpty) plan.note,
          ].join('\n'),
        ),
        isThreeLine: true,
        onTap: onTap,
        trailing: onEdit == null
            ? const Icon(Icons.chevron_right)
            : PopupMenuButton<String>(
                onSelected: (v) => v == 'edit' ? onEdit!() : onDelete!(),
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'edit', child: Text(l10n.commonEdit)),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(l10n.commonDelete),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Planın zamanı gelen hayvanları: kayıtsız ve en gecikmiş üstte (sunucu
/// sıralar). Seçilenler tek istekte "uygulandı" işaretlenir.
class VaccinePlanDueScreen extends ConsumerStatefulWidget {
  const VaccinePlanDueScreen({super.key, required this.plan, this.today});

  final VaccinePlan plan;

  /// Test için; null ise bugün.
  final DateTime? today;

  @override
  ConsumerState<VaccinePlanDueScreen> createState() =>
      _VaccinePlanDueScreenState();
}

class _VaccinePlanDueScreenState extends ConsumerState<VaccinePlanDueScreen> {
  final Set<String> _selected = {};

  DateTime get _today => widget.today ?? DateTime.now();

  Future<void> _mark() async {
    final ok = await markVaccinated(
      context,
      ref,
      planId: widget.plan.id,
      animalIds: _selected.toList(),
      today: _today,
    );
    if (ok && mounted) setState(_selected.clear);
  }

  @override
  Widget build(BuildContext context) {
    final due = ref.watch(dueVaccinationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.plan.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: due,
        errorMessage: l10n.vaccineDueLoadFailed,
        onRetry: () => ref.invalidate(dueVaccinationsProvider),
        builder: (all) {
          final list = [
            for (final d in all)
              if (d.planId == widget.plan.id) d,
          ];
          // Tazelemeden sonra listeden düşen seçim unutulur.
          _selected.retainAll(list.map((d) => d.animalId));
          final allSelected =
              list.isNotEmpty && _selected.length == list.length;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.vaccineDueIntro,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurfaceMuted,
                        ),
                      ),
                    ),
                    if (list.isNotEmpty)
                      TextButton(
                        onPressed: () => setState(() {
                          if (allSelected) {
                            _selected.clear();
                          } else {
                            _selected.addAll(list.map((d) => d.animalId));
                          }
                        }),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.darkGreenColor,
                        ),
                        child: Text(
                          allSelected
                              ? l10n.vaccineSelectNone
                              : l10n.vaccineSelectAll,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: list.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Text(
                            l10n.vaccineDueEmpty,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.onSurfaceMuted),
                          ),
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                        children: [for (final d in list) _dueTile(d)],
                      ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _selected.isEmpty ? null : _mark,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.brandFill,
                        foregroundColor: AppColors.onFill,
                      ),
                      icon: const Icon(Icons.check),
                      label: Text(l10n.vaccineMarkSelected(_selected.length)),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _dueTile(VaccinationDue d) {
    final label = dueLabel(d, _today);
    final last = d.lastGivenOn;
    return CheckboxListTile(
      value: _selected.contains(d.animalId),
      onChanged: (v) => setState(
        () => v == true
            ? _selected.add(d.animalId)
            : _selected.remove(d.animalId),
      ),
      activeColor: AppColors.brandFill,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        d.animalName.isEmpty ? d.earTag : '${d.earTag} · ${d.animalName}',
      ),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label.text,
              style: TextStyle(
                color: label.alarm
                    ? AppColors.darkRedColor
                    : AppColors.onSurfaceMuted,
                fontWeight: label.alarm ? FontWeight.w600 : null,
              ),
            ),
            if (last != null)
              TextSpan(
                text:
                    ' · ${l10n.vaccineLastGiven(Fmt.dayMonthYear(vaccineDay(last)))}',
              ),
          ],
        ),
      ),
    );
  }
}

class _PlanDraft {
  const _PlanDraft(this.name, this.intervalDays, this.speciesId, this.note);

  final String name;
  final int intervalDays;
  final String? speciesId;
  final String note;
}

/// Plan formu: ad, aralık (gün), tür ("Bütün türler" = null), not.
class _PlanDialog extends StatefulWidget {
  const _PlanDialog({required this.plan, required this.species});

  final VaccinePlan? plan;
  final List<Species> species;

  @override
  State<_PlanDialog> createState() => _PlanDialogState();
}

class _PlanDialogState extends State<_PlanDialog> {
  late final _name = TextEditingController(text: widget.plan?.name ?? '');
  late final _interval = TextEditingController(
    text: widget.plan == null ? '' : '${widget.plan!.intervalDays}',
  );
  late final _note = TextEditingController(text: widget.plan?.note ?? '');
  late String? _species = widget.plan?.speciesId;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _interval.dispose();
    _note.dispose();
    super.dispose();
  }

  void _save() {
    final name = _name.text.trim();
    final days = int.tryParse(_interval.text.trim());
    if (name.isEmpty) {
      setState(() => _error = l10n.vaccinePlanNameRequired);
      return;
    }
    if (days == null || days < 7 || days > 1095) {
      setState(() => _error = l10n.vaccinePlanIntervalRange);
      return;
    }
    Navigator.of(
      context,
    ).pop(_PlanDraft(name, days, _species, _note.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderRadius: AppRadius.mdAll);
    // Bilinmeyen tür (liste yüklenemedi) seçili kalsın diye listeye eklenir.
    final ids = {for (final s in widget.species) s.id};
    return AlertDialog(
      title: Text(
        widget.plan == null ? l10n.vaccinePlanAdd : l10n.vaccinePlanEdit,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _name,
              maxLength: 80,
              decoration: InputDecoration(
                labelText: l10n.vaccinePlanName,
                border: border,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _interval,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l10n.vaccinePlanInterval,
                border: border,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String?>(
              initialValue: _species,
              decoration: InputDecoration(
                labelText: l10n.vaccinePlanSpecies,
                border: border,
              ),
              items: [
                DropdownMenuItem(child: Text(l10n.vaccineAllSpecies)),
                for (final s in widget.species)
                  DropdownMenuItem(value: s.id, child: Text(s.displayName)),
                if (_species != null && !ids.contains(_species))
                  DropdownMenuItem(value: _species, child: Text(_species!)),
              ],
              onChanged: (v) => setState(() => _species = v),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _note,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: l10n.commonNoteOptional,
                border: border,
              ),
            ),
            if (_error != null)
              Text(_error!, style: TextStyle(color: AppColors.darkRedColor)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(onPressed: _save, child: Text(l10n.commonSave)),
      ],
    );
  }
}

class _MarkDraft {
  const _MarkDraft(this.day, this.note);

  final DateTime day;
  final String note;
}

/// Uygulama günü (bugün varsayılan; gelecek ve 5 yıldan eski seçilemez) ve
/// isteğe bağlı not.
class _MarkDialog extends StatefulWidget {
  const _MarkDialog({required this.today});

  final DateTime today;

  @override
  State<_MarkDialog> createState() => _MarkDialogState();
}

class _MarkDialogState extends State<_MarkDialog> {
  final _note = TextEditingController();
  late DateTime _day = vaccineDay(widget.today);

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final today = vaccineDay(widget.today);
    final picked = await showDatePicker(
      context: context,
      initialDate: _day,
      firstDate: DateTime(today.year - 5, today.month, today.day + 1),
      lastDate: today,
      helpText: l10n.vaccineMarkHelp,
    );
    if (picked != null) setState(() => _day = picked);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(l10n.vaccineMarkTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
            onPressed: _pick,
            child: Text(l10n.vaccineMarkDate(Fmt.dayMonthYear(_day))),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _note,
            maxLength: 1000,
            decoration: InputDecoration(
              labelText: l10n.commonNoteOptional,
              border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.of(context).pop(_MarkDraft(_day, _note.text.trim())),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
