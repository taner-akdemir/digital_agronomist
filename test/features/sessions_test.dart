import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/app_build.dart';
import 'package:milktrace/data/models/user_session.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/settings/sessions_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

void main() {
  test('uygulama oturumu User-Agent\'tan tanınır', () {
    const app = UserSession(id: 'a', userAgent: 'MilkTrace/1.2.0 (android)');
    expect(app.kind.app, isTrue);
    expect(app.kind.platform, 'android');
    const web = UserSession(id: 'b', userAgent: 'Mozilla/5.0 Chrome');
    expect(web.kind.app, isFalse);
  });

  test('istekler tanınır bir User-Agent taşır', () {
    AppBuild.platform = 'android';
    AppBuild.version = '1.2.0';
    addTearDown(() {
      AppBuild.platform = null;
      AppBuild.version = null;
    });
    expect(AppBuild.headers['User-Agent'], 'MilkTrace/1.2.0 (android)');
    expect(
      const UserSession(
        id: 'x',
        userAgent: 'MilkTrace/1.2.0 (android)',
      ).kind.app,
      isTrue,
      reason: 'sunucuya giden değer listede tanınır',
    );
  });

  testWidgets('bu cihaz işaretli; diğeri kapatılır; hepsi kapatılır', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = MockRepository(latency: Duration.zero);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        ],
        child: const MaterialApp(home: SessionsScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Milk Trace · Android · bu cihaz'), findsOneWidget);
    expect(find.text('Tarayıcı (panel)'), findsOneWidget);
    expect(
      find.byTooltip('Bu oturumu kapat'),
      findsOneWidget,
      reason: 'bu cihazda yok',
    );

    await tester.tap(find.text('Diğer bütün cihazlardan çık'));
    await tester.pumpAndSettle();
    expect(find.text('Tarayıcı (panel)'), findsNothing);
    expect(find.text('Diğer bütün cihazlardan çık'), findsNothing);
    expect((await tester.runAsync(repo.loginSessions))!, hasLength(1));
  });
}
