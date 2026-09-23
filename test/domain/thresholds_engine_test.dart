import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/thresholds.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/domain/thresholds_engine.dart';

/// Renk kurallarının Go tarafındakiyle AYNI vakalardan geçtiğini doğrular.
///
/// test/fixtures/color_cases.json, backend'deki
/// common/milkrules/testdata/color_cases.json'ın BAYT-BİREBİR kopyasıdır.
/// İki dosya ayrışırsa backend'in gönderdiği renk ile uygulamanın çizdiği
/// renk farklılaşır — ve bu, kullanıcının aldığı push uyarısıyla ekranda
/// gördüğü rengin çelişmesi demektir.
void main() {
  final raw = File('test/fixtures/color_cases.json').readAsStringSync();
  final fixture = jsonDecode(raw) as Map<String, dynamic>;

  final thresholds = <String, Thresholds>{
    for (final e in (fixture['thresholds'] as Map<String, dynamic>).entries)
      e.key: Thresholds.fromJson({
        'speciesId': e.key,
        ...e.value as Map<String, dynamic>,
      }),
  };

  MilkColor colorOf(String name) => MilkColor.values.byName(name);

  group('flowColor golden', () {
    for (final c in fixture['flowCases'] as List<dynamic>) {
      final tc = c as Map<String, dynamic>;
      final input = tc['input'] as Map<String, dynamic>;

      test(tc['name'] as String, () {
        final got = ThresholdsEngine.flowColor(
          flowLpm: (input['flowLpm'] as num).toDouble(),
          elapsedSec: input['elapsedSec'] as int,
          volumeMl: input['volumeMl'] as int,
          expectedMl: input['expectedMl'] as int,
          attached: input['attached'] as bool,
          animalAssigned: input['animalAssigned'] as bool,
          t: thresholds[tc['species']]!,
        );
        expect(got, colorOf(tc['want'] as String));
      });
    }
  });

  group('yield golden', () {
    for (final c in fixture['yieldCases'] as List<dynamic>) {
      final tc = c as Map<String, dynamic>;

      test(tc['name'] as String, () {
        final volume = tc['volumeMl'] as int;
        final expected = tc['expectedMl'] as int;
        final t = thresholds[tc['species']]!;

        expect(
          ThresholdsEngine.yieldColor(volume, expected, t),
          colorOf(tc['wantColor'] as String),
        );
        expect(
          ThresholdsEngine.yieldPct(volume, expected),
          closeTo((tc['wantPct'] as num).toDouble(), 1e-9),
        );
      });
    }
  });

  test('fixture üç türü de kapsıyor', () {
    expect(thresholds.keys, containsAll(['cow', 'goat', 'sheep']));
  });

  test('fixture backend kopyasıyla aynı', () {
    // Yol yerel geliştirme kurulumuna göre; CI'da bu kontrol
    // `make check-color-fixture` ile yapılır.
    final backend = File(
      '${Platform.environment['HOME']}/GolandProjects/milktrace/'
      'common/milkrules/testdata/color_cases.json',
    );
    if (!backend.existsSync()) {
      markTestSkipped('backend repo bulunamadı, karşılaştırma atlandı');
      return;
    }
    expect(
      backend.readAsStringSync(),
      raw,
      reason: 'golden fixture ayrışmış — iki taraf farklı renk üretir',
    );
  });
}
