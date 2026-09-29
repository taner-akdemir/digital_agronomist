import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/data/models/quiet_hours.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/settings/quiet_hours_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<MockRepository> _pump(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 2400);
  addTearDown(tester.view.resetPhysicalSize);
  final repo = MockRepository(latency: Duration.zero);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      child: const MaterialApp(home: QuietHoursScreen()),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  test('dakika etiketi ve gövde', () {
    expect(minuteLabel(22 * 60), '22:00');
    expect(minuteLabel(5 * 60 + 7), '05:07');
    expect(const QuietHours(enabled: true).toJson(), {
      'enabled': true,
      'startMinute': 1320,
      'endMinute': 300,
    });
  });

  test('kanal gövdesi eskalasyonu yalnızca verilince taşır', () {
    const base = NotificationChannelDraft(
      name: 'x',
      kind: 'email',
      provider: 'smtp',
      config: {},
      recipients: [],
      minSeverity: 'warning',
      sendResolved: true,
      enabled: true,
      sources: ['ops'],
    );
    expect(base.toJson().containsKey('escalationMinutes'), isFalse);
    const sms = NotificationChannelDraft(
      name: 'x',
      kind: 'sms',
      provider: 'netgsm',
      config: {},
      recipients: [],
      minSeverity: 'critical',
      sendResolved: true,
      enabled: true,
      sources: ['ops'],
      escalationMinutes: 0,
    );
    expect(sms.toJson()['escalationMinutes'], 0);
  });

  testWidgets('kapalı açılır, varsayılan saat görünür; açılıp kaydedilir', (
    tester,
  ) async {
    final repo = await _pump(tester);
    expect(find.text('22:00'), findsOneWidget);
    expect(find.text('05:00'), findsOneWidget);
    expect(find.textContaining('Kritik uyarılar'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(repo.quietHours))!;
    expect(saved, const QuietHours(enabled: true));
    expect(find.text('Sessiz saat kaydedildi'), findsOneWidget);
  });

  testWidgets('başlangıç ve bitiş aynıysa kaydedilmez', (tester) async {
    final repo = await _pump(tester);
    await tester.runAsync(
      () =>
          repo.setQuietHours(const QuietHours(startMinute: 60, endMinute: 60)),
    );
    await tester.pumpWidget(const SizedBox());
    final again = await _pumpWith(tester, repo);
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('Başlangıç ve bitiş aynı olamaz.'), findsOneWidget);
    final saved = (await tester.runAsync(again.quietHours))!;
    expect(saved.enabled, isFalse);
  });
}

Future<MockRepository> _pumpWith(
  WidgetTester tester,
  MockRepository repo,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      child: const MaterialApp(home: QuietHoursScreen()),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}
