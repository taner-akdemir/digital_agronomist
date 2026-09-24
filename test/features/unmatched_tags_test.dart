import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/features/history/unmatched_tags_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

const _tag = '982000123456789';

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

Future<MockRepository> _pump(
  WidgetTester tester,
  Widget home, {
  String role = 'tenant_owner',
}) async {
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
        path: '/animals/unmatched-tags',
        builder: (_, _) => const UnmatchedTagsScreen(),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => _As(role)),
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('işletme sahibi Hayvanlar sekmesinde bandı görür ve açar', (
    tester,
  ) async {
    await _pump(tester, const HistoryScreen());

    expect(find.text('1 tanınmayan küpe'), findsOneWidget);
    await tester.tap(find.text('1 tanınmayan küpe'));
    await tester.pumpAndSettle();
    expect(find.text(_tag), findsOneWidget);
    // Okunduğu nokta adıyla, kimlikle değil.
    expect(find.textContaining('Nokta 8'), findsOneWidget);
    expect(find.textContaining('3 okuma'), findsOneWidget);
  });

  testWidgets('operatör bandı görmez', (tester) async {
    await _pump(tester, const HistoryScreen(), role: 'tenant_operator');
    expect(find.textContaining('tanınmayan küpe'), findsNothing);
  });

  testWidgets('küpe küpesiz hayvana atanır ve listeden düşer', (tester) async {
    final repo = await _pump(tester, const UnmatchedTagsScreen());

    // TR-YENI küpesiz: listenin başında gelir.
    final fresh = await tester.runAsync(() async {
      final a = (await repo.animals()).first;
      return repo.saveAnimal(
        a.copyWith(id: '', earTag: 'TR-YENI', rfid: null, name: 'Yeni'),
      );
    });

    await tester.tap(find.text('Hayvana ata'));
    await tester.pumpAndSettle();
    expect(find.textContaining('küpesi yok'), findsWidgets);
    await tester.tap(find.text('Yeni'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(
      repo.animals,
    ))!.firstWhere((a) => a.id == fresh!.id);
    expect(saved.rfid, _tag);
    expect(find.text('Küpe TR-YENI kaydına eklendi'), findsOneWidget);
    expect(find.text('Tanınmayan küpe yok'), findsOneWidget);
  });

  testWidgets('küpesi olan hayvana atamak onay ister', (tester) async {
    final repo = await _pump(tester, const UnmatchedTagsScreen());
    final a = (await tester.runAsync(
      repo.animals,
    ))!.firstWhere((a) => a.rfid != null);

    await tester.tap(find.text('Hayvana ata'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), a.earTag);
    await tester.pumpAndSettle();
    await tester.tap(find.text(a.name ?? a.earTag).last);
    await tester.pumpAndSettle();

    expect(find.text('Küpe değiştirilsin mi?'), findsOneWidget);
    await tester.tap(find.text('Vazgeç'));
    await tester.pumpAndSettle();
    final same = (await tester.runAsync(
      repo.animals,
    ))!.firstWhere((x) => x.id == a.id);
    expect(same.rfid, a.rfid, reason: 'vazgeçilince değişmez');
    expect(find.text(_tag), findsOneWidget);
  });

  testWidgets('küpe yok sayılır', (tester) async {
    await _pump(tester, const UnmatchedTagsScreen());

    await tester.tap(find.text('Yok say'));
    await tester.pumpAndSettle();
    expect(find.text('Küpe yok sayılsın mı?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Yok say').last);
    await tester.pumpAndSettle();
    expect(find.text('Tanınmayan küpe yok'), findsOneWidget);
  });
}
