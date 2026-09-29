import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/settings/farm_location_screen.dart';
import 'package:milktrace/features/settings/milking_schedule_screen.dart';
import 'package:milktrace/features/settings/notification_channels_providers.dart';
import 'package:milktrace/features/team/team_providers.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setup_checklist.g.dart';

/// Kurulum listesinin kapatılması (backend ADR 0123): cihazda, işletme
/// başına. Okunamazsa kapatılmamış sayılır.
@Riverpod(keepAlive: true)
class SetupDismissed extends _$SetupDismissed {
  String get _key => 'setup.dismissed.${ref.read(authProvider).user?.tenantId}';

  @override
  bool build() {
    ref.watch(authProvider.select((s) => s.user?.tenantId));
    _load();
    return false;
  }

  Future<void> _load() async {
    try {
      if (await ref.read(settingsStoreProvider).readBool(_key) ?? false) {
        state = true;
      }
    } on Object {
      // Okunamazsa liste görünür; zararı yok.
    }
  }

  Future<void> dismiss() async {
    state = true;
    try {
      await ref.read(settingsStoreProvider).writeBool(_key, true);
    } on Object {
      // Bu oturumda kapalı kalır.
    }
  }
}

/// Kurulum adımı: ne, yapıldı mı, nereye gidilir. [done] null: okunamadı
/// (adım gösterilmez — bilinmeyeni "yapılmadı" diye göstermek yanlış yönlendirir).
typedef SetupStep = ({String title, bool? done, String route});

/// Adımlar ve durumları; hepsi sunucudaki veriden, ayrı bir uç yok.
List<SetupStep> setupSteps(WidgetRef ref) {
  bool? of<T>(AsyncValue<T> v, bool Function(T) test) =>
      v.hasValue ? test(v.requireValue) : null;
  return [
    (
      title: l10n.setupAnimals,
      done: of(ref.watch(animalsProvider), (l) => l.isNotEmpty),
      route: '/history',
    ),
    (
      title: l10n.setupSchedule,
      done: of(
        ref.watch(milkingScheduleProvider),
        (s) => s.morningAt.isNotEmpty || s.eveningAt.isNotEmpty,
      ),
      route: '/settings/schedule',
    ),
    (
      title: l10n.setupChannel,
      done: of(ref.watch(notificationChannelListProvider), (l) => l.isNotEmpty),
      route: '/settings/notifications',
    ),
    (
      title: l10n.setupTeam,
      done: of(ref.watch(teamListProvider), (l) => l.length > 1),
      route: '/settings/team',
    ),
    (
      title: l10n.setupLocation,
      done: of(
        ref.watch(farmListProvider),
        (l) => l.any((f) => f.latitude != null),
      ),
      route: '/settings/farm-location',
    ),
  ];
}

/// Panoda ilk kurulum listesi (backend ADR 0123): yalnızca işletme sahibine;
/// hepsi tamamlanınca ya da kapatılınca görünmez.
class SetupChecklistCard extends ConsumerWidget {
  const SetupChecklistCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    if (user?.role != 'tenant_owner' || user?.kiosk == true) {
      return const SizedBox.shrink();
    }
    if (ref.watch(setupDismissedProvider)) return const SizedBox.shrink();
    final steps = [
      for (final s in setupSteps(ref))
        if (s.done != null) s,
    ];
    final left = steps.where((s) => s.done == false).length;
    if (steps.isEmpty || left == 0) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      // Material: ListTile dokunma dalgası ve arka planı kartın üstünde
      // çizilsin (DecoratedBox onları gizlerdi).
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
          side: BorderSide(color: AppColors.darkGreenColor),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.setupTitle(steps.length - left, steps.length),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.setupDismiss,
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        ref.read(setupDismissedProvider.notifier).dismiss(),
                  ),
                ],
              ),
              for (final s in steps)
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    s.done! ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: s.done!
                        ? AppColors.darkGreenColor
                        : AppColors.onSurfaceMuted,
                  ),
                  title: Text(
                    s.title,
                    style: TextStyle(
                      decoration: s.done! ? TextDecoration.lineThrough : null,
                      color: s.done! ? AppColors.onSurfaceMuted : null,
                    ),
                  ),
                  trailing: s.done! ? null : const Icon(Icons.chevron_right),
                  onTap: s.done!
                      ? null
                      : () => s.route == '/history'
                            ? context.go(s.route)
                            : context.push(s.route),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
