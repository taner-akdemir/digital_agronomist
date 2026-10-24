import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/hall.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/features/history/session_summary_sheet.dart';
import 'package:milktrace/features/history/widgets/animal_status_chip.dart';
import 'package:milktrace/features/history/widgets/yield_class_badge.dart';
import 'package:milktrace/features/history/yield_report.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/widgets/async_view.dart';
import 'package:milktrace/widgets/list_detail.dart';

/// Geçmiş sekmesi (§15.1): oturum listesi + filtrelenebilir hayvan listesi.
///
/// Hayvan detayı ayrı bir ekran (`/history/animal/:id`), sekmenin içinde
/// değil: geri tuşu detaydan listeye dönmeli, Geçmiş sekmesinden çıkmamalı.
///
/// Tablette ([detail] dolu, backend ADR 0141) liste solda kalır, sağ bölme
/// Hayvanlar'da yönlendiricinin detay yığını, Oturumlar'da seçili oturumun
/// özetidir.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, this.detail, this.selectedAnimalId});

  /// İki bölmede sağdaki hayvan detayı yığını; telefonda null.
  final Widget? detail;

  /// Açık hayvan detayı (listede vurgulanır).
  final String? selectedAnimalId;

  @override
  Widget build(BuildContext context) {
    final tabs = Column(
      children: [
        TabBar(
          labelColor: AppColors.darkGreenColor,
          unselectedLabelColor: AppColors.onSurfaceMuted,
          indicatorColor: AppColors.darkGreenColor,
          tabs: [
            Tab(text: l10n.historyTabAnimals),
            Tab(text: l10n.historyTabSessions),
          ],
        ),
        const Expanded(
          child: TabBarView(children: [_AnimalsTab(), _SessionsTab()]),
        ),
      ],
    );
    return DefaultTabController(
      length: 2,
      child: switch (detail) {
        null => tabs,
        final d => _TwoPaneHistory(
          list: tabs,
          detail: d,
          selectedAnimalId: selectedAnimalId,
        ),
      },
    );
  }
}

/// Geçmiş sekmesinin yönlendirici kabuğu (backend ADR 0141): yer yetiyorsa
/// listeyi kendisi çizer ve iç yığını ([child]) sağ bölmeye koyar.
class HistoryPanes extends StatelessWidget {
  const HistoryPanes({super.key, required this.child, this.selectedAnimalId});

  final Widget child;
  final String? selectedAnimalId;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final twoPane = ListDetail.fits(constraints.maxWidth);
      return _HistoryLayout(
        twoPane: twoPane,
        child: twoPane
            ? HistoryScreen(detail: child, selectedAnimalId: selectedAnimalId)
            : child,
      );
    },
  );
}

/// `/history` sayfası: telefonda liste; tablette liste kabukta olduğu için
/// sağ bölmenin "bir hayvan seçin" boş hali.
class HistoryRoot extends StatelessWidget {
  const HistoryRoot({super.key});

  @override
  Widget build(BuildContext context) => _HistoryLayout.twoPaneOf(context)
      ? DetailPlaceholder(icon: Icons.pets, text: l10n.tabletSelectAnimal)
      : const HistoryScreen();
}

class _HistoryLayout extends InheritedWidget {
  const _HistoryLayout({required this.twoPane, required super.child});

  final bool twoPane;

  static bool twoPaneOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_HistoryLayout>()?.twoPane ??
      false;

  @override
  bool updateShouldNotify(_HistoryLayout old) => twoPane != old.twoPane;
}

class _TwoPaneHistory extends StatefulWidget {
  const _TwoPaneHistory({
    required this.list,
    required this.detail,
    required this.selectedAnimalId,
  });

  final Widget list;
  final Widget detail;
  final String? selectedAnimalId;

  @override
  State<_TwoPaneHistory> createState() => _TwoPaneHistoryState();
}

class _TwoPaneHistoryState extends State<_TwoPaneHistory> {
  String? _session;

  @override
  void didUpdateWidget(_TwoPaneHistory old) {
    super.didUpdateWidget(old);
    // Oturum özetinden ya da uyarıdan bir hayvan açıldı: detayı görünür
    // kılmak için Hayvanlar sekmesine geç.
    final id = widget.selectedAnimalId;
    if (id != null && id != old.selectedAnimalId) {
      DefaultTabController.of(context).animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = DefaultTabController.of(context);
    return _PaneSelection(
      animalId: widget.selectedAnimalId,
      sessionId: _session,
      onSession: (id) => setState(() => _session = id),
      child: TwoPane(
        list: widget.list,
        // IndexedStack: detay yığını (bir Navigator) sekme değişince
        // sökülmemeli; yönlendirici ona bağlı.
        detail: AnimatedBuilder(
          animation: tabs,
          builder: (context, _) => IndexedStack(
            index: tabs.index,
            sizing: StackFit.expand,
            children: [
              widget.detail,
              switch (_session) {
                null => DetailPlaceholder(
                  icon: Icons.history,
                  text: l10n.tabletSelectSession,
                ),
                final id => SessionSummaryView(
                  key: ValueKey(id),
                  sessionId: id,
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

/// İki bölmede listenin seçimi: satır vurgusu ve oturuma dokununca özetin
/// sağda açılması.
class _PaneSelection extends InheritedWidget {
  const _PaneSelection({
    required this.animalId,
    required this.sessionId,
    required this.onSession,
    required super.child,
  });

  final String? animalId;
  final String? sessionId;
  final ValueChanged<String> onSession;

  static _PaneSelection? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_PaneSelection>();

  @override
  bool updateShouldNotify(_PaneSelection old) =>
      animalId != old.animalId || sessionId != old.sessionId;
}

class _AnimalsTab extends ConsumerWidget {
  const _AnimalsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animals = ref.watch(filteredAnimalsProvider);
    // Hayvan ekleme YALNIZCA işletme sahibine (§5); backend de 403 döner.
    final isOwner = ref.watch(authProvider).user?.role == 'tenant_owner';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            0,
          ),
          // Wrap: dar ekranda ya da büyük yazıda düğmeler alt satıra iner.
          child: Wrap(
            alignment: WrapAlignment.end,
            children: [
              // Verim raporu BÜTÜN rollere: okuru veteriner (ADR 0064).
              TextButton.icon(
                onPressed: () => showYieldReportSheet(context),
                icon: const Icon(Icons.ios_share),
                label: Text(l10n.historyReport),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
              // Aşı takvimi (backend ADR 0112) BÜTÜN rollere: uygulamayı
              // çoğunlukla veteriner girer.
              TextButton.icon(
                onPressed: () => context.push('/vaccinations'),
                icon: const Icon(Icons.vaccines_outlined),
                label: Text(l10n.historyVaccines),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
              // Aktivite (backend ADR 0145) BÜTÜN rollere: kızgınlığı
              // gözle doğrulayan çoğunlukla sağımcı ya da veteriner.
              TextButton.icon(
                onPressed: () => context.push('/activity'),
                icon: const Icon(Icons.directions_walk),
                label: Text(l10n.activityTitle),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.darkGreenColor,
                ),
              ),
              // Sürüyü ilk kez girerken tek tek eklemek yerine (ADR 0063).
              // Gruplar (ADR 0092): yönetim sahibin.
              if (isOwner)
                TextButton.icon(
                  onPressed: () => context.push('/animals/groups'),
                  icon: const Icon(Icons.workspaces_outline),
                  label: Text(l10n.historyGroups),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                  ),
                ),
              if (isOwner)
                TextButton.icon(
                  onPressed: () => context.push('/animals/import'),
                  icon: const Icon(Icons.upload_file),
                  label: Text(l10n.historyFromList),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                  ),
                ),
              if (isOwner)
                TextButton.icon(
                  onPressed: () => context.push('/animals/new'),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.historyAddAnimal),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                  ),
                ),
            ],
          ),
        ),
        if (isOwner) const _UnmatchedTagsBanner(),
        const _Filters(),
        _ActiveFilter(count: animals.value?.length ?? 0),
        Expanded(
          child: AsyncView(
            value: animals,
            errorMessage: l10n.historyAnimalsLoadFailed,
            onRetry: () => ref.invalidate(animalsProvider),
            builder: (list) => list.isEmpty
                ? _Empty(l10n.historyNoAnimalsForFilter)
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      0,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    itemCount: list.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (_, i) => _AnimalTile(animal: list[i]),
                  ),
          ),
        ),
      ],
    );
  }
}

/// Tanınmayan küpe varsa işletme sahibine bant (backend ADR 0056). Yoksa
/// hiç yer kaplamaz: her gün boş bir "0 küpe" satırı gürültüdür.
class _UnmatchedTagsBanner extends ConsumerWidget {
  const _UnmatchedTagsBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.watch(unmatchedTagsProvider).value?.length ?? 0;
    if (n == 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Material(
        color: AppColors.lightAmberColor,
        borderRadius: AppRadius.mdAll,
        child: ListTile(
          leading: Icon(Icons.nfc, color: AppColors.darkAmberColor),
          title: Text(
            l10n.historyUnmatchedBanner(n),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.darkAmberColor,
            ),
          ),
          subtitle: Text(l10n.historyUnmatchedBannerHint),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/animals/unmatched-tags'),
        ),
      ),
    );
  }
}

class _Filters extends ConsumerWidget {
  const _Filters();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final species = ref.watch(speciesListProvider).value ?? const <Species>[];
    final filter = ref.watch(animalFilterStateProvider);
    final notifier = ref.read(animalFilterStateProvider.notifier);
    final groups = ref.watch(animalGroupsProvider).value ?? const [];

    // Tek satır, YATAY kaydırmalı: beş sınıf + üç tür çipi dikey sarılsaydı
    // filtreler listenin yarısını yerdi.
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        children: [
          for (final s in species)
            _Chip(
              label: s.displayName,
              selected: filter.speciesId == s.id,
              onTap: () => notifier.toggleSpecies(s.id),
            ),
          const VerticalDivider(
            width: AppSpacing.lg,
            indent: 10,
            endIndent: 10,
          ),
          for (final c in YieldClass.values)
            if (c != YieldClass.normal)
              _Chip(
                label: c.label,
                selected: filter.yieldClass == c,
                onTap: () => notifier.toggleClass(c),
              ),
          // Yavaş sağılanlar (backend ADR 0125): karar sunucunun.
          _Chip(
            label: l10n.historyFilterSlow,
            selected: filter.slow,
            onTap: notifier.toggleSlow,
          ),
          if (groups.isNotEmpty)
            const VerticalDivider(
              width: AppSpacing.lg,
              indent: 10,
              endIndent: 10,
            ),
          for (final g in groups)
            _Chip(
              label: g.name,
              selected: filter.groupId == g.id,
              onTap: () => notifier.toggleGroup(g.id),
            ),
        ],
      ),
    );
  }
}

/// Etkin filtrenin özeti ve temizleme düğmesi.
///
/// Çip şeridi YATAY kaydırmalı: dashboard'dan "kuruya aday" ile gelindiğinde
/// seçili çip ekranın dışında kalıyor ve kullanıcı listenin neden 3 satır
/// olduğunu göremiyordu. Temizlemek için de o çipi bulmak gerekiyordu.
class _ActiveFilter extends ConsumerWidget {
  const _ActiveFilter({required this.count});

  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(animalFilterStateProvider);
    if (filter.speciesId == null &&
        filter.yieldClass == null &&
        filter.groupId == null &&
        !filter.slow) {
      return const SizedBox.shrink();
    }
    final groups = ref.watch(animalGroupsProvider).value ?? const [];

    final species = ref.watch(speciesListProvider).value ?? const <Species>[];
    final labels = [
      if (filter.speciesId case final id?)
        species
                .where((s) => s.id == id)
                .map((s) => s.displayName)
                .firstOrNull ??
            l10n.historyFilterSpecies,
      if (filter.yieldClass case final c?) c.label,
      if (filter.groupId case final id?)
        groups.where((g) => g.id == id).map((g) => g.name).firstOrNull ??
            l10n.historyFilterGroup,
      if (filter.slow) l10n.historyFilterSlow,
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      child: Row(
        children: [
          Icon(
            Icons.filter_alt_outlined,
            size: 14,
            color: AppColors.onSurfaceMuted,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              '${labels.join(' · ')} · ${l10n.historyAnimalCount(count)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.darkGreenColor,
              visualDensity: VisualDensity.compact,
            ),
            onPressed: () =>
                ref.read(animalFilterStateProvider.notifier).clear(),
            child: Text(l10n.commonClear, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: Center(
        child: FilterChip(
          label: Text(label, style: const TextStyle(fontSize: 12)),
          selected: selected,
          onSelected: (_) => onTap(),
          showCheckmark: false,
          backgroundColor: AppColors.surface,
          selectedColor: AppColors.lightGreenColor,
          side: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}

class _AnimalTile extends StatelessWidget {
  const _AnimalTile({required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    final selected = _PaneSelection.maybeOf(context)?.animalId == animal.id;
    return Material(
      color: selected ? AppColors.lightGreenColor : AppColors.surface,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: () => context.go('/history/animal/${animal.id}'),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animal.name ?? animal.earTag,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      // Ad varsa küpe altta: ad boş olabilir ama küpe
                      // hayvanı TANIMLAYAN alandır, hep görünmeli (§4).
                      [
                        animal.name == null
                            ? '${animal.breed ?? ''} · ${l10n.historyLactationNo(animal.lactationNo)}'
                            : animal.earTag,
                        ?animal.groupName,
                      ].join(' · '),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
              ),
              // Sağmal olmayan hayvanın sınıfı eskidir: yerine durumu.
              if (animal.isMilking)
                YieldClassBadge(yieldClass: animal.yieldClass, dense: true)
              else
                AnimalStatusChip(label: animal.statusLabel),
              const SizedBox(width: AppSpacing.xs),
              Icon(Icons.chevron_right, color: AppColors.lightGreyColor),
            ],
          ),
        ),
      ),
    );
  }
}

class _SessionsTab extends ConsumerWidget {
  const _SessionsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(pastSessionsProvider);
    final halls = ref.watch(hallsProvider).value ?? const <Hall>[];
    final hallById = {for (final h in halls) h.id: h};

    return AsyncView(
      value: sessions,
      errorMessage: l10n.historySessionsLoadFailed,
      onRetry: () => ref.invalidate(pastSessionsProvider),
      builder: (list) => list.isEmpty
          ? _Empty(l10n.historyNoSessions)
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
              // Bitmiş oturuma dokunmak özetini açar (backend ADR 0094).
              // Tablette özet sağ bölmede açılır (ADR 0141).
              itemBuilder: (context, i) {
                final pane = _PaneSelection.maybeOf(context);
                final id = list[i].id;
                return GestureDetector(
                  onTap: list[i].status == 'active'
                      ? null
                      : pane != null
                      ? () => pane.onSession(id)
                      : () => showSessionSummary(context, id),
                  child: _SessionTile(
                    session: list[i],
                    hall: hallById[list[i].hallId],
                    selected: pane?.sessionId == id,
                  ),
                );
              },
            ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.session,
    required this.hall,
    this.selected = false,
  });

  final MilkingSession session;
  final Hall? hall;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final active = session.status == 'active';
    final started = session.startedAt;
    final ended = session.endedAt;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: selected ? AppColors.lightGreenColor : AppColors.surface,
        borderRadius: AppRadius.mdAll,
        border: Border.all(
          color: active ? AppColors.lightGreenColor : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            active ? Icons.play_circle_fill : Icons.check_circle_outline,
            color: active ? AppColors.flowGreen : AppColors.lightGreyColor,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.historySessionTitle(
                    hall?.name ?? '?',
                    Fmt.sessionType(session.type),
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  started == null
                      ? l10n.historySessionStartUnknown
                      : '${Fmt.dayMonth(started)} · ${Fmt.time(started)}'
                            '${ended == null ? '' : ' – ${Fmt.time(ended)}'}'
                            // Sistem açtıysa söylenir: "kim başlattı?"
                            // sorusunun cevabı (backend ADR 0083).
                            '${session.autoStarted ? ' · ${l10n.historySessionAutoStarted}' : ''}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
              ],
            ),
          ),
          if (active)
            Text(
              l10n.historySessionRunning,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.flowGreen,
              ),
            )
          else if (started != null && ended != null)
            Text(
              Fmt.duration(ended.difference(started)),
              style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
            ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.onSurfaceMuted),
      ),
    ),
  );
}

/// Sağmal olmayan hayvanın durumu ("Kuruda", "Satıldı"): nötr gri, çünkü
/// bir sorun değil, bir bilgi.
