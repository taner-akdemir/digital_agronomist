import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/live/widgets/animal_picker.dart';
import 'package:milktrace/providers/repository_providers.dart';

// Mock sürü: 10 inek (…001–010), 10 keçi (…011–020), 10 koyun (…021–030).
const _cow1 = '0192a1f0-0070-7000-8000-000000000001';
const _goat1 = '0192a1f0-0070-7000-8000-000000000011';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// Yalnızca inekleri döndüren sürü.
class _CowsOnly extends MockRepository {
  _CowsOnly() : super(latency: Duration.zero, loadAsset: _disk);

  @override
  Future<List<Animal>> animals() async => [
    for (final a in await super.animals())
      if (a.id.compareTo('0192a1f0-0070-7000-8000-000000000011') < 0) a,
  ];
}

/// Seçiciyi açar; sonucu [result]'a yazar.
Future<void> _open(
  WidgetTester tester, {
  Set<String> assigned = const {},
  SpoutAnimal? current,
  MilkTraceRepository? repo,
  void Function(AnimalPick?)? onResult,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith(
          (ref) =>
              repo ?? MockRepository(latency: Duration.zero, loadAsset: _disk),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async {
                final r = await showAnimalPicker(
                  context,
                  spoutLabel: 'A-1 · Nokta 1',
                  alreadyAssigned: assigned,
                  current: current,
                );
                onResult?.call(r);
              },
              child: const Text('aç'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('aç'));
  await tester.pumpAndSettle();
}

ChoiceChip _chip(WidgetTester tester, String label) => tester.widget(
  find.ancestor(of: find.text(label), matching: find.byType(ChoiceChip)),
);

/// Listedeki hayvanların alt satırları ("küpe · tür").
List<String> _subtitles(WidgetTester tester) => [
  for (final t in tester.widgetList<ListTile>(find.byType(ListTile)))
    if (t.subtitle case final Text s) s.data!,
];

void main() {
  testWidgets('karışık sürüde tür süzgeci çıkar ve listeyi daraltır', (
    tester,
  ) async {
    await _open(tester);

    expect(_chip(tester, 'Tümü').selected, isTrue, reason: 'eşleşme yok');
    expect(find.byType(ChoiceChip), findsNWidgets(4));

    await tester.tap(find.text('Keçi'));
    await tester.pumpAndSettle();
    expect(_chip(tester, 'Keçi').selected, isTrue);
    final subtitles = _subtitles(tester);
    expect(subtitles, isNotEmpty);
    expect(subtitles.every((s) => s.contains('Keçi')), isTrue);
  });

  testWidgets('oturumdaki hayvanlar tek türse o tür seçili gelir', (
    tester,
  ) async {
    await _open(tester, assigned: {_cow1});
    expect(_chip(tester, 'İnek').selected, isTrue);
    expect(
      _subtitles(tester).every((s) => s.contains('İnek')),
      isTrue,
      reason: 'yalnızca inekler',
    );

    // Kullanıcı seçimi varsayılanı ezer.
    await tester.tap(find.text('Tümü'));
    await tester.pumpAndSettle();
    expect(_chip(tester, 'Tümü').selected, isTrue);
  });

  testWidgets('oturumda karışık tür varsa tümü seçili gelir', (tester) async {
    await _open(tester, assigned: {_cow1, _goat1});
    expect(_chip(tester, 'Tümü').selected, isTrue);
  });

  testWidgets('tek türlü sürüde süzgeç yok', (tester) async {
    await _open(tester, repo: _CowsOnly());
    expect(find.byType(ChoiceChip), findsNothing);
  });

  testWidgets('hayvan seçimi PickAnimal döner', (tester) async {
    AnimalPick? result;
    await _open(tester, onResult: (r) => result = r);

    await tester.tap(find.textContaining('TR340000002').first);
    await tester.pumpAndSettle();
    expect(result, isA<PickAnimal>());
    expect((result! as PickAnimal).animalId, isNotEmpty);
  });

  testWidgets('bağlı hayvan varsa eşleştirme kaldırılabilir', (tester) async {
    AnimalPick? result;
    await _open(
      tester,
      current: const SpoutAnimal(
        id: _cow1,
        earTag: 'TR340000001',
        name: 'Sarıkız',
      ),
      onResult: (r) => result = r,
    );

    expect(find.text('Sarıkız yanlış bağlandıysa'), findsOneWidget);
    await tester.tap(find.text('Eşleştirmeyi kaldır'));
    await tester.pumpAndSettle();
    expect(result, isA<ClearAnimal>());
  });

  testWidgets('boş noktada kaldırma seçeneği yok', (tester) async {
    await _open(tester);
    expect(find.text('Eşleştirmeyi kaldır'), findsNothing);
  });
}
