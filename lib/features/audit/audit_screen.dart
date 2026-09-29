import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/audit_entry.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audit_screen.g.dart';

/// Son 90 günün işlem kaydı (backend ADR 0082).
@riverpod
Future<List<AuditEntry>> auditLog(Ref ref) =>
    ref.watch(repositoryProvider).auditLog();

/// Olay kodunun Türkçesi; tanınmayan kod olduğu gibi (yeni olay eski
/// uygulamayı bozmasın).
String auditActionLabel(String action) => switch (action) {
  'animal.create' => l10n.auditAnimalCreate,
  'animal.update' => l10n.auditAnimalUpdate,
  'animal.import' => l10n.auditAnimalImport,
  'animal.calving' => l10n.auditAnimalCalving,
  'treatment.add' => l10n.auditTreatmentAdd,
  'treatment.delete' => l10n.auditTreatmentDelete,
  'breeding.add' => l10n.auditBreedingAdd,
  'breeding.delete' => l10n.auditBreedingDelete,
  'delivery.add' => l10n.auditDeliveryAdd,
  'delivery.delete' => l10n.auditDeliveryDelete,
  'settings.update' => l10n.auditSettingsUpdate,
  'thresholds.update' => l10n.auditThresholdsUpdate,
  'spout.unassign' => l10n.auditSpoutUnassign,
  'tag.dismiss' => l10n.auditTagDismiss,
  'team.add' => l10n.auditTeamAdd,
  'team.update' => l10n.auditTeamUpdate,
  'team.remove' => l10n.auditTeamRemove,
  'channel.create' => l10n.auditChannelCreate,
  'channel.update' => l10n.auditChannelUpdate,
  'channel.delete' => l10n.auditChannelDelete,
  _ => action,
};

IconData _icon(String action) => switch (action.split('.').first) {
  'animal' => Icons.pets_outlined,
  'thresholds' => Icons.tune,
  'spout' || 'tag' => Icons.link_off,
  'team' => Icons.group_outlined,
  'channel' => Icons.notifications_outlined,
  'treatment' => Icons.medication_outlined,
  'breeding' => Icons.favorite_border,
  'delivery' => Icons.local_shipping_outlined,
  'settings' => Icons.settings_outlined,
  _ => Icons.history,
};

/// İşlem kaydı ekranı: hesap kartından, yalnızca işletme sahibine.
class AuditScreen extends ConsumerWidget {
  const AuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = ref.watch(auditLogProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.auditTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(auditLogProvider.future),
        child: AsyncView(
          value: log,
          errorMessage: l10n.auditLoadFailed,
          builder: (list) => list.isEmpty
              ? ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      child: Text(
                        l10n.auditEmpty,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.onSurfaceMuted),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: list.length + 1,
                  separatorBuilder: (_, i) => i == 0
                      ? const SizedBox.shrink()
                      : const Divider(height: 1),
                  itemBuilder: (_, i) => i == 0
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: Text(
                            l10n.auditIntro,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.onSurfaceMuted,
                            ),
                          ),
                        )
                      : _Row(entry: list[i - 1]),
                ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.entry});

  final AuditEntry entry;

  @override
  Widget build(BuildContext context) {
    final e = entry;
    final who = e.userDeleted
        ? l10n.auditDeletedUser
        : (e.userName?.isNotEmpty ?? false)
        ? e.userName!
        : '—';
    final when = '${Fmt.dayMonthYear(e.at)} ${Fmt.time(e.at)}';
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(_icon(e.action), color: AppColors.darkGreenColor),
      title: Text(
        [
          auditActionLabel(e.action),
          if (e.target.isNotEmpty) e.target,
        ].join(' · '),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (e.detail.isNotEmpty) Text(e.detail),
          Text(
            '$who · $when',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.onSurfaceMuted,
            ),
          ),
        ],
      ),
    );
  }
}
