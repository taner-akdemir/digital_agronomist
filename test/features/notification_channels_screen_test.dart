import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/settings/notification_channel_form_screen.dart';
import 'package:milktrace/features/settings/notification_channels_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

class _FakeAuth extends Auth {
  _FakeAuth(this.role);

  final String role;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'a@b.c',
      fullName: 'Demo',
      role: role,
      tenantId: 't1',
    ),
  );
}

/// Güncellemeleri kaydeden mock: formun sunucuya NE gönderdiğini görmek için.
class RecordingRepo extends MockRepository {
  RecordingRepo() : super(latency: Duration.zero, loadAsset: _diskAsset);

  final updates = <NotificationChannelDraft>[];

  @override
  Future<NotificationChannel> updateNotificationChannel(
    String id,
    NotificationChannelDraft draft,
  ) {
    updates.add(draft);
    return super.updateNotificationChannel(id, draft);
  }
}

late RecordingRepo repo;

Future<void> pumpApp(
  WidgetTester tester, {
  String role = 'tenant_owner',
  String initial = '/settings/notifications',
}) async {
  repo = RecordingRepo();
  final container = ProviderContainer(
    overrides: [
      repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      authProvider.overrideWith(() => _FakeAuth(role)),
    ],
  );
  addTearDown(container.dispose);

  tester.view.physicalSize = const Size(1200, 6000);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final router = GoRouter(
    initialLocation: initial,
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, _) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => showAccountSheet(context),
              child: const Text('hesap'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/settings/thresholds',
        builder: (_, _) => const SizedBox(),
      ),
      GoRoute(
        path: '/settings/notifications',
        builder: (_, _) => const NotificationChannelsScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (_, s) => NotificationChannelFormScreen(
              kind: s.uri.queryParameters['kind'],
              provider: s.uri.queryParameters['provider'],
            ),
          ),
          GoRoute(
            path: ':id',
            builder: (_, s) => NotificationChannelFormScreen(
              channelId: s.pathParameters['id'],
            ),
          ),
        ],
      ),
    ],
  );

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  // Kanallar alıcı telefonlarını ve API anahtarlarını taşır; backend diğer
  // rollere 403 döner. Düğme hiç görünmemeli.
  testWidgets('hesap kartında kanallar yalnızca işletme sahibine', (
    tester,
  ) async {
    await pumpApp(tester, initial: '/home');
    await tester.tap(find.text('hesap'));
    await tester.pumpAndSettle();
    expect(find.text('Bildirim kanalları'), findsOneWidget);

    await pumpApp(tester, role: 'tenant_operator', initial: '/home');
    await tester.tap(find.text('hesap'));
    await tester.pumpAndSettle();
    expect(find.text('Bildirim kanalları'), findsNothing);
  });

  testWidgets('liste demo kanalı gösterir', (tester) async {
    await pumpApp(tester);
    expect(find.text('Çiftlik e-postası'), findsOneWidget);
    expect(find.textContaining('SMTP'), findsOneWidget);
    expect(find.textContaining('Uyarı ve üstü'), findsOneWidget);
    expect(find.textContaining('Her sürü uyarısı'), findsOneWidget);
  });

  testWidgets('SMS kanalı eklenir; numara uluslararası biçimde olmalı', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('Kanal ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ActionChip, 'NetGSM').first);
    await tester.pumpAndSettle();

    expect(find.text('Yeni kanal'), findsOneWidget);
    // SMS varsayılanı yalnızca kritik.
    final seg = tester.widget<SegmentedButton<String>>(
      find.byType(SegmentedButton<String>),
    );
    expect(seg.selected, {'critical'});

    Finder field(String label) =>
        find.widgetWithText(TextFormField, label).first;
    await tester.enterText(field('Telefon numaraları'), '05321112233');
    await tester.enterText(field('Kullanıcı kodu *'), '8501112233');
    await tester.enterText(field('Parola *'), 'gizli');
    await tester.enterText(field('SMS başlığı *'), 'MILKTRACE');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Uluslararası biçimde olmalı'),
      findsOneWidget,
      reason: 'yerel biçim reddedilmeli',
    );

    await tester.enterText(field('Telefon numaraları'), '+905321112233');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    // Mock gecikmesi Future.delayed; widget testinin sahte saatinde
    // beklenirse hiç tamamlanmaz. Gerçek zamanda okunur.
    final channels = (await tester.runAsync(repo.notificationChannels))!;
    final sms = channels.firstWhere((c) => c.kind == 'sms');
    expect(sms.recipients, ['+905321112233']);
    expect(sms.secrets, {'password': true});
    expect(sms.minSeverity, 'critical');
    expect(
      sms.sources,
      ['ops', 'summary'],
      reason:
          'varsayılan: sistem alarmları + sağım özeti; her uyarı ayrı değil',
    );
  });

  // Sırlar sunucudan gelmez; boş bırakılan sır alanı GÖNDERİLMEZ, yoksa
  // kayıtlı parola silinirdi.
  testWidgets('düzenlemede boş sır gönderilmez ve korunur', (tester) async {
    await pumpApp(
      tester,
      initial: '/settings/notifications/0192a1f0-00a0-7000-8000-000000000001',
    );
    expect(find.text('Kanalı düzenle'), findsOneWidget);
    expect(find.textContaining('Kayıtlı. Değiştirmek için'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Kanal adı').first,
      'Sahip e-postası',
    );
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final sent = repo.updates.single;
    expect(sent.name, 'Sahip e-postası');
    expect(sent.config.containsKey('password'), isFalse);
    final after = (await tester.runAsync(repo.notificationChannels))!.single;
    expect(after.secrets['password'], isTrue);
  });
}
