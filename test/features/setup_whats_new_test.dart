import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/milking_schedule.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/onboarding/setup_checklist.dart';
import 'package:milktrace/features/whats_new/whats_new.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Mem implements SettingsStore {
  final values = <String, Object?>{};

  @override
  Future<bool?> readBool(String key) async => values[key] as bool?;
  @override
  Future<void> writeBool(String key, bool value) async => values[key] = value;
  @override
  Future<String?> readString(String key) async => values[key] as String?;
  @override
  Future<void> writeString(String key, String? value) async =>
      values[key] = value;
}

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
      tenantId: 't1',
    ),
  );
}

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  String role = 'tenant_owner',
  MockRepository? repo,
  _Mem? store,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => _As(role)),
        repositoryProvider.overrideWith(
          (ref) =>
              (repo ?? MockRepository(latency: Duration.zero, loadAsset: _disk))
                  as MilkTraceRepository,
        ),
        settingsStoreProvider.overrideWithValue(store ?? _Mem()),
      ],
      child: MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('kurulum listesi: yapılanlar işaretli; kapatılınca kaybolur', (
    tester,
  ) async {
    final store = _Mem();
    final repo = MockRepository(latency: Duration.zero, loadAsset: _disk);
    await _pump(tester, const SetupChecklistCard(), repo: repo, store: store);
    expect(find.textContaining('Kuruluma başlayın'), findsOneWidget);
    expect(find.text('Sağım saatlerini girin'), findsOneWidget);
    final unchecked = tester.widget<Icon>(
      find
          .descendant(
            of: find.widgetWithText(ListTile, 'Sağım saatlerini girin'),
            matching: find.byType(Icon),
          )
          .first,
    );
    expect(unchecked.icon, Icons.radio_button_unchecked);

    await tester.runAsync(
      () => repo.setMilkingSchedule(const MilkingSchedule(morningAt: '06:00')),
    );
    await tester.pumpWidget(const SizedBox());
    await _pump(tester, const SetupChecklistCard(), repo: repo, store: store);
    final done = tester.widget<Icon>(
      find
          .descendant(
            of: find.widgetWithText(ListTile, 'Sağım saatlerini girin'),
            matching: find.byType(Icon),
          )
          .first,
    );
    expect(done.icon, Icons.check_circle);

    await tester.tap(find.byTooltip('Listeyi kapat'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Kuruluma başlayın'), findsNothing);
    expect(store.values['setup.dismissed.t1'], isTrue);
  });

  testWidgets('kurulum listesi yalnızca sahibe', (tester) async {
    await _pump(tester, const SetupChecklistCard(), role: 'tenant_operator');
    expect(find.textContaining('Kuruluma başlayın'), findsNothing);
  });

  testWidgets('yenilikler: ilk kurulumda yok, güncellemede bir kez', (
    tester,
  ) async {
    final store = _Mem();
    await _pump(
      tester,
      const WhatsNewListener(child: Text('kabuk')),
      store: store,
    );
    expect(find.text('Yenilikler'), findsNothing, reason: 'ilk kurulum');
    expect(store.values['whatsNew.seen'], whatsNewId);

    store.values['whatsNew.seen'] = 'eski';
    await tester.pumpWidget(const SizedBox());
    await _pump(
      tester,
      const WhatsNewListener(child: Text('kabuk')),
      store: store,
    );
    expect(find.text('Yenilikler'), findsOneWidget);
    expect(find.textContaining('Karanlık tema'), findsOneWidget);
    await tester.tap(find.text('Tamam'));
    await tester.pumpAndSettle();

    await tester.pumpWidget(const SizedBox());
    await _pump(
      tester,
      const WhatsNewListener(child: Text('kabuk')),
      store: store,
    );
    expect(find.text('Yenilikler'), findsNothing, reason: 'bir kez');
  });
}
