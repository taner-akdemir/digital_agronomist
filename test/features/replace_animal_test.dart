import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/live/live_providers.dart';
import 'package:milktrace/features/live/widgets/animal_picker.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// Çağrıların SIRASINI kaydeden depo.
class _Recording extends MockRepository {
  _Recording() : super(latency: Duration.zero, loadAsset: _disk);
  final calls = <String>[];

  @override
  Future<void> unassignAnimal({
    required String sessionId,
    required String spoutId,
  }) async {
    calls.add('unassign $spoutId');
    await super.unassignAnimal(sessionId: sessionId, spoutId: spoutId);
  }

  @override
  Future<void> assignAnimal({
    required String sessionId,
    required String spoutId,
    required String animalId,
  }) async {
    calls.add('assign $spoutId $animalId');
    await super.assignAnimal(
      sessionId: sessionId,
      spoutId: spoutId,
      animalId: animalId,
    );
  }
}

void main() {
  group('replace', () {
    Future<List<String>> run(bool discard) async {
      final repo = _Recording();
      final c = ProviderContainer(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        ],
      );
      addTearDown(c.dispose);
      // autoDispose: dinlenmezse await sırasında atılırdı (ekranda tahta
      // dinliyor).
      c.listen(milkingControlProvider, (_, _) {});
      await c
          .read(milkingControlProvider.notifier)
          .replace(
            sessionId: 's',
            spoutId: 'p',
            animalId: 'a2',
            discardPrevious: discard,
          );
      return repo.calls;
    }

    test('yanlış eşleştirme: önce kaldırılır, sonra bağlanır', () async {
      expect(await run(true), ['unassign p', 'assign p a2']);
    });

    test('önceki sağıldı: yalnızca bağlanır (backend kapatır)', () async {
      expect(await run(false), ['assign p a2']);
    });
  });

  group('askReplace', () {
    Future<ReplaceChoice?> ask(WidgetTester tester, String button) async {
      ReplaceChoice? got;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () async => got = await askReplace(
                  context,
                  previous: const SpoutAnimal(
                    id: 'a1',
                    earTag: 'TR340000001',
                    name: 'Sarıkız',
                  ),
                  volumeMl: 4200,
                ),
                child: const Text('aç'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('aç'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Sarıkız (TR340000001)'), findsOneWidget);
      expect(find.textContaining('4.2 L'), findsOneWidget);
      await tester.tap(find.text(button));
      await tester.pumpAndSettle();
      return got;
    }

    testWidgets('sağıldı', (tester) async {
      expect(await ask(tester, 'Sağıldı'), ReplaceChoice.milked);
    });
    testWidgets('yanlış eşleştirme', (tester) async {
      expect(await ask(tester, 'Yanlış eşleştirme'), ReplaceChoice.mistaken);
    });
    testWidgets('vazgeç', (tester) async {
      expect(await ask(tester, 'Vazgeç'), isNull);
    });
  });
}
