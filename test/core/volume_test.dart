import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/species.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/live/widgets/live_info_card.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

class _UnitRepo extends MockRepository {
  _UnitRepo() : super(latency: Duration.zero);
  final units = <String>[];

  @override
  Future<void> setVolumeUnit(String unit) async => units.add(unit);
}

class _FakeAuth extends Auth {
  _FakeAuth(this.role);
  final String role;
  final applied = <String>[];

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(id: 'u', email: 'a@b.c', fullName: 'X', role: role),
  );

  @override
  Future<void> applyVolumeUnit(String unit) async => applied.add(unit);
}

void main() {
  test('litre ve kilogram; yoğunluk tür kimliği ya da koduyla', () {
    const l = VolumeFormat.litre;
    expect(l.amount(10400), '10.4 L');

    final kg = VolumeFormat.from(
      'kg',
      const [
        Thresholds(
          speciesId: 'sp-goat',
          flowLow: 1,
          flowHigh: 2,
          milkDensity: 1.05,
        ),
      ],
      const [Species(id: 'sp-goat', code: 'goat', nameTr: 'Keçi')],
    );
    expect(kg.amount(10000, species: 'sp-goat'), '10.5 kg');
    expect(kg.amount(10000, species: 'goat'), '10.5 kg', reason: 'kodla da');
    expect(kg.amount(10000), '10.3 kg', reason: 'tür bilinmiyorsa 1,03');
    expect(kg.label, 'kg');
  });

  testWidgets('canlı kart kilogram gösterir', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            child: LiveInfoCard(
              update: SpoutUpdate(
                sessionId: 's',
                spoutId: 'p',
                volumeMl: 8400,
                expectedMl: 11000,
                animal: SpoutAnimal(id: 'a', earTag: 'TR1', species: 'cow'),
              ),
              title: 'A-1',
              volume: VolumeFormat(unit: 'kg', density: {'cow': 1.03}),
            ),
          ),
        ),
      ),
    );
    expect(find.text('8.7 kg'), findsOneWidget);
    expect(find.text('11.3 kg'), findsOneWidget);
  });

  Future<(_UnitRepo, _FakeAuth)> openSheet(
    WidgetTester tester,
    String role,
  ) async {
    final repo = _UnitRepo();
    final auth = _FakeAuth(role);
    tester.view.physicalSize = const Size(1200, 4000);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => auth),
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
          supportInfoProvider.overrideWith((ref) async => null),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showAccountSheet(context),
                child: const Text('aç'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('aç'));
    await tester.pumpAndSettle();
    return (repo, auth);
  }

  testWidgets('sahip süt birimini kilogram yapar', (tester) async {
    final (repo, auth) = await openSheet(tester, 'tenant_owner');
    await tester.tap(find.text('Kilogram'));
    await tester.pumpAndSettle();
    expect(repo.units, ['kg']);
    expect(auth.applied, ['kg']);
  });

  testWidgets('operatör birim seçimini görmez', (tester) async {
    await openSheet(tester, 'tenant_operator');
    expect(find.text('Süt birimi'), findsNothing);
  });
}
