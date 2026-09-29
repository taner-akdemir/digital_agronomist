import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

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

Future<MockRepository> _pump(WidgetTester tester, Widget home) async {
  tester.view.physicalSize = const Size(1200, 3000);
  addTearDown(tester.view.resetPhysicalSize);
  final repo = MockRepository(
    latency: Duration.zero,
    today: DateTime(2026, 9, 22),
    loadAsset: _disk,
  );
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => Scaffold(body: home),
      ),
      GoRoute(
        path: '/history/animal/:id',
        builder: (_, s) => Text('detay ${s.pathParameters['id']}'),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_Owner.new),
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  test('cihaz dilinden uygulama dili', () {
    expect(resolveAppLocale(const [Locale('en', 'US')]).languageCode, 'en');
    expect(
      resolveAppLocale(const [Locale('de'), Locale('en')]).languageCode,
      'en',
    );
    expect(resolveAppLocale(const [Locale('de')]).languageCode, 'tr');
    expect(resolveAppLocale(const [Locale('tr', 'TR')]).languageCode, 'tr');
    expect(resolveAppLocale(null).languageCode, 'tr');
  });

  group('İngilizce', () {
    setUp(() => setL10nLocale(const Locale('en')));
    tearDown(() => setL10nLocale(const Locale('tr')));

    test('biçimler ve tür adı', () {
      expect(Fmt.dayMonth(DateTime(2026, 9, 3)), '3 Sep');
      expect(Fmt.percent(86), '86%');
      expect(Fmt.sessionType('morning'), 'Morning');
      const cow = Species(id: 's', code: 'cow', nameTr: 'İnek');
      expect(cow.displayName, 'Cow');
      expect(
        const Species(id: 'x', code: 'buffalo', nameTr: 'Manda').displayName,
        'Manda',
        reason: 'tanınmayan tür sunucunun adıyla',
      );
    });

    testWidgets('pano İngilizce açılır', (tester) async {
      await _pump(tester, const DashboardScreen());
      expect(tester.takeException(), isNull);
      expect(find.textContaining('Open alerts'), findsOneWidget);
    });

    testWidgets('geçmiş ve oturum özeti İngilizce', (tester) async {
      await _pump(tester, const HistoryScreen());
      expect(tester.takeException(), isNull);
      expect(find.text('Animals'), findsOneWidget);
      await tester.tap(find.text('Sessions'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.check_circle_outline).first);
      await tester.pumpAndSettle();
      expect(find.text('Session summary'), findsOneWidget);
      expect(find.text('Lactating, not milked: 1'), findsOneWidget);
    });
  });

  testWidgets('bitmiş oturuma dokununca özet ve sağılmayanlar', (tester) async {
    await _pump(tester, const HistoryScreen());
    await tester.tap(find.text('Oturumlar'));
    await tester.pumpAndSettle();
    final tiles = find.byIcon(Icons.check_circle_outline);
    expect(tiles, findsWidgets);
    await tester.tap(tiles.first);
    await tester.pumpAndSettle();
    expect(find.text('Oturum özeti'), findsOneWidget);
    expect(find.text('Sağılmayan sağmal: 1'), findsOneWidget);
  });
}
