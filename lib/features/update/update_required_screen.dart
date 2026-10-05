import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Play Store sayfası (paket kimliği CLAUDE.md §7).
final playStoreUri = Uri.parse(
  'https://play.google.com/store/apps/details?id=com.algebran.milktrace.milktrace',
);

/// App Store Connect'teki "Apple ID" (sayı). Kayıt açılınca yazılır; boşken
/// iOS'ta mağaza düğmesi çizilmez, yalnızca metin ve destek kalır.
const _appStoreId = '';

/// App Store sayfası; kimlik bilinmiyorsa null.
final Uri? appStoreUri = _appStoreId.isEmpty
    ? null
    : Uri.parse('https://apps.apple.com/app/id$_appStoreId');

/// "Güncelleme gerekli" (backend ADR 0080): sunucu bu sürümü artık
/// desteklemiyor (426). Geri dönüş yok — eski sürümle devam etmek, sağımı
/// bozuk bir uygulamayla kaydetmek olurdu. Desteğe ulaşılabilir.
class UpdateRequiredScreen extends ConsumerWidget {
  const UpdateRequiredScreen({super.key, this.isAndroid, this.iosStoreUri});

  /// Test için; null ise çalışılan platform.
  final bool? isAndroid;

  /// Test için; null ise [appStoreUri].
  final Uri? iosStoreUri;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final android = isAndroid ?? Platform.isAndroid;
    final storeUri = android ? playStoreUri : (iosStoreUri ?? appStoreUri);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.system_update,
                      size: 64,
                      color: AppColors.darkGreenColor,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.updateTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreenColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      android ? l10n.updateBodyAndroid : l10n.updateBodyIos,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.onSurfaceMuted),
                    ),
                    if (storeUri != null) ...[
                      const SizedBox(height: AppSpacing.xl),
                      FilledButton.icon(
                        onPressed: () =>
                            ref.read(supportLauncherProvider)(storeUri),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.brandFill,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.lg,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.mdAll,
                          ),
                        ),
                        icon: const Icon(Icons.shop),
                        label: Text(
                          android
                              ? l10n.updatePlayButton
                              : l10n.updateAppStoreButton,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xl),
                    const SupportButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
