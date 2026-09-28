import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/features/support/support.dart';

void main() {
  Future<List<Uri>> pump(WidgetTester tester, SupportInfo? info) async {
    final opened = <Uri>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          supportInfoProvider.overrideWith((ref) async => info),
          appVersionProvider.overrideWith((ref) async => '1.0.0+3'),
          supportLauncherProvider.overrideWithValue((uri) async {
            opened.add(uri);
            return true;
          }),
        ],
        child: const MaterialApp(home: Scaffold(body: SupportButtons())),
      ),
    );
    await tester.pumpAndSettle();
    return opened;
  }

  testWidgets('WhatsApp hazır metin ve sürümle, Ara tel: ile açılır', (
    tester,
  ) async {
    final opened = await pump(tester, (
      phone: '+905551112233',
      whatsapp: '+905559998877',
    ));
    await tester.tap(find.text('WhatsApp'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ara'));
    await tester.pumpAndSettle();

    expect(opened, hasLength(2));
    expect(opened[0].host, 'wa.me');
    expect(opened[0].path, '/905559998877');
    expect(opened[0].queryParameters['text'], contains('(Uygulama 1.0.0+3)'));
    expect(opened[1].toString(), 'tel:+905551112233');
  });

  testWidgets('numara yoksa bölüm hiç görünmez', (tester) async {
    await pump(tester, null);
    expect(find.text('Destek'), findsNothing);
    await pump(tester, (phone: null, whatsapp: null));
    expect(find.text('Destek'), findsNothing);
  });

  testWidgets('yalnızca telefon varsa yalnızca Ara', (tester) async {
    await pump(tester, (phone: '+905551112233', whatsapp: null));
    expect(find.text('Ara'), findsOneWidget);
    expect(find.text('WhatsApp'), findsNothing);
  });
}
