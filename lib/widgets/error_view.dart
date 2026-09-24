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
  const ErrorView({super.key, required this.message, this.error});

  final String message;
  final Object? error;

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
        ],
      ),
    );
  }
}
