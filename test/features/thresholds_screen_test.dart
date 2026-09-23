import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/settings/thresholds_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

/// Asset'i diskten okur; gerekçesi history_screen_test'te.
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

late MockRepository repo;
late ProviderContainer container;

Future<void> pumpScreen(
  WidgetTester tester, {
  String role = 'tenant_owner',
}) async {
  repo = MockRepository(latency: Duration.zero, loadAsset: _diskAsset);
  container = ProviderContainer(
    overrides: [
      repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      authProvider.overrideWith(() => _FakeAuth(role)),
    ],
  );
  addTearDown(container.dispose);

  // Form uzun; ListView yalnızca görüneni kurduğu için Kaydet düğmesi
  // kısa yüzeyde hiç build edilmiyordu.
  tester.view.physicalSize = const Size(1200, 7500);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: ThresholdsScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

/// Kaydet düğmesine basar.
///
/// ensureVisible ŞART: form uzun ve düğme test yüzeyinin biraz altında
/// kalıyor; doğrudan tap() "off-screen" diye düşüyordu.
Future<void> tapSave(WidgetTester tester) async {
  final finder = find.widgetWithText(FilledButton, 'Kaydet');
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Etikete göre alanın metnini değiştirir.
Future<void> enter(WidgetTester tester, String label, String value) async {
  await tester.enterText(find.widgetWithText(TextFormField, label), value);
  await tester.pumpAndSettle();
}

void main() {
  // §6.5'in kalibrasyon notunun EKRANDA durduğunu doğrular.
  //
  // Doküman bunu açıkça istiyor: değerler tahmini başlangıç değerleri ve
  // kullanıcıya böyle gösterilmeli.
  testWidgets('kalibrasyon uyarısı gösterilir', (tester) async {
    await pumpScreen(tester);

    expect(
      find.textContaining('tahmini başlangıç değerleridir'),
      findsOneWidget,
    );
  });

  testWidgets('her tür için ayrı sekme açılır', (tester) async {
    await pumpScreen(tester);

    expect(find.text('İnek'), findsOneWidget);
    expect(find.text('Keçi'), findsOneWidget);
    expect(find.text('Koyun'), findsOneWidget);
  });

  // Owner OLMAYANIN düzenleyemediğini ama GÖREBİLDİĞİNİ doğrular.
  //
  // Gizlemek, sağımdaki "bu kırmızı neden kırmızı?" sorusunu cevapsız
  // bırakırdı.
  testWidgets('owner olmayan görür ama kaydedemez', (tester) async {
    await pumpScreen(tester, role: 'tenant_operator');

    expect(find.textContaining('yalnızca işletme sahibi'), findsOneWidget);
    expect(find.text('Alt eşik'), findsWidgets);

    final save = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Kaydet'),
    );
    expect(save.onPressed, isNull);
  });

  testWidgets('owner kaydedebilir', (tester) async {
    await pumpScreen(tester);

    final save = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Kaydet'),
    );
    expect(save.onPressed, isNotNull);
  });

  // BANT SIRASININ doğrulandığını gösterir.
  //
  // Alt eşik üst eşiği geçerse renk motoru hiçbir zaman sarı üretmez ve
  // bant sessizce kaybolurdu (§6.2).
  testWidgets('alt eşik üst eşiği geçemez', (tester) async {
    await pumpScreen(tester);

    await enter(tester, 'Alt eşik', '5');

    expect(find.text('Üst eşikten küçük olmalı'), findsOneWidget);

    await tapSave(tester);

    expect(
      repo.thresholdWrites,
      isEmpty,
      reason: 'geçersiz form kaydedilmemeli',
    );
  });

  testWidgets('verim yüzdesi 100ü geçemez', (tester) async {
    await pumpScreen(tester);

    await enter(tester, 'Yeşil eşiği', '120');

    expect(find.text('En çok 100 olabilir'), findsOneWidget);
  });

  // Litre girip mL kaydedildiğini doğrular (§3 birim kuralı).
  testWidgets('geçerli değerler mL olarak kaydedilir', (tester) async {
    await pumpScreen(tester);

    await enter(tester, 'Alt eşik', '1.2');
    await enter(tester, 'Kuruya çıkma alt eşiği', '9');

    await tapSave(tester);

    final saved = repo.thresholdWrites.single;
    expect(saved.flowLow, 1.2);
    expect(saved.dryOffDailyMl, 9000);
  });

  // Kaydedilen değerin OKUMADA da göründüğünü doğrular: canlı ekranın renk
  // aynası aynı listeden besleniyor.
  testWidgets('kaydedilen eşik listeden de okunur', (tester) async {
    await pumpScreen(tester);

    await enter(tester, 'Alt eşik', '1.4');
    await tapSave(tester);

    final list = await container.read(thresholdsListProvider.future);
    expect(
      list
          .firstWhere(
            (t) => t.speciesId == repo.thresholdWrites.single.speciesId,
          )
          .flowLow,
      1.4,
    );
  });
}
