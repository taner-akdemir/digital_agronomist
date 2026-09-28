import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/audit_entry.dart';
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
  'animal.create' => 'Hayvan eklendi',
  'animal.update' => 'Hayvan kaydı değişti',
  'animal.import' => 'Listeden içe aktarma',
  'animal.calving' => 'Buzağılama kaydedildi',
  'thresholds.update' => 'Eşikler değişti',
  'spout.unassign' => 'Eşleştirme kaldırıldı',
  'tag.dismiss' => 'Tanınmayan küpe yok sayıldı',
  'team.add' => 'Kullanıcı eklendi',
  'team.update' => 'Kullanıcı değişti',
  'team.remove' => 'Kullanıcı çıkarıldı',
  'channel.create' => 'Bildirim kanalı eklendi',
  'channel.update' => 'Bildirim kanalı değişti',
  'channel.delete' => 'Bildirim kanalı silindi',
  _ => action,
};

IconData _icon(String action) => switch (action.split('.').first) {
  'animal' => Icons.pets_outlined,
  'thresholds' => Icons.tune,
  'spout' || 'tag' => Icons.link_off,
  'team' => Icons.group_outlined,
  'channel' => Icons.notifications_outlined,
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
          tooltip: 'Geri',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'İşlem kaydı',
          style: TextStyle(
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
          errorMessage: 'İşlem kaydı yüklenemedi',
          builder: (list) => list.isEmpty
              ? ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(AppSpacing.xxl),
                      child: Text(
                        'Son 90 günde kayıtlı değişiklik yok.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.onSurfaceMuted),
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
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: AppSpacing.md),
                          child: Text(
                            'Son 90 gün: eşik, hayvan kaydı, eşleştirme, kullanıcı '
                            've bildirim kanalı değişiklikleri.',
                            style: TextStyle(
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
        ? 'Silinmiş kullanıcı'
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
