import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/features/history/widgets/animal_status_chip.dart';
import 'package:milktrace/features/history/widgets/yield_chart.dart';
import 'package:milktrace/features/history/widgets/yield_class_badge.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
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
          ..invalidate(animalHistoryProvider(animal.id))
          ..invalidate(animalNotesProvider(animal.id));
        await ref.read(animalTrendProvider(animal.id).future);
      },
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          _IdentityCard(
            animal: animal,
            // Taze süre TÜRÜN eşiğinden (backend ADR 0059); eşik yoksa
            // varsayılan.
            freshDays:
                ref
                    .watch(thresholdsListProvider)
                    .value
                    ?.where((t) => t.speciesId == animal.speciesId)
                    .firstOrNull
                    ?.freshLactationDays ??
                Animal.freshLactationDays,
          ),
          const SizedBox(height: AppSpacing.md),
          // Notlar sınıf etiketinin HEMEN altında: sınıflandırma karar
          // desteğidir, not ("mastitis, tedavide") o kararın bağlamı (§6.4).
          _NotesCard(animalId: animal.id),
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
  const _IdentityCard({required this.animal, required this.freshDays});

  final Animal animal;
  final int freshDays;

  @override
  Widget build(BuildContext context) {
    final cls = animal.yieldClass;
    final dim = animal.daysInMilk(DateTime.now());

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
              // Sağmal olmayanın sınıfı DONMUŞTUR: rozet yerine durum;
              // son etiket aşağıda tarihiyle (backend ADR 0055).
              if (animal.isMilking)
                YieldClassBadge(yieldClass: cls)
              else
                AnimalStatusChip(label: animal.statusLabel),
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
              // Laktasyon günü yalnızca SAĞMAL hayvanda anlamlı.
              if (animal.isMilking && dim != null)
                _Fact('Laktasyon günü', '$dim.'),
            ],
          ),
          if (animal.isMilking && dim != null && dim < freshDays) ...[
            const SizedBox(height: AppSpacing.sm),
            // Neden "düşüşte" ya da "kuruya aday" görünmediği: sınıf
            // etiketinin kendisi kadar açıklaması da ekranda (§6.4).
            Text(
              'Taze laktasyon: ilk $freshDays günde "düşüşte" ve "kuruya '
              'çıkarma adayı" etiketi verilmez; verim henüz yükseliyor.',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.onSurfaceMuted,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          if (!animal.isMilking)
            _FrozenClass(animal: animal)
          else ...[
            Text(
              cls.explanation,
              style: const TextStyle(fontSize: 12, height: 1.4),
            ),
            if (_stale(animal) case final at?) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Sınıf ${Fmt.dayMonthYear(at)} hesabından: gece hesabı '
                'yalnızca son 30 günde sağılan hayvanı yeniler.',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceMuted,
                ),
              ),
            ],
          ],
          if (animal.isMilking &&
              cls != YieldClass.normal &&
              cls != YieldClass.high) ...[
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

/// Sağmal hayvanın sınıfı ESKİYSE hesap günü; değilse null.
///
/// Gece hesabı dünü hesaplıyor, yani güncel bir sınıf en çok bir iki gün
/// geridedir. Daha eskisi, hayvanın pencerede sağımı olmadığı için
/// yenilenmemiş demektir ve kullanıcı bunu bilmeli.
DateTime? _stale(Animal a) {
  final at = a.yieldClassAt;
  if (at == null) return null;
  final days = DateTime.now().difference(at).inDays;
  return days > 2 ? at : null;
}

/// Sağmal olmayan hayvanın DONMUŞ sınıfı (backend ADR 0055).
///
/// Etiket silinmez: "kuruya çıkarken yüksek verimliydi" laktasyonlar arası
/// karşılaştırmada değerli. Ama güncel bir değerlendirme gibi de okunmamalı;
/// açıklaması ve kesim uyarısı bu yüzden gösterilmez.
class _FrozenClass extends StatelessWidget {
  const _FrozenClass({required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    final at = animal.yieldClassAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Son sınıf: ${animal.yieldClass.label}'
          '${at == null ? '' : ' (${Fmt.dayMonthYear(at)})'}',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Sağmal olmayan hayvan sınıflandırılmaz; bu etiket sağmalken '
          'yapılan son hesaptan kalmadır.',
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
        ),
      ],
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

/// Hayvan notları (§6.4, backend ADR 0050): en yeni üstte, yazarı ve anıyla.
///
/// Bütün işletme rolleri yazar — görüntüleyici §5'te "veteriner, danışman"
/// ve "son veteriner kontrolü" notunu tam o kişi yazar. Notlar düzenlenmez
/// ve silinmez: bir karar izi.
class _NotesCard extends ConsumerWidget {
  const _NotesCard({required this.animalId});

  final String animalId;

  /// Kartta gösterilen en fazla not; gerisi "N not daha".
  static const _shown = 5;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final text = await showDialog<String>(
      context: context,
      builder: (_) => const _NoteDialog(),
    );
    if (text == null || text.trim().isEmpty || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(repositoryProvider).addAnimalNote(animalId, text);
      ref.invalidate(animalNotesProvider(animalId));
      messenger.showSnackBar(const SnackBar(content: Text('Not eklendi')));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text(userMessage(e) ?? 'Not eklenemedi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(animalNotesProvider(animalId));

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Notlar',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton.icon(
                onPressed: () => _add(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Not ekle'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
            ],
          ),
          AsyncView(
            value: notes,
            errorMessage: 'Notlar alınamadı',
            builder: (list) {
              if (list.isEmpty) {
                return const Text(
                  'Henüz not yok. Veteriner kontrolü, gebelik ya da tedavi '
                  'bilgisi sınıf etiketini yorumlamaya yardım eder.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final n in list.take(_shown))
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Durum değişikliği kendiliğinden düşer (backend
                          // ADR 0057); elle yazılandan ayırt edilsin.
                          if (n.isStatusChange)
                            Row(
                              children: [
                                const Icon(
                                  Icons.swap_horiz,
                                  size: 16,
                                  color: AppColors.darkGreenColor,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Expanded(
                                  child: Text(
                                    n.note,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.darkGreenColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Text(n.note, style: const TextStyle(fontSize: 13)),
                          Text(
                            [
                              if ((n.authorName ?? '').isNotEmpty)
                                n.authorName!,
                              '${Fmt.dayMonthYear(n.createdAt)} '
                                  '${Fmt.time(n.createdAt)}',
                            ].join(' · '),
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.onSurfaceMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (list.length > _shown)
                    Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.sm),
                      child: Text(
                        '${list.length - _shown} not daha',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.onSurfaceMuted,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Not yazma penceresi; en çok 1000 karakter (backend sınırı).
class _NoteDialog extends StatefulWidget {
  const _NoteDialog();

  @override
  State<_NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<_NoteDialog> {
  final _text = TextEditingController();

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Not ekle'),
    content: TextField(
      controller: _text,
      autofocus: true,
      minLines: 3,
      maxLines: 6,
      maxLength: 1000,
      decoration: const InputDecoration(
        hintText: 'Örn. Son veteriner kontrolü: mastitis, tedavide.',
        border: OutlineInputBorder(borderRadius: AppRadius.smAll),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('Vazgeç'),
      ),
      FilledButton(
        onPressed: () => Navigator.of(context).pop(_text.text),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.darkGreenColor,
        ),
        child: const Text('Kaydet'),
      ),
    ],
  );
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
