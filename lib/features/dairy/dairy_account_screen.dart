import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/widgets/brand_mark.dart';

/// Mandıra hesabıyla girildiğinde TEK ekran (backend ADR 0137).
///
/// Mandıra kullanıcısı işletmesizdir; gateway ona işletme uçlarının hepsini
/// kapatıyor ve mandıra ekranları web panelinde. Başka bir ekran açılsa
/// yalnızca 403 hataları gösterirdi.
class DairyAccountScreen extends ConsumerWidget {
  const DairyAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrandMark(size: 56),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.dairyAccountTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreenColor,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.dairyAccountBody(user?.dairyName ?? ''),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                FilledButton.icon(
                  onPressed: () => ref.read(supportLauncherProvider)(
                    Uri.parse(Env.webLoginUrl),
                  ),
                  icon: const Icon(Icons.open_in_browser),
                  label: Text(l10n.dairyAccountOpenWeb),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brandFill,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () => ref.read(authProvider.notifier).signOut(),
                  child: Text(l10n.dairyAccountSignOut),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
