import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/widgets/animal_status_chip.dart';
import 'package:milktrace/features/history/widgets/yield_class_badge.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// Fixture'dan [cls] sınıfındaki hayvanı alır, [change] ile değiştirip
/// kaydeder ve detay ekranını AYNI depoyla açar.
Future<void> _open(
  WidgetTester tester,
  YieldClass cls,
  Animal Function(Animal) change,
) async {
  tester.view.physicalSize = const Size(1200, 4000);
  addTearDown(tester.view.resetPhysicalSize);

  final repo = MockRepository(
    latency: Duration.zero,
    today: DateTime(2026, 9, 22),
    loadAsset: _disk,
  );
  final animal = await tester.runAsync(() async {
    final a = (await repo.animals()).firstWhere((a) => a.yieldClass == cls);
    return repo.saveAnimal(change(a));
  });

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      child: MaterialApp(
        home: Scaffold(body: AnimalDetailScreen(animalId: animal!.id)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  // Backend ADR 0055: kuruya çıkan hayvanın etiketi silinmez ama güncel
  // bir değerlendirme gibi de okunmaz.
  testWidgets('sağmal olmayanda sınıf tarihiyle donmuş görünür', (
    tester,
  ) async {
    await _open(
      tester,
      YieldClass.dryOffCandidate,
      (a) => a.copyWith(status: 'dry', yieldClassAt: DateTime.utc(2026, 9, 12)),
    );

    expect(find.byType(YieldClassBadge), findsNothing);
    expect(find.widgetWithText(AnimalStatusChip, 'Kuruda'), findsOneWidget);
    expect(
      find.text(
        'Son sınıf: ${YieldClass.dryOffCandidate.label} '
        '(${Fmt.dayMonthYear(DateTime.utc(2026, 9, 12))})',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('son hesaptan kalmadır'), findsOneWidget);
    // Güncel açıklama ve kesim/veteriner uyarısı YOK.
    expect(find.text(YieldClass.dryOffCandidate.explanation), findsNothing);
    expect(find.textContaining('teşhis değildir'), findsNothing);
  });

  testWidgets('hesap günü bilinmiyorsa tarih yazılmaz', (tester) async {
    await _open(tester, YieldClass.high, (a) => a.copyWith(status: 'sold'));

    expect(find.text('Son sınıf: ${YieldClass.high.label}'), findsOneWidget);
    expect(find.widgetWithText(AnimalStatusChip, 'Satıldı'), findsOneWidget);
  });

  testWidgets('sağmal hayvanın eski sınıfı tarihle işaretlenir', (
    tester,
  ) async {
    final old = DateTime.now().subtract(const Duration(days: 10));
    await _open(tester, YieldClass.high, (a) => a.copyWith(yieldClassAt: old));

    expect(find.byType(YieldClassBadge), findsOneWidget);
    expect(find.textContaining('hesabından: gece hesabı'), findsOneWidget);
  });

  testWidgets('sağmal hayvanın güncel sınıfında not yok', (tester) async {
    final fresh = DateTime.now().subtract(const Duration(days: 1));
    await _open(
      tester,
      YieldClass.high,
      (a) => a.copyWith(yieldClassAt: fresh),
    );

    expect(find.textContaining('hesabından: gece hesabı'), findsNothing);
    expect(find.text(YieldClass.high.explanation), findsOneWidget);
  });
}
