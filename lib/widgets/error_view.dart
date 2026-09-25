import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';

/// Yükleme hatası gösterimi.
///
/// Ayrıntı satırı API hatasıysa BACKEND'İN MESAJI gösterilir: §16'ya göre
/// hata mesajları Türkçedir ve doğrudan kullanıcıya gösterilebilir.
/// Onun yerine "DioException [bad response]..." yazmak, sahadaki operatöre
/// hiçbir şey anlatmazdı.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.message, this.error, this.onRetry});

  final String message;
  final Object? error;

  /// Verilirse "Tekrar dene" düğmesi çıkar. Olmadan hata ekranı uygulama
  /// yeniden açılana kadar kalıyordu: servis dönse de sekme değiştirmek
  /// sağlayıcıyı yenilemiyordu (cihazda bulundu).
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final detail = switch (error) {
      null => null,
      final e => userMessage(e) ?? '$e',
    };

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppColors.flowRed, size: 40),
          const SizedBox(height: AppSpacing.sm),
          Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (detail != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceMuted,
              ),
            ),
          ],
          if (onRetry case final retry?) ...[
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: retry,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar dene'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.darkGreenColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
