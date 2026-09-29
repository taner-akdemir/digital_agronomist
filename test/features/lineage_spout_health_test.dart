import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/spout_health.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/devices/devices_providers.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/animal_form_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Owner extends Auth {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'x@milktrace.local',
      fullName: 'X',
      role: 'tenant_owner',
      tenantId: 't1',
    ),
  );
}

/// Nokta sağlığı dönen mock (mock'ta yok; sunucunun cevabı gibi).
class _HealthRepo extends MockRepository {
  _HealthRepo(this.health)
    : super(
        latency: Duration.zero,
        today: DateTime(2026, 9, 22),
        loadAsset: _disk,
      );

  final List<SpoutHealth> health;

  @override
  Future<List<SpoutHealth>> spoutHealth() async => health;
}

MockRepository _repo() => MockRepository(
  latency: Duration.zero,
  today: DateTime(2026, 9, 22),
  loadAsset: _disk,
);

Future<void> _pumpRouter(
  WidgetTester tester,
  MilkTraceRepository repo,
  String initial,
) async {
  tester.view.physicalSize = const Size(1200, 4000);
  addTearDown(tester.view.resetPhysicalSize);
  final router = GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: '/animals/new',
        builder: (_, s) => AnimalFormScreen(
          damId: s.uri.queryParameters['damId'],
          birthDate: DateTime.tryParse(s.uri.queryParameters['birth'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/history/animal/:id',
        // Detay uygulamada kabuğun Scaffold'unda çizilir.
        builder: (_, s) => Scaffold(
          body: AnimalDetailScreen(animalId: s.pathParameters['id']!),
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_Owner.new),
        repositoryProvider.overrideWith((ref) => repo),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  test('gövde anne ve babayı her zaman taşır (tam kayıt)', () {
    const a = Animal(id: 'x', speciesId: 's', earTag: 'T', status: 'active');
    final body = ApiRepository.animalBody(a);
    expect(body.containsKey('damId'), isTrue);
    expect(body.containsKey('sireCode'), isTrue);
    expect(
      ApiRepository.animalBody(a.copyWith(damId: 'd', sireCode: 'HOL-1')),
      containsPair('sireCode', 'HOL-1'),
    );
  });

  testWidgets('yavru kısayolu anneyi ve doğumu doldurur; detayda soy', (
    tester,
  ) async {
    final repo = _repo();
    final dam = (await tester.runAsync(repo.animals))!.first;
    await _pumpRouter(
      tester,
      repo,
      '/animals/new?damId=${dam.id}&birth=2026-09-20',
    );
    expect(find.textContaining(dam.earTag), findsWidgets);
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Küpe numarası'),
      'TR-YAVRU-1',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Baba (boğa/sperma kodu)'),
      'HOL-123',
    );
    await tester.scrollUntilVisible(
      find.text('Kaydet'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final all = (await tester.runAsync(repo.animals))!;
    final calf = all.firstWhere((a) => a.earTag == 'TR-YAVRU-1');
    expect(calf.damId, dam.id);
    expect(calf.sireCode, 'HOL-123');
    expect(calf.birthDate, DateTime(2026, 9, 20));
  });

  testWidgets('annenin detayında yavru çipi', (tester) async {
    final repo = _repo();
    final dam = (await tester.runAsync(() async {
      final d = (await repo.animals()).first;
      await repo.saveAnimal(
        Animal(
          id: '',
          speciesId: d.speciesId,
          earTag: 'TR-YAVRU-2',
          status: 'active',
          damId: d.id,
        ),
      );
      return d;
    }))!;
    await _pumpRouter(tester, repo, '/history/animal/${dam.id}');
    expect(find.text('Yavrular:'), findsOneWidget);
    expect(find.widgetWithText(ActionChip, 'TR-YAVRU-2'), findsOneWidget);
  });

  testWidgets('düşük debi ölçen nokta sarı ve ünitesi açık', (tester) async {
    final repo0 = _repo();
    // Çevrimiçi, hatasız sayaçlı bir nokta: başka sorunu olan satırda
    // ekipman işareti öne çıkmaz.
    final devices = (await tester.runAsync(repo0.devices))!;
    final now = DateTime.now();
    final online = devices.firstWhere(
      (d) =>
          d.status == 'online' &&
          d.spoutId != null &&
          !d.hasRecentError(now) &&
          !d.isCalibrationDue(now),
    );
    final target = online.spoutId!;
    final repo = _HealthRepo([
      SpoutHealth(
        spoutId: target,
        milkings: 20,
        animals: 5,
        avgFlow: 1.0,
        unitMedian: 1.8,
        diffPct: -44.4,
        low: true,
      ),
    ]);
    tester.view.physicalSize = const Size(1200, 5200);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final container = ProviderContainer(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: Scaffold(body: DevicesScreen())),
      ),
    );
    await tester.pumpAndSettle();
    final health = await container.read(spoutHealthProvider.future);
    expect(health[target]?.low, isTrue);
    expect(find.text('Düşük debi · %44'), findsOneWidget);
  });
}
