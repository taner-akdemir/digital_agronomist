// Play mağaza ekran görüntüleri (TR/EN). Yalnızca istenince çalışır:
//
//   MILKTRACE_STORE_SCREENS=/çıktı/klasörü flutter test test/store_screens_test.dart
//
// Değişken yokken testler atlanır; normal `flutter test` etkilenmez.
//
// Uygulamanın GERÇEK kökü (MilkTraceApp: router, tema, dil) sahte verilerle
// (MockRepository, assets/data) çizilir; oturum işletme sahibi olarak açık
// gelir. Görüntüler 1080×1920 (mantıksal 411×731 @ 2.625) PNG olarak
// <klasör>/{tr,en}/NN-ad.png'ye yazılır. Gerçek yazı tipleri (Poppins,
// Material Icons, Roboto) diskten yüklenir — yoksa test yazı tipi kutular çizer.
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/app/app.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/delivery.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/features/whats_new/whats_new.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

final _out = Platform.environment['MILKTRACE_STORE_SCREENS'];
final _shot = GlobalKey();

const _tenantId = 't1';

/// Mock verideki ilk hayvan (assets/data/animals.json, "Sarıkız").
const _animalId = '0192a1f0-0070-7000-8000-000000000001';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Owner extends Auth {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'ahmet@yildizciftligi.com.tr',
      fullName: 'Ahmet Yıldız',
      role: 'tenant_owner',
      tenantId: _tenantId,
      tenants: [
        TenantRef(id: _tenantId, name: 'Yıldız Çiftliği', role: 'tenant_owner'),
      ],
    ),
  );
}

class _NoPush extends PushRegistration {
  @override
  Future<PushStatus> build() async => PushStatus.unavailable;
}

class _Memory implements SettingsStore {
  _Memory(this.values);

  final Map<String, Object?> values;

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

/// Canlı akışı kare üretmeyen depo: mock'un akışı 2 sn'de bir kare veren
/// sonsuz döngü, pumpAndSettle oturmazdı. Tahta ilk yüklemenin (gerçek
/// API'deki `GET /sessions/{id}/live`) değerleriyle çizilir.
class _StillRepository extends MockRepository {
  _StillRepository() : super(latency: Duration.zero, loadAsset: _disk);

  final _controllers = <StreamController<SpoutUpdate>>[];

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) {
    final c = StreamController<SpoutUpdate>();
    _controllers.add(c);
    return c.stream;
  }

  /// Mock'ta teslim yok; ekranda boş liste yerine iki günde bir tank
  /// teslimi (son 60 gün, somatik hücre grafiği dolsun). Karşılaştırmayı
  /// gerçekte sunucu yapar (backend ADR 0089); değerler uydurmadır.
  @override
  Future<Deliveries> deliveries() async {
    final today = DateTime.now();
    const scc = [210, 460, 230, 250, 240, 280, 300, 270, 260, 240];
    const diff = [-0.6, -5.7, -1.2, 0.8, -2.1, -0.4, 1.5, -1.8, -0.9, 0.3];
    return Deliveries(
      items: [
        for (var i = 0; i < 30; i++)
          Delivery(
            id: 'd$i',
            deliveredOn: DateTime(today.year, today.month, today.day - 2 * i),
            volumeMl: 372000 - (i % 5) * 3500,
            authorName: 'Ahmet Yıldız',
            compared: i < 29,
            periodFrom: DateTime(
              today.year,
              today.month,
              today.day - 2 * i - 2,
            ),
            meteredMl: i < 29
                ? ((372000 - (i % 5) * 3500) / (1 + diff[i % 10] / 100)).round()
                : 0,
            withheldMl: i == 0 ? 4200 : 0,
            diffPct: i < 29 ? diff[i % 10] : 0,
            mismatch: i < 29 && diff[i % 10].abs() > 5,
            fatPct: 3.8 + (i % 3) / 10,
            proteinPct: 3.2 + (i % 2) / 10,
            sccK: scc[i % 10],
            bacteriaK: 35 + i % 8,
            highScc: scc[i % 10] > 400,
          ),
      ],
    );
  }
}

Future<void> _loadFonts() async {
  Future<void> family(String name, List<String> files) async {
    final l = FontLoader(name);
    for (final f in files) {
      l.addFont(File(f).readAsBytes().then((b) => ByteData.sublistView(b)));
    }
    await l.load();
  }

  await family('Poppins', [
    for (final w in ['Regular', 'Medium', 'SemiBold', 'Bold'])
      'assets/fonts/Poppins-$w.ttf',
  ]);
  // flutter_tester: <flutter>/bin/cache/artifacts/engine/<platform>/flutter_tester
  final flutterRoot = File(
    Platform.resolvedExecutable,
  ).parent.parent.parent.parent.parent.parent.path;
  final fonts = '$flutterRoot/bin/cache/artifacts/material_fonts';
  await family('MaterialIcons', ['$fonts/MaterialIcons-Regular.otf']);
  final roboto = [
    '$fonts/Roboto-Regular.ttf',
    '$fonts/Roboto-Medium.ttf',
    '$fonts/Roboto-Bold.ttf',
  ];
  await family('Roboto', roboto);
  // Ailesi verilmemiş metin (ör. açılır listenin kendi stili) testte
  // "FlutterTest" kutu yazı tipine düşer; Android'de Roboto'dur.
  await family('FlutterTest', roboto);
  await family('Ahem', roboto);
  // Hesap simgesi (CupertinoIcons.person_circle) paketin yazı tipinde.
  final cupertino = _packageDir('cupertino_icons');
  if (cupertino != null) {
    await family('packages/cupertino_icons/CupertinoIcons', [
      '$cupertino/assets/CupertinoIcons.ttf',
    ]);
  }
}

/// Paketin diskteki kökü (.dart_tool/package_config.json).
String? _packageDir(String name) {
  final config = File('.dart_tool/package_config.json');
  if (!config.existsSync()) return null;
  final json = jsonDecode(config.readAsStringSync()) as Map<String, dynamic>;
  for (final p in json['packages'] as List<dynamic>) {
    final m = p as Map<String, dynamic>;
    if (m['name'] != name) continue;
    final uri = Uri.parse(m['rootUri'] as String);
    return uri.isAbsolute
        ? uri.toFilePath()
        : config.parent.uri.resolveUri(uri).toFilePath();
  }
  return null;
}

Widget _app(String lang) => RepaintBoundary(
  key: _shot,
  child: ProviderScope(
    overrides: [
      authProvider.overrideWith(_Owner.new),
      pushRegistrationProvider.overrideWith(_NoPush.new),
      pushTapsProvider.overrideWith((ref) => const Stream.empty()),
      repositoryProvider.overrideWith(
        (ref) => _StillRepository() as MilkTraceRepository,
      ),
      supportInfoProvider.overrideWith((ref) async => null),
      settingsStoreProvider.overrideWithValue(
        _Memory({
          'app.language': lang,
          'app.theme': 'light',
          'whatsNew.seen': whatsNewId,
          'setup.dismissed.$_tenantId': true,
        }),
      ),
    ],
    child: const MilkTraceApp(),
  ),
);

Future<void> _go(WidgetTester tester, String path) async {
  ProviderScope.containerOf(
    tester.element(find.byType(MilkTraceApp)),
  ).read(routerProvider).go(path);
  await tester.pumpAndSettle();
}

Future<void> _save(WidgetTester tester, String lang, String name) async {
  FocusManager.instance.primaryFocus?.unfocus();
  // Görseller (marka işareti) gerçek asenkron okunur; sahte saatte bitmez.
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 200)),
  );
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull, reason: name);
  final boundary = tester.renderObject<RenderRepaintBoundary>(
    find.byKey(_shot),
  );
  final bytes = await tester.runAsync(() async {
    final ui.Image img = await boundary.toImage(pixelRatio: 2.625);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  });
  final f = File('$_out/$lang/$name.png');
  f.parent.createSync(recursive: true);
  f.writeAsBytesSync(bytes!);
}

void main() {
  setUpAll(() async {
    if (_out != null) await _loadFonts();
    // Sağ üstteki "DEBUG" şeridi görüntüye girmesin.
    WidgetsApp.debugAllowBannerOverride = false;
  });

  tearDown(() {
    // Global dil ve parlaklık sonraki testlere sızmasın.
    AppColors.brightness = Brightness.light;
    setL10nLocale(const Locale('tr'));
  });

  for (final lang in ['tr', 'en']) {
    testWidgets('mağaza ekranları ($lang)', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 2.625;
      addTearDown(tester.view.reset);
      // Cihaz dili seçilen dil: kayıtlı seçim diskten okunana kadar ilk
      // çizim cihaz diliyle olur (gerçek telefondaki gibi).
      tester.platformDispatcher.localesTestValue = [Locale(lang)];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
      // flutter_test gölgeleri siyah çizgi çizer; çekimde gerçek gölge.
      debugDisableShadows = false;

      await tester.pumpWidget(_app(lang));
      await tester.pumpAndSettle();

      await _go(tester, '/live');
      await _save(tester, lang, '01-canli-sagim');
      await _go(tester, '/dashboard');
      await _save(tester, lang, '02-pano');
      await _go(tester, '/history');
      await _save(tester, lang, '03-hayvanlar');
      await _go(tester, '/history/animal/$_animalId');
      await _save(tester, lang, '04-hayvan-detayi');
      await _go(tester, '/alerts');
      await _save(tester, lang, '05-uyarilar');
      await _go(tester, '/devices');
      await _save(tester, lang, '06-sayaclar');
      await _go(tester, '/deliveries');
      await _save(tester, lang, '07-tank-teslimleri');

      // Açık akışlar kapanmadan ağaç sökülsün; gölge ayarı geri.
      await tester.pumpWidget(const SizedBox());
      debugDisableShadows = true;
    }, skip: _out == null);
  }
}
