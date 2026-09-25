import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/history/animal_form_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

class _As extends Auth {
  _As(this.role);
  final String role;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'x@milktrace.local',
      fullName: 'X',
      role: role,
      tenantId: 't1',
    ),
  );
}

MockRepository _repo() => MockRepository(
  latency: Duration.zero,
  today: DateTime(2026, 9, 22),
  loadAsset: _diskAsset,
);

Widget _app(Widget home, {String role = 'tenant_owner', MockRepository? repo}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => Scaffold(body: home),
      ),
      GoRoute(
        path: '/animals/new',
        builder: (_, _) => const AnimalFormScreen(),
      ),
      GoRoute(
        path: '/history/animal/:id',
        builder: (_, s) => Text('detay ${s.pathParameters['id']}'),
      ),
    ],
  );
  return ProviderScope(
    overrides: [
      authProvider.overrideWith(() => _As(role)),
      repositoryProvider.overrideWith(
        (ref) => (repo ?? _repo()) as MilkTraceRepository,
      ),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  // Hayvan ekleme yalnızca işletme sahibine (§5); backend de 403 döner.
  for (final (role, visible) in [
    ('tenant_owner', true),
    ('tenant_viewer', false),
  ]) {
    testWidgets('Hayvan ekle düğmesi: $role', (tester) async {
      tester.view.physicalSize = const Size(1200, 2400);
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(_app(const HistoryScreen(), role: role));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hayvanlar'));
      await tester.pumpAndSettle();
      expect(find.text('Hayvan ekle'), visible ? findsOneWidget : findsNothing);
      expect(find.text('Listeden'), visible ? findsOneWidget : findsNothing);
      expect(find.text('Rapor'), findsOneWidget, reason: 'rapor bütün rollere');
    });
  }

  // Küpe zorunlu; kaydedince hayvan listeye girer ve detayı açılır.
  testWidgets('yeni hayvan kaydedilir', (tester) async {
    tester.view.physicalSize = const Size(1200, 3200);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = _repo();

    await tester.pumpWidget(_app(const AnimalFormScreen(), repo: repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('Küpe numarası zorunlu'), findsOneWidget);
    expect(find.text('Tür seçin'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Küpe numarası'),
      'TR-YENI-1',
    );
    await tester.tap(find.text('Tür'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('İnek').last);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Ad (isteğe bağlı)'),
      'Benekli',
    );
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    expect(find.textContaining('detay mock-animal-1'), findsOneWidget);
    // Gerçek zamanda: mock'un gecikmesi bir zamanlayıcı ve testWidgets'in
    // sahte saati onu ilerletmeden bekleseydik test sonsuza dek takılırdı.
    final all = (await tester.runAsync(repo.animals))!;
    final added = all.where((a) => a.earTag == 'TR-YENI-1').single;
    expect(added.name, 'Benekli');
    expect(added.status, 'active');
  });
}
