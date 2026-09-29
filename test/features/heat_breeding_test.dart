import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal_trend.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/dashboard_summary.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/alerts/alert_style.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/features/history/widgets/yield_chart.dart';
import 'package:milktrace/features/settings/farm_location_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Owner extends Auth {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u',
      email: 'a@b.c',
      fullName: 'X',
      role: 'tenant_owner',
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
        breeding: const BreedingKpi(
          calvingIntervalDays: 384,
          calvingIntervals: 12,
          firstServicePct: 41.7,
          firstServices: 24,
        ),
      );
}

Widget _app(Widget home, MilkTraceRepository repo) => ProviderScope(
  overrides: [
    authProvider.overrideWith(_Owner.new),
    repositoryProvider.overrideWith((ref) => repo),
  ],
  child: MaterialApp(home: Scaffold(body: home)),
);

void main() {
  test('koordinat ayrıştırma ve yeni uyarı simgeleri', () {
    expect(parseCoordinate('39.9208, 32.8541'), (39.9208, 32.8541));
    expect(parseCoordinate('39.9208 32.8541'), (39.9208, 32.8541));
    expect(parseCoordinate('91, 32'), isNull);
    expect(parseCoordinate('39,9208'), isNull, reason: 'tek sayı');
    expect(parseCoordinate('Ankara'), isNull);
    expect(AlertStyle.icon('heat_stress'), Icons.thermostat);
    expect(
      AlertStyle.icon('dry_off_due'),
      isNot(Icons.notifications_none_outlined),
    );
    expect(
      AlertStyle.icon('calving_due'),
      isNot(Icons.notifications_none_outlined),
    );
  });

  testWidgets('panoda üreme kartı: değer ve örnek sayısı; eksik değer çizgi', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(_app(const DashboardScreen(), _Repo()));
    await tester.pumpAndSettle();
    expect(find.text('Üreme · son 12 ay'), findsOneWidget);
    expect(find.text('384 gün'), findsOneWidget);
    expect(find.text('12 kayıt'), findsOneWidget);
    expect(find.text('%42'), findsOneWidget);
    expect(find.text('—'), findsOneWidget, reason: 'boş kalma örneği yok');
  });

  testWidgets('tesis konumu: bozuk biçim reddedilir, doğru biçim kaydedilir', (
    tester,
  ) async {
    final repo = MockRepository(latency: Duration.zero, loadAsset: _disk);
    await tester.pumpWidget(_app(const FarmLocationScreen(), repo));
    await tester.pumpAndSettle();
    final field = find.byType(TextField).first;
    await tester.enterText(field, 'Ankara');
    await tester.tap(find.text('Kaydet').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('Enlem, boylam biçiminde'), findsOneWidget);

    await tester.enterText(field, '39.9208, 32.8541');
    await tester.tap(find.text('Kaydet').first);
    await tester.pumpAndSettle();
    final farms = (await tester.runAsync(repo.farms))!;
    expect(farms.first.latitude, 39.9208);
    expect(farms.first.longitude, 32.8541);
    expect(find.text('Konumu sil'), findsOneWidget);
  });

  testWidgets('verim grafiği ısı stresi günlerini işaretler', (tester) async {
    List<AnimalDailyStat> days(double? hot) => [
      for (var i = 0; i < 10; i++)
        AnimalDailyStat(
          date: DateTime(2026, 7, 1 + i),
          totalMl: 20000,
          thi: i == 5 ? hot : 65,
        ),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: YieldChart(daily: days(80))),
      ),
    );
    expect(find.text('Isı stresi günü (THI ≥ 72)'), findsOneWidget);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: YieldChart(daily: days(70))),
      ),
    );
    expect(find.text('Isı stresi günü (THI ≥ 72)'), findsNothing);
  });
}
