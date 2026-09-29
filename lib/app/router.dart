import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/core/app_build.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/features/alerts/alerts_screen.dart';
import 'package:milktrace/features/audit/audit_screen.dart';
import 'package:milktrace/features/auth/login_screen.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/features/deliveries/deliveries_screen.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/animal_form_screen.dart';
import 'package:milktrace/features/history/animal_import_screen.dart';
import 'package:milktrace/features/history/groups_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/features/history/unmatched_tags_screen.dart';
import 'package:milktrace/features/kiosk/kiosk_screen.dart';
import 'package:milktrace/features/live/live_board_screen.dart';
import 'package:milktrace/features/settings/milking_schedule_screen.dart';
import 'package:milktrace/features/settings/notification_channel_form_screen.dart';
import 'package:milktrace/features/settings/notification_channels_screen.dart';
import 'package:milktrace/features/settings/thresholds_screen.dart';
import 'package:milktrace/features/settings/two_factor_screen.dart';
import 'package:milktrace/features/shell/scaffold_with_nav_bar.dart';
import 'package:milktrace/features/splash/splash_screen.dart';
import 'package:milktrace/features/team/milkers_screen.dart';
import 'package:milktrace/features/team/team_screen.dart';
import 'package:milktrace/features/update/update_required_screen.dart';
import 'package:milktrace/l10n/l10n.dart';
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
    refreshListenable: Listenable.merge([authListenable, UpgradeGate.required]),
    redirect: (context, state) {
      final auth = authListenable.value;
      final at = state.matchedLocation;

      // Sunucu bu sürümü artık desteklemiyor (426, backend ADR 0080): her
      // şeyin önünde. Oturum durumuna bakılmaz; giriş de yapılamıyor.
      if (UpgradeGate.required.value) return at == '/update' ? null : '/update';

      // Token diskten okunurken KARAR VERME. Burada signedOut sayılsaydı
      // uygulama her açılışta giriş ekranını bir an gösterip içeri atlardı.
      if (auth.isRestoring) return at == '/splash' ? null : '/splash';

      if (!auth.isSignedIn) return at == '/login' ? null : '/login';

      // Sağımhane tableti (backend ADR 0091): tek ekran. Gateway diğer
      // uçları zaten kapatıyor; başka bir ekran açılsa boş hata gösterirdi.
      if (auth.user?.kiosk ?? false) return at == '/kiosk' ? null : '/kiosk';
      if (at == '/kiosk') return '/live';

      // Oturum açık: giriş ve açılış ekranlarında durmanın anlamı yok.
      if (at == '/login' || at == '/splash') return '/live';

      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/update', builder: (_, _) => const UpdateRequiredScreen()),
      GoRoute(path: '/kiosk', builder: (_, _) => const KioskScreen()),
      // Kabuğun DIŞINDA: uyarı listesi bir sekmeye ait değil, her sekmeden
      // açılır ve tam ekran gelir.
      GoRoute(path: '/alerts', builder: (_, _) => const AlertsScreen()),
      // Eşik ayarları da kabuğun dışında: hesap kartından açılıyor ve bir
      // sekmeye ait değil.
      GoRoute(
        path: '/settings/thresholds',
        builder: (_, _) => const ThresholdsScreen(),
      ),
      // İşletmenin kullanıcıları (backend ADR 0076): hesap kartından,
      // yalnızca işletme sahibine.
      GoRoute(path: '/settings/team', builder: (_, _) => const TeamScreen()),
      // İşlem kaydı (backend ADR 0082): hesap kartından, yalnızca sahibe.
      GoRoute(path: '/settings/audit', builder: (_, _) => const AuditScreen()),
      // Sağımcı özeti (backend ADR 0090): hesap kartından, yalnızca sahibe.
      GoRoute(
        path: '/settings/milkers',
        builder: (_, _) => const MilkersScreen(),
      ),
      // İki adımlı doğrulama (backend ADR 0102): hesap kartından.
      GoRoute(
        path: '/settings/2fa',
        builder: (_, _) => const TwoFactorScreen(),
      ),
      // Sağım saatleri (backend ADR 0099): hesap kartından, yalnızca sahibe.
      GoRoute(
        path: '/settings/schedule',
        builder: (_, _) => const MilkingScheduleScreen(),
      ),
      // Tank teslimleri (backend ADR 0089): panodaki karttan.
      GoRoute(path: '/deliveries', builder: (_, _) => const DeliveriesScreen()),
      // Bildirim kanalları (backend ADR 0028): hesap kartından, yalnızca
      // işletme sahibine.
      GoRoute(
        path: '/settings/notifications',
        builder: (_, _) => const NotificationChannelsScreen(),
        routes: [
          // "new" SABİT YOL, ":id"den önce: yoksa "new" bir kanal kimliği
          // sanılırdı.
          GoRoute(
            path: 'new',
            builder: (_, state) => NotificationChannelFormScreen(
              kind: state.uri.queryParameters['kind'],
              provider: state.uri.queryParameters['provider'],
            ),
          ),
          GoRoute(
            path: ':id',
            builder: (_, state) => NotificationChannelFormScreen(
              channelId: state.pathParameters['id'],
            ),
          ),
        ],
      ),
      // Hayvan ekleme/düzenleme: kabuğun dışında, tam ekran form (kanal
      // formuyla aynı). Yalnızca işletme sahibi açar.
      GoRoute(
        path: '/animals/new',
        builder: (_, _) => const AnimalFormScreen(),
      ),
      // Toplu içe aktarma (backend ADR 0063): yalnızca işletme sahibi.
      // Hayvan grupları (backend ADR 0092): yalnızca sahip.
      GoRoute(path: '/animals/groups', builder: (_, _) => const GroupsScreen()),
      GoRoute(
        path: '/animals/import',
        builder: (_, _) => const AnimalImportScreen(),
      ),
      // Tanınmayan küpeler (backend ADR 0056): yalnızca işletme sahibi.
      GoRoute(
        path: '/animals/unmatched-tags',
        builder: (_, _) => const UnmatchedTagsScreen(),
      ),
      GoRoute(
        path: '/animals/:id/edit',
        builder: (_, state) =>
            AnimalFormScreen(animalId: state.pathParameters['id']),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, shell) => ScaffoldWithNavBar(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (_, _) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/live',
                builder: (_, _) => const LiveBoardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
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
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/devices',
                builder: (_, _) => const DevicesScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (_, state) => Scaffold(
      appBar: AppBar(title: Text(l10n.coreRouteNotFound)),
      body: Center(child: Text(l10n.coreRouteNotFoundBody('${state.uri}'))),
    ),
  );
}
