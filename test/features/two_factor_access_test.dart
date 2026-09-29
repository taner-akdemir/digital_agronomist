import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/team_member.dart';
import 'package:milktrace/data/push/push_message.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/login_screen.dart';
import 'package:milktrace/features/settings/two_factor_screen.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

/// Parolası doğru, 2FA açık hesap: kod "654321".
class _MfaAuth extends Auth {
  final seconds = <String>[];

  @override
  AuthState build() => AuthState.signedOut;

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async => throw const MfaRequired('tok-1');

  @override
  Future<void> signInSecondFactor({
    required String mfaToken,
    required String code,
  }) async {
    seconds.add('$mfaToken/$code');
    if (code != '654321') {
      throw const ApiException(
        code: 'UNAUTHORIZED',
        message: 'doğrulama kodu hatalı',
        status: 401,
      );
    }
  }
}

void main() {
  test('erişim bitişi: son gün dahil', () {
    final m = TeamMember(
      id: 'u',
      email: 'v@x',
      role: 'tenant_viewer',
      accessUntil: DateTime(2026, 9, 29),
    );
    expect(m.accessExpired(DateTime(2026, 9, 29, 23)), isFalse);
    expect(m.accessExpired(DateTime(2026, 9, 30, 0, 1)), isTrue);
    expect(
      const TeamMember(
        id: 'u',
        email: 'v@x',
        role: 'tenant_viewer',
      ).accessExpired(DateTime(2099)),
      isFalse,
    );
  });

  test('süreli erişim bildirimi Kullanıcılar ekranını açar', () {
    expect(
      PushMessage.fromRemote(
        data: {'type': 'access_ended', 'tenantId': 't'},
      ).route,
      '/settings/team',
    );
  });

  testWidgets('parola sonrası kod adımı; yanlış kodda sunucu mesajı', (
    tester,
  ) async {
    final auth = _MfaAuth();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => auth),
          supportInfoProvider.overrideWith((ref) async => null),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
    await tester.enterText(find.byType(TextFormField).at(0), 'a@ciftlik.tr');
    await tester.enterText(find.byType(TextFormField).at(1), 'parola-123');
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.text('Doğrulama kodu'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, '111111');
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(find.text('doğrulama kodu hatalı'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, '654321');
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(auth.seconds, ['tok-1/111111', 'tok-1/654321']);
  });

  testWidgets('2FA kurulumu: anahtar, kod, yedek kodlar; sonra açık görünür', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 3000);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = MockRepository(latency: Duration.zero);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        ],
        child: const MaterialApp(home: TwoFactorScreen()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kurulumu başlat'));
    await tester.pumpAndSettle();
    expect(find.text('JBSWY3DPEHPK3PXP'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '000000');
    await tester.tap(find.text('Doğrula ve aç'));
    await tester.pumpAndSettle();
    expect(find.textContaining('kod tutmadı'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Doğrula ve aç'));
    await tester.pumpAndSettle();
    expect(find.text('Yedek kodlar'), findsOneWidget);
    expect(find.textContaining('demo0-kod0'), findsOneWidget);

    await tester.tap(find.text('Kaydettim'));
    await tester.pumpAndSettle();
    expect(find.text('İki adımlı doğrulama açık'), findsOneWidget);
  });
}
