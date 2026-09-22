import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/dashboard/dashboard_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

/// Öğlen: sabah sağımı olmuş, akşam sağımı olmamış.
final _noon = DateTime(2026, 9, 22, 12);

/// Asset'i diskten okur; gerekçesi history_screen_test'te.
Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

Widget wrap(Widget child, {DateTime? today}) => ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => MockRepository(
              latency: Duration.zero,
              today: today ?? _noon,
              loadAsset: _diskAsset,
            ) as MilkTraceRepository),
      ],
      child: MaterialApp(home: Scaffold(body: child)),
    );

void main() {
  // Dört kart varsayılan 800x600 test yüzeyine sığmıyor ve alttakiler hiç
  // build edilmiyordu (ListView yalnızca görüneni kurar). Telefon boyu bir
  // yüzey veriliyor.
  Future<void> pumpDashboard(WidgetTester tester, {DateTime? today}) async {
    tester.view.physicalSize = const Size(1200, 4800);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(wrap(const DashboardScreen(), today: today));
    await tester.pumpAndSettle();
  }

  testWidgets('günün özeti, tür ve sınıf dağılımı çizilir', (tester) async {
    await pumpDashboard(tester);

    expect(find.text('Bugün toplanan süt'), findsOneWidget);
    expect(find.textContaining('sağım · '), findsOneWidget);
    expect(find.textContaining('İnek · '), findsOneWidget);
    expect(find.text(YieldClass.dryOffCandidate.label), findsOneWidget);
  });

  // NORMAL sınıfın burada GÖSTERİLDİĞİNİ doğrular.
  //
  // Hayvan listesinde normal rozetsizdir (§6.4) ama dağılımda sayısı
  // olmadan yüzdeler toplamı anlamsız kalır.
  testWidgets('sınıf dağılımı normal sınıfı da sayar', (tester) async {
    await pumpDashboard(tester);

    expect(find.text(YieldClass.normal.label), findsOneWidget);
    expect(find.text('Verim sınıfları · 30 hayvan'), findsOneWidget);
  });

  testWidgets('açık uyarılar özetlenir ve tümüne geçiş sunulur',
      (tester) async {
    await pumpDashboard(tester);

    expect(find.text('Açık uyarılar'), findsOneWidget);
    expect(find.textContaining('düşük debiyle sağılıyor'), findsOneWidget);
    // Fixture'da 5 açık uyarı var, 3'ü gösteriliyor.
    expect(find.text('2 uyarı daha'), findsOneWidget);
    expect(find.text('Tümü'), findsOneWidget);
  });

  // Gün başında "sağım yok" denmesini doğrular: boş tür listesi yerine
  // sıfır litre ve sebebi yazan bir satır görünmeli.
  testWidgets('gün başında sağım yok mesajı çıkar', (tester) async {
    await pumpDashboard(tester, today: DateTime(2026, 9, 22));

    expect(find.text('Bugün henüz sağım yapılmadı'), findsOneWidget);
    expect(find.text('0.0'), findsOneWidget);
  });
}
