import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/features/live/live_board_screen.dart';
import 'package:milktrace/features/shell/scaffold_with_nav_bar.dart';
import 'package:milktrace/features/splash/splash_screen.dart';

/// Uygulamanın tek yönlendirme tablosu.
///
/// Eskiden İKİ tane vardı: main.dart'ta bir onGenerateRoute ve sekme
/// kabuğunun içinde ondan bağımsız ikinci bir tane. İkisi birbirini
/// görmüyordu ve uygulamanın nereye gittiğini takip etmek zordu.
GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, _) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => ScaffoldWithNavBar(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/dashboard', builder: (_, _) => const DashboardScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/live', builder: (_, _) => const LiveBoardScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/history', builder: (_, _) => const HistoryScreen()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/devices', builder: (_, _) => const DevicesScreen()),
          ]),
        ],
      ),
    ],
    errorBuilder: (_, state) => Scaffold(
      appBar: AppBar(title: const Text('Sayfa bulunamadı')),
      body: Center(child: Text('Aradığınız sayfa bulunamadı:\n${state.uri}')),
    ),
  );
}
