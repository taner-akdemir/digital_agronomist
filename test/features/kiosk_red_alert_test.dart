import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/milking_session.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/flow_color.dart';
import 'package:milktrace/features/kiosk/kiosk_screen.dart';
import 'package:milktrace/features/live/red_alert.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// Canlı akışı testin sürdüğü depo.
class _Board extends MockRepository {
  _Board() : super(latency: Duration.zero, loadAsset: _disk);

  // ignore: close_sinks, test süresince açık; süreçle kapanır.
  final frames = StreamController<SpoutUpdate>.broadcast();
  LiveSession? first;

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) => frames.stream;

  @override
  Future<LiveSession> liveSession({required String hallId}) async =>
      first = await super.liveSession(hallId: hallId);
}

class _MemStore implements SettingsStore {
  final values = <String, Object?>{};

  @override
  Future<bool?> readBool(String key) async => values[key] as bool?;

  @override
  Future<void> writeBool(String key, bool value) async => values[key] = value;

  @override
  Future<String?> readString(String key) async => values[key] as String?;

  @override
  Future<void> writeString(String key, String? value) async =>
      values[key] = value;
}

class _Auth extends Auth {
  _Auth({required this.kiosk});

  final bool kiosk;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u',
      email: 'tablet@ciftlik.local',
      fullName: 'Sağımhane',
      role: 'tenant_operator',
      kiosk: kiosk,
    ),
  );
}

void main() {
  test('yalnızca sağımdaki ve hayvanlı noktanın yeni kırmızısı', () {
    const a = SpoutAnimal(id: 'a1', earTag: 'TR1');
    SpoutUpdate u(
      String spout,
      MilkColor c, {
      SpoutState s = SpoutState.milking,
    }) => SpoutUpdate(
      sessionId: 's',
      spoutId: spout,
      animal: a,
    ).copyWith(flowColor: c, state: s);
    final seen = <String>{};
    expect(takeNewReds([u('p1', MilkColor.yellow)], seen), isFalse);
    expect(takeNewReds([u('p1', MilkColor.red)], seen), isTrue);
    expect(
      takeNewReds([u('p1', MilkColor.red)], seen),
      isFalse,
      reason: 'bir kez',
    );
    expect(
      takeNewReds([u('p2', MilkColor.red, s: SpoutState.idle)], seen),
      isFalse,
      reason: 'sağımda değil',
    );
    expect(
      takeNewReds([
        const SpoutUpdate(
          sessionId: 's',
          spoutId: 'p3',
        ).copyWith(flowColor: MilkColor.red, state: SpoutState.milking),
      ], seen),
      isFalse,
      reason: 'hayvansız',
    );
  });

  Future<(_Board, List<bool>, _MemStore)> pumpKiosk(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1600, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = _Board();
    final awake = <bool>[];
    final store = _MemStore();
    var rings = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
          authProvider.overrideWith(() => _Auth(kiosk: true)),
          screenAwakeProvider.overrideWith(
            (ref) =>
                (on) async => awake.add(on),
          ),
          settingsStoreProvider.overrideWith((ref) => store),
          redAlertSinkProvider.overrideWith(
            (ref) =>
                () => rings++,
          ),
        ],
        child: MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(0.8)),
            child: child!,
          ),
          home: const KioskScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return (repo, awake, store);
  }

  testWidgets('sağımhane ekranı: ekran açık kalır, sekme yok', (tester) async {
    final (_, awake, _) = await pumpKiosk(tester);
    expect(find.text('Milk Trace · Sağımhane'), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(awake, [true]);
  });

  testWidgets('yeni kırmızıda bir kez çalar; kapatılınca çalmaz', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1600, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = _Board();
    final store = _MemStore();
    var rings = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
          authProvider.overrideWith(() => _Auth(kiosk: true)),
          screenAwakeProvider.overrideWith((ref) => (on) async {}),
          settingsStoreProvider.overrideWith((ref) => store),
          redAlertSinkProvider.overrideWith(
            (ref) =>
                () => rings++,
          ),
        ],
        child: MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(0.8)),
            child: child!,
          ),
          home: const KioskScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(rings, 0, reason: 'açılışta zaten kırmızı olan çalmaz');

    final calm = repo.first!.updates
        .where(
          (u) =>
              u.animal != null &&
              !(u.flowColor == MilkColor.red && u.state == SpoutState.milking),
        )
        .toList();
    expect(calm.length, greaterThanOrEqualTo(2));

    SpoutUpdate red(SpoutUpdate u) =>
        u.copyWith(flowColor: MilkColor.red, state: SpoutState.milking);

    repo.frames.add(red(calm[0]));
    await tester.pumpAndSettle();
    expect(rings, 1);
    repo.frames.add(red(calm[0]));
    await tester.pumpAndSettle();
    expect(rings, 1, reason: 'aynı sağım için bir kez');

    await tester.tap(find.byTooltip('Kırmızı uyarısını kapat'));
    await tester.pumpAndSettle();
    expect(store.values['live.redAlert'], isFalse, reason: 'cihazda saklanır');
    repo.frames.add(red(calm[1]));
    await tester.pumpAndSettle();
    expect(rings, 1, reason: 'kapalıyken çalmaz');
  });

  testWidgets('tablet hesabı her yerden sağımhane ekranına yönlenir', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [authProvider.overrideWith(() => _Auth(kiosk: true))],
    );
    addTearDown(container.dispose);
    final router = container.read(routerProvider);
    router.go('/dashboard');
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: GoRouter(
            // Yalnızca yönlendirme kuralı sınanıyor; ekranlar değil.
            initialLocation: '/dashboard',
            redirect: router.configuration.topRedirect,
            routes: [
              for (final p in ['/dashboard', '/kiosk', '/splash', '/login'])
                GoRoute(path: p, builder: (_, _) => Text(p)),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('/kiosk'), findsOneWidget);
  });
}
