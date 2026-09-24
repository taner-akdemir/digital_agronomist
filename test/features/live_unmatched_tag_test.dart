import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/features/live/widgets/animal_picker.dart';
import 'package:milktrace/features/live/widgets/live_info_card.dart';
import 'package:milktrace/providers/repository_providers.dart';

const _unknown = UnmatchedTag(
  rfid: '982000123456789',
  reason: 'unknown',
  message: 'küpe 982000123456789 kayıtlı değil',
);

SpoutUpdate _update({SpoutAnimal? animal, UnmatchedTag? tag}) => SpoutUpdate(
  sessionId: 's',
  spoutId: 'p',
  animal: animal,
  unmatchedTag: tag,
);

/// Kart doğal yüksekliğinde çizilir.
///
/// Canlı ekranda kart yüksekliği SABİT (252). Test fontu gerçek fonttan
/// uzun olduğu için mutlak taşma burada ölçülemiyor; ölçüt görelidir: yeni
/// hâller bugünkü en uzun karttan (adlı hayvan + "Düşük Debi") uzun
/// olmamalı.
Widget _card(SpoutUpdate u) => MaterialApp(
  home: Scaffold(
    body: Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 180,
        child: LiveInfoCard(update: u, title: 'A-1 · Nokta 8'),
      ),
    ),
  ),
);

Future<double> _height(WidgetTester tester, SpoutUpdate u) async {
  await tester.pumpWidget(_card(u));
  return tester.getSize(find.byType(LiveInfoCard)).height;
}

const _named = SpoutAnimal(id: 'a', earTag: 'TR340000001', name: 'Sarıkız');

void main() {
  testWidgets('tanınmayan küpe hayvansız kartta sebebiyle görünür', (
    tester,
  ) async {
    await tester.pumpWidget(_card(_update(tag: _unknown)));

    expect(find.text('Tanınmayan küpe'), findsOneWidget);
    expect(find.text('küpe 982000123456789 kayıtlı değil'), findsOneWidget);
    expect(find.text('Hayvan eşleştirilmedi'), findsNothing);
  });

  testWidgets(
    'önceki hayvan sağılırken yeni küpe küpe satırının yerine geçer',
    (tester) async {
      await tester.pumpWidget(_card(_update(animal: _named, tag: _unknown)));

      expect(find.text('Sarıkız'), findsOneWidget);
      expect(find.text('küpe 982000123456789 kayıtlı değil'), findsOneWidget);
      expect(find.text('TR340000001'), findsNothing);
    },
  );

  testWidgets('uyarı yoksa kart eskisi gibi', (tester) async {
    await tester.pumpWidget(_card(_update()));

    expect(find.text('Hayvan eşleştirilmedi'), findsOneWidget);
    expect(find.text('Tanınmayan küpe'), findsNothing);
  });

  testWidgets('yeni hâller en uzun karttan uzun değil', (tester) async {
    final tallest = await _height(
      tester,
      _update(animal: _named).copyWith(flowColor: MilkColor.red),
    );
    final bare = await _height(tester, _update(tag: _unknown));
    final named = await _height(
      tester,
      _update(animal: _named, tag: _unknown).copyWith(flowColor: MilkColor.red),
    );

    expect(bare, lessThanOrEqualTo(tallest));
    expect(named, tallest, reason: 'küpe satırının YERİNE geçer, eklenmez');
  });

  group('seçici', () {
    Future<void> open(WidgetTester tester, UnmatchedTag? tag) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repositoryProvider.overrideWith(
              (ref) =>
                  MockRepository(
                        latency: Duration.zero,
                        loadAsset: (p) async => File(p).readAsStringSync(),
                      )
                      as MilkTraceRepository,
            ),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => showAnimalPicker(
                    context,
                    spoutLabel: 'A-1 · Nokta 8',
                    alreadyAssigned: const {},
                    unmatched: tag,
                  ),
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

    testWidgets('okunan küpeyi ve ne yapılacağını başta söyler', (
      tester,
    ) async {
      await open(tester, _unknown);
      expect(
        find.text(
          'küpe 982000123456789 kayıtlı değil. Hayvanı aşağıdan seçin.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('sağmal olmayan hayvanın listede olmadığını söyler', (
      tester,
    ) async {
      await open(
        tester,
        const UnmatchedTag(
          rfid: '900000000000001',
          reason: 'not_milking',
          message: 'TR001 sağmal değil (kuruda)',
        ),
      );
      expect(
        find.textContaining('TR001 sağmal değil (kuruda): listede yok.'),
        findsOneWidget,
      );
    });

    testWidgets('uyarı yoksa kutu yok', (tester) async {
      await open(tester, null);
      expect(find.byIcon(Icons.nfc), findsNothing);
    });
  });
}
