import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/features/team/team_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

class _FakeAuth extends Auth {
  _FakeAuth(this.role);

  final String role;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'a@b.c',
      fullName: 'Demo',
      role: role,
      tenantId: 't1',
    ),
  );
}

late MockRepository repo;

Future<void> pumpApp(
  WidgetTester tester, {
  String role = 'tenant_owner',
  String initial = '/settings/team',
}) async {
  repo = MockRepository(latency: Duration.zero, loadAsset: _diskAsset);
  final container = ProviderContainer(
    overrides: [
      repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      authProvider.overrideWith(() => _FakeAuth(role)),
      supportInfoProvider.overrideWith((ref) async => null),
    ],
  );
  addTearDown(container.dispose);
  tester.view.physicalSize = const Size(1200, 4000);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final router = GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, _) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => showAccountSheet(context),
              child: const Text('hesap'),
            ),
          ),
        ),
      ),
      GoRoute(path: '/settings/team', builder: (_, _) => const TeamScreen()),
      GoRoute(
        path: '/settings/thresholds',
        builder: (_, _) => const SizedBox(),
      ),
      GoRoute(
        path: '/settings/notifications',
        builder: (_, _) => const SizedBox(),
      ),
    ],
  );
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('hesap kartında Kullanıcılar yalnızca işletme sahibine', (
    tester,
  ) async {
    await pumpApp(tester, initial: '/home');
    await tester.tap(find.text('hesap'));
    await tester.pumpAndSettle();
    expect(find.text('Kullanıcılar'), findsOneWidget);

    await pumpApp(tester, role: 'tenant_viewer', initial: '/home');
    await tester.tap(find.text('hesap'));
    await tester.pumpAndSettle();
    expect(find.text('Kullanıcılar'), findsNothing);
  });

  testWidgets('parolasız ekleme davet gönderir ve listeye düşer', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(find.text('Demo Çiftçi'), findsOneWidget);
    expect(find.text('Mehmet Yılmaz'), findsOneWidget);

    await tester.tap(find.text('Kullanıcı ekle'));
    await tester.pumpAndSettle();
    final fields = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(fields.at(0), 'Dr. Ayşe Kaya');
    await tester.enterText(fields.at(1), 'vet@ciftlik.tr');
    await tester.tap(find.text('Görüntüleyici'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Veteriner, danışman'), findsOneWidget);
    await tester.tap(find.text('Ekle'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(
      find.text('Kullanıcı eklendi, davet e-postası gönderildi'),
      findsOneWidget,
    );
    expect(find.text('Dr. Ayşe Kaya'), findsOneWidget);
    final members = (await tester.runAsync(repo.teamMembers))!;
    final added = members.firstWhere((m) => m.email == 'vet@ciftlik.tr');
    expect(added.role, 'tenant_viewer');
  });

  // Sağımhane tableti (backend ADR 0091): parola zorunlu, rol operatör.
  testWidgets('sağımhane tableti parolayla eklenir', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Kullanıcı ekle'));
    await tester.pumpAndSettle();
    final fields = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(fields.at(0), 'Sağımhane');
    await tester.enterText(fields.at(1), 'tablet@ciftlik.tr');
    await tester.tap(find.text('Sağımhane tableti'));
    await tester.pumpAndSettle();
    expect(find.text('Görüntüleyici'), findsNothing, reason: 'rol seçimi yok');
    await tester.tap(find.text('Ekle'));
    await tester.pumpAndSettle();
    expect(find.text('Tablet için parola girin.'), findsOneWidget);

    await tester.enterText(fields.at(2), 'tablet-123');
    await tester.tap(find.text('Ekle'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    final members = (await tester.runAsync(repo.teamMembers))!;
    final tablet = members.firstWhere((m) => m.email == 'tablet@ciftlik.tr');
    expect(tablet.kiosk, isTrue);
    expect(tablet.role, 'tenant_operator');
    expect(find.textContaining('Sağımhane tableti ·'), findsOneWidget);
  });

  testWidgets('kısa geçici parola reddedilir', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Kullanıcı ekle'));
    await tester.pumpAndSettle();
    final fields = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.byType(TextFormField),
    );
    await tester.enterText(fields.at(0), 'Ali');
    await tester.enterText(fields.at(1), 'ali@ciftlik.tr');
    await tester.enterText(fields.at(2), 'kisa');
    await tester.tap(find.text('Ekle'));
    await tester.pumpAndSettle();
    expect(find.text('En az 8 karakter.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('askıya alma ve silme; sahip satırı dokunulmaz', (tester) async {
    await pumpApp(tester);

    // Sahip satırına dokunmak bir şey açmaz.
    await tester.tap(find.text('Demo Çiftçi'));
    await tester.pumpAndSettle();
    expect(find.text('Askıya al'), findsNothing);

    await tester.tap(find.text('Mehmet Yılmaz'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Askıya al'));
    await tester.pumpAndSettle();
    expect(find.text('Askıda'), findsOneWidget);

    await tester.tap(find.text('Mehmet Yılmaz'));
    await tester.pumpAndSettle();
    expect(find.text('Etkinleştir'), findsOneWidget);
    await tester.tap(find.text('Sil'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Silinmiş kullanıcı'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Sil'));
    await tester.pumpAndSettle();

    expect(find.text('Mehmet Yılmaz'), findsNothing);
    expect((await tester.runAsync(repo.teamMembers))!.length, 1);
  });
}
