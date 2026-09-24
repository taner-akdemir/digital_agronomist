import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/features/history/widgets/yield_chart.dart';
import 'package:milktrace/features/history/widgets/yield_class_badge.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/error_view.dart';
import 'package:milktrace/widgets/milk_palette.dart';

/// Hayvan detayı: sınıf, trend, verim grafiği ve son sağımlar (§15.1).
///
/// KENDİ Scaffold'u YOK: Geçmiş sekmesinin içinde açılır, yani kabuğun üst
/// çubuğu ve alt menüsü yerinde kalır. İçeride ikinci bir AppBar iki üst
/// çubuk demekti; geri okunu bu yüzden ekran kendi başlığında taşıyor.
class AnimalDetailScreen extends ConsumerWidget {
  const AnimalDetailScreen({super.key, required this.animalId});

  final String animalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animals = ref.watch(animalsProvider);

    return Column(
      children: [
        _BackBar(
          animalId: animalId,
          title:
              animals.value
                  ?.where((a) => a.id == animalId)
                  .map((a) => a.name ?? a.earTag)
                  .firstOrNull ??
              'Hayvan',
        ),
        Expanded(
          child: AsyncView(
            value: animals,
            errorMessage: 'Hayvan bilgisi yüklenemedi',
            builder: (list) {
              final animal = list.where((a) => a.id == animalId).firstOrNull;
              if (animal == null) {
                return const Center(
                  child: ErrorView(message: 'Bu hayvan kayıtlı değil'),
                );
              }
              return _Body(animal: animal);
            },
          ),
        ),
      ],
    );
  }
}

class _BackBar extends ConsumerWidget {
  const _BackBar({required this.title, required this.animalId});

  final String title;
  final String animalId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Düzenleme YALNIZCA işletme sahibine (§5); backend de 403 döner.
    final isOwner = ref.watch(authProvider).user?.role == 'tenant_owner';
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Geri',
            onPressed: () => context.go('/history'),
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreenColor,
              ),
            ),
          ),
          if (isOwner)
            IconButton(
              tooltip: 'Düzenle',
              onPressed: () => context.push('/animals/$animalId/edit'),
              icon: const Icon(Icons.edit_outlined),
            ),
        ],
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trend = ref.watch(animalTrendProvider(animal.id));
    final history = ref.watch(animalHistoryProvider(animal.id));

    return RefreshIndicator(
      onRefresh: () async {
        ref
          ..invalidate(animalTrendProvider(animal.id))
          ..invalidate(animalHistoryProvider(animal.id));
        await ref.read(animalTrendProvider(animal.id).future);
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _IdentityCard(animal: animal),
          const SizedBox(height: AppSpacing.md),
          AsyncView(
            value: trend,
            errorMessage: 'Trend alınamadı',
            builder: (t) => _TrendCard(trend: t),
          ),
          const SizedBox(height: AppSpacing.md),
          AsyncView(
            value: history,
            errorMessage: 'Sağım geçmişi alınamadı',
            builder: (h) => _HistoryCard(milkings: h),
          ),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    final cls = animal.yieldClass;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animal.name ?? animal.earTag,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      animal.earTag,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
              ),
              YieldClassBadge(yieldClass: cls),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.xs,
            children: [
              if (animal.breed != null) _Fact('Irk', animal.breed!),
              _Fact('Laktasyon', '${animal.lactationNo}.'),
              if (animal.lastCalvingDate != null)
                _Fact(
                  'Son buzağılama',
                  Fmt.dayMonthYear(animal.lastCalvingDate!),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            cls.explanation,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          if (cls != YieldClass.normal && cls != YieldClass.high) ...[
            const SizedBox(height: AppSpacing.sm),
            // §6.4'ün uyarısı ekranda DURMALI: sistem karar destek aracıdır,
            // kesim kararı vermez. Bu cümle olmadan rozet bir teşhis gibi
            // okunurdu.
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: AppColors.lightGreyColor,
                ),
                SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Bu bir öneridir, teşhis değildir. Gebelik, laktasyon dönemi '
                    've hastalık verimi düşürebilir; veteriner kontrolü gerekir.',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.onSurfaceMuted,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.trend});

  final AnimalTrend trend;

  @override
  Widget build(BuildContext context) {
    // Eğim GÜNLÜK mL; 30 günlük değişim olarak göstermek daha okunur —
    // "günde -142 mL" sahada hiçbir şey ifade etmiyor.
    final monthly = trend.trendSlope * 30 / 1000;

    // Küçük dalgalanma RENKLENDİRİLMEZ. Her negatif eğime kırmızı vermek,
    // laktasyonun doğal inişindeki sağlıklı bir hayvanı da kırmızı
    // gösteriyordu — §6.2'nin ısınma/bitiş bastırmalarıyla aynı gerekçe:
    // yanlış alarm, rengi anlamsızlaştırır.
    final base = trend.ma30Ml / 1000;
    final notable = base > 0 && (monthly.abs() / base) >= 0.10;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Verim trendi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _Stat('7 gün ort.', '${Fmt.litres(trend.ma7Ml)} L'),
              _Stat('30 gün ort.', '${Fmt.litres(trend.ma30Ml)} L'),
              _Stat(
                '30 günlük eğilim',
                '${monthly >= 0 ? '+' : ''}${monthly.toStringAsFixed(1)} L',
                color: !notable
                    ? null
                    : monthly < 0
                    ? AppColors.flowRed
                    : AppColors.flowGreen,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          YieldChart(daily: trend.daily),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.milkings});

  /// Yeniden eskiye sıralı.
  final List<AnimalMilking> milkings;

  /// Ekranda gösterilen sağım sayısı.
  ///
  /// 90 günün 180 satırının tamamı listelenseydi, kullanıcı aradığı günü
  /// kaydırarak arardı. Tarih aralığı seçimi Faz 5'e ait.
  static const int _limit = 20;

  @override
  Widget build(BuildContext context) {
    if (milkings.isEmpty) {
      return const _Card(
        child: Text(
          'Bu hayvana ait sağım kaydı yok',
          style: TextStyle(color: AppColors.onSurfaceMuted),
        ),
      );
    }

    final shown = milkings.take(_limit).toList(growable: false);

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Son sağımlar',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final m in shown) _MilkingRow(milking: m),
          if (milkings.length > _limit) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${milkings.length} sağımın ilk $_limit tanesi gösteriliyor',
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.onSurfaceMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MilkingRow extends StatelessWidget {
  const _MilkingRow({required this.milking});

  final AnimalMilking milking;

  @override
  Widget build(BuildContext context) {
    final palette = MilkPalette.of(milking.color);
    final started = milking.startedAt;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: palette.foreground,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              started == null
                  ? Fmt.sessionType(milking.sessionType)
                  : '${Fmt.dayMonth(started)} · '
                        '${Fmt.sessionType(milking.sessionType)}',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Text(
            '${Fmt.litres(milking.volumeMl)} L',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 46,
            child: Text(
              // Beklenti yoksa yüzde YAZILMAZ: %0 yanlış alarm olurdu (§6.3).
              milking.expectedMl == 0 ? '—' : Fmt.percent(milking.yieldPct),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value, {this.color});

  final String label;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.onSurfaceMuted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color ?? AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(color: AppColors.onSurfaceMuted),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpacing.lg),
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: AppRadius.mdAll,
      border: Border.all(color: AppColors.border),
    ),
    child: child,
  );
}
