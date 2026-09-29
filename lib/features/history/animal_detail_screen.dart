import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/breeding_card.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/features/history/treatments_card.dart';
import 'package:milktrace/features/history/widgets/animal_status_chip.dart';
import 'package:milktrace/features/history/widgets/yield_chart.dart';
import 'package:milktrace/features/history/widgets/yield_class_badge.dart';
import 'package:milktrace/l10n/l10n.dart';
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
              l10n.animalDetailTitleFallback,
        ),
        Expanded(
          child: AsyncView(
            value: animals,
            errorMessage: l10n.animalDetailLoadFailed,
            builder: (list) {
              final animal = list.where((a) => a.id == animalId).firstOrNull;
              if (animal == null) {
                return Center(
                  child: ErrorView(message: l10n.animalDetailNotRegistered),
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
            tooltip: l10n.commonBack,
            onPressed: () => context.go('/history'),
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreenColor,
              ),
            ),
          ),
          if (isOwner)
            IconButton(
              tooltip: l10n.commonEdit,
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
          ..invalidate(animalNotesProvider(animal.id))
          ..invalidate(animalTreatmentsProvider(animal.id))
          ..invalidate(animalBreedingProvider(animal.id));
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
          // Buzağılama kaydı yalnızca işletme sahibine (backend ADR 0060;
          // hayvan kaydı onun işi, backend de 403 döner).
          if (ref.watch(authProvider).user?.role == 'tenant_owner')
            _CalvingButton(animal: animal),
          const SizedBox(height: AppSpacing.md),
          // Notlar sınıf etiketinin HEMEN altında: sınıflandırma karar
          // desteğidir, not ("mastitis, tedavide") o kararın bağlamı (§6.4).
          _NotesCard(animalId: animal.id),
          const SizedBox(height: AppSpacing.md),
          // Tedavi ve arınma (backend ADR 0084): süren arınma kırmızı bant.
          TreatmentsCard(animal: animal),
          const SizedBox(height: AppSpacing.md),
          // Üreme (backend ADR 0088): durum, beklenen doğum, kuruya çıkarma.
          BreedingCard(animal: animal),
          const SizedBox(height: AppSpacing.md),
          AsyncView(
            value: trend,
            errorMessage: l10n.animalDetailTrendFailed,
            builder: (t) => _TrendCard(
              trend: t,
              volume: ref.watch(volumeFormatProvider),
              species: animal.speciesId,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AsyncView(
            value: history,
            errorMessage: l10n.animalDetailHistoryFailed,
            builder: (h) => _HistoryCard(
              milkings: h,
              volume: ref.watch(volumeFormatProvider),
              species: animal.speciesId,
            ),
          ),
        ],
      ),
    );
  }
}

/// "Buzağıladı" (backend ADR 0060): tarih seçtirir, özeti onaylatır ve TEK
/// istekte tarih, laktasyon sırası, durum ve notu yazdırır. Formda üç alanı
/// ayrı ayrı düzeltmek, birini unutmaya açıktı.
class _CalvingButton extends ConsumerWidget {
  const _CalvingButton({required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => _record(context, ref),
        icon: const Icon(Icons.child_friendly_outlined),
        label: Text(l10n.animalDetailCalved),
        style: TextButton.styleFrom(foregroundColor: AppColors.darkGreenColor),
      ),
    );
  }

  Future<void> _record(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = animal.lastCalvingDate;
    // Önceki buzağılamadan sonraki ilk gün; en fazla bir yıl geriye.
    var first = today.subtract(const Duration(days: 365));
    if (last != null) {
      final after = DateTime(last.year, last.month, last.day + 1);
      if (after.isAfter(first)) first = after;
    }
    if (first.isAfter(today)) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.animalDetailCalvingAlreadyToday)),
      );
      return;
    }
    final date = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: first,
      lastDate: today,
      helpText: l10n.animalDetailCalvingDate,
    );
    if (date == null || !context.mounted) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.animalDetailCalvingConfirmTitle),
        content: Text(
          [
            '${animal.name ?? animal.earTag} · ${Fmt.dayMonthYear(date)}',
            l10n.animalDetailCalvingLactation(
              animal.lactationNo,
              animal.lactationNo + 1,
            ),
            if (!animal.isMilking)
              l10n.animalDetailCalvingStatus(animal.statusLabel),
          ].join('\n'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.brandFill),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
    if (ok != true) return;

    try {
      await ref.read(repositoryProvider).recordCalving(animal.id, date);
      ref
        ..invalidate(animalsProvider)
        ..invalidate(animalNotesProvider(animal.id))
        ..invalidate(animalTrendProvider(animal.id));
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.animalDetailCalvingSaved),
          backgroundColor: AppColors.brandFill,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.commonSaveFailed(e)),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    }
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
                      style: TextStyle(
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
              if (animal.breed != null)
                _Fact(l10n.animalDetailBreed, animal.breed!),
              if (animal.groupName != null)
                _Fact(l10n.animalDetailGroup, animal.groupName!),
              _Fact(
                l10n.animalDetailLactation,
                l10n.animalDetailOrdinal(animal.lactationNo),
              ),
              if (animal.lastCalvingDate != null)
                _Fact(
                  l10n.animalDetailLastCalving,
                  Fmt.dayMonthYear(animal.lastCalvingDate!),
                ),
              // Laktasyon günü yalnızca SAĞMAL hayvanda anlamlı.
              if (animal.isMilking && dim != null)
                _Fact(
                  l10n.animalDetailDaysInMilk,
                  l10n.animalDetailOrdinal(dim),
                ),
            ],
          ),
          if (animal.isMilking && dim != null && dim < freshDays) ...[
            const SizedBox(height: AppSpacing.sm),
            // Neden "düşüşte" ya da "kuruya aday" görünmediği: sınıf
            // etiketinin kendisi kadar açıklaması da ekranda (§6.4).
            Text(
              l10n.animalDetailFreshLactation(freshDays),
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
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
                l10n.animalDetailStaleClass(Fmt.dayMonthYear(at)),
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: AppColors.lightGreyColor,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    l10n.animalDetailDisclaimer,
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
          '${l10n.animalDetailLastClass(animal.yieldClass.label)}'
          '${at == null ? '' : ' (${Fmt.dayMonthYear(at)})'}',
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.animalDetailFrozenClassNote,
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
        ),
      ],
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.trend, required this.volume, this.species});

  final AnimalTrend trend;

  /// Miktar birimi ve hayvanın türü (yoğunluk için, backend ADR 0086).
  final VolumeFormat volume;
  final String? species;

  @override
  Widget build(BuildContext context) {
    // Eğim GÜNLÜK mL; 30 günlük değişim olarak göstermek daha okunur —
    // "günde -142 mL" sahada hiçbir şey ifade etmiyor.
    final monthly = volume.value(
      (trend.trendSlope * 30).round(),
      species: species,
    );

    // Küçük dalgalanma RENKLENDİRİLMEZ. Her negatif eğime kırmızı vermek,
    // laktasyonun doğal inişindeki sağlıklı bir hayvanı da kırmızı
    // gösteriyordu — §6.2'nin ısınma/bitiş bastırmalarıyla aynı gerekçe:
    // yanlış alarm, rengi anlamsızlaştırır.
    final base = volume.value(trend.ma30Ml, species: species);
    final notable = base > 0 && (monthly.abs() / base) >= 0.10;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.animalDetailYieldTrend,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _Stat(
                l10n.animalDetailAvg7,
                volume.amount(trend.ma7Ml, species: species),
              ),
              _Stat(
                l10n.animalDetailAvg30,
                volume.amount(trend.ma30Ml, species: species),
              ),
              _Stat(
                l10n.animalDetailTrend30,
                '${monthly >= 0 ? '+' : ''}${monthly.toStringAsFixed(1)} '
                '${volume.label}',
                color: !notable
                    ? null
                    : monthly < 0
                    ? AppColors.flowRed
                    : AppColors.flowGreen,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          YieldChart(
            daily: trend.daily,
            factor: volume.value(1000, species: species),
            unit: volume.label,
          ),
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.milkings,
    required this.volume,
    this.species,
  });

  /// Yeniden eskiye sıralı.
  final List<AnimalMilking> milkings;

  /// Miktar birimi ve hayvanın türü (backend ADR 0086).
  final VolumeFormat volume;
  final String? species;

  /// Ekranda gösterilen sağım sayısı.
  ///
  /// 90 günün 180 satırının tamamı listelenseydi, kullanıcı aradığı günü
  /// kaydırarak arardı. Tarih aralığı seçimi Faz 5'e ait.
  static const int _limit = 20;

  @override
  Widget build(BuildContext context) {
    if (milkings.isEmpty) {
      return _Card(
        child: Text(
          l10n.animalDetailNoMilkings,
          style: TextStyle(color: AppColors.onSurfaceMuted),
        ),
      );
    }

    final shown = milkings.take(_limit).toList(growable: false);

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.animalDetailRecentMilkings,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final m in shown)
            _MilkingRow(milking: m, volume: volume, species: species),
          if (milkings.length > _limit) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.animalDetailShownOfTotal(milkings.length, _limit),
              style: TextStyle(fontSize: 11, color: AppColors.onSurfaceMuted),
            ),
          ],
        ],
      ),
    );
  }
}

class _MilkingRow extends StatelessWidget {
  const _MilkingRow({
    required this.milking,
    required this.volume,
    this.species,
  });

  final VolumeFormat volume;
  final String? species;

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
            volume.amount(milking.volumeMl, species: species),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 46,
            child: Text(
              // Beklenti yoksa yüzde YAZILMAZ: %0 yanlış alarm olurdu (§6.3).
              milking.expectedMl == 0 ? '—' : Fmt.percent(milking.yieldPct),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
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
            style: TextStyle(fontSize: 11, color: AppColors.onSurfaceMuted),
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
            style: TextStyle(color: AppColors.onSurfaceMuted),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
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
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.animalDetailNoteAdded)),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.animalDetailNoteAddFailed(e)),
        ),
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
              Expanded(
                child: Text(
                  l10n.animalDetailNotes,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () => _add(context, ref),
                icon: const Icon(Icons.add, size: 18),
                label: Text(l10n.animalDetailAddNote),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
            ],
          ),
          AsyncView(
            value: notes,
            errorMessage: l10n.animalDetailNotesFailed,
            builder: (list) {
              if (list.isEmpty) {
                return Text(
                  l10n.animalDetailNoNotes,
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
                          if (n.isStatusChange || n.isCalving)
                            Row(
                              children: [
                                Icon(
                                  n.isCalving
                                      ? Icons.child_friendly_outlined
                                      : Icons.swap_horiz,
                                  size: 16,
                                  color: AppColors.darkGreenColor,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Expanded(
                                  child: Text(
                                    n.note,
                                    style: TextStyle(
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
                            style: TextStyle(
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
                        l10n.animalDetailMoreNotes(list.length - _shown),
                        style: TextStyle(
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
    title: Text(l10n.animalDetailAddNote),
    content: TextField(
      controller: _text,
      autofocus: true,
      minLines: 3,
      maxLines: 6,
      maxLength: 1000,
      decoration: InputDecoration(
        hintText: l10n.animalDetailNoteHint,
        border: const OutlineInputBorder(borderRadius: AppRadius.smAll),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(l10n.commonCancel),
      ),
      FilledButton(
        onPressed: () => Navigator.of(context).pop(_text.text),
        style: FilledButton.styleFrom(backgroundColor: AppColors.brandFill),
        child: Text(l10n.commonSave),
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
