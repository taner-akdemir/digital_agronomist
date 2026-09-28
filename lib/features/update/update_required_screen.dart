import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/support/support.dart';

/// Play Store sayfası (paket kimliği CLAUDE.md §7).
final playStoreUri = Uri.parse(
  'https://play.google.com/store/apps/details?id=com.algebran.milktrace.milktrace',
);

/// "Güncelleme gerekli" (backend ADR 0080): sunucu bu sürümü artık
/// desteklemiyor (426). Geri dönüş yok — eski sürümle devam etmek, sağımı
/// bozuk bir uygulamayla kaydetmek olurdu. Desteğe ulaşılabilir.
class UpdateRequiredScreen extends ConsumerWidget {
  const UpdateRequiredScreen({super.key, this.isAndroid});

  /// Test için; null ise çalışılan platform.
  final bool? isAndroid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final android = isAndroid ?? Platform.isAndroid;
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
                    const Icon(
                      Icons.system_update,
                      size: 64,
                      color: AppColors.darkGreenColor,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    const Text(
                      'Güncelleme gerekli',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreenColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Milk Trace\'in bu sürümü artık desteklenmiyor. Sağım '
                      'kayıtlarının doğru tutulması için uygulamayı '
                      '${android ? 'Google Play\'den' : 'App Store\'dan'} '
                      'güncelleyin.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.onSurfaceMuted),
                    ),
                    if (android) ...[
                      const SizedBox(height: AppSpacing.xl),
                      FilledButton.icon(
                        onPressed: () =>
                            ref.read(supportLauncherProvider)(playStoreUri),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.darkGreenColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.lg,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppRadius.mdAll,
                          ),
                        ),
                        icon: const Icon(Icons.shop),
                        label: const Text('Google Play\'de güncelle'),
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
