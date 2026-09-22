import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/features/auth/login_screen.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/features/live/live_board_screen.dart';
import 'package:milktrace/features/shell/scaffold_with_nav_bar.dart';
import 'package:milktrace/features/splash/splash_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

/// Uygulamanın tek yönlendirme tablosu.
///
/// Eskiden İKİ tane vardı: main.dart'ta bir onGenerateRoute ve sekme
/// kabuğunun içinde ondan bağımsız ikinci bir tane. İkisi birbirini
/// görmüyordu ve uygulamanın nereye gittiğini takip etmek zordu.
///
/// keepAlive: router yeniden kurulursa gezinme geçmişi sıfırlanır.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // go_router Riverpod'u bilmez; oturum değişimini ona bir Listenable ile
  // duyururuz. ref.listen doğrudan redirect içinde okunamaz — redirect
  // provider container'ına değil, gezinme yığınına bağlı çalışır.
  final authListenable = ValueNotifier<AuthState>(ref.read(authProvider));
  ref.listen(authProvider, (_, next) => authListenable.value = next);
  ref.onDispose(authListenable.dispose);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: authListenable,
    redirect: (context, state) {
      final auth = authListenable.value;
      final at = state.matchedLocation;

      // Token diskten okunurken KARAR VERME. Burada signedOut sayılsaydı
      // uygulama her açılışta giriş ekranını bir an gösterip içeri atlardı.
      if (auth.isRestoring) return at == '/splash' ? null : '/splash';

      if (!auth.isSignedIn) return at == '/login' ? null : '/login';

      // Oturum açık: giriş ve açılış ekranlarında durmanın anlamı yok.
      if (at == '/login' || at == '/splash') return '/live';

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, _) => const LoginScreen(),
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
            GoRoute(
              path: '/history',
              builder: (_, _) => const HistoryScreen(),
              routes: [
                // ALT ROTA: hayvan detayı Geçmiş sekmesinin yığınında açılır.
                // Kök seviyede olsaydı detaydan geri dönüş sekmeyi de
                // sıfırlar, seçili filtreler kaybolurdu.
                GoRoute(
                  path: 'animal/:id',
                  builder: (_, state) => AnimalDetailScreen(
                    animalId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
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
