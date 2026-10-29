import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/whats_new/whats_new.dart';
import 'package:milktrace/features/write_queue/pending_writes.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/widgets/adaptive.dart';
import 'package:milktrace/widgets/custom_app_bar.dart';
import 'package:milktrace/widgets/help_button.dart';
import 'package:milktrace/widgets/offline_banner.dart';

/// Dört sekmeli kabuk (§15.1).
///
/// StatefulShellRoute kullanılır: her sekmenin KENDİ navigasyon yığını olur
/// ve sekme değiştirince yığın korunur. Eski kabuk (persistent_bottom_nav_bar)
/// iki sorunu vardı: PersistentTabController build() içinde kuruluyordu, yani
/// her yeniden çizimde sekme sıfırlanıyordu (§15.3/21); ve dört sekmenin
/// hepsine AYNI HomeScreen ÖRNEĞİ konmuştu, yani dört sekme de aynı ekranı
/// gösteriyordu (§15.3/22).
class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static List<_TabSpec> get _tabs => [
    _TabSpec(l10n.shellTabDashboard, Icons.dashboard_outlined, Icons.dashboard),
    _TabSpec(l10n.shellTabLive, Icons.water_drop_outlined, Icons.water_drop),
    _TabSpec(l10n.shellTabHistory, Icons.history_outlined, Icons.history),
    _TabSpec(l10n.shellTabDevices, Icons.sensors_outlined, Icons.sensors),
  ];

  /// Sekmelerin yardım makaleleri, [_tabs] sırasıyla.
  static const _helpSlugs = [
    HelpSlug.firstSetup,
    HelpSlug.liveMilking,
    HelpSlug.yieldReport,
    HelpSlug.devices,
  ];

  @override
  Widget build(BuildContext context) {
    // Telefonda alt menü, tablette yan ray (backend ADR 0141): karar
    // genişlikten. Gövde her iki düzende de AYNI anahtarla Row'un içinde
    // durur; dönünce sekme yığınları ve ekranların durumu kaybolmaz.
    final compact = WindowSize.of(context).isCompact;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Milk Trace',
        helpSlug: _helpSlugs[navigationShell.currentIndex],
      ),
      body: Row(
        children: [
          if (!compact) ...[
            _Rail(navigationShell: navigationShell, tabs: _tabs),
            VerticalDivider(width: 1, thickness: 1, color: AppColors.border),
          ],
          Expanded(
            key: const ValueKey('shell-body'),
            child: Column(
              children: [
                const OfflineBanner(),
                // Gönderilmeyi bekleyen kayıtlar (backend ADR 0140).
                const PendingWritesBanner(),
                // Güncellemeden sonra bir kez Yenilikler (backend ADR 0123).
                Expanded(
                  child: WriteQueueListener(
                    child: WhatsNewListener(child: navigationShell),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: compact
          ? NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) => _go(navigationShell, index),
              backgroundColor: AppColors.surface,
              indicatorColor: AppColors.lightGreenColor,
              destinations: [
                for (final t in _tabs)
                  NavigationDestination(
                    icon: Icon(t.icon, color: AppColors.iconGreyColor),
                    selectedIcon: Icon(
                      t.selectedIcon,
                      color: AppColors.darkGreenColor,
                    ),
                    label: t.label,
                  ),
              ],
            )
          : null,
    );
  }
}

void _go(StatefulNavigationShell shell, int index) => shell.goBranch(
  index,
  // Zaten açık sekmeye tekrar basmak o sekmeyi köküne döndürür.
  initialLocation: index == shell.currentIndex,
);

/// Tablet yan rayı. Yatay telefonda yükseklik dört hedefe yetmeyebilir:
/// ray kaydırılabilir, taşmaz.
class _Rail extends StatelessWidget {
  const _Rail({required this.navigationShell, required this.tabs});

  final StatefulNavigationShell navigationShell;
  final List<_TabSpec> tabs;

  @override
  Widget build(BuildContext context) {
    final extended = MediaQuery.sizeOf(context).width >= kExtendedRailMinWidth;
    final label = Theme.of(context).textTheme.labelLarge;
    return SafeArea(
      top: false,
      right: false,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: NavigationRail(
                extended: extended,
                minExtendedWidth: 220,
                labelType: extended
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                groupAlignment: -1,
                selectedIndex: navigationShell.currentIndex,
                onDestinationSelected: (index) => _go(navigationShell, index),
                backgroundColor: AppColors.surface,
                indicatorColor: AppColors.lightGreenColor,
                // Ray, verilen stili temaya katmadan kullanır: yazı tipi
                // temadan alınmazsa etiketler Poppins yerine Roboto çıkar.
                selectedLabelTextStyle: label?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGreenColor,
                ),
                unselectedLabelTextStyle: label?.copyWith(
                  color: AppColors.onSurfaceMuted,
                ),
                destinations: [
                  for (final t in tabs)
                    NavigationRailDestination(
                      icon: Icon(t.icon, color: AppColors.iconGreyColor),
                      selectedIcon: Icon(
                        t.selectedIcon,
                        color: AppColors.darkGreenColor,
                      ),
                      label: Text(t.label),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabSpec {
  const _TabSpec(this.label, this.icon, this.selectedIcon);
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
