import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/breeding.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/features/history/animal_form_screen.dart';
import 'package:milktrace/features/history/breeding_card.dart';
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
      id: 'u',
      email: 'a@b.c',
      fullName: 'X',
      role: role,
      tenantId: 't',
    ),
  );
}

class _Repo extends MockRepository {
  _Repo()
    : super(
        latency: Duration.zero,
        today: DateTime(2026, 9, 22),
        loadAsset: _disk,
      );

  @override
  Future<DashboardSummary> dashboard() async =>
      (await super.dashboard()).copyWith(
        exits: const [
          ExitCount(reason: 'low_yield', count: 3),
          ExitCount(reason: 'unknown', count: 1),
        ],
      );
}

void main() {
  test('gövde çıkış nedenini yalnızca çıkış durumunda taşır', () {
    const a = Animal(
      id: 'x',
      speciesId: 's',
      earTag: 'T',
      status: 'active',
      exitReason: 'age',
    );
    expect(ApiRepository.animalBody(a)['exitReason'], isNull);
    expect(
      ApiRepository.animalBody(a.copyWith(status: 'sold'))['exitReason'],
      'age',
    );
    expect(exitReasonLabel('mastitis'), 'Mastitis');
    expect(exitReasonLabel(null), 'Belirtilmedi');
    expect(exitReasonLabel('yeni'), 'yeni', reason: 'tanınmayan kod ham');
  });

  test(
    'mock ayna: kızgınlık + 21; sonrasında tohumlanınca beklenen yok',
    () async {
      final repo = MockRepository(latency: Duration.zero, loadAsset: _disk);
      final a = (await repo.animals()).first;
      await repo.addBreeding(a.id, kind: 'heat', date: DateTime(2026, 9, 10));
      var p = (await repo.animals()).firstWhere((x) => x.id == a.id).pregnancy!;
      expect(p.status, 'open');
      expect(p.expectedHeat, DateTime(2026, 10, 1));
      await repo.addBreeding(
        a.id,
        kind: 'insemination',
        date: DateTime(2026, 9, 11),
      );
      p = (await repo.animals()).firstWhere((x) => x.id == a.id).pregnancy!;
      expect(p.expectedHeat, isNull);
    },
  );

  testWidgets('üreme kartında kızgınlık kaydı ve beklenen pencere', (
    tester,
  ) async {
    final repo = MockRepository(latency: Duration.zero);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
          authProvider.overrideWith(() => _As('tenant_viewer')),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: BreedingCard(
                animal: Animal(
                  id: 'a1',
                  speciesId: 'cow',
                  earTag: 'TR1',
                  pregnancy: Pregnancy(
                    status: 'open',
                    lastHeat: DateTime(2026, 9, 10),
                    expectedHeat: DateTime(2026, 10, 1),
                  ),
                ),
                today: DateTime(2026, 9, 28),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Kızgınlık bekleniyor: 28 Eyl – 4 Eki'), findsOneWidget);

    await tester.tap(find.text('Kayıt ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kızgınlık'));
    await tester.pumpAndSettle();
    expect(find.textContaining('18–24. gün'), findsOneWidget);
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    final saved = (await tester.runAsync(() => repo.breedingEvents('a1')))!;
    expect(saved.single.kind, 'heat');
    expect(find.text('Kızgınlık'), findsWidgets);
  });

  testWidgets('satıldı seçilince çıkış nedeni zorunlu ve kaydedilir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = MockRepository(latency: Duration.zero, loadAsset: _disk);
    final first = (await tester.runAsync(repo.animals))!.first;
    final router = GoRouter(
      initialLocation: '/animals/${first.id}/edit',
      routes: [
        GoRoute(
          path: '/animals/:id/edit',
          builder: (_, s) => AnimalFormScreen(animalId: s.pathParameters['id']),
        ),
        GoRoute(path: '/', builder: (_, _) => const Text('geri')),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
          authProvider.overrideWith(() => _As('tenant_owner')),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Çıkış nedeni'), findsNothing);

    await tester.tap(find.text(first.statusLabel).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Satıldı').last);
    await tester.pumpAndSettle();
    expect(find.text('Çıkış nedeni'), findsOneWidget);

    Future<void> save() async {
      await tester.scrollUntilVisible(
        find.text('Kaydet'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Kaydet'));
      await tester.pumpAndSettle();
    }

    await save();
    expect(find.text('Çıkış nedenini seçin'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Çıkış nedeni'),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Çıkış nedeni'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Düşük verim').last);
    await tester.pumpAndSettle();
    await save();
    final saved = (await tester.runAsync(
      repo.animals,
    ))!.firstWhere((a) => a.id == first.id);
    expect(saved.status, 'sold');
    expect(saved.exitReason, 'low_yield');
  });

  testWidgets('panoda çıkış nedenleri', (tester) async {
    tester.view.physicalSize = const Size(1200, 5000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith(
            (ref) => _Repo() as MilkTraceRepository,
          ),
          authProvider.overrideWith(() => _As('tenant_owner')),
        ],
        child: const MaterialApp(home: Scaffold(body: DashboardScreen())),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Sürüden çıkış · son 12 ay (4)'), findsOneWidget);
    expect(find.text('Düşük verim'), findsOneWidget);
    expect(find.text('Belirtilmedi'), findsOneWidget);
  });
}
