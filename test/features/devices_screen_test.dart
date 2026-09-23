import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/devices/devices_providers.dart';
import 'package:milktrace/features/devices/devices_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

final _today = DateTime(2026, 9, 22, 12);

/// Asset'i diskten okur; gerekçesi history_screen_test'te.
Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

MockRepository _repo() => MockRepository(
  latency: Duration.zero,
  today: _today,
  loadAsset: _diskAsset,
);

late ProviderContainer _container;

Widget wrap(Widget child) => UncontrolledProviderScope(
  container: _container,
  child: MaterialApp(home: Scaffold(body: child)),
);

Future<void> pumpDevices(WidgetTester tester) async {
  // Ağaç varsayılan 800x600 test yüzeyine sığmıyor; alttaki kartlar hiç
  // build edilmiyordu.
  tester.view.physicalSize = const Size(1200, 5200);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(wrap(const DevicesScreen()));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    _container = ProviderContainer(
      overrides: [
        repositoryProvider.overrideWith(
          (ref) => _repo() as MilkTraceRepository,
        ),
      ],
    );
  });
  tearDown(() => _container.dispose());

  test('ağaç bölge → ünite → nokta olarak kurulur', () async {
    final tree = await _container.read(deviceTreeProvider.future);

    expect(tree.halls, hasLength(3));
    expect(tree.halls.every((h) => h.vacuums.isNotEmpty), isTrue);
    expect(
      tree.halls.expand((h) => h.vacuums).expand((v) => v.spouts),
      hasLength(30),
    );
  });

  // Sayaçsız noktanın FARK EDİLDİĞİNİ doğrular.
  //
  // Sağım başladığında o noktadan hiç veri gelmeyecek; eksik ancak bu
  // ekranda görülür.
  test('sayaçsız nokta ve takılı olmayan sayaç ayrı ayrı sayılır', () async {
    final tree = await _container.read(deviceTreeProvider.future);

    expect(tree.emptySpouts, 1);
    expect(tree.unassigned, hasLength(3));
    expect(tree.online, 27);
    expect(tree.offline, 2);
  });

  // Noktaların ÜNİTE İÇİNDE sıra numarasına göre geldiğini doğrular:
  // asset sırası değişirse "Nokta 7"nin listede 3. sırada çıkması
  // kullanıcıyı yanıltırdı.
  test('noktalar sıra numarasına göre sıralı', () async {
    final tree = await _container.read(deviceTreeProvider.future);

    for (final v in tree.halls.expand((h) => h.vacuums)) {
      final nos = v.spouts.map((s) => s.spout.positionNo).toList();
      expect(nos, List.generate(nos.length, (i) => i + 1));
    }
  });

  testWidgets('özet, bölgeler ve takılı olmayan sayaçlar çizilir', (
    tester,
  ) async {
    await pumpDevices(tester);

    expect(find.text('27 Çevrimiçi'), findsOneWidget);
    expect(find.text('2 Çevrimdışı'), findsOneWidget);
    expect(find.text('1 Sayaçsız nokta'), findsOneWidget);
    expect(find.text('A Bölgesi'), findsOneWidget);
    expect(find.text('Takılı olmayan sayaçlar'), findsOneWidget);
  });

  // Sorunlu ünitenin AÇIK geldiğini doğrular: 30 noktayı birden açmak,
  // ilgilenilmesi gereken iki satırı kaydırma içinde kaybederdi.
  testWidgets('sorunlu ünite açık, sorunsuz ünite kapalı gelir', (
    tester,
  ) async {
    await pumpDevices(tester);

    // A-1'de sorun yok (10 nokta, hepsi çevrimiçi) → kapalı.
    expect(find.text('10 nokta · tümü çevrimiçi'), findsOneWidget);
    // B-1 ve C-1'de birer sorun var → açık, satırları görünür.
    expect(find.textContaining('ilgilenilmeli'), findsNWidgets(2));
    expect(find.textContaining('Çevrimdışı ·'), findsWidgets);
    expect(find.text('Sayaç takılı değil'), findsOneWidget);
  });

  testWidgets('sayaca dokununca ayrıntı sayfası açılır', (tester) async {
    await pumpDevices(tester);

    // Satırda artık protokol de yazıyor; tam eşleşme aranmıyor.
    await tester.tap(find.textContaining('MT-B1-000011'));
    await tester.pumpAndSettle();

    expect(find.text('Yazılım sürümü'), findsOneWidget);
    expect(find.text('Kalibrasyon katsayısı'), findsOneWidget);
    expect(find.text('Simülatör cihazı'), findsOneWidget);
  });

  // §17 Faz 5 demosu: native MQTT + üretici MQTT + Modbus sayaçları AYNI
  // ekranda. Protokol dağılımının sayıldığını doğrular.
  test('kaynaklar PROFİLE göre gruplanır, protokole göre değil', () async {
    final tree = await _container.read(deviceTreeProvider.future);

    // Native MQTT ile üretici MQTT aynı protokolü konuşuyor; protokole göre
    // sayılsaydı üç kaynak iki satıra düşer ve demonun asıl noktası olan
    // üretici ayrımı kaybolurdu.
    expect(tree.protocols, {'mqtt': 20, 'modbus': 9});
    expect(tree.sources, hasLength(3));
    expect(
      tree.sources.map((s) => s.profile.vendor),
      containsAll(['MILKTRACE', 'ORNEK-URETICI', 'AKIS-METRE']),
    );
    expect(tree.sources.first.count, 10);
    expect(hasMixedSources(tree), isTrue);
    expect(
      tree.unprofiled,
      0,
      reason: 'takılı sayaçların hepsinin profili olmalı',
    );
  });

  testWidgets('karışık kaynaklı tesiste satırda protokol yazar', (
    tester,
  ) async {
    await pumpDevices(tester);

    expect(find.text('Kaynaklar:'), findsOneWidget);
    expect(find.text('ORNEK-URETICI · MQTT · 10'), findsOneWidget);
    expect(find.text('AKIS-METRE · Modbus · 9'), findsOneWidget);
    // B-1 üretici MQTT, C-1 Modbus: ikisi de açık geliyor.
    expect(find.textContaining('MT-C1-000022 · Modbus'), findsOneWidget);
  });

  // Profil bilgisinin AYRINTIDA da durduğunu doğrular.
  //
  // §16/1: üretici adı bir VERİdir, uygulama ona göre davranmaz ama
  // gösterir — sahadaki teknisyen hangi sözleşmeyi konuştuğunu bilmeli.
  testWidgets('sayaç ayrıntısı profili ve protokolü gösterir', (tester) async {
    await pumpDevices(tester);

    await tester.tap(find.textContaining('MT-B1-000011'));
    await tester.pumpAndSettle();

    expect(find.text('ORNEK-URETICI MM-200 · v1'), findsOneWidget);
    expect(find.text('MQTT'), findsOneWidget);
  });
}
