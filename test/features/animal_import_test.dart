import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/animal_import.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/history/animal_import_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// Backend'in raporunu taklit eder ve çağrıları kaydeder.
class _Repo extends MockRepository {
  _Repo({this.fail})
    : super(
        latency: Duration.zero,
        today: DateTime(2026, 9, 25),
        loadAsset: _disk,
      );

  final ApiException? fail;
  final calls = <({bool dryRun, String? speciesId, int bytes})>[];

  @override
  Future<AnimalImportReport> importAnimals(
    List<int> file, {
    String? speciesId,
    required bool dryRun,
  }) async {
    calls.add((dryRun: dryRun, speciesId: speciesId, bytes: file.length));
    if (fail != null) throw fail!;
    return AnimalImportReport(
      dryRun: dryRun,
      total: 4,
      create: 2,
      exists: 1,
      errors: 1,
      ignoredColumns: const ['Anne Küpe'],
      rows: const [
        AnimalImportRow(line: 2, earTag: 'TR340000001', outcome: 'exists'),
        AnimalImportRow(
          line: 3,
          earTag: 'TR340000002',
          name: 'Sarıkız',
          outcome: 'create',
        ),
        AnimalImportRow(
          line: 4,
          earTag: 'A-17',
          outcome: 'create',
          warning: 'küpe numarası TR ile başlayan bir numara değil',
        ),
        AnimalImportRow(
          line: 5,
          earTag: 'TR340000004',
          outcome: 'error',
          message: 'tür tanınmadı ("at")',
        ),
      ],
    );
  }
}

Future<_Repo> _open(WidgetTester tester, {ApiException? fail}) async {
  tester.view.physicalSize = const Size(1200, 6000);
  addTearDown(tester.view.resetPhysicalSize);
  final repo = _Repo(fail: fail);
  final router = GoRouter(
    initialLocation: '/import',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) => const Scaffold(body: Text('liste')),
        routes: [
          GoRoute(
            path: 'import',
            builder: (_, _) => const AnimalImportScreen(),
          ),
        ],
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        importFilePickerProvider.overrideWithValue(
          () async => (name: 'surum.xlsx', bytes: List.filled(10, 0)),
        ),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('önizleme yazmaz, sonuçları gösterir; onay ekler', (
    tester,
  ) async {
    final repo = await _open(tester);
    expect(find.text('Türü yazılmamış satırlar'), findsOneWidget);
    expect(find.text('İnek'), findsOneWidget, reason: 'varsayılan tür inek');

    await tester.tap(find.text('Dosya seç'));
    await tester.pumpAndSettle();

    expect(repo.calls.single.dryRun, isTrue);
    expect(repo.calls.single.bytes, 10);
    expect(repo.calls.single.speciesId, isNotNull);
    expect(find.text('surum.xlsx'), findsOneWidget);
    expect(find.text('2 eklenecek'), findsOneWidget);
    expect(find.text('1 zaten kayıtlı'), findsOneWidget);
    expect(find.text('1 hatalı, atlanacak'), findsOneWidget);
    expect(find.text('Alınmayan sütunlar: Anne Küpe'), findsOneWidget);
    expect(find.text('tür tanınmadı ("at")'), findsOneWidget);
    expect(
      find.text('küpe numarası TR ile başlayan bir numara değil'),
      findsOneWidget,
    );
    expect(find.text('TR340000002 · Sarıkız'), findsOneWidget);

    await tester.tap(find.text('2 hayvanı ekle'));
    await tester.pumpAndSettle();
    expect(repo.calls.last.dryRun, isFalse);
    expect(find.text('2 hayvan eklendi'), findsOneWidget);
    expect(find.text('liste'), findsOneWidget, reason: 'ekran kapanır');
  });

  testWidgets('dosya hatası backend mesajıyla görünür, ekle düğmesi yok', (
    tester,
  ) async {
    await _open(
      tester,
      fail: const ApiException(
        code: 'VALIDATION',
        message: 'küpe numarası sütunu bulunamadı',
        status: 422,
      ),
    );
    await tester.tap(find.text('Dosya seç'));
    await tester.pumpAndSettle();
    expect(find.text('küpe numarası sütunu bulunamadı'), findsOneWidget);
    expect(find.textContaining('hayvanı ekle'), findsNothing);
  });
}
