import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/providers/auth_providers.dart';

/// Hesap kartı: kim giriş yapmış ve çıkış.
///
/// Çıkış AYRI BİR EKRAN DEĞİL: dört sekmenin hiçbirine ait olmadığı için
/// kabuğun üstünde bir sayfa açmak gezinme yığınını karıştırırdı.
Future<void> showAccountSheet(BuildContext context) => showModalBottomSheet<void>(
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const CircleAvatar(
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
                            : 'Kullanıcı',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (user != null)
                        Text(
                          user.email,
                          style: const TextStyle(color: AppColors.onSurfaceMuted),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (Env.apiMode == ApiMode.mock) ...[
              const SizedBox(height: AppSpacing.lg),
              const _ModeBadge(),
            ],
            const SizedBox(height: AppSpacing.xl),
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
              label: const Text('Çıkış yap'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.darkRedColor,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeBadge extends StatelessWidget {
  const _ModeBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.flowYellowSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: const Row(
        children: [
          Icon(Icons.science_outlined, size: 18, color: AppColors.darkAmberColor),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Demo verisiyle çalışıyorsunuz (mock mod).',
              style: TextStyle(color: AppColors.darkAmberColor, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
