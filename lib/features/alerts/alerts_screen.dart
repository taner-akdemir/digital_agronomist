import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/features/alerts/alert_style.dart';
import 'package:milktrace/features/alerts/alerts_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/milk_palette.dart';

/// Bildirim merkezi (§15.1 "Diğer").
///
/// Sekme kabuğunun DIŞINDA, tam ekran açılır: uyarı listesi bir sekmenin
/// alt ekranı değil, her sekmeden ulaşılan bir yer.
class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Uyarılar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(alertListProvider);
          await ref.read(alertListProvider.future);
        },
        child: AsyncView(
          value: alerts,
          errorMessage: 'Uyarılar yüklenemedi',
          builder: (list) => list.isEmpty
              ? const _Empty()
              : ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: list.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) => _AlertCard(alert: list[i]),
                ),
        ),
      ),
    );
  }
}

class _AlertCard extends ConsumerWidget {
  const _AlertCard({required this.alert});

  final Alert alert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = MilkPalette.of(AlertStyle.color(alert.severity));
    final acked = alert.isAcknowledged;
    final animalId = alert.animalId;

    return Opacity(
      // Okunmuş uyarı SİLİNMEZ, soluklaşır: neyin ne zaman kapatıldığı
      // sahada geriye dönük olarak sorulan bir şey.
      opacity: acked ? 0.55 : 1,
      child: Material(
        color: acked ? AppColors.surfaceAlt : palette.surface,
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          // Hayvan uyarısından hayvanın geçmişine geçilir: "düşük debi"
          // uyarısının ilk sorusu "bu hayvan daha önce de böyle miydi?".
          onTap: animalId == null
              ? null
              : () => context.go('/history/animal/$animalId'),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              borderRadius: AppRadius.mdAll,
              border: Border.all(
                color: acked ? AppColors.border : palette.border,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  AlertStyle.icon(alert.type),
                  size: 20,
                  color: acked ? AppColors.lightGreyColor : palette.foreground,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Metin BACKEND'DEN gelir ve olduğu gibi gösterilir:
                      // hangi kuralın tetiklendiğini sunucu bilir (§16).
                      Text(
                        alert.message,
                        style: const TextStyle(fontSize: 13, height: 1.35),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        _when(alert),
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.onSurfaceMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!acked)
                  TextButton(
                    // Rengi TEMADAN değil token'dan: ColorScheme'in birincil
                    // rengi mavi ve düğme, yeşil paletin ortasında tek başına
                    // mavi duruyordu (§15 tasarım dili).
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.darkGreenColor,
                    ),
                    onPressed: () =>
                        ref.read(alertListProvider.notifier).ack(alert.id),
                    child: const Text('Okundu', style: TextStyle(fontSize: 12)),
                  )
                else
                  const Padding(
                    padding: EdgeInsets.only(left: AppSpacing.sm, top: 2),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _when(Alert a) {
    final t = a.createdAt;
    if (t == null) return '';
    final stamp = '${Fmt.dayMonth(t)} · ${Fmt.time(t)}';
    return a.isAcknowledged ? '$stamp · okundu' : stamp;
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    // Kaydırılabilir kalmalı: RefreshIndicator boş listede de çalışsın.
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      children: const [
        SizedBox(height: AppSpacing.xxl),
        Icon(
          Icons.notifications_none_outlined,
          size: 44,
          color: AppColors.lightGreyColor,
        ),
        SizedBox(height: AppSpacing.md),
        Text(
          'Açık uyarı yok',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.onSurfaceMuted),
        ),
      ],
    );
  }
}
