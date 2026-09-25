import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/alerts/alerts_providers.dart';
import 'package:milktrace/features/alerts/alerts_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

final _today = DateTime(2026, 9, 22);

/// Asset'i diskten okur; gerekçesi history_screen_test'te.
Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

MockRepository _repo() => MockRepository(
  latency: Duration.zero,
  today: _today,
  loadAsset: _diskAsset,
);

late ProviderContainer _container;

Widget wrap(Widget child) => UncontrolledProviderScope(
  container: _container,
  child: MaterialApp(home: child),
);

void main() {
  setUp(() {
    _container = ProviderContainer(
      overrides: [
        repositoryProvider.overrideWith(
          (ref) => _repo() as MilkTraceRepository,
        ),
      ],
    );
  });
  tearDown(() => _container.dispose());

  // AÇIK uyarıların okunmuşların ÜSTÜNDE olduğunu doğrular.
  //
  // Düz zaman sıralaması, dün okunmuş bir uyarıyı bu sabahki açık uyarının
  // üstüne koyabilirdi.
  testWidgets('açık uyarılar üstte, okunmuşlar altta', (tester) async {
    await tester.pumpWidget(wrap(const AlertsScreen()));
    await tester.pumpAndSettle();

    final okundu = find.text('Okundu').evaluate().length;
    expect(okundu, 5, reason: 'fixture\'da bir uyarı okunmuş gelir');

    final texts = tester
        .widgetList<Text>(find.byType(Text))
        .map((t) => t.data ?? '')
        .toList();
    final firstAcked = texts.indexWhere((t) => t.endsWith('· okundu'));
    final lastOpen = texts.lastIndexWhere((t) => t == 'Okundu');

    expect(firstAcked, greaterThan(lastOpen));
  });

  // "Okundu" düğmesinin GERÇEKTEN bir şey yaptığını doğrular.
  // Geri gelen sayacın uyarısı açık kalır ama "geri geldi" saati görünür
  // (backend ADR 0041). Saat Europe/Istanbul: 18:29Z → 21:29.
  testWidgets('geri gelen sayaç uyarısında dönüş saati görünür', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const AlertsScreen()));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.textContaining('geri geldi'), 200);
    expect(find.textContaining('· geri geldi 21:29'), findsOneWidget);
  });

  testWidgets('okundu işaretlenen uyarı listeden düşer ve sayaç azalır', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const AlertsScreen()));
    await tester.pumpAndSettle();

    final before = _container.read(openAlertCountProvider);
    expect(before, 5);

    await tester.tap(find.text('Okundu').first);
    await tester.pumpAndSettle();

    expect(find.text('Okundu'), findsNWidgets(before - 1));
    expect(_container.read(openAlertCountProvider), before - 1);
  });

  // Onayın SUNUCUYA da gittiğini doğrular: yalnızca ekranda işaretlenseydi
  // liste tazelendiğinde uyarı geri gelirdi.
  testWidgets('onay kaynağa yazılır, tazelemede geri gelmez', (tester) async {
    await tester.pumpWidget(wrap(const AlertsScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Okundu').first);
    await tester.pumpAndSettle();

    _container.invalidate(alertListProvider);
    await tester.pumpAndSettle();

    expect(find.text('Okundu'), findsNWidgets(4));
  });

  testWidgets('uyarı metni backend\'den geldiği gibi gösterilir', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const AlertsScreen()));
    await tester.pumpAndSettle();

    expect(find.textContaining('düşük debiyle sağılıyor'), findsOneWidget);
  });

  // Sayaç hatası "geri gelmez", düzelir (backend ADR 0058).
  test('çözülen sayaç hatası "düzeldi", çevrimdışı "geri geldi" yazar', () {
    Alert a(String type) => Alert(
      id: 'a',
      type: type,
      severity: 'warning',
      message: 'm',
      createdAt: DateTime.utc(2026, 9, 21, 18, 0),
      resolvedAt: DateTime.utc(2026, 9, 21, 18, 29),
    );
    expect(alertTimeLabel(a('device_error')), contains('düzeldi 21:29'));
    expect(alertTimeLabel(a('device_offline')), contains('geri geldi 21:29'));
  });
}
