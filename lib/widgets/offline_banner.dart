import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/providers/offline_providers.dart';

/// Çevrimdışıyken ekranın üstündeki bant (§18/7).
///
/// Verinin NE ZAMANA ait olduğunu söyler: eski bir canlı kareyi güncel
/// sanmak, bağlantının koptuğunu hiç bilmemekten kötüdür. Yazmaların neden
/// çalışmadığını da açıklar.
class OfflineBanner extends ConsumerWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final at = ref.watch(offlineStatusProvider);
    if (at == null) return const SizedBox.shrink();
    final now = DateTime.now();
    final local = at.toLocal();
    final sameDay =
        local.year == now.year &&
        local.month == now.month &&
        local.day == now.day;
    final when = sameDay ? Fmt.time(at) : '${Fmt.dayMonth(at)} ${Fmt.time(at)}';
    return Material(
      color: AppColors.lightAmberColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.cloud_off,
              size: 18,
              color: AppColors.darkAmberColor,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                'Çevrimdışı · son veri $when. Değişiklikler bağlantı gelince '
                'yapılabilir.',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.darkAmberColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
