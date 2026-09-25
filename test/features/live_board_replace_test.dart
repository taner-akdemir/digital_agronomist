import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/live/live_board_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

const _spout1 = '0192a1f0-0050-7000-8000-000000000001';

/// Çağrı sırasını kaydeden, canlı akışı hiç bitmeyen depo. Mock'un akışı
/// 2 sn'de bir kare üreten sonsuz döngü; testte pumpAndSettle oturmazdı.
class _Board extends MockRepository {
  _Board({this.zeroVolume = false})
    : super(latency: Duration.zero, loadAsset: _disk);

  /// Nokta 1'in ölçümü sıfır: sağım yeni başlamış.
  final bool zeroVolume;
  final calls = <String>[];

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) =>
      StreamController<SpoutUpdate>().stream;

  @override
  Future<LiveSession> liveSession({required String hallId}) async {
    final live = await super.liveSession(hallId: hallId);
    if (!zeroVolume) return live;
    return live.copyWith(
      updates: [
        for (final u in live.updates)
          u.spoutId == _spout1 ? u.copyWith(volumeMl: 0) : u,
      ],
    );
  }

  @override
  Future<void> unassignAnimal({
    required String sessionId,
    required String spoutId,
  }) async {
    calls.add('unassign ${spoutId.substring(spoutId.length - 3)}');
    await super.unassignAnimal(sessionId: sessionId, spoutId: spoutId);
  }

  @override
  Future<void> assignAnimal({
    required String sessionId,
    required String spoutId,
    required String animalId,
  }) async {
    calls.add('assign ${spoutId.substring(spoutId.length - 3)}');
    await super.assignAnimal(
      sessionId: sessionId,
      spoutId: spoutId,
      animalId: animalId,
    );
  }
}

/// Nokta 1'e (Sarıkız) dokunur ve boştaki Gelin'i seçer.
Future<void> _pickGelin(WidgetTester tester, _Board repo) async {
  tester.view.physicalSize = const Size(1600, 4000);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
      ],
      // Test fontu gerçek fonttan uzun ve sabit yükseklikli kart taşıyordu
      // (bkz. live_unmatched_tag_test); burada sınanan kart değil akış.
      child: MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(0.8)),
          child: child!,
        ),
        home: const Scaffold(body: LiveBoardScreen()),
      ),
    ),
  );
  await tester.pumpAndSettle();

  await tester.tap(find.text('Sarıkız'));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField), 'TR340000008');
  await tester.pumpAndSettle();
  await tester.tap(find.text('Gelin'));
  await tester.pumpAndSettle();
}

void main() {
  // Backend ADR 0053, "sonradan eklenen".
  testWidgets('ölçüm varken sorulur; yanlış eşleştirme önce kaldırır', (
    tester,
  ) async {
    final repo = _Board();
    await _pickGelin(tester, repo);

    expect(find.text('Önceki hayvan sağıldı mı?'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.textContaining('10.4 L'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Yanlış eşleştirme'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['unassign 001', 'assign 001']);
  });

  testWidgets('sağıldı: yalnızca bağlanır', (tester) async {
    final repo = _Board();
    await _pickGelin(tester, repo);
    await tester.tap(find.text('Sağıldı'));
    await tester.pumpAndSettle();
    expect(repo.calls, ['assign 001']);
  });

  testWidgets('vazgeçilirse hiçbir şey olmaz', (tester) async {
    final repo = _Board();
    await _pickGelin(tester, repo);
    await tester.tap(find.text('Vazgeç'));
    await tester.pumpAndSettle();
    expect(repo.calls, isEmpty);
  });

  testWidgets('ölçüm yoksa sormadan temizlenir', (tester) async {
    final repo = _Board(zeroVolume: true);
    await _pickGelin(tester, repo);
    expect(find.text('Önceki hayvan sağıldı mı?'), findsNothing);
    expect(repo.calls, ['unassign 001', 'assign 001']);
  });
}
