import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/history/yield_report.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Repo extends MockRepository {
  _Repo({this.fail})
    : super(
        latency: Duration.zero,
        today: DateTime(2026, 9, 25),
        loadAsset: _disk,
      );

  final ApiException? fail;
  final calls = <(DateTime?, DateTime?)>[];

  @override
  Future<ReportFile> yieldReport({DateTime? from, DateTime? to}) async {
    calls.add((from, to));
    if (fail != null) throw fail!;
    return (name: 'verim.xlsx', bytes: Uint8List.fromList([1, 2]));
  }
}

Future<(_Repo, List<ReportFile>)> _open(
  WidgetTester tester, {
  ApiException? fail,
}) async {
  final repo = _Repo(fail: fail);
  final shared = <ReportFile>[];
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        reportSharerProvider.overrideWithValue((f) async => shared.add(f)),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () => showYieldReportSheet(context),
              child: const Text('aç'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('aç'));
  await tester.pumpAndSettle();
  return (repo, shared);
}

void main() {
  testWidgets('dönem seçilir, rapor iner ve paylaşılır', (tester) async {
    final (repo, shared) = await _open(tester);
    expect(find.text('Son 7 gün'), findsOneWidget);
    expect(find.text('Son 90 gün'), findsOneWidget);

    await tester.tap(find.text('Son 30 gün'));
    await tester.pumpAndSettle();

    final (from, to) = repo.calls.single;
    expect(to!.difference(from!).inDays, 29, reason: 'bugün dahil 30 gün');
    expect(shared.single.name, 'verim.xlsx');
    expect(find.text('Verim raporu'), findsNothing, reason: 'pencere kapanır');
  });

  testWidgets('hata backend mesajıyla pencerede kalır', (tester) async {
    final (_, shared) = await _open(
      tester,
      fail: const ApiException(
        code: 'VALIDATION',
        message: 'rapor en çok 92 gün olabilir',
        status: 422,
      ),
    );
    await tester.tap(find.text('Son 90 gün'));
    await tester.pumpAndSettle();
    expect(find.text('rapor en çok 92 gün olabilir'), findsOneWidget);
    expect(shared, isEmpty);
  });
}
