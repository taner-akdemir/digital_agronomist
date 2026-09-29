import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/vaccination.dart';
import 'package:milktrace/features/history/vaccinations_screen.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Hayvan detayındaki "Aşılar" kartı (backend ADR 0112): girdiği her planın
/// sırası ("Şap · sonraki 3 Eki", "kayıt yok", "gecikti"), "Uygulandı" ve
/// son uygulamalar. BÜTÜN roller işaretler; yanlış kaydı yalnızca sahip
/// siler.
class VaccinationsCard extends ConsumerWidget {
  const VaccinationsCard({super.key, required this.animal, this.today});

  final Animal animal;

  /// Test için; null ise bugün.
  final DateTime? today;

  static const _shown = 3;

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Vaccination v,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.vaccineDeleteTitle),
        content: Text(
          '${v.planName} · ${Fmt.dayMonthYear(vaccineDay(v.givenOn))}\n'
          '${l10n.vaccineDeleteBody}',
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
      await ref.read(repositoryProvider).deleteVaccination(v.id);
      ref
        ..invalidate(animalVaccinationsProvider(animal.id))
        ..invalidate(vaccinePlansProvider)
        ..invalidate(dueVaccinationsProvider);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonDeleteFailed(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(animalVaccinationsProvider(animal.id));
    final isOwner = ref.watch(authProvider).user?.role == 'tenant_owner';
    final now = today ?? DateTime.now();

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
          Text(
            l10n.vaccineCardTitle,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.xs),
          AsyncView(
            value: data,
            errorMessage: l10n.vaccineCardLoadFailed,
            builder: (v) {
              if (v.due.isEmpty && v.items.isEmpty) {
                return Text(
                  l10n.vaccineCardEmpty,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final d in v.due) _dueRow(context, ref, d, now),
                  if (v.items.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.vaccineRecent,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                    for (final r in v.items.take(_shown))
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(r.planName),
                        subtitle: Text(
                          [
                            Fmt.dayMonthYear(vaccineDay(r.givenOn)),
                            if (r.note.isNotEmpty) r.note,
                            if (r.authorName.isNotEmpty) r.authorName,
                          ].join(' · '),
                        ),
                        trailing: isOwner
                            ? IconButton(
                                tooltip: l10n.commonDeleteWrongRecord,
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => _delete(context, ref, r),
                              )
                            : null,
                      ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _dueRow(
    BuildContext context,
    WidgetRef ref,
    VaccinationDue d,
    DateTime now,
  ) {
    final label = dueLabel(d, now, next: true);
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        Icons.vaccines_outlined,
        color: label.alarm ? AppColors.flowRed : AppColors.darkGreenColor,
      ),
      title: Text(d.planName),
      subtitle: Text(
        label.text,
        style: TextStyle(
          color: label.alarm ? AppColors.darkRedColor : null,
          fontWeight: label.alarm ? FontWeight.w600 : null,
        ),
      ),
      trailing: TextButton(
        onPressed: () => markVaccinated(
          context,
          ref,
          planId: d.planId,
          animalIds: [animal.id],
          today: now,
        ),
        style: TextButton.styleFrom(foregroundColor: AppColors.darkGreenColor),
        child: Text(l10n.vaccineGiven),
      ),
    );
  }
}
