import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/milking_schedule.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/delete_account.dart';
import 'package:milktrace/features/settings/milking_schedule_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

class _Auth extends Auth {
  int signOuts = 0;

  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u',
      email: 'a@b.c',
      fullName: 'X',
      role: 'tenant_owner',
    ),
  );

  @override
  Future<void> signOut() async {
    signOuts++;
    state = AuthState.signedOut;
  }
}

/// Parolası "dogru-parola" olan hesap; tek sahip ise 409.
class _Repo extends MockRepository {
  _Repo({this.soleOwner = false}) : super(latency: Duration.zero);

  final bool soleOwner;
  final deleted = <String>[];

  @override
  Future<void> deleteMyAccount(String password) async {
    if (password != 'dogru-parola') {
      throw const ApiException(
        code: 'UNAUTHORIZED',
        message: 'parola hatalı',
        status: 401,
      );
    }
    if (soleOwner) {
      throw const ApiException(
        code: 'CONFLICT',
        message:
            'Yayla işletmesinin tek sahibisiniz; hesabı silmek için destekle iletişime geçin',
        status: 409,
      );
    }
    deleted.add(password);
  }
}

Future<_Auth> _pumpDelete(WidgetTester tester, _Repo repo) async {
  final auth = _Auth();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => auth),
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showDeleteAccount(context),
              child: const Text('sil'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('sil'));
  await tester.pumpAndSettle();
  return auth;
}

void main() {
  testWidgets(
    'parolasız ve yanlış parolayla silinmez; doğrusuyla silinir, çıkılır',
    (tester) async {
      final repo = _Repo();
      final auth = await _pumpDelete(tester, repo);

      await tester.tap(find.text('Kalıcı olarak sil'));
      await tester.pumpAndSettle();
      expect(find.text('Onay için parolanızı girin.'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'yanlis');
      await tester.tap(find.text('Kalıcı olarak sil'));
      await tester.pumpAndSettle();
      expect(find.text('parola hatalı'), findsOneWidget);
      expect(auth.signOuts, 0);

      await tester.enterText(find.byType(TextField), 'dogru-parola');
      await tester.tap(find.text('Kalıcı olarak sil'));
      await tester.pumpAndSettle();
      expect(repo.deleted, ['dogru-parola']);
      expect(auth.signOuts, 1);
      expect(find.byType(AlertDialog), findsNothing);
    },
  );

  testWidgets('tek sahip: sunucunun mesajı, pencere açık kalır', (
    tester,
  ) async {
    final auth = await _pumpDelete(tester, _Repo(soleOwner: true));
    await tester.enterText(find.byType(TextField), 'dogru-parola');
    await tester.tap(find.text('Kalıcı olarak sil'));
    await tester.pumpAndSettle();
    expect(find.textContaining('tek sahibisiniz'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(auth.signOuts, 0);
  });

  testWidgets('sağım saatleri: akşam kapatılır, gecikme değişir, kaydedilir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = MockRepository(latency: Duration.zero);
    await tester.runAsync(
      () => repo.setMilkingSchedule(
        const MilkingSchedule(morningAt: '06:00', eveningAt: '17:30'),
      ),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        ],
        child: const MaterialApp(home: MilkingScheduleScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('06:00'), findsOneWidget);
    expect(find.text('17:30'), findsOneWidget);

    await tester.tap(find.byType(Switch).last);
    await tester.pumpAndSettle();
    expect(find.text('Kapalı'), findsOneWidget);

    await tester.tap(find.text('45 dk'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('60 dk').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(repo.milkingSchedule))!;
    expect(saved, const MilkingSchedule(morningAt: '06:00', graceMinutes: 60));
    expect(find.text('Sağım saatleri kaydedildi'), findsOneWidget);
  });
}
