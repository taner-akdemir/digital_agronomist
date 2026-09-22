import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/widgets/milk_palette.dart';

/// Bir sağım noktasının canlı kartı (§6.2, §6.3).
///
/// Eski kart StatefulWidget'tı ama hiç değişken durumu yoktu (§15.3/17) ve
/// `lowFlowRate > currentFlow` koşulunu tek bir build içinde BEŞ KEZ
/// tekrarlıyordu. Artık renk bir kez çözülür ve kartın her parçası aynı
/// karardan beslenir.
class LiveInfoCard extends StatelessWidget {
  const LiveInfoCard({
    super.key,
    required this.update,
    required this.title,
  });

  final SpoutUpdate update;

  /// "Ünite A-1 · Nokta 3" gibi.
  final String title;

  @override
  Widget build(BuildContext context) {
    final palette = MilkPalette.of(update.flowColor);
    final animal = update.animal;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(color: palette.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _header(palette),
          const SizedBox(height: AppSpacing.sm),
          Text(
            animal?.name ?? animal?.earTag ?? 'Hayvan eşleştirilmedi',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: animal == null ? AppColors.lightGreyColor : AppColors.onSurface,
            ),
          ),
          if (animal?.name != null)
            Text(
              animal!.earTag,
              style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceMuted),
            ),
          const SizedBox(height: AppSpacing.md),
          _flowRow(palette),
          const SizedBox(height: AppSpacing.sm),
          _progress(palette),
          const SizedBox(height: AppSpacing.sm),
          _amountRow('Şu an', '${Fmt.litres(update.volumeMl)} L'),
          _amountRow('Hedef', '${Fmt.litres(update.expectedMl)} L'),
          if (update.flowColor == MilkColor.red) ...[
            const SizedBox(height: AppSpacing.sm),
            // Ölçülen şey BASINÇ DEĞİL DEBİ. Eski metin "Düşük Basınç"
            // yazıyordu ve yanlıştı (§15.3/15).
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    size: 16, color: AppColors.flowRed),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Düşük Debi',
                  style: TextStyle(
                    color: palette.foreground,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _header(MilkPalette palette) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.lightGreyColor),
          ),
        ),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: palette.foreground,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _flowRow(MilkPalette palette) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: Text(
            'Akış oranı',
            style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
          ),
        ),
        Text(
          update.flowRate.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: palette.foreground,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        const Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Text('L/dk',
              style: TextStyle(fontSize: 11, color: AppColors.onSurfaceMuted)),
        ),
      ],
    );
  }

  Widget _progress(MilkPalette palette) {
    // Eski kart TitledProgressBar(maxSteps: targetAmount.toInt(),
    // currentStep: sessionYield.toInt()) kullanıyordu. Üç ayrı hatası vardı
    // (§15.3/16): hedef 0 ise bölme hatası, hedef aşılınca taşma, ve .toInt()
    // ondalıkları kırpıyordu. Oran burada hesaplanıp 0..1'e kısıtlanıyor;
    // yüzde metni KIRPILMIYOR ki %100 üstü verim görünebilsin.
    final ratio = update.expectedMl == 0
        ? 0.0
        : (update.volumeMl / update.expectedMl).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: AppRadius.smAll,
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 16,
            backgroundColor: AppColors.veryLightGreyColor,
            valueColor: AlwaysStoppedAnimation<Color>(palette.foreground),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          update.expectedMl == 0
              ? 'Hedef tanımsız'
              : Fmt.percent(update.yieldPct),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurfaceMuted,
          ),
        ),
      ],
    );
  }

  Widget _amountRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.onSurfaceMuted)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
