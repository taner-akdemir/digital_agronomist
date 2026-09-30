import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/core/format.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/models/animal_milking.dart';
import 'package:milktrace/data/models/api_key.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/meter_check.dart';
import 'package:milktrace/data/models/milking_speed.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/alerts/alert_style.dart';
import 'package:milktrace/features/audit/audit_screen.dart';
import 'package:milktrace/features/auth/account_sheet.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/features/settings/api_keys_screen.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

final _today = DateTime(2026, 9, 22);

class _User extends Auth {
  _User(this.role);
  final String role;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'x@milktrace.local',
      fullName: 'X',
      role: role,
      tenantId: 't1',
    ),
  );
}

/// Sunucunun cevabı gibi ek veri dönen mock.
class _Repo extends MockRepository {
  _Repo({
    this.summaries,
    this.checks,
    this.speed,
    this.checkError,
    this.firstOngoing = false,
  }) : super(latency: Duration.zero, today: _today, loadAsset: _disk);

  final List<MeterSummary>? summaries;
  final MeterChecks? checks;
  final List<MilkingSpeed>? speed;
  final Object? checkError;

  /// En yeni sağım sürüyor (endedAt yok): sağım sırasında açılan detay.
  final bool firstOngoing;

  @override
  Future<List<AnimalMilking>> animalHistory(
    String animalId, {
    DateTime? from,
    DateTime? to,
  }) async {
    final list = await super.animalHistory(animalId, from: from, to: to);
    if (!firstOngoing || list.isEmpty) return list;
    return [list.first.copyWith(endedAt: null), ...list.skip(1)];
  }

  @override
  Future<List<MeterSummary>> meterSummaries() async =>
      summaries ?? await super.meterSummaries();

  @override
  Future<MeterChecks> meterChecks(String deviceId) async =>
      checks ?? await super.meterChecks(deviceId);

  @override
  Future<List<MilkingSpeed>> milkingSpeed() async =>
      speed ?? await super.milkingSpeed();

  @override
  Future<MeterCheckResult> addMeterCheck(String milkingId, int manualMl) {
    if (checkError case final e?) return Future.error(e);
    return super.addMeterCheck(milkingId, manualMl);
  }
}

class _MemoryStore implements SettingsStore {
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

Future<void> _pumpDetail(
  WidgetTester tester,
  MilkTraceRepository repo,
  String animalId, {
  String role = 'tenant_owner',
}) async {
  tester.view.physicalSize = const Size(1200, 6000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final router = GoRouter(
    initialLocation: '/history/animal/$animalId',
    routes: [
      GoRoute(
        path: '/history/animal/:id',
        builder: (_, s) => Scaffold(
          body: AnimalDetailScreen(animalId: s.pathParameters['id']!),
        ),
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => _User(role)),
        repositoryProvider.overrideWith((ref) => repo),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('JSON', () {
    test('kontrol cevabı: kontrol ve özet', () {
      final r = MeterCheckResult.fromJson({
        'check': {
          'id': 'c1',
          'milkingId': 'm1',
          'deviceId': 'd1',
          'earTag': '',
          'meteredMl': 10800,
          'manualMl': 10000,
          'deviationPct': 8.0,
          'createdAt': '2026-09-29T06:10:00Z',
        },
        'summary': {
          'deviceId': 'd1',
          'serialNo': 'SN-1',
          'checks': 3,
          'avgDeviationPct': 8.0,
          'needsCalibration': true,
        },
      });
      expect(r.check.meteredMl, 10800);
      expect(r.check.deviationPct, 8.0);
      expect(r.summary.needsCalibration, isTrue);
      expect(r.summary.serialNo, 'SN-1');
      expect(signedPct(r.check.deviationPct), '+8.0');
      expect(signedPct(-3.4), '-3.4');
    });

    test('sayaç listesi: özet ve kontroller, eksik alanlar varsayılan', () {
      final c = MeterChecks.fromJson({
        'summary': {'deviceId': 'd1', 'serialNo': '', 'checks': 0},
        'items': [
          {
            'id': 'c1',
            'milkingId': 'm1',
            'earTag': 'TR1',
            'meteredMl': 9000,
            'manualMl': 10000,
            'deviationPct': -10,
            'authorName': 'Ali',
            'createdAt': '2026-09-29T06:10:00Z',
          },
        ],
      });
      expect(c.summary.avgDeviationPct, 0);
      expect(c.items.single.deviationPct, -10.0);
      expect(c.items.single.deviceId, isNull);
    });

    test('sağım hızı ve API anahtarı', () {
      final s = MilkingSpeed.fromJson({
        'animalId': 'a1',
        'milkings': 40,
        'avgFlow': 1.4,
        'peakFlow': 2.6,
        'durationSec': 372,
        'herdAvgFlow': 2.0,
        'slow': true,
      });
      expect(s.slow, isTrue);
      expect(s.belowHerdPct, 30);

      final k = ApiKeyCreated.fromJson({
        'key': {
          'id': 'k1',
          'name': 'Yem',
          'prefix': 'ab12cd34',
          'createdAt': '2026-09-29T06:10:00Z',
          'createdBy': 'Demo',
        },
        'token': 'mtk_ab12cd34_secret',
      });
      expect(k.token, 'mtk_ab12cd34_secret');
      expect(k.key.masked, 'mtk_ab12cd34_…');
      expect(k.key.lastUsedAt, isNull);
    });
  });

  group('mock', () {
    test('üç kontrolde %8 sapma kalibrasyon ister; düzeltince iner', () async {
      final repo = MockRepository(
        latency: Duration.zero,
        today: _today,
        loadAsset: _disk,
      );
      final animal = (await repo.animals()).first;
      final h = await repo.animalHistory(animal.id);
      MeterCheckResult? last;
      for (final m in h.take(3)) {
        last = await repo.addMeterCheck(m.id, (m.volumeMl / 1.08).round());
      }
      expect(last!.summary.checks, 3);
      expect(last.summary.avgDeviationPct, closeTo(8.0, 0.11));
      expect(last.summary.needsCalibration, isTrue);
      final summaries = await repo.meterSummaries();
      expect(summaries.single.needsCalibration, isTrue);
      final list = await repo.meterChecks(last.check.deviceId!);
      expect(list.items, hasLength(3));
      expect(list.items.first.earTag, animal.earTag);

      // Aynı sağım yeniden girilirse güncellenir (sağım başına bir kayıt).
      for (final m in h.take(3)) {
        last = await repo.addMeterCheck(m.id, m.volumeMl);
      }
      expect(last!.summary.checks, 3);
      expect(last.summary.needsCalibration, isFalse);
    });

    test('bilinmeyen sağım 404, sıfır miktar 422', () async {
      final repo = MockRepository(
        latency: Duration.zero,
        today: _today,
        loadAsset: _disk,
      );
      await expectLater(
        repo.addMeterCheck('yok-2026-09-20-m', 1000),
        throwsA(isA<ApiException>().having((e) => e.status, 'status', 404)),
      );
      await expectLater(
        repo.addMeterCheck('x', 0),
        throwsA(isA<ApiException>().having((e) => e.status, 'status', 422)),
      );
    });

    test('hız üretilmiş geçmişten; yavaş uydurulmaz', () async {
      final repo = MockRepository(
        latency: Duration.zero,
        today: _today,
        loadAsset: _disk,
      );
      final list = await repo.milkingSpeed();
      expect(list, isNotEmpty);
      expect(list.every((s) => s.avgFlow > 0 && s.herdAvgFlow > 0), isTrue);
      expect(list.every((s) => s.durationSec > 0), isTrue);
      expect(list.any((s) => s.slow), isFalse);
    });

    test('anahtar bir kez döner, listede önek; iptal edilir', () async {
      final repo = MockRepository(latency: Duration.zero);
      final c = await repo.createApiKey('  Yem programı ');
      expect(c.token, startsWith('mtk_${c.key.prefix}_'));
      expect(c.token.length, 4 + 8 + 1 + 32);
      expect((await repo.apiKeys()).single.name, 'Yem programı');
      await repo.revokeApiKey(c.key.id);
      expect(await repo.apiKeys(), isEmpty);
      await expectLater(
        repo.createApiKey(' '),
        throwsA(isA<ApiException>().having((e) => e.status, 'status', 422)),
      );
    });
  });

  group('sayaç kontrolü', () {
    testWidgets('sağıma dokununca elle ölçüm; sapma ve ortalama yazar', (
      tester,
    ) async {
      final repo = _Repo();
      final (animal, first) = (await tester.runAsync(() async {
        final a = (await repo.animals()).first;
        return (a, (await repo.animalHistory(a.id)).first);
      }))!;
      await _pumpDetail(tester, repo, animal.id);

      expect(
        find.text('Sayacı denetlemek için sağıma dokunup tartılan sütü girin.'),
        findsOneWidget,
      );
      final label =
          '${Fmt.dayMonth(first.startedAt!)} · '
          '${Fmt.sessionType(first.sessionType)}';
      await tester.tap(find.text(label).first);
      await tester.pumpAndSettle();
      expect(find.text('Elle ölçüm'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '10');
      await tester.tap(find.widgetWithText(FilledButton, 'Kaydet'));
      await tester.pumpAndSettle();

      final dev = ((first.volumeMl - 10000) / 10000 * 1000).round() / 10;
      final pct = signedPct(dev);
      expect(
        find.text('Sayaç %$pct · son 1 kontrol ortalaması %$pct'),
        findsOneWidget,
      );
    });

    testWidgets('sayaçsız sağımda sunucunun metni', (tester) async {
      final repo = _Repo(
        checkError: const ApiException(
          code: 'VALIDATION',
          message: 'bu sağımda sayaç ölçümü yok; kontrol yapılamaz',
          status: 422,
        ),
      );
      final (animal, first) = (await tester.runAsync(() async {
        final a = (await repo.animals()).first;
        return (a, (await repo.animalHistory(a.id)).first);
      }))!;
      await _pumpDetail(tester, repo, animal.id, role: 'tenant_operator');
      await tester.tap(
        find
            .text(
              '${Fmt.dayMonth(first.startedAt!)} · '
              '${Fmt.sessionType(first.sessionType)}',
            )
            .first,
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '9,5');
      await tester.tap(find.widgetWithText(FilledButton, 'Kaydet'));
      await tester.pumpAndSettle();
      expect(
        find.text('bu sağımda sayaç ölçümü yok; kontrol yapılamaz'),
        findsOneWidget,
      );
    });

    testWidgets('süren sağıma dokunulmaz; bitmişe dokunulur', (tester) async {
      final repo = _Repo(firstOngoing: true);
      final (animal, list) = (await tester.runAsync(() async {
        final a = (await repo.animals()).first;
        return (a, await repo.animalHistory(a.id));
      }))!;
      expect(list.first.endedAt, isNull);
      expect(list[1].endedAt, isNotNull);
      await _pumpDetail(tester, repo, animal.id, role: 'tenant_operator');
      String label(AnimalMilking m) =>
          '${Fmt.dayMonth(m.startedAt!)} · ${Fmt.sessionType(m.sessionType)}';

      // Sunucu süreni reddederdi ("bitmiş sağım bulunamadı"): pencere açılmaz.
      await tester.tap(find.text(label(list.first)).first);
      await tester.pumpAndSettle();
      expect(find.text('Elle ölçüm'), findsNothing);

      await tester.tap(find.text(label(list[1])).last);
      await tester.pumpAndSettle();
      expect(find.text('Elle ölçüm'), findsOneWidget);
    });

    testWidgets('görüntüleyici sağıma dokunamaz', (tester) async {
      final repo = _Repo();
      final animal = (await tester.runAsync(repo.animals))!.first;
      await _pumpDetail(tester, repo, animal.id, role: 'tenant_viewer');
      expect(
        find.text('Sayacı denetlemek için sağıma dokunup tartılan sütü girin.'),
        findsNothing,
      );
    });

    testWidgets('kalibrasyon gereken sayaç sarı; sayaç sayfasında kontroller', (
      tester,
    ) async {
      final base = MockRepository(
        latency: Duration.zero,
        today: _today,
        loadAsset: _disk,
      );
      final devices = (await tester.runAsync(base.devices))!;
      final now = DateTime.now();
      final d = devices.firstWhere(
        (x) =>
            x.status == 'online' &&
            x.spoutId != null &&
            !x.hasRecentError(now) &&
            !x.isCalibrationDue(now),
      );
      final summary = MeterSummary(
        deviceId: d.id,
        serialNo: d.serialNo,
        checks: 3,
        avgDeviationPct: 8.04,
        needsCalibration: true,
      );
      final repo = _Repo(
        summaries: [summary],
        checks: MeterChecks(
          summary: summary,
          items: [
            MeterCheck(
              id: 'c1',
              milkingId: 'm1',
              deviceId: d.id,
              earTag: 'TR-KONTROL',
              meteredMl: 10800,
              manualMl: 10000,
              deviationPct: 8.0,
              createdAt: DateTime.utc(2026, 9, 21, 6),
            ),
          ],
        ),
      );
      tester.view.physicalSize = const Size(1200, 5200);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repositoryProvider.overrideWith(
              (ref) => repo as MilkTraceRepository,
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: DevicesScreen())),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Kontrol sapması %+8'), findsOneWidget);

      await tester.tap(find.text('Kontrol sapması %+8'));
      await tester.pumpAndSettle();
      expect(find.text('Sayaç kontrolü'), findsOneWidget);
      expect(find.text('Son 3 kontrol ortalaması %+8.0'), findsOneWidget);
      expect(
        find.textContaining('kurulum ekibinden kalibrasyon isteyin'),
        findsOneWidget,
      );
      expect(
        find.text('21 Eyl · TR-KONTROL · sayaç 10.8 L / elle 10.0 L'),
        findsOneWidget,
      );
    });
  });

  group('sağım hızı', () {
    testWidgets('detayda hız kartı ve yavaş satırı', (tester) async {
      final base = MockRepository(
        latency: Duration.zero,
        today: _today,
        loadAsset: _disk,
      );
      final animal = (await tester.runAsync(base.animals))!.first;
      final repo = _Repo(
        speed: [
          MilkingSpeed(
            animalId: animal.id,
            milkings: 40,
            avgFlow: 1.4,
            peakFlow: 2.6,
            durationSec: 372,
            herdAvgFlow: 2.0,
            slow: true,
          ),
        ],
      );
      await _pumpDetail(tester, repo, animal.id);
      expect(find.text('Sağım hızı · son 30 gün'), findsOneWidget);
      expect(find.text('1.40 L/dk'), findsOneWidget);
      expect(find.text('2.60 L/dk'), findsOneWidget);
      expect(find.text('6 dk 12 sn'), findsOneWidget);
      expect(find.text('Sürü ortalaması 2.00 L/dk · 40 sağım'), findsOneWidget);
      expect(
        find.textContaining('Yavaş sağılıyor: sürü ortalamasının %30 altında'),
        findsOneWidget,
      );
    });

    testWidgets('veri yoksa kart yok', (tester) async {
      final repo = _Repo(speed: const []);
      final animal = (await tester.runAsync(repo.animals))!.first;
      await _pumpDetail(tester, repo, animal.id);
      expect(find.text('Sağım hızı · son 30 gün'), findsNothing);
    });

    test('yavaş sağılanlar süzgeci yalnızca yavaşları bırakır', () async {
      Animal a(String id) =>
          Animal(id: id, speciesId: 'cow', earTag: id, status: 'active');
      final container = ProviderContainer(
        overrides: [
          animalsProvider.overrideWith((ref) async => [a('A'), a('B'), a('C')]),
          milkingSpeedProvider.overrideWith(
            (ref) async => {
              'A': const MilkingSpeed(animalId: 'A', slow: true),
              'B': const MilkingSpeed(animalId: 'B'),
            },
          ),
        ],
      );
      addTearDown(container.dispose);
      expect(
        await container.read(filteredAnimalsProvider.future),
        hasLength(3),
      );
      container.read(animalFilterStateProvider.notifier).toggleSlow();
      expect(
        (await container.read(filteredAnimalsProvider.future)).map((x) => x.id),
        ['A'],
      );
      container.read(animalFilterStateProvider.notifier).clear();
      expect(container.read(animalFilterStateProvider).slow, isFalse);
    });

    test('hız okunamazsa boş (liste düşmez)', () async {
      final container = ProviderContainer(
        overrides: [
          repositoryProvider.overrideWith(
            (ref) => _Throwing() as MilkTraceRepository,
          ),
        ],
      );
      addTearDown(container.dispose);
      expect(await container.read(milkingSpeedProvider.future), isEmpty);
    });
  });

  group('API anahtarları', () {
    testWidgets('oluşturunca tam anahtar BİR KEZ; iptal edilir', (
      tester,
    ) async {
      final repo = MockRepository(latency: Duration.zero);
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied = (call.arguments as Map)['text'] as String?;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            repositoryProvider.overrideWith(
              (ref) => repo as MilkTraceRepository,
            ),
          ],
          child: const MaterialApp(home: ApiKeysScreen()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Henüz anahtar yok.'), findsOneWidget);
      expect(find.textContaining('/api/v1/exports/daily'), findsOneWidget);

      await tester.tap(find.text('Anahtar oluştur'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Yem programı');
      await tester.tap(find.widgetWithText(FilledButton, 'Kaydet'));
      await tester.pumpAndSettle();

      expect(find.text('Anahtar oluşturuldu'), findsOneWidget);
      expect(
        find.textContaining('Bu anahtar bir daha gösterilmez'),
        findsOneWidget,
      );
      final tokenFinder = find.byWidgetPredicate(
        (w) => w is SelectableText && (w.data ?? '').startsWith('mtk_'),
      );
      expect(tokenFinder, findsOneWidget);
      final token = tester.widget<SelectableText>(tokenFinder).data!;

      await tester.tap(find.text('Kopyala'));
      await tester.pumpAndSettle();
      expect(copied, token);

      await tester.tap(find.text('Kaydettim'));
      await tester.pumpAndSettle();
      expect(find.text('Yem programı'), findsOneWidget);
      final key = (await tester.runAsync(repo.apiKeys))!.single;
      expect(find.textContaining(key.masked), findsOneWidget);
      expect(find.textContaining(token), findsNothing, reason: 'bir kez');
      expect(find.textContaining('Hiç kullanılmadı'), findsOneWidget);

      await tester.tap(find.byTooltip('İptal et'));
      await tester.pumpAndSettle();
      expect(find.text('Anahtar iptal edilsin mi?'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'İptal et'));
      await tester.pumpAndSettle();
      expect(find.text('Henüz anahtar yok.'), findsOneWidget);
      expect(await tester.runAsync(repo.apiKeys), isEmpty);
    });

    Future<void> openSheet(WidgetTester tester, String role) async {
      tester.view.physicalSize = const Size(1200, 6000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authProvider.overrideWith(() => _User(role)),
            repositoryProvider.overrideWith(
              (ref) =>
                  MockRepository(latency: Duration.zero, loadAsset: _disk)
                      as MilkTraceRepository,
            ),
            supportInfoProvider.overrideWith((ref) async => null),
            settingsStoreProvider.overrideWithValue(_MemoryStore()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => TextButton(
                  onPressed: () => showAccountSheet(context),
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

    testWidgets('hesap kartında yalnızca sahibe', (tester) async {
      await openSheet(tester, 'tenant_owner');
      expect(find.text('API anahtarları'), findsOneWidget);
    });

    testWidgets('operatöre düğme yok', (tester) async {
      await openSheet(tester, 'tenant_operator');
      expect(find.text('API anahtarları'), findsNothing);
    });
  });

  test('işlem kaydı etiketleri ve uyarı simgesi', () {
    expect(auditActionLabel('api_key.create'), 'API anahtarı oluşturuldu');
    expect(auditActionLabel('api_key.revoke'), 'API anahtarı iptal edildi');
    expect(auditActionLabel('meter.check'), 'Sayaç kontrolü');
    expect(AlertStyle.icon('meter_drift'), Icons.speed);
  });
}

class _Throwing extends MockRepository {
  _Throwing() : super(latency: Duration.zero);

  @override
  Future<List<MilkingSpeed>> milkingSpeed() async => throw Exception('ağ');
}
