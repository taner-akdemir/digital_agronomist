import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/live/live_board_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Board extends MockRepository {
  _Board() : super(latency: Duration.zero, loadAsset: _disk);

  final calls = <String>[];

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) =>
      StreamController<SpoutUpdate>().stream;

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

void main() {
  // Backend ADR 0136: boş nokta önceki sıradan önerilir; önizlemeden tek
  // dokunuşla eşleştirilir.
  testWidgets('Grubu aynen onayla boş noktayı önerir ve eşleştirir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1600, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = _Board();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith(
            (ref) => repo as MilkTraceRepository,
          ),
        ],
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

    final button = find.textContaining('Grubu aynen onayla (');
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.textContaining('Gelin'), findsWidgets);
    await tester.tap(find.textContaining('Onayla ('));
    await tester.pumpAndSettle();

    expect(repo.calls, contains('assign 008'));
    expect(find.textContaining('nokta eşleştirildi'), findsOneWidget);
  });
}
