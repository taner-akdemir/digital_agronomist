import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
