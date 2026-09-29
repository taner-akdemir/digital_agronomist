import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

class _SignedIn extends Auth {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'ciftci@milktrace.local',
      fullName: 'Demo',
      role: 'tenant_operator',
      tenantId: 't1',
    ),
  );
}

/// Push durumunu testin belirlediği kayıt.
class _FixedPush extends PushRegistration {
  _FixedPush(this._status);
  final PushStatus _status;

  @override
  Future<PushStatus> build() async => _status;
}

/// Bellekteki ayar deposu: testte cihaz tercihlerine dokunulmaz.
class _MemoryStore implements SettingsStore {
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

Future<MockRepository> _open(
  WidgetTester tester,
  PushStatus status, {
  _MemoryStore? store,
}) async {
  final repo = MockRepository(latency: Duration.zero)..pushTokens.add('tok-1');
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_SignedIn.new),
        pushRegistrationProvider.overrideWith(() => _FixedPush(status)),
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        supportInfoProvider.overrideWith((ref) async => null),
        settingsStoreProvider.overrideWithValue(store ?? _MemoryStore()),
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
  return repo;
}

void main() {
  // Kayıtlı telefonda test bildirimi düğmesi; basınca sonuç yazar
  // (backend ADR 0048).
  testWidgets('push kayıtlıysa test bildirimi gönderilir', (tester) async {
    await _open(tester, PushStatus.registered);

    expect(find.text('Bu telefona test bildirimi'), findsOneWidget);
    await tester.tap(find.text('Bu telefona test bildirimi'));
    await tester.pumpAndSettle();
    expect(find.text('Test bildirimi gönderildi (1 telefon)'), findsOneWidget);
  });

  // Kapalıysa düğme yok, sebep yazıyor: bildirim gelmeyen kullanıcı bunun
  // beklenen bir durum olduğunu bilsin.
  testWidgets('push kapalıysa sebebi yazar', (tester) async {
    await _open(tester, PushStatus.unavailable);

    expect(find.text('Bu telefona test bildirimi'), findsNothing);
    expect(find.textContaining('Bu telefonda bildirim kapalı'), findsOneWidget);
  });

  // Dil her role açık (backend ADR 0093); seçim sağlayıcıya ve cihaza yazılır.
  testWidgets('dil seçimi İngilizceye geçirir', (tester) async {
    final store = _MemoryStore();
    await _open(tester, PushStatus.unavailable, store: store);

    expect(find.text('Dil'), findsOneWidget);
    expect(find.text('Cihaz dili'), findsOneWidget);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
    );
    expect(container.read(appLanguageProvider), 'en');
    expect(store.values['app.language'], 'en');
  });
}
