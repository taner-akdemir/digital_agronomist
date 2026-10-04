import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/audit/audit_screen.dart';
import 'package:milktrace/features/dairy/dairy_sharing_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

void main() {
  // Backend ADR 0137: veri varsayılan gizli; açık rıza kutusu
  // işaretlenmeden onay verilemez; iptal tek dokunuş.
  testWidgets('mandıraya açık rızayla onay verilir ve iptal edilir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1600, 5000);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = MockRepository(latency: Duration.zero, loadAsset: _disk);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        ],
        child: const MaterialApp(home: DairySharingScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Hiçbir mandıraya veri paylaşmıyorsunuz.'),
      findsOneWidget,
    );
    expect(find.textContaining('Hayvan adı, küpe'), findsOneWidget);

    await tester.tap(find.text('Mandıra ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mandıra'), warnIfMissed: false);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yayla Süt · Konya').last);
    await tester.pumpAndSettle();

    final grant = find.widgetWithText(FilledButton, 'Onay ver');
    expect(
      tester.widget<FilledButton>(grant).onPressed,
      isNull,
      reason: 'rıza kutusu işaretlenmeden kapalı',
    );
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(grant).onPressed, isNotNull);
    await tester.tap(grant);
    await tester.pumpAndSettle();

    expect(find.text('Yayla Süt · Konya'), findsOneWidget);
    expect(find.textContaining('Bitiş:'), findsOneWidget, reason: '1 yıl');
    await tester.tap(find.widgetWithText(TextButton, 'İptal et'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'İptal et'));
    await tester.pumpAndSettle();
    expect(
      find.text('Hiçbir mandıraya veri paylaşmıyorsunuz.'),
      findsOneWidget,
    );
    expect(find.textContaining('İptal edildi:'), findsOneWidget);
  });

  test('mandıra hesabı ve işlem kaydı etiketleri', () {
    const u = AuthUser(
      id: 'u',
      email: 'm@x',
      fullName: '',
      role: 'dairy_viewer',
    );
    expect(u.isDairy, isTrue);
    expect(
      auditActionLabel('dairy_share.grant'),
      'Mandıra paylaşımı onaylandı',
    );
  });
}
