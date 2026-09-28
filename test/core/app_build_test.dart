import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/app_build.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/features/update/update_required_screen.dart';

/// İstekleri kaydeden ve verilen durum koduyla cevaplayan adaptör.
class _Adapter implements HttpClientAdapter {
  _Adapter(this.status);

  final int status;
  final seen = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    seen.add(options);
    return ResponseBody.fromString(
      jsonEncode({
        'error': {'code': 'UPGRADE_REQUIRED', 'message': 'güncelleyin'},
      }),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  tearDown(() {
    AppBuild.platform = null;
    AppBuild.build = null;
    UpgradeGate.required.value = false;
  });

  test('sürüm başlıkları gider; 426 güncelleme kapısını açar', () async {
    AppBuild.platform = 'android';
    AppBuild.build = 7;
    final adapter = _Adapter(426);
    final dio = Dio()
      ..httpClientAdapter = adapter
      ..interceptors.add(AppBuildInterceptor());

    await expectLater(
      dio.get<dynamic>('https://x.test/me'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.seen.single.headers['X-App-Platform'], 'android');
    expect(adapter.seen.single.headers['X-App-Build'], '7');
    expect(UpgradeGate.required.value, isTrue);
  });

  test('sürüm okunamadıysa başlık yok; başka hata kapıyı açmaz', () async {
    final adapter = _Adapter(500);
    final dio = Dio()
      ..httpClientAdapter = adapter
      ..interceptors.add(AppBuildInterceptor());
    await expectLater(
      dio.get<dynamic>('https://x.test/me'),
      throwsA(isA<DioException>()),
    );
    expect(adapter.seen.single.headers.containsKey('X-App-Build'), isFalse);
    expect(UpgradeGate.required.value, isFalse);
  });

  Future<List<Uri>> pumpScreen(
    WidgetTester tester, {
    required bool android,
  }) async {
    final opened = <Uri>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          supportInfoProvider.overrideWith((ref) async => null),
          supportLauncherProvider.overrideWithValue((uri) async {
            opened.add(uri);
            return true;
          }),
        ],
        child: MaterialApp(home: UpdateRequiredScreen(isAndroid: android)),
      ),
    );
    await tester.pumpAndSettle();
    return opened;
  }

  testWidgets('Android: Google Play düğmesi mağaza sayfasını açar', (
    tester,
  ) async {
    final opened = await pumpScreen(tester, android: true);
    expect(find.text('Güncelleme gerekli'), findsOneWidget);
    await tester.tap(find.text("Google Play'de güncelle"));
    await tester.pumpAndSettle();
    expect(opened, [playStoreUri]);
  });

  testWidgets('iOS: mağaza bağlantısı henüz yok, yalnızca metin', (
    tester,
  ) async {
    await pumpScreen(tester, android: false);
    expect(find.textContaining("App Store'dan"), findsOneWidget);
    expect(find.text("Google Play'de güncelle"), findsNothing);
  });
}
