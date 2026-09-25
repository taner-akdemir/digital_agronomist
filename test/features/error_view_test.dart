import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/widgets/error_view.dart';

void main() {
  // Cihazda bulundu: servis dönse de hata ekranı kalıyordu.
  testWidgets('tekrar dene düğmesi yalnızca verilirse çıkar ve çağırır', (
    tester,
  ) async {
    var retried = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorView(
            message: 'Bölgeler yüklenemedi',
            onRetry: () => retried++,
          ),
        ),
      ),
    );
    await tester.tap(find.text('Tekrar dene'));
    expect(retried, 1);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ErrorView(message: 'Bölgeler yüklenemedi')),
      ),
    );
    expect(find.text('Tekrar dene'), findsNothing);
  });
}
