import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/vaccination.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/alerts/alert_style.dart';
import 'package:milktrace/features/audit/audit_screen.dart';
import 'package:milktrace/features/history/vaccinations_card.dart';
import 'package:milktrace/features/history/vaccinations_screen.dart';
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

const _cow = '0192a1f0-0020-7000-8000-000000000001';
const _sarikiz = '0192a1f0-0070-7000-8000-000000000001';
final _today = DateTime(2026, 9, 22);

MockRepository _repo() => MockRepository(
  latency: Duration.zero,
  today: _today,
  loadAsset: (p) async => File(p).readAsStringSync(),
);

Future<void> _pump(
  WidgetTester tester,
  MockRepository repo,
  Widget child, {
  required String role,
  bool scaffold = false,
}) async {
  tester.view.physicalSize = const Size(1200, 2400);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        authProvider.overrideWith(() => _FakeAuth(role)),
      ],
      child: MaterialApp(
        home: scaffold
            ? Scaffold(body: SingleChildScrollView(child: child))
            : child,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  test('plan, sıra ve hayvan kartı çözülür', () {
    final p = VaccinePlan.fromJson({
      'id': 'p',
      'name': 'Şap',
      'intervalDays': 180,
      'speciesId': null,
      'note': '',
      'animals': 12,
      'dueSoon': 4,
      'never': 2,
    });
    expect(p.speciesId, isNull);
    expect(p.dueSoon, 4);

    final v = AnimalVaccinations.fromJson({
      'items': [
        {
          'id': 'v',
          'planId': 'p',
          'planName': 'Şap',
          'animalId': 'a',
          'givenOn': '2026-04-01T00:00:00Z',
          'authorName': 'Vet',
          'createdAt': '2026-04-01T08:00:00Z',
        },
      ],
      'due': [
        {
          'planId': 'p',
          'planName': 'Şap',
          'animalId': 'a',
          'earTag': 'TR1',
          'animalName': '',
          'lastGivenOn': '2026-04-01T00:00:00Z',
          'dueOn': '2026-09-28T00:00:00Z',
        },
        {
          'planId': 'q',
          'planName': 'Brusella',
          'animalId': 'a',
          'earTag': 'TR1',
          'animalName': '',
          'lastGivenOn': null,
          'dueOn': null,
        },
      ],
    });
    expect(v.items.single.note, '');
    expect(vaccineDay(v.items.single.givenOn), DateTime(2026, 4, 1));
    expect(vaccineDay(v.due.first.dueOn!), DateTime(2026, 9, 28));
    expect(dueLabel(v.due.first, _today, next: true).text, 'sonraki 28 Eyl');
    expect(
      dueLabel(v.due.first, DateTime(2026, 9, 29)).text,
      'gecikti · 28 Eyl',
    );
    expect(dueLabel(v.due.last, _today).text, 'kayıt yok');
    expect(dueLabel(v.due.last, _today).alarm, isTrue);

    // Başka yıla düşen gün yılıyla: yıllık planın bir sonraki dozu bugünle
    // karışmasın; geçen yıldan kalan gecikme de.
    final nextYear = v.due.first.copyWith(dueOn: DateTime.utc(2027, 9, 22));
    expect(dueLabel(nextYear, _today, next: true).text, 'sonraki 22 Eyl 2027');
    final lastYear = v.due.first.copyWith(dueOn: DateTime.utc(2026, 12, 20));
    expect(
      dueLabel(lastYear, DateTime(2027, 1, 5)).text,
      'gecikti · 20 Ara 2026',
    );

    expect(AlertStyle.icon('vaccination_due'), Icons.vaccines_outlined);
    expect(auditActionLabel('vaccination.add'), 'Aşı uygulandı');
    expect(auditActionLabel('vaccine_plan.create'), 'Aşı planı eklendi');
  });

  test(
    'mock: kayıtsız zamanı gelmiş sayılır; gelecek gün reddedilir',
    () async {
      final repo = _repo();
      final p = await repo.saveVaccinePlan(
        name: 'Şap',
        intervalDays: 180,
        speciesId: _cow,
      );
      var plans = await repo.vaccinePlans();
      expect(
        (plans.single.animals, plans.single.dueSoon, plans.single.never),
        (10, 10, 10),
      );
      await expectLater(
        repo.saveVaccinePlan(name: 'şap', intervalDays: 30),
        throwsA(isA<ApiException>().having((e) => e.status, 'status', 409)),
        reason: 'ad tekil',
      );
      await expectLater(
        repo.addVaccinations(
          planId: p.id,
          animalIds: [_sarikiz],
          givenOn: DateTime(2026, 9, 23),
        ),
        throwsA(isA<ApiException>()),
        reason: 'gelecek gün yok',
      );
      final n = await repo.addVaccinations(
        planId: p.id,
        animalIds: [_sarikiz, 'yok'],
        givenOn: _today,
      );
      expect(n, 1, reason: 'plana girmeyen sessizce atlanır');
      expect(
        await repo.addVaccinations(
          planId: p.id,
          animalIds: [_sarikiz],
          givenOn: _today,
        ),
        0,
        reason: 'aynı gün ikinci kayıt yok sayılır',
      );
      plans = await repo.vaccinePlans();
      expect((plans.single.dueSoon, plans.single.never), (9, 9));
      final due = await repo.dueVaccinations();
      expect(due.any((d) => d.animalId == _sarikiz), isFalse);
    },
  );

  // Aşı uyarısından gelen yol (/vaccinations/:planId, backend ADR 0112).
  testWidgets(
    'plan yolu planın zamanı gelenlerini, silinmiş plan listeyi açar',
    (tester) async {
      final repo = _repo();
      // Mock'un gecikmesi sahte saatte ilerlemez: gerçek zamanda kaydedilir.
      final plan = (await tester.runAsync(
        () => repo.saveVaccinePlan(name: 'Şap', intervalDays: 180),
      ))!;

      await _pump(
        tester,
        repo,
        VaccinePlanRoute(planId: plan.id),
        role: 'tenant_operator',
      );
      expect(
        find.textContaining('Zamanı geçmiş, 30 gün içinde'),
        findsOneWidget,
      );

      await _pump(
        tester,
        repo,
        const VaccinePlanRoute(planId: 'silinmis'),
        role: 'tenant_operator',
      );
      expect(find.text('Aşı takvimi'), findsOneWidget);
    },
  );

  testWidgets('sahip plan ekler; kayıtsız hayvanlar zamanı gelmiş sayılır', (
    tester,
  ) async {
    final repo = _repo();
    await _pump(
      tester,
      repo,
      VaccinationsScreen(today: _today),
      role: 'tenant_owner',
    );
    expect(find.textContaining('Henüz aşı planı yok'), findsOneWidget);

    await tester.tap(find.text('Plan ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('Plan adını girin.'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Ad (ör. Şap)'),
      'Şap',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Tekrar aralığı (gün)'),
      '3',
    );
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('7 ile 1095 gün arasında olmalı.'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Tekrar aralığı (gün)'),
      '180',
    );
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(repo.vaccinePlans))!;
    expect(saved.single.name, 'Şap');
    expect(saved.single.speciesId, isNull, reason: 'varsayılan bütün türler');
    expect(find.text('Şap'), findsOneWidget);
    expect(find.textContaining('180 günde bir · Bütün türler'), findsOneWidget);
    expect(
      find.textContaining('30 hayvan · 30 zamanı yakın · 30 kayıt yok'),
      findsOneWidget,
    );
    expect(find.byType(PopupMenuButton<String>), findsOneWidget);
  });

  testWidgets(
    'görüntüleyici planı düzenleyemez ama işaretler; sayılar güncellenir',
    (tester) async {
      final repo = _repo();
      await tester.runAsync(
        () => repo.saveVaccinePlan(
          name: 'Şap',
          intervalDays: 180,
          speciesId: _cow,
        ),
      );
      await _pump(
        tester,
        repo,
        VaccinationsScreen(today: _today),
        role: 'tenant_viewer',
      );
      expect(find.text('Plan ekle'), findsNothing);
      expect(find.byType(PopupMenuButton<String>), findsNothing);
      expect(
        find.textContaining('10 hayvan · 10 zamanı yakın · 10 kayıt yok'),
        findsOneWidget,
      );

      await tester.tap(find.text('Şap'));
      await tester.pumpAndSettle();
      // Liste tembel çizilir; ekrandakilerin hepsi kayıtsız.
      expect(find.text('kayıt yok'), findsWidgets);
      expect(find.text('Uygulandı olarak işaretle (0)'), findsOneWidget);

      await tester.tap(find.text('TR340000001 · Sarıkız'));
      await tester.pumpAndSettle();
      expect(find.text('Uygulandı olarak işaretle (1)'), findsOneWidget);
      await tester.tap(find.text('Tümünü seç'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Uygulandı olarak işaretle (10)'));
      await tester.pumpAndSettle();
      expect(find.text('Uygulama günü: 22 Eyl 2026'), findsOneWidget);
      await tester.tap(find.text('Kaydet'));
      await tester.pumpAndSettle();

      expect(find.text('10 hayvan işaretlendi'), findsOneWidget);
      expect(find.text('Zamanı gelen hayvan yok.'), findsOneWidget);
      final plans = (await tester.runAsync(repo.vaccinePlans))!;
      expect((plans.single.dueSoon, plans.single.never), (0, 0));

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(
        find.textContaining('10 hayvan · 0 zamanı yakın · 0 kayıt yok'),
        findsOneWidget,
      );
    },
  );

  Future<MockRepository> seededCard(WidgetTester tester, String role) async {
    final repo = _repo();
    await tester.runAsync(() async {
      final sap = await repo.saveVaccinePlan(
        name: 'Şap',
        intervalDays: 180,
        speciesId: _cow,
      );
      await repo.saveVaccinePlan(name: 'Brusella', intervalDays: 365);
      final parazit = await repo.saveVaccinePlan(
        name: 'Parazit',
        intervalDays: 30,
      );
      await repo.addVaccinations(
        planId: sap.id,
        animalIds: [_sarikiz],
        givenOn: DateTime(2026, 4, 1),
      );
      await repo.addVaccinations(
        planId: parazit.id,
        animalIds: [_sarikiz],
        givenOn: DateTime(2026, 8, 1),
        note: 'ivermektin',
      );
    });
    await _pump(
      tester,
      repo,
      VaccinationsCard(
        animal: const Animal(
          id: _sarikiz,
          speciesId: _cow,
          earTag: 'TR340000001',
        ),
        today: _today,
      ),
      role: role,
      scaffold: true,
    );
    return repo;
  }

  testWidgets('hayvan kartı sıradaki günü, kayıtsızı ve gecikeni gösterir', (
    tester,
  ) async {
    final repo = await seededCard(tester, 'tenant_viewer');
    expect(find.text('Aşılar'), findsOneWidget);
    expect(find.text('kayıt yok'), findsOneWidget, reason: 'Brusella');
    expect(find.text('gecikti · 31 Ağu'), findsOneWidget, reason: 'Parazit');
    expect(find.text('sonraki 28 Eyl'), findsOneWidget, reason: 'Şap');
    expect(find.textContaining('1 Ağu 2026 · ivermektin'), findsOneWidget);
    expect(
      find.byIcon(Icons.delete_outline),
      findsNothing,
      reason: 'yalnızca sahip siler',
    );

    // Kayıtsız plan listenin başında (sunucudaki sıra): ilk "Uygulandı".
    await tester.tap(find.text('Uygulandı').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('1 hayvan işaretlendi'), findsOneWidget);
    expect(find.text('kayıt yok'), findsNothing);
    // +365 gün gelecek yıla düşer: yılıyla, yoksa bugünle ("22 Eyl") karışırdı.
    expect(
      find.text('sonraki 22 Eyl 2027'),
      findsOneWidget,
      reason: '+365 gün',
    );
    final v = (await tester.runAsync(() => repo.animalVaccinations(_sarikiz)))!;
    expect(v.items.first.planName, 'Brusella');
  });

  testWidgets('sahip yanlış aşı kaydını onayla siler', (tester) async {
    final repo = await seededCard(tester, 'tenant_owner');
    expect(find.byIcon(Icons.delete_outline), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.delete_outline).first);
    await tester.pumpAndSettle();
    expect(find.text('Aşı kaydı silinsin mi?'), findsOneWidget);
    await tester.tap(find.text('Sil'));
    await tester.pumpAndSettle();

    final v = (await tester.runAsync(() => repo.animalVaccinations(_sarikiz)))!;
    expect(v.items.single.planName, 'Şap');
    expect(
      find.text('kayıt yok'),
      findsNWidgets(2),
      reason: 'Parazit kayıtsız',
    );
  });
}
