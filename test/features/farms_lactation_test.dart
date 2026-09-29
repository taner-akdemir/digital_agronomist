import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/animal_import.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/farm_summary.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/animal_import_screen.dart';
import 'package:milktrace/features/settings/farms_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

const _t1 = TenantRef(id: 't1', name: 'Yayla', role: 'tenant_viewer');
const _t2 = TenantRef(id: 't2', name: 'Ova', role: 'tenant_operator');

class _Vet extends Auth {
  final switched = <String>[];

  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'vet@x.tr',
      fullName: 'Dr. Ayşe',
      role: 'tenant_viewer',
      tenantId: 't1',
      tenants: [_t1, _t2],
    ),
  );

  @override
  Future<void> switchTenant(String tenantId) async => switched.add(tenantId);
}

class _Repo extends MockRepository {
  _Repo()
    : super(
        latency: Duration.zero,
        today: DateTime(2026, 9, 22),
        loadAsset: _disk,
      );

  Lactation305? lactation;

  @override
  Future<List<FarmSummary>> myFarms() async => const [
    FarmSummary(
      tenantId: 't2',
      name: 'Ova',
      role: 'tenant_operator',
      todayMl: 412000,
      todayAnimals: 18,
      openAlerts: 2,
      vaccinationsDue: 5,
    ),
    FarmSummary(tenantId: 't1', name: 'Yayla', role: 'tenant_viewer'),
  ];

  @override
  Future<AnimalTrend> animalTrend(String animalId) async =>
      (await super.animalTrend(animalId)).copyWith(lactation: lactation);
}

void main() {
  test('laktasyon bloğu çözülür; içe aktarma soy etiketleri', () {
    final t = AnimalTrend.fromJson({
      'animalId': 'a',
      'lactation': {
        'calvingDate': '2026-06-24T00:00:00Z',
        'daysInMilk': 90,
        'actualMl': 2150000,
        'projected305Ml': 8900000,
        'complete': false,
      },
    });
    expect(t.lactation!.projected305Ml, 8900000);
    expect(
      changeLabel(const AnimalImportChange(field: 'dam', to: 'TR1')),
      startsWith('Anne'),
    );
    expect(
      changeLabel(const AnimalImportChange(field: 'sire', to: 'HOL-1')),
      startsWith('Baba'),
    );
  });

  testWidgets('çiftliklerim: özet ve dokununca o işletmeye geçer', (
    tester,
  ) async {
    final auth = _Vet();
    final router = GoRouter(
      initialLocation: '/settings/farms',
      routes: [
        GoRoute(
          path: '/settings/farms',
          builder: (_, _) => const FarmsScreen(),
        ),
        GoRoute(path: '/dashboard', builder: (_, _) => const Text('pano')),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => auth),
          repositoryProvider.overrideWith(
            (ref) => _Repo() as MilkTraceRepository,
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Ova'), findsOneWidget);
    expect(find.text('Bugün 412 L · 18 hayvan'), findsOneWidget);
    expect(find.text('2 okunmamış uyarı · 5 aşı zamanı'), findsOneWidget);
    expect(find.textContaining('Şu an bu işletmedesiniz'), findsOneWidget);

    await tester.tap(find.text('Ova'));
    await tester.pumpAndSettle();
    expect(auth.switched, ['t2']);
    expect(find.text('pano'), findsOneWidget);
  });

  testWidgets('305 gün kartı: ölçülen, tahmin ve tahminsiz hâl', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 6000);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = _Repo()
      ..lactation = Lactation305(
        calvingDate: DateTime.utc(2026, 6, 24),
        daysInMilk: 90,
        actualMl: 2150000,
        projected305Ml: 8900000,
      );
    final animal = (await tester.runAsync(repo.animals))!.first;
    Future<void> pump() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(_Vet.new),
            repositoryProvider.overrideWith(
              (ref) => repo as MilkTraceRepository,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(body: AnimalDetailScreen(animalId: animal.id)),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pump();
    expect(find.text('Bu laktasyon · 305 gün'), findsOneWidget);
    expect(find.text('Ölçülen: 2150 L (90. gün)'), findsOneWidget);
    expect(find.text('305 gün tahmini: 8900 L'), findsOneWidget);

    repo.lactation = repo.lactation!.copyWith(projected305Ml: null);
    await tester.pumpWidget(const SizedBox());
    await pump();
    expect(find.textContaining('en az 30 günlük'), findsOneWidget);
  });
}
