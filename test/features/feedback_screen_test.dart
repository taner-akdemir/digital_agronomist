import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/features/settings/feedback_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

// Geri bildirim ekranı (backend ADR 0106).

final _png = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, //
  0, 0, 0, 13, 0x49, 0x48, 0x44, 0x52,
]);

Future<MockRepository> _pump(
  WidgetTester tester, {
  FeedbackImage? image,
}) async {
  final repo = MockRepository(latency: Duration.zero);
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, _) => const Scaffold(body: Text('ana ekran')),
        routes: [
          GoRoute(path: 'feedback', builder: (_, _) => const FeedbackScreen()),
        ],
      ),
    ],
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => repo as MilkTraceRepository),
        feedbackImagePickerProvider.overrideWithValue(() async => image),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  router.push('/home/feedback');
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  testWidgets('yalnızca metin gönderilir, ekran kapanır', (tester) async {
    final repo = await _pump(tester);

    await tester.enterText(
      find.byKey(const Key('feedbackMessage')),
      '  Canlı ekran donuyor  ',
    );
    await tester.tap(find.text('Gönder'));
    await tester.pumpAndSettle();

    expect(repo.sentFeedback, hasLength(1));
    expect(repo.sentFeedback.single.message, 'Canlı ekran donuyor');
    expect(repo.sentFeedback.single.screenshot, isNull);
    expect(repo.sentFeedback.single.contentType, isNull);
    expect(find.text('Geri bildiriminiz alındı, teşekkürler.'), findsOneWidget);
    expect(find.text('ana ekran'), findsOneWidget, reason: 'ekran kapandı');
  });

  testWidgets('seçilen görüntü türüyle birlikte gider; kaldırılabilir', (
    tester,
  ) async {
    final repo = await _pump(tester, image: (name: 'ekran.png', bytes: _png));

    await tester.tap(find.text('Ekran görüntüsü ekle'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('feedbackThumbnail')), findsOneWidget);
    expect(find.text('ekran.png'), findsOneWidget);

    // Kaldır → ekle düğmesi geri gelir; yeniden ekle.
    await tester.tap(find.byTooltip('Görüntüyü kaldır'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('feedbackThumbnail')), findsNothing);
    await tester.tap(find.text('Ekran görüntüsü ekle'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('feedbackMessage')), 'Ekte');
    await tester.tap(find.text('Gönder'));
    await tester.pumpAndSettle();

    final sent = repo.sentFeedback.single;
    expect(sent.message, 'Ekte');
    expect(sent.screenshot, _png);
    expect(sent.contentType, 'image/png');
  });

  testWidgets('boş mesaj gönderilmez', (tester) async {
    final repo = await _pump(tester);

    await tester.enterText(find.byKey(const Key('feedbackMessage')), '   ');
    await tester.tap(find.text('Gönder'));
    await tester.pumpAndSettle();

    expect(find.text('Bir mesaj yazın.'), findsOneWidget);
    expect(repo.sentFeedback, isEmpty);
    expect(find.byType(FeedbackScreen), findsOneWidget);
  });

  testWidgets('desteklenmeyen ya da büyük görüntü eklenmez', (tester) async {
    await _pump(
      tester,
      image: (name: 'a.gif', bytes: Uint8List.fromList('GIF89a....'.codeUnits)),
    );
    await tester.tap(find.text('Ekran görüntüsü ekle'));
    await tester.pumpAndSettle();
    expect(
      find.text('PNG, JPEG ya da WebP bir görüntü seçin.'),
      findsOneWidget,
    );
    expect(find.byKey(const Key('feedbackThumbnail')), findsNothing);
  });

  testWidgets('2 MB üstü görüntü reddedilir', (tester) async {
    final big = Uint8List(feedbackMaxImageBytes + 1)..setAll(0, _png);
    await _pump(tester, image: (name: 'b.png', bytes: big));
    await tester.tap(find.text('Ekran görüntüsü ekle'));
    await tester.pumpAndSettle();
    expect(find.text('Görüntü en çok 2 MB olabilir.'), findsOneWidget);
    expect(find.byKey(const Key('feedbackThumbnail')), findsNothing);
  });

  test('tür içerikten tanınır', () {
    expect(feedbackImageType(_png), 'image/png');
    expect(
      feedbackImageType(Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0])),
      'image/jpeg',
    );
    expect(
      feedbackImageType(
        Uint8List.fromList('RIFF\x00\x00\x00\x00WEBPVP8 '.codeUnits),
      ),
      'image/webp',
    );
    expect(feedbackImageType(Uint8List.fromList('GIF89a'.codeUnits)), isNull);
  });
}
