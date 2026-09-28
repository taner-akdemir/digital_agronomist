import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/features/auth/login_screen.dart';
import 'package:milktrace/providers/auth_providers.dart';

void main() {
  Future<void> pump(
    WidgetTester tester,
    Future<String> Function(String) requester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          passwordResetRequesterProvider.overrideWithValue(requester),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
  }

  testWidgets('Parolamı unuttum: e-postayı gönderir, sunucu metnini gösterir', (
    tester,
  ) async {
    String? sentTo;
    await pump(tester, (email) async {
      sentTo = email;
      return 'Bu e-posta kayıtlıysa sıfırlama bağlantısı gönderildi.';
    });

    await tester.enterText(find.byType(TextFormField).first, ' a@ciftlik.tr ');
    await tester.tap(find.text('Parolamı unuttum'));
    await tester.pumpAndSettle();

    // Girişteki e-posta pencereye taşınır.
    expect(find.widgetWithText(TextFormField, 'a@ciftlik.tr'), findsOneWidget);
    await tester.tap(find.text('Bağlantı gönder'));
    await tester.pumpAndSettle();

    expect(sentTo, 'a@ciftlik.tr');
    expect(
      find.text('Bu e-posta kayıtlıysa sıfırlama bağlantısı gönderildi.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Tamam'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('posta kapalıysa sunucunun hatası gösterilir', (tester) async {
    await pump(
      tester,
      (_) async => throw const ApiException(
        code: 'UNAVAILABLE',
        message: 'parola sıfırlama şu an kullanılamıyor; yöneticinize başvurun',
        status: 503,
      ),
    );

    await tester.tap(find.text('Parolamı unuttum'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextFormField),
      ),
      'a@ciftlik.tr',
    );
    await tester.tap(find.text('Bağlantı gönder'));
    await tester.pumpAndSettle();

    expect(
      find.text('parola sıfırlama şu an kullanılamıyor; yöneticinize başvurun'),
      findsOneWidget,
    );
    expect(
      find.text('Bağlantı gönder'),
      findsOneWidget,
      reason: 'pencere açık',
    );
  });
}
