// Tablet düzeni (backend ADR 0141): telefonda alt menü, tablette yan ray;
// geniş ekranda hayvan listesi ile detayı yan yana; hiçbir boyda taşma yok.
//
// Uygulamanın gerçek kökü (MilkTraceApp: router, tema) mock verilerle,
// işletme sahibi oturumuyla çizilir.
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/app/app.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/data/models/auth_state.dart';
import 'package:milktrace/data/models/auth_user.dart';
import 'package:milktrace/data/models/spout_update.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/activity/activity_screen.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/features/whats_new/whats_new.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

const _tenantId = 't1';

/// Mock verideki ilk hayvan (assets/data/animals.json).
const _animalId = '0192a1f0-0070-7000-8000-000000000001';

Future<String> _disk(String p) async => File(p).readAsStringSync();

class _Owner extends Auth {
  @override
  AuthState build() => const AuthState(
    status: AuthStatus.signedIn,
    user: AuthUser(
      id: 'u1',
      email: 'owner@example.com',
      fullName: 'Owner',
      role: 'tenant_owner',
      tenantId: _tenantId,
      tenants: [TenantRef(id: _tenantId, name: 'Farm', role: 'tenant_owner')],
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

/// Canlı akışı kare üretmeyen depo (mock'un sonsuz akışı pumpAndSettle'ı
/// oturtmazdı).
class _StillRepository extends MockRepository {
  _StillRepository() : super(latency: Duration.zero, loadAsset: _disk);

  @override
  Stream<SpoutUpdate> watchSession(String sessionId) =>
      StreamController<SpoutUpdate>().stream;
}

Widget _app() => ProviderScope(
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
        'app.language': 'tr',
        'app.theme': 'light',
        'whatsNew.seen': whatsNewId,
        'setup.dismissed.$_tenantId': true,
      }),
    ),
  ],
  child: const MilkTraceApp(),
);

Future<void> _go(WidgetTester tester, String path) async {
  ProviderScope.containerOf(
    tester.element(find.byType(MilkTraceApp)),
  ).read(routerProvider).go(path);
  await tester.pumpAndSettle();
  expect(tester.takeException(), isNull, reason: path);
}

const _sizes = {
  'telefon': Size(390, 844),
  'tablet dikey': Size(800, 1280),
  'tablet yatay': Size(1280, 800),
};

Future<void> _open(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(_app());
  await tester.pumpAndSettle();
}

/// Gerçek yazı tipleri: test yazı tipinde her harf 1 em kare, metin
/// cihazdakinden çok geniş çıkar; taşma denetimi gerçek ölçüyle yapılsın.
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
  final roboto = [
    '$fonts/Roboto-Regular.ttf',
    '$fonts/Roboto-Medium.ttf',
    '$fonts/Roboto-Bold.ttf',
  ];
  if (roboto.every((f) => File(f).existsSync())) {
    await family('Roboto', roboto);
    await family('FlutterTest', roboto);
  }
}

void main() {
  setUpAll(_loadFonts);

  for (final MapEntry(key: name, value: size) in _sizes.entries) {
    final phone = size.width < 600;

    testWidgets('$name: ${phone ? 'alt menü' : 'yan ray'}', (tester) async {
      await _open(tester, size);
      await _go(tester, '/dashboard');

      expect(find.byType(NavigationBar), phone ? findsOneWidget : findsNothing);
      expect(
        find.byType(NavigationRail),
        phone ? findsNothing : findsOneWidget,
      );
      if (!phone) {
        final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
        expect(rail.extended, size.width >= 1200);
      }
    });

    testWidgets('$name: hayvan detayı ${phone ? 'tek' : 'iki'} bölme', (
      tester,
    ) async {
      await _open(tester, size);
      await _go(tester, '/history/animal/$_animalId');

      expect(find.byType(AnimalDetailScreen), findsOneWidget);
      expect(
        find.byType(HistoryScreen),
        phone ? findsNothing : findsOneWidget,
        reason: 'liste detayın yanında',
      );
      // İki bölmede detayın geri oku yok: liste zaten yanında.
      expect(
        find.descendant(
          of: find.byType(AnimalDetailScreen),
          matching: find.byIcon(Icons.arrow_back),
        ),
        phone ? findsWidgets : findsNothing,
      );

      // Listeye dönüş: tablette yer tutucu, telefonda yalnız liste.
      await _go(tester, '/history');
      expect(find.byType(AnimalDetailScreen), findsNothing);
      expect(find.byType(HistoryScreen), findsOneWidget);
    });

    testWidgets(
      '$name: aktivite listesi ${phone ? 'detayı açar' : 'iki bölme'}',
      (tester) async {
        await _open(tester, size);
        await _go(tester, '/activity');

        expect(find.byType(AnimalDetailScreen), findsNothing);
        await tester.tap(find.byType(ActivityRowTile).first);
        await tester.pumpAndSettle();

        expect(find.byType(AnimalDetailScreen), findsOneWidget);
        expect(
          find.byType(ActivityScreen),
          phone ? findsNothing : findsOneWidget,
          reason: 'tablette liste detayın yanında',
        );
      },
    );

    testWidgets('$name: ekranlar taşmadan çizilir', (tester) async {
      await _open(tester, size);
      for (final path in [
        '/live',
        '/dashboard',
        '/history',
        '/history/animal/$_animalId',
        '/devices',
        '/alerts',
        '/activity',
        '/deliveries',
        '/animals/new',
        '/settings/thresholds',
        '/settings/feedback',
        '/settings/quiet-hours',
      ]) {
        await _go(tester, path);
      }
    });
  }
}
