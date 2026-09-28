import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/breeding.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/dashboard/upcoming_card.dart';
import 'package:milktrace/features/history/breeding_card.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

class _FakeAuth extends Auth {
  _FakeAuth(this.role);

  final String role;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(id: 'u', email: 'a@b.c', fullName: 'X', role: role),
  );
}

Future<MockRepository> _pump(
  WidgetTester tester,
  Widget child, {
  String role = 'tenant_owner',
  MockRepository? repo,
}) async {
  final r = repo ?? MockRepository(latency: Duration.zero);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => r as MilkTraceRepository),
        authProvider.overrideWith(() => _FakeAuth(role)),
      ],
      child: MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return r;
}

void main() {
  test('gebelik durumu ve etiketler çözülür', () {
    final a = Animal.fromJson({
      'id': 'a',
      'speciesId': 'cow',
      'earTag': 'TR1',
      'pregnancy': {
        'status': 'pregnant',
        'lastInsemination': '2026-01-10',
        'expectedCalving': '2026-10-20',
        'dryOffDate': '2026-08-21',
      },
    });
    expect(a.pregnancy!.statusLabel, 'Gebe');
    expect(a.pregnancy!.expectedCalving, DateTime(2026, 10, 20));
    expect(
      BreedingEvent.fromJson({
        'id': 'e',
        'animalId': 'a',
        'kind': 'pregnancy_check',
        'eventDate': '2026-02-10',
        'result': 'open',
      }).label,
      'Gebelik kontrolü · boş',
    );
  });

  testWidgets('görüntüleyici (veteriner) tohumlama girer; silemez', (
    tester,
  ) async {
    final card = BreedingCard(
      animal: const Animal(id: 'a1', speciesId: 'cow', earTag: 'TR1'),
      today: DateTime(2026, 9, 28),
    );
    final repo = await _pump(tester, card, role: 'tenant_viewer');
    expect(find.textContaining('Kayıt yok'), findsOneWidget);

    await tester.tap(find.text('Kayıt ekle'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'HO-123');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(() => repo.breedingEvents('a1')))!;
    expect(saved.single.kind, 'insemination');
    expect(saved.single.sire, 'HO-123');
    expect(saved.single.eventDate, DateTime(2026, 9, 28));
    expect(find.text('Tohumlama · HO-123'), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsNothing);
  });

  testWidgets('gebelik kontrolü "boş" girilir; sahip onayla siler', (
    tester,
  ) async {
    final repo = MockRepository(latency: Duration.zero);
    await tester.runAsync(
      () => repo.addBreeding(
        'a1',
        kind: 'pregnancy_check',
        date: DateTime(2026, 9, 1),
        result: 'open',
      ),
    );
    await _pump(
      tester,
      BreedingCard(
        animal: const Animal(
          id: 'a1',
          speciesId: 'cow',
          earTag: 'TR1',
          pregnancy: Pregnancy(status: 'open'),
        ),
        today: DateTime(2026, 9, 28),
      ),
      repo: repo,
    );
    expect(find.text('Boş'), findsOneWidget);
    expect(find.text('Gebelik kontrolü · boş'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Üreme kaydı silinsin mi?'), findsOneWidget);
    await tester.tap(find.text('Sil'));
    await tester.pumpAndSettle();
    expect((await tester.runAsync(() => repo.breedingEvents('a1')))!, isEmpty);
  });

  testWidgets('gebe hayvanda beklenen doğum ve kuruya çıkarma yazılır', (
    tester,
  ) async {
    await _pump(
      tester,
      BreedingCard(
        animal: Animal(
          id: 'a1',
          speciesId: 'cow',
          earTag: 'TR1',
          pregnancy: Pregnancy(
            status: 'pregnant',
            expectedCalving: DateTime(2026, 10, 20),
            dryOffDate: DateTime(2026, 8, 21),
          ),
        ),
      ),
    );
    expect(find.text('Gebe'), findsOneWidget);
    expect(find.textContaining('Beklenen doğum:'), findsOneWidget);
    expect(find.textContaining('Önerilen kuruya çıkarma:'), findsOneWidget);
  });

  testWidgets('yaklaşanlar boşken çizilmez', (tester) async {
    await _pump(tester, const UpcomingBreedingCard());
    expect(find.text('Yaklaşanlar'), findsNothing);
  });

  test('mock: gebe hayvanın kuruya çıkarması yaklaşanlarda', () async {
    final today = DateTime(2026, 9, 28);
    final repo = MockRepository(
      latency: Duration.zero,
      today: today,
      loadAsset: (p) async => File(p).readAsStringSync(),
    );
    // 283 gün gebelik, 60 gün kuru: kuruya çıkarma 10 gün sonra.
    final ins = today.subtract(const Duration(days: 283 - 60 - 10));
    // Tohumlama son buzağılamadan SONRA olmalı (öncesi sayılmaz).
    // İlk kayıt Sarıkız: sağmal inek.
    final first = (await repo.animals()).first;
    final cow = await repo.saveAnimal(
      first.copyWith(lastCalvingDate: ins.subtract(const Duration(days: 80))),
    );
    await repo.addBreeding(cow.id, kind: 'insemination', date: ins);
    await repo.addBreeding(
      cow.id,
      kind: 'pregnancy_check',
      date: ins.add(const Duration(days: 40)),
      result: 'pregnant',
    );
    final up = await repo.upcomingBreeding();
    final dry = up.singleWhere((u) => u.animalId == cow.id);
    expect(dry.event, 'dry_off');
    expect(dry.date, today.add(const Duration(days: 10)));
  });

  testWidgets('yaklaşan kuruya çıkarma panoda görünür', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          upcomingBreedingProvider.overrideWith(
            (ref) async => [
              UpcomingBreeding(
                animalId: 'a1',
                earTag: 'TR1',
                name: 'Sarıkız',
                event: 'dry_off',
                date: DateTime(2026, 10, 8),
              ),
            ],
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: UpcomingBreedingCard())),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Yaklaşanlar'), findsOneWidget);
    expect(find.text('TR1 · Sarıkız'), findsOneWidget);
    expect(find.text('Kuruya çıkar'), findsOneWidget);
  });
}
