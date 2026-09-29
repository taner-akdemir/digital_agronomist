import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/volume.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/delivery.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/deliveries/deliveries_screen.dart';
import 'package:milktrace/features/deliveries/delivery_card.dart';
import 'package:milktrace/features/deliveries/milk_quality.dart';
import 'package:milktrace/features/team/milkers_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';

class _FakeAuth extends Auth {
  _FakeAuth(this.role);

  final String role;

  @override
  AuthState build() => AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(id: 'u', email: 'a@b.c', fullName: 'X', role: role),
  );
}

Future<MockRepository> _pump(
  WidgetTester tester,
  Widget child, {
  String role = 'tenant_owner',
  MockRepository? repo,
  VolumeFormat volume = VolumeFormat.litre,
  bool scaffold = true,
}) async {
  final r = repo ?? MockRepository(latency: Duration.zero);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => r as MilkTraceRepository),
        authProvider.overrideWith(() => _FakeAuth(role)),
        volumeFormatProvider.overrideWith((ref) => volume),
      ],
      child: MaterialApp(
        home: scaffold
            ? Scaffold(body: SingleChildScrollView(child: child))
            : child,
      ),
    ),
  );
  await tester.pumpAndSettle();
  return r;
}

void main() {
  test('teslim ve karşılaştırma çözülür', () {
    final d = Delivery.fromJson({
      'id': 'd',
      'deliveredOn': '2026-09-03',
      'volumeMl': 200000,
      'compared': true,
      'periodFrom': '2026-09-02',
      'meteredMl': 210000,
      'withheldMl': 10000,
      'diffPct': 5.0,
      'mismatch': true,
      'kgPerLitre': 1.03,
    });
    expect(d.deliveredOn, DateTime(2026, 9, 3));
    expect(diffLabel(d), '+%5.0 · sayaçlar fazla');
    expect(diffLabel(d.copyWith(diffPct: -2.14)), '−%2.1 · sayaçlar eksik');
    expect(durationLabel(372), '6 dk 12 sn');
    expect(durationLabel(0), '—');
  });

  testWidgets('görüntüleyiciye kayıt yoksa pano kartı çizilmez', (
    tester,
  ) async {
    await _pump(tester, const DeliveryCard(), role: 'tenant_viewer');
    expect(find.text('Tank teslimi'), findsNothing);
  });

  testWidgets('operatör panodan teslim girer (kg → mL)', (tester) async {
    final repo = await _pump(
      tester,
      const DeliveryCard(),
      role: 'tenant_operator',
      volume: const VolumeFormat(unit: 'kg'),
    );
    expect(find.textContaining('Tanker fişini girin'), findsOneWidget);

    await tester.tap(find.text('Teslim gir'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('Tanker fişindeki miktarı girin.'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Teslim edilen (kg)'),
      '1030',
    );
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(repo.deliveries))!;
    expect(saved.items.single.volumeMl, 1000000, reason: '1030 kg / 1,03');
    expect(find.textContaining('tanker 1030.0 kg'), findsOneWidget);
    expect(find.textContaining('Karşılaştırılmadı'), findsOneWidget);
  });

  testWidgets('fark eşiği aşan teslim amber; sahip onayla siler', (
    tester,
  ) async {
    final repo = MockRepository(latency: Duration.zero);
    await tester.runAsync(
      () => repo.addDelivery(day: DateTime(2026, 9, 3), volumeMl: 200000),
    );
    await _pump(tester, const DeliveriesScreen(), repo: repo, scaffold: false);
    expect(find.textContaining('3 Eyl'), findsWidgets);
    expect(find.byTooltip('Fark eşiği'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    expect(find.text('Teslim silinsin mi?'), findsOneWidget);
    await tester.tap(find.text('Sil'));
    await tester.pumpAndSettle();
    expect((await tester.runAsync(repo.deliveries))!.items, isEmpty);
  });

  testWidgets('operatör silemez, eşiği değiştiremez', (tester) async {
    final repo = MockRepository(latency: Duration.zero);
    await tester.runAsync(
      () => repo.addDelivery(day: DateTime(2026, 9, 3), volumeMl: 200000),
    );
    await _pump(
      tester,
      const DeliveriesScreen(),
      role: 'tenant_operator',
      repo: repo,
      scaffold: false,
    );
    expect(find.byIcon(Icons.delete_outline), findsNothing);
    expect(find.byTooltip('Fark eşiği'), findsNothing);
    expect(find.text('Teslim gir'), findsOneWidget);
  });

  testWidgets('karşılaştırılan teslim farkı ve pencereyi yazar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DeliveryTile(
            delivery: Delivery(
              id: 'd',
              deliveredOn: DateTime(2026, 9, 3),
              volumeMl: 200000,
              compared: true,
              periodFrom: DateTime(2026, 9, 2),
              meteredMl: 210000,
              withheldMl: 10000,
              diffPct: 5,
              mismatch: true,
            ),
            volume: VolumeFormat.litre,
          ),
        ),
      ),
    );
    expect(find.textContaining('(ayrılan 10.0 L hariç)'), findsOneWidget);
    expect(find.text('+%5.0 · sayaçlar fazla'), findsOneWidget);
  });

  // Süt kalitesi (backend ADR 0110): analiz isteğe bağlı; sınır aşımı
  // uyarı satırı ve amber kenar; eğilim en az iki analizle çizilir.
  testWidgets('teslime analiz girilir; yüksek hücre uyarısı ve eğilim', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    addTearDown(tester.view.resetPhysicalSize);
    final repo = MockRepository(latency: Duration.zero);
    await tester.runAsync(
      () => repo.addDelivery(
        day: DateTime(2026, 9, 1),
        volumeMl: 500000,
        sccK: 250,
        fatPct: 3.8,
      ),
    );
    await _pump(
      tester,
      DeliveriesScreen(today: DateTime(2026, 9, 5)),
      repo: repo,
      scaffold: false,
      role: 'tenant_operator',
    );
    expect(find.text('Grafik için en az iki analiz gerekli.'), findsOneWidget);

    await tester.tap(find.text('Teslim gir'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Teslim edilen (L)'),
      '480',
    );
    await tester.tap(find.text('Mandıra analizi'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Somatik hücre (bin/mL)'),
      '520',
    );
    await tester.enterText(find.widgetWithText(TextField, 'Yağ (%)'), '40');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    expect(find.text('Geçerli bir sayı girin'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Yağ (%)'), '3,9');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    final saved = (await tester.runAsync(repo.deliveries))!;
    final latest = saved.items.first;
    expect(latest.sccK, 520);
    expect(latest.fatPct, 3.9);
    expect(latest.highScc, isTrue);
    expect(
      find.text('Somatik hücre sınırın üstünde (400 bin/mL)'),
      findsWidgets,
    );
    expect(
      find.text('Yağ %3.90 · Protein %— · Hücre 520 · Bakteri —'),
      findsOneWidget,
    );
    expect(find.byType(QualityTrendCard), findsOneWidget);
    expect(find.text('Grafik için en az iki analiz gerekli.'), findsNothing);
  });

  testWidgets('sahip somatik hücre sınırını değiştirir', (tester) async {
    final repo = MockRepository(latency: Duration.zero);
    await tester.runAsync(
      () => repo.addDelivery(
        day: DateTime(2026, 9, 3),
        volumeMl: 200000,
        sccK: 450,
      ),
    );
    await _pump(tester, const DeliveriesScreen(), repo: repo, scaffold: false);
    expect(find.textContaining('sınırın üstünde'), findsOneWidget);
    await tester.tap(find.byTooltip('Somatik hücre sınırı (bin/mL)'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '500');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();
    final v = (await tester.runAsync(repo.deliveries))!;
    expect(v.sccLimitK, 500);
    expect(v.tolerancePct, 5, reason: 'fark eşiği korunur');
    expect(find.textContaining('sınırın üstünde'), findsNothing);
  });

  testWidgets('sağımcı özeti: bilinen ve bilinmeyen sağımcı', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          milkersProvider(7).overrideWith(
            (ref) async => const [
              Milker(
                userId: 'u1',
                name: 'Mehmet',
                sessions: 14,
                milkings: 200,
                volumeMl: 1960000,
                avgDurationSec: 372,
                lowFlowMilkings: 20,
              ),
              Milker(milkings: 4),
            ],
          ),
        ],
        child: const MaterialApp(home: MilkersScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Mehmet'), findsOneWidget);
    expect(find.text('14 oturum · 200 sağım · 1960 L'), findsOneWidget);
    expect(
      find.text('Ortalama sağım 6 dk 12 sn · düşük debi %10'),
      findsOneWidget,
    );
    expect(find.text('Sağımcısı bilinmeyen'), findsOneWidget);
  });
}
