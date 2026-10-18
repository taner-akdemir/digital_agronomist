import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/data/models/assistant.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/assistant/assistant_providers.dart';
import 'package:milktrace/features/assistant/assistant_screen.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

class _SignedIn extends Auth {
  _SignedIn([this.role = 'tenant_viewer']);
  final String role;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'vet@milktrace.local',
      fullName: 'Veteriner',
      role: role,
      tenantId: 't1',
    ),
  );
}

class _NoPush extends PushRegistration {
  @override
  Future<PushStatus> build() async => PushStatus.unavailable;
}

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

/// Sahte asistan: durumu ve cevabı test belirler.
class _Repo extends MockRepository {
  _Repo({bool enabled = true, this.statusError = false})
    : super(latency: Duration.zero) {
    assistantEnabled = enabled;
  }

  final bool statusError;
  int? failWith;

  @override
  Future<AssistantStatus> assistantStatus() async {
    if (statusError) throw StateError('ağ yok');
    return super.assistantStatus();
  }

  @override
  Future<AssistantReply> askAssistant(List<AssistantMessage> messages) async {
    if (failWith case final status?) {
      final req = RequestOptions(path: '/assistant/messages');
      throw DioException(
        requestOptions: req,
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: req,
          statusCode: status,
          data: {
            'error': {'code': 'x', 'message': 'sunucu'},
          },
        ),
      );
    }
    return super.askAssistant(messages);
  }
}

List<Override> _overrides(
  MockRepository repo,
  _MemoryStore store, {
  String role = 'tenant_viewer',
  List<Uri>? opened,
  SupportInfo? support,
}) => [
  authProvider.overrideWith(() => _SignedIn(role)),
  pushRegistrationProvider.overrideWith(_NoPush.new),
  repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
  supportInfoProvider.overrideWith((ref) async => support),
  settingsStoreProvider.overrideWithValue(store),
  supportLauncherProvider.overrideWithValue((uri) async {
    opened?.add(uri);
    return true;
  }),
];

Future<void> _openSheet(
  WidgetTester tester,
  MockRepository repo, {
  String role = 'tenant_viewer',
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: _overrides(repo, _MemoryStore(), role: role),
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
}

Future<void> _openScreen(
  WidgetTester tester,
  MockRepository repo,
  _MemoryStore store, {
  List<Uri>? opened,
  SupportInfo? support,
}) async {
  final router = GoRouter(
    initialLocation: '/assistant',
    routes: [
      GoRoute(path: '/live', builder: (_, _) => const Text('canlı')),
      GoRoute(path: '/assistant', builder: (_, _) => const AssistantScreen()),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: _overrides(repo, store, opened: opened, support: support),
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _ask(WidgetTester tester, String text) async {
  await tester.enterText(find.byKey(const Key('assistantInput')), text);
  await tester.pump();
  await tester.tap(find.byKey(const Key('assistantSend')));
  await tester.pumpAndSettle();
}

void main() {
  group('hesap kartı → Yardım', () {
    testWidgets('asistan açıksa "Asistan" satırı görünür', (tester) async {
      await _openSheet(tester, _Repo());
      expect(find.text('Yardım'), findsOneWidget);
      expect(find.byKey(const Key('accountAssistant')), findsOneWidget);
    });

    testWidgets('kapalıysa satır yok', (tester) async {
      await _openSheet(tester, _Repo(enabled: false));
      expect(find.byKey(const Key('accountAssistant')), findsNothing);
      expect(find.text('Asistan'), findsNothing);
    });

    testWidgets('durum okunamazsa satır yok', (tester) async {
      await _openSheet(tester, _Repo(statusError: true));
      expect(find.byKey(const Key('accountAssistant')), findsNothing);
    });

    test('mandıra kullanıcısında durum hiç sorulmaz', () async {
      final repo = _Repo();
      final c = ProviderContainer(
        overrides: _overrides(repo, _MemoryStore(), role: 'dairy_viewer'),
      );
      addTearDown(c.dispose);
      expect(await c.read(assistantStatusProvider.future), isNull);
    });
  });

  testWidgets('ilk kullanımda bilgilendirme; onay cihaza yazılır', (
    tester,
  ) async {
    final store = _MemoryStore();
    final opened = <Uri>[];
    await _openScreen(tester, _Repo(), store, opened: opened);

    expect(find.textContaining("Anthropic'e iletilir"), findsOneWidget);
    await tester.tap(find.text('Gizlilik politikası'));
    await tester.pumpAndSettle();
    expect(opened.single.path, '/gizlilik');

    await tester.tap(find.text('Anladım'));
    await tester.pumpAndSettle();
    expect(store.values[AssistantNoticeAck.key], isTrue);
    expect(find.textContaining("Anthropic'e iletilir"), findsNothing);
  });

  testWidgets('onaylanmışsa bilgilendirme yeniden çıkmaz', (tester) async {
    final store = _MemoryStore()..values[AssistantNoticeAck.key] = true;
    await _openScreen(tester, _Repo(), store);
    expect(find.textContaining("Anthropic'e iletilir"), findsNothing);
    expect(find.text('Bugün kalan soru: 10'), findsOneWidget);
  });

  testWidgets('soru gider, cevap kaynak çipiyle gelir, yeni konuşma siler', (
    tester,
  ) async {
    final repo = _Repo();
    final opened = <Uri>[];
    final store = _MemoryStore()..values[AssistantNoticeAck.key] = true;
    await _openScreen(tester, repo, store, opened: opened);

    await _ask(tester, 'Sağım nasıl başlatılır?');

    expect(find.text('Sağım nasıl başlatılır?'), findsOneWidget);
    expect(find.textContaining('Yardım merkezine bakın'), findsOneWidget);
    expect(find.text('Kaynaklar'), findsOneWidget);
    expect(find.text('Bugün kalan soru: 9'), findsOneWidget);
    expect(
      repo.assistantRequests.single.single.text,
      'Sağım nasıl başlatılır?',
    );

    // Kaynak çipi sitedeki makaleyi dış tarayıcıda açar.
    await tester.tap(find.widgetWithText(ActionChip, 'Sağım'));
    await tester.pumpAndSettle();
    expect(opened.single.path, '/yardim/sagim');

    // İkinci soru geçmişin tamamıyla gider.
    await _ask(tester, 'Peki bitirmek?');
    expect(repo.assistantRequests.last.map((m) => m.role), [
      'user',
      'assistant',
      'user',
    ]);

    await tester.tap(find.byKey(const Key('assistantNewConversation')));
    await tester.pumpAndSettle();
    expect(find.text('Sağım nasıl başlatılır?'), findsNothing);
    expect(find.textContaining('nasıl kullanıldığını sorun'), findsOneWidget);
  });

  testWidgets('devretme: numara yoksa yardım merkezine yönlendirir', (
    tester,
  ) async {
    final repo = _Repo()
      ..assistantAnswer = (_) =>
          const AssistantReply(text: 'Bunu bilmiyorum.', handoff: true);
    final store = _MemoryStore()..values[AssistantNoticeAck.key] = true;
    await _openScreen(tester, repo, store);

    await _ask(tester, 'Fatura?');
    expect(find.byKey(const Key('assistantHandoff')), findsOneWidget);
    expect(find.text('Yardım merkezini aç'), findsOneWidget);
    expect(find.text('WhatsApp'), findsNothing);
  });

  testWidgets('devretme: destek numarası varsa WhatsApp ve Ara', (
    tester,
  ) async {
    final repo = _Repo()
      ..assistantAnswer = (_) =>
          const AssistantReply(text: 'Destek ekibine yazın.', handoff: true);
    final store = _MemoryStore()..values[AssistantNoticeAck.key] = true;
    await _openScreen(
      tester,
      repo,
      store,
      support: (phone: '+905551112233', whatsapp: '+905551112233'),
    );

    await _ask(tester, 'Bir insanla konuşmak istiyorum');
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('Ara'), findsOneWidget);
    expect(find.text('Yardım merkezini aç'), findsNothing);
  });

  testWidgets('429: dostça mesaj ve giriş kapanır', (tester) async {
    final repo = _Repo()..failWith = 429;
    final store = _MemoryStore()..values[AssistantNoticeAck.key] = true;
    await _openScreen(tester, repo, store);

    await _ask(tester, 'Soru');
    expect(find.textContaining('Bugünkü soru hakkınız doldu'), findsOneWidget);
    final field = tester.widget<TextField>(
      find.byKey(const Key('assistantInput')),
    );
    expect(field.enabled, isFalse);
  });

  testWidgets('19 mesajda giriş kapanır ve ipucu çıkar', (tester) async {
    final repo = _Repo()..assistantRemaining = 50;
    final store = _MemoryStore()..values[AssistantNoticeAck.key] = true;
    await _openScreen(tester, repo, store);

    for (var i = 0; i < 10; i++) {
      await _ask(tester, 'soru $i');
    }
    expect(repo.assistantRequests.last, hasLength(19));
    expect(find.textContaining('en uzun hâline ulaştı'), findsOneWidget);
    final field = tester.widget<TextField>(
      find.byKey(const Key('assistantInput')),
    );
    expect(field.enabled, isFalse);
  });
}
