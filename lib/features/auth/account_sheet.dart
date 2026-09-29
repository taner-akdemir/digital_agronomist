import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/features/auth/delete_account.dart';
import 'package:milktrace/features/auth/role_labels.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

/// Hesap kartı: kim giriş yapmış, rolü ne, ayarlar ve çıkış.
///
/// §15.1'in "profil" ekranı BUDUR. Ayrı bir sekme ya da tam ekran sayfa
/// değil: dört sekmenin hiçbirine ait olmadığı için kabuğun üstünde bir
/// sayfa açmak gezinme yığınını karıştırırdı.
Future<void> showAccountSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) => const _AccountSheet(),
    );

class _AccountSheet extends ConsumerWidget {
  const _AccountSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    // Dil değişince kart da yeni dille yeniden çizilsin.
    ref.watch(appLanguageProvider);

    // KAYDIRILABİLİR: alt sayfa varsayılan olarak ekranın yarısı kadar;
    // küçük telefonda (ve yatayda) düğmeler taşıyordu.
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            0,
            AppSpacing.xl,
            AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.lightGreenColor,
                    child: Icon(Icons.person, color: AppColors.darkGreenColor),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.fullName.isNotEmpty == true
                              ? user!.fullName
                              : l10n.accountDefaultName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (user != null) ...[
                          Text(
                            user.email,
                            style: TextStyle(color: AppColors.onSurfaceMuted),
                          ),
                          // Rol GÖRÜNÜR olmalı: eşik ayarlarının neden salt
                          // okunur açıldığının cevabı burada.
                          Text(
                            [
                              roleLabel(user.role),
                              ?user.tenantName,
                            ].join(' · '),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.lightGreyColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (Env.apiMode == ApiMode.mock) ...[
                const SizedBox(height: AppSpacing.lg),
                const _ModeBadge(),
              ],
              // Süt birimi (backend ADR 0086): sahip seçer, herkes görür.
              if (user != null && user.role == 'tenant_owner') ...[
                const SizedBox(height: AppSpacing.md),
                _UnitRow(unit: user.volumeUnit),
              ],
              // Dil (backend ADR 0093): cihazda saklanır, her rol seçer.
              const SizedBox(height: AppSpacing.md),
              const _LanguageRow(),
              // Tema (backend ADR 0109): cihazda saklanır, her rol seçer.
              const SizedBox(height: AppSpacing.md),
              const _ThemeRow(),
              // Birden çok işletmenin üyesi (veteriner, danışman; backend
              // ADR 0081) işletmeler arasında geçer.
              if ((user?.tenants.length ?? 0) > 1) ...[
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: () => _pickTenant(context, ref, user!),
                  icon: const Icon(Icons.swap_horiz),
                  label: Text(l10n.accountSwitchFarm),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              const _PushRow(),
              // Eşik ayarları HERKESE açık, düzenleme yalnızca owner'a
              // (§15.1): sağımdaki "bu kırmızı neden kırmızı?" sorusunun
              // cevabı orada ve gizlemek kimseye yaramaz.
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/settings/thresholds');
                },
                icon: const Icon(Icons.tune),
                label: Text(l10n.accountThresholds),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.mdAll,
                  ),
                ),
              ),
              // Bildirim kanalları YALNIZCA işletme sahibine: kanallar alıcı
              // telefonlarını ve API anahtarlarını taşır, backend diğer
              // rollere 403 döner. Boş bir ekran açıp hata göstermek yerine
              // düğme hiç görünmez.
              if (user?.role == 'tenant_owner') ...[
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push('/settings/notifications');
                  },
                  icon: const Icon(Icons.notifications_active_outlined),
                  label: Text(l10n.accountNotificationChannels),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                ),
                // Kullanıcılar (backend ADR 0076): yalnızca sahip; backend
                // diğer rollere 403.
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push('/settings/team');
                  },
                  icon: const Icon(Icons.group_outlined),
                  label: Text(l10n.accountUsers),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                ),
                // Sağımcılar (backend ADR 0090): yalnızca sahip.
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push('/settings/milkers');
                  },
                  icon: const Icon(Icons.badge_outlined),
                  label: Text(l10n.accountMilkers),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                ),
                // Sağım saatleri (backend ADR 0099): yalnızca sahip.
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push('/settings/schedule');
                  },
                  icon: const Icon(Icons.alarm),
                  label: Text(l10n.accountMilkingSchedule),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                ),
                // İşlem kaydı (backend ADR 0082): yalnızca sahip.
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push('/settings/audit');
                  },
                  icon: const Icon(Icons.history),
                  label: Text(l10n.accountAuditLog),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                ),
              ],
              // Sessiz saat (backend ADR 0107): bütün roller, kişiye ait.
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/settings/quiet-hours');
                },
                icon: const Icon(Icons.bedtime_outlined),
                label: Text(l10n.accountQuietHours),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.mdAll,
                  ),
                ),
              ),
              // Açık oturumlar (backend ADR 0105): bütün roller.
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/settings/sessions');
                },
                icon: const Icon(Icons.devices_outlined),
                label: Text(l10n.accountSessions),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.mdAll,
                  ),
                ),
              ),
              // İki adımlı doğrulama (backend ADR 0102): bütün roller; tablet
              // hesabının kartı yok.
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/settings/2fa');
                },
                icon: Icon(
                  (user?.twoFactor ?? false)
                      ? Icons.verified_user
                      : Icons.shield_outlined,
                ),
                label: Text(
                  (user?.twoFactor ?? false)
                      ? l10n.accountTwoFactorOn
                      : l10n.accountTwoFactor,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.mdAll,
                  ),
                ),
              ),
              // Geri bildirim (backend ADR 0106): bütün roller.
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.push('/settings/feedback');
                },
                icon: const Icon(Icons.feedback_outlined),
                label: Text(l10n.feedbackTitle),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.mdAll,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: Env.apiMode == ApiMode.mock
                    // Mock modda kimlik sunucusu yok; çıkış kullanıcıyı asla
                    // geçemeyeceği bir giriş ekranına kilitlerdi.
                    ? null
                    : () async {
                        Navigator.of(context).pop();
                        await ref.read(authProvider.notifier).signOut();
                      },
                icon: const Icon(Icons.logout),
                label: Text(l10n.accountSignOut),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.darkRedColor,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadius.mdAll,
                  ),
                ),
              ),
              // Destek (backend ADR 0077); numara yoksa hiç görünmez.
              const SizedBox(height: AppSpacing.lg),
              const SupportButtons(),
              // Hesap silme (backend ADR 0098; Play şartı). Mock modda
              // silinecek hesap yok.
              if (Env.apiMode != ApiMode.mock)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDeleteAccount(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkRedColor,
                  ),
                  child: Text(l10n.deleteAccountTitle),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Push durumu ve test bildirimi (backend ADR 0048).
///
/// Kayıtlıysa "Bu telefona test bildirimi" düğmesi: Firebase bağlandığı gün
/// ve saha pilotunda "bildirim bu telefona geliyor mu?" sorusunun tek
/// dokunuşluk cevabı. Kapalıysa SEBEBİ yazar: bildirim gelmeyen kullanıcı
/// bunun bir hata mı yoksa beklenen durum mu olduğunu bilsin.
class _PushRow extends ConsumerStatefulWidget {
  const _PushRow();

  @override
  ConsumerState<_PushRow> createState() => _PushRowState();
}

class _PushRowState extends ConsumerState<_PushRow> {
  bool _busy = false;

  Future<void> _send() async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final sent = await ref.read(repositoryProvider).sendTestPush();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            sent == 0
                ? l10n.accountTestPushNone
                : l10n.accountTestPushSent(sent),
          ),
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.accountTestPushFailed(e)),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(pushRegistrationProvider).value;
    return switch (status) {
      PushStatus.registered => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: OutlinedButton.icon(
          onPressed: _busy ? null : _send,
          icon: const Icon(Icons.phonelink_ring_outlined),
          label: Text(
            _busy ? l10n.accountTestPushSending : l10n.accountTestPush,
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.darkGreenColor,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          ),
        ),
      ),
      PushStatus.unavailable => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Row(
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 18,
              color: AppColors.onSurfaceMuted,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                l10n.accountPushUnavailable,
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
              ),
            ),
          ],
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

/// İşletme seçimi; seçilince oturum o işletmeye geçer ve canlı sekmeye
/// dönülür (açık ekranlar eski işletmenin verisiyle kalmasın).
Future<void> _pickTenant(
  BuildContext context,
  WidgetRef ref,
  AuthUser user,
) async {
  final picked = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(l10n.accountPickFarm),
      children: [
        for (final t in user.tenants)
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(t.id),
            child: Row(
              children: [
                Icon(
                  t.id == user.tenantId
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: AppColors.darkGreenColor,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.name),
                      Text(
                        roleLabel(t.role),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurfaceMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  if (picked == null || picked == user.tenantId || !context.mounted) return;
  final messenger = ScaffoldMessenger.of(context);
  final router = GoRouter.of(context);
  Navigator.of(context).pop();
  try {
    await ref.read(authProvider.notifier).switchTenant(picked);
    router.go('/live');
  } catch (e) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(userMessage(e) ?? l10n.accountSwitchFarmFailed(e)),
        backgroundColor: AppColors.dangerFill,
      ),
    );
  }
}

/// Süt birimi seçimi: Litre / Kilogram (backend ADR 0086).
class _UnitRow extends ConsumerWidget {
  const _UnitRow({required this.unit});

  final String unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.accountMilkUnit,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SegmentedButton<String>(
          segments: [
            ButtonSegment(value: 'L', label: Text(l10n.accountUnitLitre)),
            ButtonSegment(value: 'kg', label: Text(l10n.accountUnitKilogram)),
          ],
          selected: {unit},
          onSelectionChanged: (s) async {
            final next = s.first;
            final messenger = ScaffoldMessenger.of(context);
            try {
              await ref.read(repositoryProvider).setVolumeUnit(next);
              await ref.read(authProvider.notifier).applyVolumeUnit(next);
            } catch (e) {
              messenger.showSnackBar(
                SnackBar(
                  content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
                  backgroundColor: AppColors.dangerFill,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

/// Uygulama dili (backend ADR 0093): cihaz dili, Türkçe ya da İngilizce.
/// Seçim cihazda saklanır; başlık üstte, düğmeler tam genişlikte — üç
/// bölüm başlıkla aynı satıra dar telefonda sığmıyor.
class _LanguageRow extends ConsumerWidget {
  const _LanguageRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(appLanguageProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.languageTitle,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.xs),
        SegmentedButton<String>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: 'auto', label: Text(l10n.languageAuto)),
            ButtonSegment(value: 'tr', label: Text(l10n.languageTurkish)),
            ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
          ],
          selected: {lang ?? 'auto'},
          onSelectionChanged: (s) {
            final next = s.first;
            ref
                .read(appLanguageProvider.notifier)
                .set(next == 'auto' ? null : next);
          },
        ),
      ],
    );
  }
}

/// Tema (backend ADR 0109): Açık (varsayılan), Karanlık ya da Cihaz.
/// Seçim cihazda saklanır; dil satırıyla aynı yerleşim.
class _ThemeRow extends ConsumerWidget {
  const _ThemeRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(appThemeModeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.themeTitle,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.xs),
        SegmentedButton<ThemeMode>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(value: ThemeMode.light, label: Text(l10n.themeLight)),
            ButtonSegment(value: ThemeMode.dark, label: Text(l10n.themeDark)),
            ButtonSegment(
              value: ThemeMode.system,
              label: Text(l10n.themeSystem),
            ),
          ],
          selected: {mode},
          onSelectionChanged: (s) =>
              ref.read(appThemeModeProvider.notifier).set(s.first),
        ),
      ],
    );
  }
}

class _ModeBadge extends StatelessWidget {
  const _ModeBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.flowYellowSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        children: [
          Icon(
            Icons.science_outlined,
            size: 18,
            color: AppColors.darkAmberColor,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.accountMockMode,
              style: TextStyle(color: AppColors.darkAmberColor, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
