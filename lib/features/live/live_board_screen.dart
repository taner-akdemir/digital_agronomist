import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/spout.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/vacuum.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/domain/placement_sequence.dart';
import 'package:milktrace/features/live/live_providers.dart';
import 'package:milktrace/features/live/red_alert.dart';
import 'package:milktrace/features/live/widgets/animal_picker.dart';
import 'package:milktrace/features/live/widgets/live_info_card.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/widgets/error_view.dart';
import 'package:milktrace/widgets/light_info.dart';

/// Canlı sağım ekranı (§15.1).
///
/// Bölge seçimi → o bölgedeki sağım noktalarının canlı kartları.
class LiveBoardScreen extends ConsumerWidget {
  const LiveBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hall = ref.watch(effectiveHallProvider);

    return hall.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorView(
        message: l10n.liveHallsLoadFailed,
        error: e,
        onRetry: () => ref.invalidate(hallsProvider),
      ),
      data: (h) =>
          h == null ? Center(child: Text(l10n.liveNoHalls)) : _Board(hall: h),
    );
  }
}

class _Board extends ConsumerWidget {
  const _Board({required this.hall});

  final Hall hall;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(liveBoardProvider(hall.id));
    final spouts = ref.watch(spoutsByHallProvider(hall.id));
    final vacuums = ref.watch(vacuumsByHallProvider(hall.id));

    final live = board.value;

    return RedAlertListener(
      hallId: hall.id,
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(liveBoardProvider(hall.id));
          await ref.read(liveBoardProvider(hall.id).future);
        },
        // Tek bir CustomScrollView. Eski ekran ListView içinde shrinkWrap'li
        // bir GridView barındırıyordu ve her build'de YENİ bir ScrollController
        // yaratıyordu (§15.3/13).
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(hall: hall, live: live),
            ),
            switch (board) {
              AsyncLoading() when live == null => const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              ),
              AsyncError(:final error) => SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorView(
                  message: l10n.liveDataFailed,
                  error: error,
                  onRetry: () => ref.invalidate(liveBoardProvider(hall.id)),
                ),
              ),
              _ => _Grid(
                live: live!,
                hall: hall,
                spouts: spouts.value ?? const [],
                vacuums: vacuums.value ?? const [],
              ),
            },
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),
          ],
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({required this.hall, required this.live});

  final Hall hall;
  final LiveSession? live;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final halls = ref.watch(hallsProvider).value ?? const <Hall>[];

    final updates = live?.updates ?? const <SpoutUpdate>[];
    final active = updates.where((u) => u.state == SpoutState.milking).length;
    final passive = updates.length - active;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.liveTitle,
            style: TextStyle(fontSize: 13, color: AppColors.onSurfaceMuted),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: hall.id,
                    isExpanded: true,
                    style: TextStyle(
                      // Açılır listenin stili temadan yazı tipi almaz.
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreenColor,
                    ),
                    items: [
                      for (final h in halls)
                        DropdownMenuItem(
                          value: h.id,
                          child: Text(l10n.liveHallName(h.name)),
                        ),
                    ],
                    onChanged: (id) {
                      if (id != null) {
                        ref.read(selectedHallProvider.notifier).select(id);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              LightInfo(
                color: AppColors.flowGreen,
                label: l10n.liveActiveCount(active),
              ),
              const SizedBox(width: AppSpacing.sm),
              LightInfo(
                color: AppColors.flowGrey,
                label: l10n.livePassiveCount(passive),
              ),
              // Kırmızı uyarısı (backend ADR 0091): titreşim + kısa ses.
              IconButton(
                tooltip: ref.watch(redAlertEnabledProvider)
                    ? l10n.liveRedAlertOff
                    : l10n.liveRedAlertOn,
                onPressed: () => ref
                    .read(redAlertEnabledProvider.notifier)
                    .set(!ref.read(redAlertEnabledProvider)),
                icon: Icon(
                  ref.watch(redAlertEnabledProvider)
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_off_outlined,
                  color: AppColors.darkGreenColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _SessionControls(hall: hall, live: live),
        ],
      ),
    );
  }
}

/// "Sağımı Başlat" / "Sağımı Bitir" (§15.1).
///
/// Sağımı BAŞLATAN operatördür, sistem değil: takip o anda başlıyor (§6.1/1)
/// ve beklenen verim oturum tipine göre hesaplanıyor (§6.3). Saate bakıp
/// tahmin etmek, tüm renkleri sessizce yanlış tarafa kaydırırdı.
class _SessionControls extends ConsumerWidget {
  const _SessionControls({required this.hall, required this.live});

  final Hall hall;
  final LiveSession? live;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (live == null) return const SizedBox.shrink();

    final busy = ref.watch(milkingControlProvider);
    final active = live!.session.status == 'active';

    return Row(
      children: [
        Expanded(
          child: active
              ? OutlinedButton.icon(
                  onPressed: busy ? null : () => _end(context, ref),
                  icon: const Icon(Icons.stop_circle_outlined, size: 18),
                  label: Text(l10n.liveEndMilking),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkRedColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.smAll,
                    ),
                  ),
                )
              : FilledButton.icon(
                  onPressed: busy ? null : () => _start(context, ref),
                  icon: const Icon(Icons.play_arrow_rounded, size: 20),
                  label: Text(l10n.liveStartMilking),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brandFill,
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.smAll,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _start(BuildContext context, WidgetRef ref) async {
    final type = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) => const _SessionTypeSheet(),
    );
    if (type == null || !context.mounted) return;

    await _guard(
      context,
      ref,
      () => ref
          .read(milkingControlProvider.notifier)
          .start(hallId: hall.id, type: type),
    );
  }

  Future<void> _end(BuildContext context, WidgetRef ref) async {
    // ONAY İSTENİR: bitirme geri alınamaz ve açık kalan hayvan sağımlarını
    // da kapatıyor (§6.1/5). Yanlışlıkla dokunmak sağımı yarıda keserdi.
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.liveEndDialogTitle),
        content: Text(l10n.liveEndDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.darkRedColor,
            ),
            child: Text(l10n.liveEndConfirm),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;

    await _guard(
      context,
      ref,
      () => ref
          .read(milkingControlProvider.notifier)
          .end(sessionId: live!.session.id),
    );
  }
}

/// Oturum tipi seçimi (§8.4: morning | evening | other).
class _SessionTypeSheet extends StatelessWidget {
  const _SessionTypeSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              0,
              AppSpacing.xl,
              AppSpacing.sm,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.liveSessionTypeTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Beklenen verim oturum tipine göre ayrışıyor (§6.3): sabah sağımı
          // akşamdan düzenli olarak yüksek. Yanlış tip tüm renkleri kaydırır.
          for (final e in [
            ('morning', l10n.fmtSessionMorning, Icons.wb_sunny_outlined),
            ('evening', l10n.fmtSessionEvening, Icons.nightlight_outlined),
            ('other', l10n.fmtSessionOther, Icons.schedule),
          ])
            ListTile(
              leading: Icon(e.$3, color: AppColors.darkGreenColor),
              title: Text(e.$2),
              onTap: () => Navigator.of(context).pop(e.$1),
            ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

/// Komutu çalıştırır, hatayı kullanıcıya gösterir.
///
/// Mesaj BACKEND'DEN gelir (§16): "bu bölgede zaten açık bir sağım oturumu
/// var" gibi bir cevabı kendi metnimizle değiştirmek, kullanıcının gerçek
/// sebebi görmesini engellerdi.
Future<void> _guard(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function() action,
) async {
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
  } on Object catch (e) {
    messenger.showSnackBar(
      SnackBar(
        content: Text(_message(e)),
        backgroundColor: AppColors.dangerFill,
      ),
    );
  }
}

String _message(Object error) =>
    userMessage(error) ?? l10n.liveActionFailed('$error');

class _Grid extends ConsumerWidget {
  const _Grid({
    required this.live,
    required this.hall,
    required this.spouts,
    required this.vacuums,
  });

  final LiveSession live;
  final Hall hall;
  final List<Spout> spouts;
  final List<Vacuum> vacuums;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Önceki sağımın yerleşimi ÖNCEDEN yüklenir: seçici açıldığında hazır
    // olsun (backend ADR 0062).
    ref.watch(previousSpoutsProvider(hall.id));
    final history =
        ref.watch(hallPlacementsProvider(hall.id)).value ?? const [];
    final animals = ref.watch(animalsProvider).value ?? const [];
    final active = live.session.status == 'active';

    if (!active) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Text(
              l10n.liveNoOpenSession,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.onSurfaceMuted),
            ),
          ),
        ),
      );
    }

    final updates = live.updates;
    if (updates.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(l10n.liveNoSpouts)),
      );
    }

    final spoutById = {for (final s in spouts) s.id: s};
    final vacuumById = {for (final v in vacuums) v.id: v};

    // Bu oturumda hangi hayvanların zaten bir noktada olduğunu seçiciye
    // veriyoruz: aynı hayvanı iki noktaya bağlamak, iki ayrı sağım kaydı
    // üretip günlük verimi ikiye bölerdi.
    final assigned = {
      for (final u in updates)
        if (u.animal case final a?) a.id,
    };

    // Sıralı öneri (backend ADR 0136): sıra canlı ekranın nokta sırası.
    final seq = PlacementSequence.build([
      for (final u in updates) u.spoutId,
    ], history);
    final current = {
      for (final u in updates)
        if (u.animal case final a?) u.spoutId: a.id,
    };
    final eligible = {
      for (final a in animals)
        if (a.isMilking) a.id,
    };
    final tagOf = {for (final a in animals) a.id: a.earTag};
    final proposals = seq.isEmpty
        ? const <Proposal>[]
        : seq.propose(
            current,
            eligible,
            rank: (x, y) => (tagOf[x] ?? x).compareTo(tagOf[y] ?? y),
          );
    String titleOf(String spoutId) {
      final spout = spoutById[spoutId];
      final vacuum = spout == null ? null : vacuumById[spout.vacuumId];
      return spout == null
          ? l10n.liveSpout
          : l10n.liveSpoutTitle(
              vacuum?.name ?? l10n.liveUnitFallback,
              '${spout.positionNo}',
            );
    }

    final grid = SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      // mainAxisExtent: kart yüksekliği SABİT. Eski ekran childAspectRatio'yu
      // (ekran yüksekliği - 300) üzerinden hesaplıyordu; küçük ekranda kart
      // taşıyor, büyük ekranda altında boşluk kalıyordu (§15.3/12).
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 240,
          mainAxisExtent: 252,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
        ),
        delegate: SliverChildBuilderDelegate(childCount: updates.length, (
          context,
          index,
        ) {
          final u = updates[index];
          final spout = spoutById[u.spoutId];
          final vacuum = spout == null ? null : vacuumById[spout.vacuumId];
          final title = spout == null
              ? l10n.liveSpout
              : l10n.liveSpoutTitle(
                  vacuum?.name ?? l10n.liveUnitFallback,
                  '${spout.positionNo}',
                );

          return GestureDetector(
            // EŞLEŞTİRME KARTA DOKUNARAK: sağım sırasında operatörün eli
            // dolu ve ayrı bir ekrana gidip nokta seçmesi gereksiz bir
            // adım olurdu. Hayvanı olan karta dokunmak da eşleştirmeyi
            // değiştirmeye izin verir — yanlış hayvan bağlanabilir.
            onTap: () => _assign(
              context,
              ref,
              u,
              title,
              assigned,
              seq.followers(u.spoutId, current, eligible),
            ),
            child: LiveInfoCard(
              update: u,
              title: title,
              volume: ref.watch(volumeFormatProvider),
            ),
          );
        }),
      ),
    );
    if (proposals.isEmpty) return grid;
    // "Grubu aynen onayla" (ADR 0136): boş noktalar önceki sıraya göre
    // önerilir; önizlemeden tek dokunuşla hepsi eşleştirilir.
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: FilledButton.tonalIcon(
              icon: const Icon(Icons.playlist_add_check),
              label: Text(l10n.liveGroupConfirm(proposals.length)),
              onPressed: ref.watch(milkingControlProvider)
                  ? null
                  : () => _confirmGroup(context, ref, proposals, titleOf, {
                      for (final a in animals)
                        a.id: a.name == null
                            ? a.earTag
                            : '${a.earTag} · ${a.name}',
                    }),
            ),
          ),
        ),
        grid,
      ],
    );
  }

  Future<void> _confirmGroup(
    BuildContext context,
    WidgetRef ref,
    List<Proposal> proposals,
    String Function(String spoutId) titleOf,
    Map<String, String> labelOf,
  ) async {
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (context) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.liveGroupTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.liveGroupHint,
                      style: TextStyle(color: AppColors.onSurfaceMuted),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final p in proposals)
                      ListTile(
                        dense: true,
                        leading: Icon(
                          p.reason == ProposalReason.sequence
                              ? Icons.timeline
                              : Icons.history,
                          color: AppColors.darkGreenColor,
                        ),
                        title: Text(labelOf[p.animalId] ?? p.animalId),
                        subtitle: Text(
                          '${titleOf(p.spoutId)} · '
                          '${p.reason == ProposalReason.sequence ? l10n.liveGroupReasonSequence : l10n.livePickerPrevHere}',
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brandFill,
                  ),
                  child: Text(l10n.liveGroupApply(proposals.length)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final r = await ref
        .read(milkingControlProvider.notifier)
        .assignAll(sessionId: live.session.id, proposals: proposals);
    final err = r.error;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          err == null
              ? l10n.liveGroupDone(r.done)
              : l10n.liveGroupPartial(r.done, _message(err)),
        ),
        backgroundColor: err == null ? null : AppColors.warningFill,
      ),
    );
  }

  Future<void> _assign(
    BuildContext context,
    WidgetRef ref,
    SpoutUpdate update,
    String title,
    Set<String> assigned,
    List<Follower> followers,
  ) async {
    final spoutId = update.spoutId;
    final pick = await showAnimalPicker(
      context,
      spoutLabel: title,
      alreadyAssigned: assigned,
      unmatched: update.unmatchedTag,
      current: update.animal,
      spoutId: spoutId,
      previousSpouts:
          ref.read(previousSpoutsProvider(hall.id)).value ?? const {},
      followers: followers,
    );
    if (pick == null || !context.mounted) return;

    final control = ref.read(milkingControlProvider.notifier);
    switch (pick) {
      case PickAnimal(:final animalId):
        final previous = update.animal;
        if (previous == null || previous.id == animalId) {
          await _guard(
            context,
            ref,
            () => control.assign(
              sessionId: live.session.id,
              spoutId: spoutId,
              animalId: animalId,
            ),
          );
          return;
        }
        // Noktada başka hayvan var (backend ADR 0053). Ölçüm yoksa sorulacak
        // bir şey yok: önceki eşleştirme temizlenir, boş sağım kimsenin
        // geçmişine girmez.
        var discard = true;
        if (update.volumeMl > 0) {
          final choice = await askReplace(
            context,
            previous: previous,
            volumeMl: update.volumeMl,
            volume: ref.read(volumeFormatProvider),
          );
          if (choice == null || !context.mounted) return;
          discard = choice == ReplaceChoice.mistaken;
        }
        await _guard(
          context,
          ref,
          () => control.replace(
            sessionId: live.session.id,
            spoutId: spoutId,
            animalId: animalId,
            discardPrevious: discard,
          ),
        );
      case ClearAnimal():
        // Geri alınamaz: ölçülen süt silinir. Kaza dokunuşunu ayırmak
        // için sorulur ve kaybolacak miktar yazılır.
        if (!await _confirmClear(
              context,
              update,
              ref.read(volumeFormatProvider),
            ) ||
            !context.mounted) {
          return;
        }
        await _guard(
          context,
          ref,
          () => control.unassign(sessionId: live.session.id, spoutId: spoutId),
        );
    }
  }

  Future<bool> _confirmClear(
    BuildContext context,
    SpoutUpdate u,
    VolumeFormat volume,
  ) async {
    // Hayvanın adı cümleye ek almadan yazılır: Türkçe iyelik eki ("-ın",
    // "-in", "-un"…) ada göre değişiyor ve yanlış ek, doğru bilginin
    // üstüne göze batan bir hata koyardı.
    final a = u.animal;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.liveClearTitle),
        content: Text(
          [
            if (a != null)
              a.name == null ? a.earTag : '${a.name} · ${a.earTag}',
            u.volumeMl > 0
                ? l10n.liveClearBodyMeasured(
                    volume.amount(u.volumeMl, species: a?.species),
                  )
                : l10n.liveClearBodyEmpty,
          ].join('\n'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.redColor),
            child: Text(l10n.liveClearConfirm),
          ),
        ],
      ),
    );
    return ok ?? false;
  }
}
