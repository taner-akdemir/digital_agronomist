import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

MockRepository _repo() => MockRepository(
  latency: Duration.zero,
  today: DateTime(2026, 9, 22),
  loadAsset: _disk,
);

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

Future<(MockRepository, Animal)> _open(
  WidgetTester tester, {
  String role = 'tenant_owner',
}) async {
  tester.view.physicalSize = const Size(1200, 4000);
  addTearDown(tester.view.resetPhysicalSize);
  final repo = _repo();
  final a = await tester.runAsync(() async {
    final a = (await repo.animals()).first;
    // Kuruda ve geçen yıl buzağılamış.
    return repo.saveAnimal(
      a.copyWith(status: 'dry', lastCalvingDate: DateTime.utc(2025, 10, 1)),
    );
  });
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => _As(role)),
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      child: MaterialApp(
        home: Scaffold(body: AnimalDetailScreen(animalId: a!.id)),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (repo, a);
}

void main() {
  group('mock', () {
    test('buzağılama laktasyonu artırır, sağmal yapar, not düşer', () async {
      final repo = _repo();
      final a = (await repo.animals()).first;
      await repo.saveAnimal(
        a.copyWith(status: 'dry', lastCalvingDate: DateTime.utc(2025, 10, 1)),
      );

      final saved = await repo.recordCalving(a.id, DateTime(2026, 9, 20));
      expect(saved.lactationNo, a.lactationNo + 1);
      expect(saved.status, 'active');
      expect(saved.yieldClass, YieldClass.normal, reason: 'yeni laktasyon');
      expect(saved.lastCalvingDate, DateTime.utc(2026, 9, 20));
      final n = (await repo.animalNotes(a.id)).first;
      expect(n.isCalving, isTrue);
      expect(
        n.note,
        'Buzağıladı: 20.09.2026 (${a.lactationNo + 1}. laktasyon); '
        'durum: Kuruda → Sağmal',
      );

      // Biten laktasyonun sınıfı nota girer (backend ADR 0060).
      await repo.saveAnimal(
        saved.copyWith(
          yieldClass: YieldClass.high,
          yieldClassAt: DateTime.utc(2026, 9, 22),
        ),
      );
      await repo.recordCalving(a.id, DateTime(2026, 9, 24));
      expect(
        (await repo.animalNotes(a.id)).first.note,
        endsWith('önceki laktasyon: Yüksek Verimli (22.09.2026 hesabı)'),
      );

      await expectLater(
        repo.recordCalving(a.id, DateTime(2026, 9, 24)),
        throwsA(isA<ApiException>().having((e) => e.status, 'status', 409)),
      );
    });
  });

  testWidgets('işletme sahibi buzağılamayı kaydeder', (tester) async {
    final (repo, a) = await _open(tester);

    await tester.tap(find.text('Buzağıladı'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.text('Buzağılama kaydedilsin mi?'), findsOneWidget);
    expect(
      find.textContaining('Laktasyon ${a.lactationNo} → ${a.lactationNo + 1}'),
      findsOneWidget,
    );
    expect(find.textContaining('Durum Kuruda → Sağmal'), findsOneWidget);
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    expect(find.text('Buzağılama kaydedildi'), findsOneWidget);
    final saved = (await tester.runAsync(
      repo.animals,
    ))!.firstWhere((x) => x.id == a.id);
    expect(saved.lactationNo, a.lactationNo + 1);
    expect(find.textContaining('Buzağıladı:'), findsOneWidget);
    expect(find.byIcon(Icons.child_friendly_outlined), findsWidgets);
  });

  testWidgets('operatör düğmeyi görmez', (tester) async {
    await _open(tester, role: 'tenant_operator');
    expect(find.text('Buzağıladı'), findsNothing);
  });
}
