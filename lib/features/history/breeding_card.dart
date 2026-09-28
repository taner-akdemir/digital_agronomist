import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/breeding.dart';
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
        const SnackBar(
          content: Text('Üreme kaydı eklendi'),
          backgroundColor: AppColors.darkGreenColor,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? 'Kaydedilemedi: $e'),
          backgroundColor: AppColors.flowRed,
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
        title: const Text('Üreme kaydı silinsin mi?'),
        content: Text(
          '${e.label} · ${Fmt.dayMonthYear(e.eventDate)}\n'
          'Yalnızca yanlış girilen kaydı silin; durum ve tarihler yeniden '
          'hesaplanır.',
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
      await ref.read(repositoryProvider).deleteBreeding(animal.id, e.id);
      _refresh(ref);
    } catch (err) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(err) ?? 'Silinemedi: $err'),
          backgroundColor: AppColors.flowRed,
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
              const Expanded(
                child: Text(
                  'Üreme',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton.icon(
                onPressed: () => _add(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Kayıt ekle'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
            ],
          ),
          if (p != null) ...[
            Text(
              p.statusLabel,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.darkGreenColor,
              ),
            ),
            if (p.expectedCalving case final c?)
              Text('Beklenen doğum: ${Fmt.dayMonthYear(c)}'),
            if (p.dryOffDate case final d?)
              Text('Önerilen kuruya çıkarma: ${Fmt.dayMonthYear(d)}'),
            const SizedBox(height: AppSpacing.sm),
          ],
          AsyncView(
            value: list,
            errorMessage: 'Üreme kayıtları alınamadı',
            builder: (items) {
              if (items.isEmpty) {
                return const Text(
                  'Kayıt yok. Tohumlama ve gebelik kontrolünü girin: beklenen '
                  'doğum ve kuruya çıkarma tarihi hesaplanır.',
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
                              tooltip: 'Yanlış kaydı sil',
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
      title: const Text('Üreme kaydı'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'insemination', label: Text('Tohumlama')),
                ButtonSegment(
                  value: 'pregnancy_check',
                  label: Text('Gebelik kontrolü'),
                ),
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
              child: Text('Tarih: ${Fmt.dayMonthYear(_date)}'),
            ),
            const SizedBox(height: AppSpacing.md),
            if (_kind == 'insemination')
              TextField(
                controller: _sire,
                decoration: const InputDecoration(
                  labelText: 'Boğa/teke ya da sperma kodu (isteğe bağlı)',
                  border: OutlineInputBorder(borderRadius: AppRadius.mdAll),
                ),
              )
            else
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'pregnant', label: Text('Gebe')),
                  ButtonSegment(value: 'open', label: Text('Boş')),
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
          child: const Text('Vazgeç'),
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
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
