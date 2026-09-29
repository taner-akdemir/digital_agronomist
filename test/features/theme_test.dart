import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/app.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Owner extends Auth {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u',
      email: 'a@b.c',
      fullName: 'X',
      role: 'tenant_owner',
      tenantId: 't',
    ),
  );
}

class _NoPush extends PushRegistration {
  @override
  Future<PushStatus> build() async => PushStatus.unavailable;
}

class _MemoryStore implements SettingsStore {
  _MemoryStore([Map<String, Object?>? initial]) {
    if (initial != null) values.addAll(initial);
  }

  final values = <String, Object?>{};

  @override
  Future<bool?> readBool(String key) async => values[key] as bool?;

  @override
  Future<void> writeBool(String key, bool value) async => values[key] = value;

  @override
  Future<String?> readString(String key) async => values[key] as String?;

  @override
  Future<void> writeString(String key, String? value) async =>
      values[key] = value;
}

MockRepository _repo() => MockRepository(
  latency: Duration.zero,
  today: DateTime(2026, 9, 22),
  loadAsset: _disk,
);

void main() {
  // Global parlaklık testler arasında sızmasın.
  tearDown(() {
    AppColors.brightness = Brightness.light;
    setL10nLocale(const Locale('tr'));
  });

  group('tema seçimi (ADR 0109)', () {
    test('varsayılan açık; kayıtlı seçim okunur ve yazılır', () async {
      final store = _MemoryStore();
      final c = ProviderContainer(
        overrides: [settingsStoreProvider.overrideWithValue(store)],
      );
      addTearDown(c.dispose);

      expect(c.read(appThemeModeProvider), ThemeMode.light);
      expect(c.read(effectiveBrightnessProvider), Brightness.light);

      await c.read(appThemeModeProvider.notifier).set(ThemeMode.dark);
      expect(store.values['app.theme'], 'dark');
      expect(c.read(effectiveBrightnessProvider), Brightness.dark);

      // Yeni açılışta kayıtlı seçim geri gelir.
      final c2 = ProviderContainer(
        overrides: [
          settingsStoreProvider.overrideWithValue(
            _MemoryStore({'app.theme': 'system'}),
          ),
        ],
      );
      addTearDown(c2.dispose);
      c2.read(appThemeModeProvider);
      await Future<void>.delayed(Duration.zero);
      expect(c2.read(appThemeModeProvider), ThemeMode.system);
    });

    test('tanınmayan kayıt açık temaya düşer', () async {
      final c = ProviderContainer(
        overrides: [
          settingsStoreProvider.overrideWithValue(
            _MemoryStore({'app.theme': 'sepia'}),
          ),
        ],
      );
      addTearDown(c.dispose);
      c.read(appThemeModeProvider);
      await Future<void>.delayed(Duration.zero);
      expect(c.read(appThemeModeProvider), ThemeMode.light);
    });

    testWidgets('"Cihaz" cihazın parlaklığını izler', (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      final c = ProviderContainer(
        overrides: [
          settingsStoreProvider.overrideWithValue(
            _MemoryStore({'app.theme': 'system'}),
          ),
        ],
      );
      addTearDown(c.dispose);
      c.read(appThemeModeProvider);
      await tester.pump();
      expect(c.read(effectiveBrightnessProvider), Brightness.dark);

      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      await tester.pump();
      expect(c.read(effectiveBrightnessProvider), Brightness.light);
    });

    testWidgets('hesap kartındaki seçici uygulamanın temasını değiştirir', (
      tester,
    ) async {
      final store = _MemoryStore({'app.language': 'tr'});
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => showAccountSheet(context),
                  child: const Text('aç'),
                ),
              ),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(_Owner.new),
            routerProvider.overrideWithValue(router),
            pushRegistrationProvider.overrideWith(_NoPush.new),
            pushTapsProvider.overrideWith((ref) => const Stream.empty()),
            repositoryProvider.overrideWith(
              (ref) =>
                  MockRepository(latency: Duration.zero) as MilkTraceRepository,
            ),
            supportInfoProvider.overrideWith((ref) async => null),
            settingsStoreProvider.overrideWithValue(store),
          ],
          child: const MilkTraceApp(),
        ),
      );
      await tester.pumpAndSettle();

      MaterialApp app() => tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app().themeMode, ThemeMode.light);
      expect(app().darkTheme?.brightness, Brightness.dark);
      expect(AppColors.brightness, Brightness.light);

      await tester.tap(find.text('aç'));
      await tester.pumpAndSettle();
      expect(find.text('Tema'), findsOneWidget);
      await tester.ensureVisible(find.text('Karanlık'));
      await tester.tap(find.text('Karanlık'));
      await tester.pumpAndSettle();

      expect(app().themeMode, ThemeMode.dark);
      expect(store.values['app.theme'], 'dark');
      expect(AppColors.brightness, Brightness.dark);
      expect(AppColors.surface, AppPalette.dark.surface);
      expect(
        Theme.of(tester.element(find.text('aç'))).brightness,
        Brightness.dark,
      );
    });
  });

  // Ana ekranlar karanlıkta hatasız kurulur (sabit renk / const kalıntısı
  // yok). Bu bir duman testi: renklerin değeri değil, kurulumun kendisi.
  group('karanlık temada ekranlar', () {
    Future<void> pump(WidgetTester tester, Widget home) async {
      AppColors.brightness = Brightness.dark;
      tester.view.physicalSize = const Size(1200, 3000);
      addTearDown(tester.view.resetPhysicalSize);
      final repo = _repo();
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => Scaffold(body: home),
          ),
          GoRoute(
            path: '/history/animal/:id',
            builder: (_, s) => Scaffold(
              body: AnimalDetailScreen(animalId: s.pathParameters['id']!),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(_Owner.new),
            repositoryProvider.overrideWith(
              (ref) => repo as MilkTraceRepository,
            ),
          ],
          child: MaterialApp.router(
            theme: buildAppTheme(),
            darkTheme: buildAppTheme(Brightness.dark),
            themeMode: ThemeMode.dark,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('pano', (tester) async {
      await pump(tester, const DashboardScreen());
      expect(tester.takeException(), isNull);
      expect(
        Theme.of(tester.element(find.byType(DashboardScreen))).brightness,
        Brightness.dark,
      );
    });

    testWidgets('geçmiş ve hayvan detayı', (tester) async {
      await pump(tester, const HistoryScreen());
      expect(tester.takeException(), isNull);

      // Hayvan detayı (grafik, kartlar).
      await tester.tap(find.byIcon(Icons.chevron_right).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.byType(AnimalDetailScreen), findsOneWidget);
    });

    testWidgets('cihazlar', (tester) async {
      await pump(tester, const DevicesScreen());
      expect(tester.takeException(), isNull);
    });
  });
}
