import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/deliveries/deliveries_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';

/// Panoda son tank teslimi (backend ADR 0089). Teslim girebilenlere hep
/// görünür (girişin yeri burası); görüntüleyiciye yalnızca kayıt varsa.
/// Okunamazsa çizilmez: hata günün özetini bastırmasın.
class DeliveryCard extends ConsumerWidget {
  const DeliveryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authProvider).user?.role;
    final value = ref.watch(deliveriesProvider).value;
    final items = value?.items ?? const [];
    final canEnter = canEnterDelivery(role);
    if (value == null || (items.isEmpty && !canEnter)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Material(
        color: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.mdAll,
          side: BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Tank teslimi',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (items.isNotEmpty)
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.darkGreenColor,
                      ),
                      onPressed: () => context.push('/deliveries'),
                      child: const Text('Tümü', style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
              if (items.isEmpty)
                const Text(
                  'Tanker fişini girin: sayaçların ölçtüğüyle karşılaştırılır, '
                  'fark büyükse uyarı gelir.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                )
              else
                DeliveryTile(
                  delivery: items.first,
                  volume: ref.watch(volumeFormatProvider),
                ),
              if (canEnter)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => showAddDelivery(context, ref),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Teslim gir'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkGreenColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
