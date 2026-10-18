import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/cache/cache_store.dart';
import 'package:milktrace/data/models/animal_note.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/data/write_queue/pending_write.dart';
import 'package:milktrace/data/write_queue/write_sender.dart';
import 'package:milktrace/features/write_queue/pending_writes.dart';
import 'package:milktrace/features/write_queue/pending_writes_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/offline_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/write_queue_providers.dart';

final _now = DateTime.utc(2026, 10, 18, 6);

/// Not ucu: [offline] iken sunucuya ulaşılamaz.
class _Repo extends MockRepository {
  _Repo() : super(latency: Duration.zero);

  bool offline = true;
  final sent = <String>[];

  @override
  Future<AnimalNote> addAnimalNote(
    String animalId,
    String note, {
    String? idempotencyKey,
  }) async {
    if (offline) {
      throw DioException(
        requestOptions: RequestOptions(path: '/x'),
        type: DioExceptionType.connectionError,
      );
    }
    sent.add(note);
    return AnimalNote(id: 'n', animalId: animalId, note: note, createdAt: _now);
  }
}

class _Auth extends Auth {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'op@x.tr',
      fullName: 'Op',
      role: 'tenant_operator',
      tenantId: 't1',
    ),
  );
}

PendingWrite _note(String id, String text, {bool failed = false}) =>
    PendingWrite(
      id: id,
      kind: PendingKind.note,
      animalId: 'a1',
      subject: 'TR-101',
      payload: PendingPayload.note(text),
      createdAt: _now,
      state: failed ? PendingState.failed : PendingState.pending,
      failure: failed ? PendingFailure.rejected : null,
      error: failed ? 'hayvan bulunamadı' : null,
      failedAt: failed ? _now : null,
    );

Future<_Repo> _pump(WidgetTester tester, List<PendingWrite> seed) async {
  final store = MemoryCacheStore()
    ..values['mtqueue:v1:t1:u1'] = jsonEncode([
      for (final w in seed) w.toJson(),
    ]);
  final repo = _Repo();
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, _) => const Scaffold(
          body: Column(
            children: [
              PendingWritesBanner(),
              PendingWritesStrip(animalId: 'a1', kinds: {PendingKind.note}),
              PendingWritesStrip(
                animalId: 'a2',
                kinds: {PendingKind.note},
                key: Key('a2'),
              ),
            ],
          ),
        ),
      ),
      GoRoute(
        path: pendingWritesRoute,
        builder: (_, _) => const PendingWritesScreen(),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(_Auth.new),
        cacheStoreProvider.overrideWithValue(store),
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        writeQueueClockProvider.overrideWithValue(() => _now),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('kuyruk boşken gösterge yok', (tester) async {
    await _pump(tester, const []);
    expect(find.byType(Badge), findsNothing);
    expect(find.textContaining('bekliyor'), findsNothing);
  });

  testWidgets('gösterge bekleyen ve gönderilemeyeni sayar, ekranı açar', (
    tester,
  ) async {
    await _pump(tester, [
      _note('w1', 'Topallık'),
      _note('w2', 'Mastitis', failed: true),
    ]);
    expect(
      find.text('1 kayıt gönderilmeyi bekliyor · 1 kayıt gönderilemedi'),
      findsOneWidget,
    );

    // Hayvanın kartında iyimser satırlar: açıkça işaretli.
    final a1 = find.byType(PendingWritesStrip).first;
    expect(
      find.descendant(of: a1, matching: find.text('Bekliyor')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: a1, matching: find.text('Gönderilemedi')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('a2')),
        matching: find.byType(PendingChip),
      ),
      findsNothing,
      reason: 'başka hayvanın kartında görünmez',
    );

    await tester.tap(find.textContaining('gönderilmeyi bekliyor'));
    await tester.pumpAndSettle();
    expect(find.text('Gönderilmeyi bekleyenler'), findsOneWidget);
    expect(find.text('Gönderilemeyenler'), findsOneWidget);
    expect(find.text('TR-101 · Topallık'), findsOneWidget);
    expect(find.text('hayvan bulunamadı'), findsOneWidget);
    expect(find.text('Şimdi gönder'), findsOneWidget);
  });

  testWidgets('gönderilemeyen onayla silinir', (tester) async {
    await _pump(tester, [_note('w2', 'Mastitis', failed: true)]);
    await tester.tap(find.textContaining('gönderilemedi').first);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(TextButton, 'Sil'));
    await tester.pumpAndSettle();
    expect(find.text('Kayıt silinsin mi?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Sil'));
    await tester.pumpAndSettle();

    expect(find.text('Gönderilmeyi bekleyen kayıt yok.'), findsOneWidget);
  });

  testWidgets('yeniden dene: bağlantı varsa kuyruk sırayla gider', (
    tester,
  ) async {
    final repo = await _pump(tester, [
      _note('w1', 'Topallık'),
      _note('w2', 'Mastitis', failed: true),
    ]);
    await tester.tap(find.textContaining('gönderilmeyi bekliyor'));
    await tester.pumpAndSettle();

    repo.offline = false;
    await tester.tap(find.text('Yeniden dene'));
    await tester.pumpAndSettle();

    // Sıra korunur: önce bekleyen, sonra yeniden denenen.
    expect(repo.sent, ['Topallık', 'Mastitis']);
    expect(find.text('Gönderilmeyi bekleyen kayıt yok.'), findsOneWidget);
  });

  testWidgets('bağlantı dönünce kuyruk boşaltılır', (tester) async {
    final repo = await _pump(tester, [_note('w1', 'Topallık')]);
    expect(find.text('Bekliyor'), findsOneWidget);
    repo.offline = false;
    final container = ProviderScope.containerOf(
      tester.element(find.byType(PendingWritesBanner)),
    );
    container.read(offlineStatusProvider.notifier)
      ..offline(_now)
      ..online();
    await tester.pumpAndSettle();
    expect(repo.sent, ['Topallık']);
    expect(find.text('Bekliyor'), findsNothing);
  });
}
