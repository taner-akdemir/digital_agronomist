import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/features/history/treatments_card.dart';
import 'package:milktrace/features/live/widgets/live_info_card.dart';
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

Widget _card(SpoutUpdate u) => MaterialApp(
  home: Scaffold(
    body: Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 180,
        child: LiveInfoCard(update: u, title: 'A-1 · Nokta 8'),
      ),
    ),
  ),
);

void main() {
  test('canlı karedeki arınma günü çözülür', () {
    final a = SpoutAnimal.fromJson({
      'id': 'a',
      'earTag': 'TR1',
      'withdrawalUntil': '2026-09-30',
    });
    expect(a.withdrawalUntil, DateTime(2026, 9, 30));
  });

  testWidgets(
    'arınmadaki hayvanın kartı "Sütü ayır" der, küpe satırının yerine',
    (tester) async {
      final held = SpoutAnimal(
        id: 'a',
        earTag: 'TR340000001',
        name: 'Sarıkız',
        withdrawalUntil: DateTime(2026, 9, 30),
      );
      await tester.pumpWidget(
        _card(
          SpoutUpdate(
            sessionId: 's',
            spoutId: 'p',
            animal: held,
          ).copyWith(flowColor: MilkColor.red),
        ),
      );
      final h = tester.getSize(find.byType(LiveInfoCard)).height;
      expect(find.text('Sütü ayır · arınma 30 Eyl'), findsOneWidget);
      expect(find.text('TR340000001'), findsNothing);

      await tester.pumpWidget(
        _card(
          SpoutUpdate(
            sessionId: 's',
            spoutId: 'p',
            animal: held.copyWith(withdrawalUntil: null),
          ).copyWith(flowColor: MilkColor.red),
        ),
      );
      expect(
        tester.getSize(find.byType(LiveInfoCard)).height,
        h,
        reason: 'yükseklik aynı',
      );
    },
  );

  Future<MockRepository> pumpCard(
    WidgetTester tester, {
    required String role,
    DateTime? until,
  }) async {
    final repo = MockRepository(latency: Duration.zero);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
          authProvider.overrideWith(() => _FakeAuth(role)),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: TreatmentsCard(
                animal: Animal(
                  id: 'a1',
                  speciesId: 'cow',
                  earTag: 'TR1',
                  withdrawalUntil: until,
                ),
                today: DateTime(2026, 9, 28),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return repo;
  }

  testWidgets('görüntüleyici (veteriner) tedavi ekler; silemez', (
    tester,
  ) async {
    final repo = await pumpCard(tester, role: 'tenant_viewer');
    expect(find.textContaining('Tedavi kaydı yok'), findsOneWidget);

    await tester.tap(find.text('Tedavi ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('İlaç adını girin.'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'İlaç'),
      'Amoksisilin',
    );
    await tester.tap(find.text('+5 gün'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(() => repo.treatments('a1')))!;
    expect(saved.single.drug, 'Amoksisilin');
    expect(saved.single.withdrawalUntil, DateTime(2026, 10, 3));
    expect(find.text('Amoksisilin'), findsOneWidget);
    expect(
      find.byIcon(Icons.delete_outline),
      findsNothing,
      reason: 'yalnızca sahip siler',
    );
  });

  testWidgets('süren arınma kırmızı bantla', (tester) async {
    await pumpCard(tester, role: 'tenant_owner', until: DateTime(2026, 9, 30));
    expect(
      find.textContaining('Arınmada: sütü 30 Eyl 2026 dahil'),
      findsOneWidget,
    );
  });
}
