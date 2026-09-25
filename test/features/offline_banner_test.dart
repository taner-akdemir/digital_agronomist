import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/providers/offline_providers.dart';
import 'package:milktrace/widgets/offline_banner.dart';

void main() {
  testWidgets('çevrimdışıyken verinin anını söyler, dönünce kaybolur', (
    tester,
  ) async {
    final c = ProviderContainer();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: const MaterialApp(home: Scaffold(body: OfflineBanner())),
      ),
    );
    expect(find.textContaining('Çevrimdışı'), findsNothing);

    final at = DateTime.now().toUtc().subtract(const Duration(minutes: 5));
    c.read(offlineStatusProvider.notifier).offline(at);
    // Daha yeni bir önbellek anı, gösterilen en eski anı ezmez.
    c.read(offlineStatusProvider.notifier).offline(DateTime.now().toUtc());
    await tester.pump();
    final l = at.toLocal();
    final hhmm =
        '${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
    expect(find.textContaining('son veri $hhmm'), findsOneWidget);

    c.read(offlineStatusProvider.notifier).online();
    await tester.pump();
    expect(find.textContaining('Çevrimdışı'), findsNothing);
  });
}
