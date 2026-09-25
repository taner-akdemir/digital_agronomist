import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/widgets/custom_app_bar.dart';
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

  static const _tabs = <_TabSpec>[
    _TabSpec('Dashboard', Icons.dashboard_outlined, Icons.dashboard),
    _TabSpec('Canlı', Icons.water_drop_outlined, Icons.water_drop),
    _TabSpec('Geçmiş', Icons.history_outlined, Icons.history),
    _TabSpec('Cihazlar', Icons.sensors_outlined, Icons.sensors),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Milk Trace'),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Zaten açık sekmeye tekrar basmak o sekmeyi köküne döndürür.
          initialLocation: index == navigationShell.currentIndex,
        ),
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
