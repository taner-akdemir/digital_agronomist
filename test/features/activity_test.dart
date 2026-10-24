// Aktiviteden kızgınlık tespiti (backend ADR 0145): Aktivite kartı, bağlama,
// overview sırası, uyarıdan "Kızgınlığı kaydet", cihaz ağacı.
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/activity.dart';
import 'package:milktrace/data/models/alert.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/activity/activity_card.dart';
import 'package:milktrace/features/activity/activity_dashboard_card.dart';
import 'package:milktrace/features/activity/activity_providers.dart';
import 'package:milktrace/features/activity/activity_status.dart';
import 'package:milktrace/features/alerts/alert_style.dart';
import 'package:milktrace/features/alerts/alerts_screen.dart';
import 'package:milktrace/features/devices/devices_providers.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

Future<String> _disk(String p) async => File(p).readAsStringSync();

/// Mock verisi: 001 kızgınlıkta (tasma 0001), 002 olağan (tasma 0002),
/// 003'te tasma yok; tasma 0003 boşta.
const _heat = '0192a1f0-0070-7000-8000-000000000001';
const _normal = '0192a1f0-0070-7000-8000-000000000002';
const _bare = '0192a1f0-0070-7000-8000-000000000003';

class _Auth extends Auth {
  _Auth(this.role, {this.kiosk = false});

  final String role;
  final bool kiosk;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u',
      email: 'a@b.c',
      fullName: 'X',
      role: role,
      tenantId: 't',
      kiosk: kiosk,
    ),
  );
}

class _Repo extends MockRepository {
  _Repo({this.bindError, this.alertList = const []})
    : super(
        latency: Duration.zero,
        today: DateTime(2026, 10, 25, 15),
        loadAsset: _disk,
      );

  final Object? bindError;
  final List<Alert> alertList;

  @override
  Future<void> bindActivityDevice(String deviceId, String? animalId) {
    if (bindError case final e?) return Future.error(e);
    return super.bindActivityDevice(deviceId, animalId);
  }

  @override
  Future<List<Alert>> alerts() async => alertList;
}

Widget _app(
  Widget home,
  MilkTraceRepository repo, {
  String role = 'tenant_owner',
}) => ProviderScope(
  overrides: [
    authProvider.overrideWith(() => _Auth(role)),
    repositoryProvider.overrideWith((ref) => repo),
  ],
  child: MaterialApp(
    home: Scaffold(body: SingleChildScrollView(child: home)),
  ),
);

ActivityOverviewRow _row(String tag, double? rise) =>
    ActivityOverviewRow(animalId: tag, tag: tag, risePct: rise);

void main() {
  test('model: API yanıtı ayrıştırılır, eksik alanlar varsayılan', () {
    final a = AnimalActivity.fromJson({
      'animalId': 'a1',
      'device': {
        'id': 'd1',
        'serial': 'ACT-1',
        'lastSeen': '2026-10-25T12:00:00Z',
      },
      'hourly': [
        {'hour': '2026-10-25T11:00:00Z', 'steps': 120, 'ruminationMin': 20.5},
        {'hour': '2026-10-25T12:00:00Z', 'activityIndex': 3.2},
      ],
      'daily': [
        {'day': '2026-10-25', 'steps': 4000},
      ],
      'status': 'rising',
    });
    expect(a.device!.serial, 'ACT-1');
    expect(a.hourly.first.steps, 120);
    expect(a.hourly.last.steps, isNull);
    expect(a.hourly.last.activityIndex, 3.2);
    expect(a.hasRumination, isTrue);
    expect(a.status, 'rising');

    final empty = AnimalActivity.fromJson({'animalId': 'a2', 'device': null});
    expect(empty.device, isNull);
    expect(empty.status, 'no_data');
    expect(empty.hasData, isFalse);

    final row = ActivityOverviewRow.fromJson({
      'animalId': 'a1',
      'tag': 'TR1',
      'name': null,
      'serial': 'ACT-1',
      'lastSeen': null,
      'risePct': null,
      'status': 'learning',
      'lastHeatDetectedAt': null,
    });
    expect(row.risePct, isNull);
    expect(row.status, 'learning');
  });

  test('overview yükselişe göre azalan; bilinmeyen en sonda', () {
    final sorted = sortByRise([
      _row('C', null),
      _row('A', 12),
      _row('B', 140),
      _row('D', -5),
    ]);
    expect([for (final r in sorted) r.tag], ['B', 'A', 'D', 'C']);
  });

  test('durum etiketleri, renkleri ve uyarı biçimi', () {
    expect(ActivityStatus.label('heat'), 'Kızgınlık belirtisi');
    expect(ActivityStatus.label('learning'), 'Öğreniyor');
    expect(ActivityStatus.label('rising'), 'Artışta');
    expect(ActivityStatus.label('pregnant'), 'Gebe');
    expect(ActivityStatus.label('no_data'), 'Veri yok');
    expect(ActivityStatus.label('bilinmeyen'), 'Veri yok');
    expect(AlertStyle.icon('heat_detected'), Icons.favorite);
    expect(AlertStyle.title('heat_detected'), 'Kızgınlık belirtisi');
    expect(AlertStyle.title('heat_expected'), 'Beklenen kızgınlık');
    expect(AlertStyle.title('low_flow'), isNull);
  });

  test('bağlama hata kodları: mock ApiException ve gerçek DioException', () {
    expect(
      activityBindError(
        const ApiException(
          code: 'ANIMAL_HAS_DEVICE',
          message: 'x',
          status: 409,
        ),
      ),
      contains('zaten bir aktivite cihazı'),
    );
    final dio = DioException(
      requestOptions: RequestOptions(path: '/devices/d/animal'),
      response: Response(
        requestOptions: RequestOptions(path: '/devices/d/animal'),
        statusCode: 422,
        data: {
          'error': {'code': 'NOT_ACTIVITY_DEVICE', 'message': 'x'},
        },
      ),
      type: DioExceptionType.badResponse,
    );
    expect(activityBindError(dio), contains('aktivite cihazı değil'));
  });

  test('cihaz ağacında tasma "takılı olmayan sayaç" sayılmaz', () async {
    final repo = _Repo();
    final c = ProviderContainer(
      overrides: [repositoryProvider.overrideWith((ref) => repo)],
    );
    addTearDown(c.dispose);
    final all = await repo.devices();
    expect(all.where((d) => d.isActivityTag), hasLength(3));
    final tree = await c.read(deviceTreeProvider.future);
    expect(tree.unassigned.where((d) => d.isActivityTag), isEmpty);
  });

  testWidgets('kart: kızgın hayvanda durum, iki grafik, geviş ve cihaz', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const ActivityCard(animalId: _heat), _Repo()));
    await tester.pumpAndSettle();

    expect(find.text('Kızgınlık belirtisi'), findsOneWidget);
    expect(find.byType(BarChart), findsNWidgets(2));
    expect(find.text('Son 48 saat · saatlik'), findsOneWidget);
    expect(find.text('Son 14 gün · günlük'), findsOneWidget);
    expect(find.textContaining('Geviş (son 24 sa)'), findsOneWidget);
    expect(find.textContaining('MT-ACT-0001'), findsOneWidget);
    expect(find.text('Cihazı çöz'), findsOneWidget);
  });

  testWidgets('kart: tasmasız hayvanda açıklama; görüntüleyici bağlayamaz', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const ActivityCard(animalId: _bare), _Repo(), role: 'tenant_viewer'),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('aktivite tasması'), findsOneWidget);
    expect(find.byType(BarChart), findsNothing);
    expect(find.text('Cihaz bağla'), findsNothing);
  });

  testWidgets('bağlama rolleri: operatör bağlar; kiosk ve mandıra bağlamaz', (
    tester,
  ) async {
    expect(activityBindRoles, {'tenant_owner', 'tenant_operator'});
    for (final (role, kiosk, can) in [
      ('tenant_operator', false, true),
      ('tenant_operator', true, false),
      ('dairy_viewer', false, false),
    ]) {
      await tester.pumpWidget(
        ProviderScope(
          key: ValueKey('$role$kiosk'),
          overrides: [
            authProvider.overrideWith(() => _Auth(role, kiosk: kiosk)),
            repositoryProvider.overrideWith((ref) => _Repo()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(child: ActivityCard(animalId: _bare)),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Cihaz bağla'),
        can ? findsOneWidget : findsNothing,
        reason: '$role kiosk=$kiosk',
      );
    }
  });

  testWidgets('sahip boştaki tasmayı bağlar, kart grafiğe döner', (
    tester,
  ) async {
    final repo = _Repo();
    await tester.pumpWidget(_app(const ActivityCard(animalId: _bare), repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cihaz bağla'));
    await tester.pumpAndSettle();
    // Bağlı tasmalar listede yok, yalnız boştaki.
    expect(find.text('MT-ACT-0001'), findsNothing);
    await tester.tap(find.text('MT-ACT-0003'));
    await tester.pumpAndSettle();

    expect(find.text('Cihaz bağlandı'), findsOneWidget);
    expect(find.textContaining('MT-ACT-0003'), findsOneWidget);
    expect(find.byType(BarChart), findsNWidgets(2));
    final devices = (await tester.runAsync(repo.devices))!;
    expect(
      devices.singleWhere((d) => d.serialNo == 'MT-ACT-0003').animalId,
      _bare,
    );
  });

  testWidgets('409 ANIMAL_HAS_DEVICE anlaşılır metinle gösterilir', (
    tester,
  ) async {
    final repo = _Repo(
      bindError: const ApiException(
        code: 'ANIMAL_HAS_DEVICE',
        message: 'conflict',
        status: 409,
      ),
    );
    await tester.pumpWidget(_app(const ActivityCard(animalId: _bare), repo));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cihaz bağla'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('MT-ACT-0003'));
    await tester.pumpAndSettle();

    expect(
      find.text('Bu hayvana zaten bir aktivite cihazı bağlı. Önce onu çözün.'),
      findsOneWidget,
    );
  });

  testWidgets('sahip tasmayı onayla çözer', (tester) async {
    final repo = _Repo();
    await tester.pumpWidget(_app(const ActivityCard(animalId: _normal), repo));
    await tester.pumpAndSettle();
    expect(find.text('Normal'), findsOneWidget);

    await tester.tap(find.text('Cihazı çöz'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Cihazı çöz'));
    await tester.pumpAndSettle();

    expect(find.text('Cihaz çözüldü'), findsOneWidget);
    expect(find.textContaining('aktivite tasması'), findsOneWidget);
  });

  testWidgets('pano kartı yalnız bakılacak hayvanları gösterir', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const ActivityDashboardCard(), _Repo()));
    await tester.pumpAndSettle();

    expect(find.text('1 kızgınlık belirtisi · 0 artışta'), findsOneWidget);
    expect(find.textContaining('Sarıkız'), findsOneWidget);
    expect(find.textContaining('Karabaş'), findsNothing, reason: 'olağan');
    expect(find.text('Listeyi aç'), findsOneWidget);
  });

  testWidgets('uyarıdan "Kızgınlığı kaydet": tür, gün ve not dolu; kuyruktan '
      'kaydedilir', (tester) async {
    final repo = _Repo(
      alertList: [
        Alert(
          id: 'al1',
          message:
              'Kızgınlık belirtisi: aktivite %140 arttı (başlangıç 24 Eki '
              '14:00).',
          type: 'heat_detected',
          severity: 'warning',
          animalId: _heat,
          createdAt: DateTime(2026, 10, 24, 15, 5),
        ),
      ],
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => _Auth('tenant_operator')),
          repositoryProvider.overrideWith((ref) => repo),
        ],
        child: const MaterialApp(home: AlertsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kızgınlık belirtisi'), findsOneWidget, reason: 'başlık');
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    await tester.tap(find.text('Kızgınlığı kaydet'));
    await tester.pumpAndSettle();

    // Diyalog: kızgınlık seçili, gün uyarının günü, not dolu.
    final seg = tester.widget<SegmentedButton<String>>(
      find.byType(SegmentedButton<String>),
    );
    expect(seg.selected, {'heat'});
    expect(find.text('Tarih: 24 Eki 2026'), findsOneWidget);
    expect(
      find.widgetWithText(TextField, 'Aktivite uyarısından'),
      findsOneWidget,
    );

    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(() => repo.breedingEvents(_heat)))!;
    expect(saved.first.kind, 'heat');
    expect(saved.first.eventDate, DateTime(2026, 10, 24));
    expect(saved.first.note, 'Aktivite uyarısından');
  });
}
