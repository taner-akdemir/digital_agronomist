import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

const _a = TenantRef(id: 't1', name: 'Demo Çiftlik', role: 'tenant_viewer');
const _b = TenantRef(id: 't2', name: 'Yayla Çiftliği', role: 'tenant_operator');

class _FakeAuth extends Auth {
  _FakeAuth(this.tenants);

  final List<TenantRef> tenants;
  final switched = <String>[];

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'vet@x.tr',
      fullName: 'Dr. Ayşe',
      role: 'tenant_viewer',
      tenantId: 't1',
      tenants: tenants,
    ),
  );

  @override
  Future<void> switchTenant(String tenantId) async => switched.add(tenantId);
}

Future<_FakeAuth> _pump(WidgetTester tester, List<TenantRef> tenants) async {
  final auth = _FakeAuth(tenants);
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, _) => Scaffold(
          body: TextButton(
            onPressed: () => showAccountSheet(context),
            child: const Text('hesap'),
          ),
        ),
      ),
      GoRoute(path: '/live', builder: (_, _) => const Text('canlı')),
    ],
  );
  tester.view.physicalSize = const Size(1200, 4000);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => auth),
        repositoryProvider.overrideWith(
          (ref) =>
              MockRepository(latency: Duration.zero) as MilkTraceRepository,
        ),
        supportInfoProvider.overrideWith((ref) async => null),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.tap(find.text('hesap'));
  await tester.pumpAndSettle();
  return auth;
}

void main() {
  testWidgets('iki işletmeli kişi işletme değiştirir; kart seçileni yazar', (
    tester,
  ) async {
    final auth = await _pump(tester, const [_a, _b]);
    expect(find.text('Görüntüleyici · Demo Çiftlik'), findsOneWidget);

    await tester.tap(find.text('İşletme değiştir'));
    await tester.pumpAndSettle();
    expect(find.text('Operatör'), findsOneWidget, reason: 'her işletmede rolü');
    await tester.tap(find.text('Yayla Çiftliği'));
    await tester.pumpAndSettle();

    expect(auth.switched, ['t2']);
    expect(find.text('canlı'), findsOneWidget, reason: 'canlı sekmeye döner');
  });

  testWidgets('tek işletmede düğme yok', (tester) async {
    await _pump(tester, const [_a]);
    expect(find.text('İşletme değiştir'), findsNothing);
  });
}
