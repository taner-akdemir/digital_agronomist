import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/treatment.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatments_card.g.dart';

/// Hayvanın tedavileri (backend ADR 0084).
@riverpod
Future<List<Treatment>> animalTreatments(Ref ref, String animalId) =>
    ref.watch(repositoryProvider).treatments(animalId);

/// Tedavi ve arınma kartı: süren arınma kırmızı bantla ("sütü tanka
/// katmayın"), altında son tedaviler. BÜTÜN roller ekler (tedaviyi
/// çoğunlukla veteriner girer); yanlış kaydı yalnızca sahip siler.
class TreatmentsCard extends ConsumerWidget {
  const TreatmentsCard({super.key, required this.animal, this.today});

  final Animal animal;

  /// Test için; null ise bugün.
  final DateTime? today;

  static const _shown = 3;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final draft = await showDialog<_Draft>(
      context: context,
      builder: (_) => _TreatmentDialog(today: today ?? DateTime.now()),
    );
    if (draft == null || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(repositoryProvider)
          .addTreatment(
            animal.id,
            drug: draft.drug,
            startedOn: draft.start,
            withdrawalUntil: draft.until,
            note: draft.note,
          );
      ref
        ..invalidate(animalTreatmentsProvider(animal.id))
        // Hayvanın arınma günü değişti: liste, detay ve seçici görsün.
        ..invalidate(animalsProvider);
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Tedavi kaydedildi'),
          backgroundColor: AppColors.darkGreenColor,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? 'Tedavi kaydedilemedi: $e'),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Treatment t) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tedavi kaydı silinsin mi?'),
        content: Text(
          '${t.drug} · ${Fmt.dayMonthYear(t.startedOn)}\n'
          'Yalnızca yanlış girilen kaydı silin; silinen kayıt arınmayı da '
          'kaldırır.',
        ),
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
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).deleteTreatment(animal.id, t.id);
      ref
        ..invalidate(animalTreatmentsProvider(animal.id))
        ..invalidate(animalsProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? 'Silinemedi: $e'),
          backgroundColor: AppColors.flowRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(animalTreatmentsProvider(animal.id));
    final isOwner = ref.watch(authProvider).user?.role == 'tenant_owner';
    final until = animal.withdrawalUntil;

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
              const Expanded(
                child: Text(
                  'Tedavi ve arınma',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton.icon(
                onPressed: () => _add(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Tedavi ekle'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
            ],
          ),
          if (until != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: const BoxDecoration(
                color: AppColors.flowRedSurface,
                borderRadius: AppRadius.smAll,
              ),
              child: Row(
                children: [
                  const Icon(Icons.block, color: AppColors.flowRed, size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Arınmada: sütü ${Fmt.dayMonthYear(until)} dahil '
                      'tanka katmayın.',
                      style: const TextStyle(
                        color: AppColors.darkRedColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          AsyncView(
            value: list,
            errorMessage: 'Tedaviler alınamadı',
            builder: (items) {
              if (items.isEmpty) {
                return const Text(
                  'Tedavi kaydı yok. Antibiyotik verilen hayvanın arınma '
                  'süresini girin: süre boyunca canlı ekranda "Sütü ayır" '
                  'uyarısı çıkar.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                );
              }
              return Column(
                children: [
                  for (final t in items.take(_shown))
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(t.drug),
                      subtitle: Text(
                        [
                          '${Fmt.dayMonthYear(t.startedOn)} → arınma '
                              '${Fmt.dayMonthYear(t.withdrawalUntil)}',
                          if (t.note.isNotEmpty) t.note,
                          if ((t.authorName ?? '').isNotEmpty) t.authorName!,
                        ].join(' · '),
                      ),
                      trailing: isOwner
                          ? IconButton(
                              tooltip: 'Yanlış kaydı sil',
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _delete(context, ref, t),
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
  const _Draft(this.drug, this.start, this.until, this.note);

  final String drug;
  final DateTime start;
  final DateTime until;
  final String note;
}

/// Tedavi formu: ilaç, başlangıç, arınma bitişi (sütün ayrılacağı son gün).
/// Bitiş için hızlı seçim: başlangıçtan +3/+5/+7 gün.
class _TreatmentDialog extends StatefulWidget {
  const _TreatmentDialog({required this.today});

  final DateTime today;

  @override
  State<_TreatmentDialog> createState() => _TreatmentDialogState();
}

class _TreatmentDialogState extends State<_TreatmentDialog> {
  final _drug = TextEditingController();
  final _note = TextEditingController();
  late DateTime _start = _day(widget.today);
  late DateTime _until = _start.add(const Duration(days: 4));
  String? _error;

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  void dispose() {
    _drug.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pick({required bool start}) async {
    final today = _day(widget.today);
    final picked = await showDatePicker(
      context: context,
      initialDate: start ? _start : _until,
      firstDate: start ? today.subtract(const Duration(days: 60)) : _start,
      lastDate: start ? today : _start.add(const Duration(days: 365)),
      helpText: start ? 'Tedavi başlangıcı' : 'Sütün ayrılacağı son gün',
    );
    if (picked == null) return;
    setState(() {
      if (start) {
        _start = picked;
        if (_until.isBefore(_start)) _until = _start;
      } else {
        _until = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderRadius: AppRadius.mdAll);
    return AlertDialog(
      title: const Text('Tedavi ekle'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _drug,
              decoration: const InputDecoration(
                labelText: 'İlaç',
                border: border,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () => _pick(start: true),
              child: Text('Başlangıç: ${Fmt.dayMonthYear(_start)}'),
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => _pick(start: false),
              child: Text('Arınma bitişi: ${Fmt.dayMonthYear(_until)}'),
            ),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final d in const [3, 5, 7])
                  ActionChip(
                    label: Text('+$d gün'),
                    onPressed: () =>
                        setState(() => _until = _start.add(Duration(days: d))),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _note,
              decoration: const InputDecoration(
                labelText: 'Not (isteğe bağlı)',
                border: border,
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
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Vazgeç'),
        ),
        FilledButton(
          onPressed: () {
            final drug = _drug.text.trim();
            if (drug.isEmpty) {
              setState(() => _error = 'İlaç adını girin.');
              return;
            }
            Navigator.of(
              context,
            ).pop(_Draft(drug, _start, _until, _note.text.trim()));
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
