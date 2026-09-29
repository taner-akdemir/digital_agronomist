import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/breeding.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'breeding_card.g.dart';

/// Hayvanın üreme kayıtları (backend ADR 0088).
@riverpod
Future<List<BreedingEvent>> animalBreeding(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).breedingEvents(animalId);

/// Yaklaşan doğum ve kuruya çıkarmalar (30 gün).
@riverpod
Future<List<UpcomingBreeding>> upcomingBreeding(Ref ref) =>
    ref.watch(repositoryProvider).upcomingBreeding();

/// Üreme kartı: durum (gebe / tohumlandı / boş), beklenen doğum ve önerilen
/// kuruya çıkarma; son kayıtlar. BÜTÜN roller kayıt ekler (tohumlamayı
/// çoğunlukla veteriner yapar); yanlış kaydı yalnızca sahip siler.
class BreedingCard extends ConsumerWidget {
  const BreedingCard({super.key, required this.animal, this.today});

  final Animal animal;

  /// Test için; null ise bugün.
  final DateTime? today;

  static const _shown = 3;

  void _refresh(WidgetRef ref) {
    ref
      ..invalidate(animalBreedingProvider(animal.id))
      // Durum ve tarihler hayvanın üstünde: liste, detay ve yaklaşanlar.
      ..invalidate(animalsProvider)
      ..invalidate(upcomingBreedingProvider);
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final draft = await showDialog<_Draft>(
      context: context,
      builder: (_) => _BreedingDialog(today: today ?? DateTime.now()),
    );
    if (draft == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(repositoryProvider)
          .addBreeding(
            animal.id,
            kind: draft.kind,
            date: draft.date,
            sire: draft.sire,
            result: draft.result,
          );
      _refresh(ref);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.breedingAdded),
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
    BreedingEvent e,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.breedingDeleteTitle),
        content: Text(
          '${e.label} · ${Fmt.dayMonthYear(e.eventDate)}\n'
          '${l10n.breedingDeleteBody}',
        ),
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
      await ref.read(repositoryProvider).deleteBreeding(animal.id, e.id);
      _refresh(ref);
    } catch (err) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(err) ?? l10n.commonDeleteFailed(err)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(animalBreedingProvider(animal.id));
    final isOwner = ref.watch(authProvider).user?.role == 'tenant_owner';
    final p = animal.pregnancy;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.breedingTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () => _add(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: Text(l10n.breedingAddRecord),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
            ],
          ),
          if (p != null) ...[
            Text(
              p.statusLabel,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreenColor,
              ),
            ),
            if (p.expectedCalving case final c?)
              Text(l10n.breedingExpectedCalving(Fmt.dayMonthYear(c))),
            if (p.dryOffDate case final d?)
              Text(l10n.breedingDryOff(Fmt.dayMonthYear(d))),
            // Beklenen kızgınlık penceresi (backend ADR 0121): 21 ± 3.
            if (p.expectedHeat case final h?)
              Text(
                l10n.breedingHeatExpected(
                  Fmt.dayMonth(h.subtract(const Duration(days: 3))),
                  Fmt.dayMonth(h.add(const Duration(days: 3))),
                ),
              ),
            const SizedBox(height: AppSpacing.sm),
          ],
          AsyncView(
            value: list,
            errorMessage: l10n.breedingLoadFailed,
            builder: (items) {
              if (items.isEmpty) {
                return Text(
                  l10n.breedingEmpty,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                );
              }
              return Column(
                children: [
                  for (final e in items.take(_shown))
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(e.label),
                      subtitle: Text(
                        [
                          Fmt.dayMonthYear(e.eventDate),
                          if ((e.authorName ?? '').isNotEmpty) e.authorName!,
                        ].join(' · '),
                      ),
                      trailing: isOwner
                          ? IconButton(
                              tooltip: l10n.commonDeleteWrongRecord,
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _delete(context, ref, e),
                            )
                          : null,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Draft {
  const _Draft(this.kind, this.date, this.sire, this.result);

  final String kind;
  final DateTime date;
  final String sire;
  final String? result;
}

/// Kayıt formu: tohumlama (boğa/teke) ya da gebelik kontrolü (gebe/boş).
class _BreedingDialog extends StatefulWidget {
  const _BreedingDialog({required this.today});

  final DateTime today;

  @override
  State<_BreedingDialog> createState() => _BreedingDialogState();
}

class _BreedingDialogState extends State<_BreedingDialog> {
  String _kind = 'insemination';
  String _result = 'pregnant';
  late DateTime _date = DateTime(
    widget.today.year,
    widget.today.month,
    widget.today.day,
  );
  final _sire = TextEditingController();

  @override
  void dispose() {
    _sire.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(l10n.breedingDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'insemination',
                  label: Text(l10n.breedingInsemination),
                ),
                ButtonSegment(
                  value: 'pregnancy_check',
                  label: Text(l10n.breedingPregnancyCheck),
                ),
                ButtonSegment(value: 'heat', label: Text(l10n.breedingHeat)),
              ],
              selected: {_kind},
              onSelectionChanged: (s) => setState(() => _kind = s.first),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () async {
                final today = DateTime(
                  widget.today.year,
                  widget.today.month,
                  widget.today.day,
                );
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _date,
                  firstDate: today.subtract(const Duration(days: 365 * 2)),
                  lastDate: today,
                );
                if (picked != null) setState(() => _date = picked);
              },
              child: Text(l10n.commonDateLabel(Fmt.dayMonthYear(_date))),
            ),
            const SizedBox(height: AppSpacing.md),
            if (_kind == 'heat')
              Text(
                l10n.breedingHeatHint,
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
              )
            else if (_kind == 'insemination')
              TextField(
                controller: _sire,
                decoration: InputDecoration(
                  labelText: l10n.breedingSireLabel,
                  border: const OutlineInputBorder(
                    borderRadius: AppRadius.mdAll,
                  ),
                ),
              )
            else
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: 'pregnant',
                    label: Text(l10n.breedingPregnant),
                  ),
                  ButtonSegment(value: 'open', label: Text(l10n.breedingOpen)),
                ],
                selected: {_result},
                onSelectionChanged: (s) => setState(() => _result = s.first),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(
            _Draft(
              _kind,
              _date,
              _kind == 'insemination' ? _sire.text.trim() : '',
              _kind == 'pregnancy_check' ? _result : null,
            ),
          ),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
