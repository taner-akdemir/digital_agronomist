import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/history/animal_form_screen.dart';
import 'package:milktrace/features/history/groups_screen.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

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
  loadAsset: _disk,
);

Future<ProviderContainer> _pump(
  WidgetTester tester,
  MockRepository repo, {
  String initial = '/',
  String role = 'tenant_owner',
}) async {
  tester.view.physicalSize = const Size(1200, 3000);
  addTearDown(tester.view.resetPhysicalSize);
  final container = ProviderContainer(
    overrides: [
      authProvider.overrideWith(() => _As(role)),
      repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
    ],
  );
  addTearDown(container.dispose);
  final router = GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: HistoryScreen()),
      ),
      GoRoute(path: '/animals/groups', builder: (_, _) => const GroupsScreen()),
      GoRoute(
        path: '/animals/:id/edit',
        builder: (_, s) => AnimalFormScreen(animalId: s.pathParameters['id']),
      ),
      GoRoute(
        path: '/history/animal/:id',
        builder: (_, s) => Text('detay ${s.pathParameters['id']}'),
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
  return container;
}

void main() {
  test('grup PUT gövdesinde her zaman gider (boş = grupsuz)', () {
    final body = ApiRepository.animalBody(
      const Animal(id: 'a', speciesId: 's', earTag: 'TR1'),
    );
    expect(body.containsKey('groupId'), isTrue);
    expect(body['groupId'], isNull);
  });

  test('grup ortalaması sağılan hayvan başına', () {
    const g = GroupTotal(
      groupId: 'g',
      name: 'Padok 1',
      animals: 10,
      milked: 4,
      totalMl: 80000,
    );
    expect(g.perAnimalMl, 20000);
    expect(g.copyWith(milked: 0).perAnimalMl, 0);
  });

  testWidgets('sahip grup ekler, adını değiştirir, siler', (tester) async {
    final repo = _repo();
    await _pump(tester, repo, initial: '/animals/groups');
    expect(find.text('Henüz grup yok.'), findsOneWidget);

    await tester.tap(find.text('Grup ekle'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Padok 1');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('Padok 1'), findsOneWidget);

    await tester.tap(find.text('Grup ekle'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'padok 1');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('bu adla bir grup zaten var'), findsOneWidget);

    await tester.tap(find.text('Padok 1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Yüksek verim');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('Yüksek verim'), findsOneWidget);

    await tester.tap(find.byTooltip('Grubu sil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sil'));
    await tester.pumpAndSettle();
    expect((await tester.runAsync(repo.animalGroups))!, isEmpty);
  });

  testWidgets('formdan gruba atanır; listede süzülür', (tester) async {
    final repo = _repo();
    final (group, first) = (await tester.runAsync(() async {
      final g = await repo.createGroup('Padok 1');
      return (g, (await repo.animals()).first);
    }))!;
    await _pump(tester, repo, initial: '/animals/${first.id}/edit');

    await tester.tap(find.text('Grupsuz'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Padok 1').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Kaydet'));
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(
      repo.animals,
    ))!.firstWhere((a) => a.id == first.id);
    expect(saved.groupId, group.id);
    expect(saved.groupName, 'Padok 1');
  });

  testWidgets('listede gruba göre süzülür', (tester) async {
    final repo = _repo();
    final (group, first) = (await tester.runAsync(() async {
      final g = await repo.createGroup('Padok 1');
      final a = (await repo.animals()).first;
      await repo.saveAnimal(a.copyWith(groupId: g.id));
      return (g, a);
    }))!;
    final container = await _pump(tester, repo);
    await tester.tap(find.text('Hayvanlar'));
    await tester.pumpAndSettle();
    container.read(animalFilterStateProvider.notifier).toggleGroup(group.id);
    await tester.pumpAndSettle();
    final list = await tester.runAsync(
      () => container.read(filteredAnimalsProvider.future),
    );
    expect(list!.map((a) => a.id), [first.id]);
    expect(find.textContaining('Padok 1 · 1 hayvan'), findsOneWidget);

    // Riverpod'un ertelenmiş dispose'u ağaç atılmadan çalışsın.
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}
