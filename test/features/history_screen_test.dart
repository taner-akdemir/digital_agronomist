import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/animal_detail_screen.dart';
import 'package:milktrace/features/history/history_screen.dart';
import 'package:milktrace/providers/repository_providers.dart';

final _today = DateTime(2026, 9, 22);

/// Asset'i DİSKTEN okur.
///
/// rootBundle'ın okuması gerçek asenkron iştir ve testWidgets'ın sahte
/// saatinde ikinci ekran kurulumundan itibaren tamamlanmıyor: liste sonsuza
/// kadar yükleniyor görünüyor, pumpAndSettle hiç oturmuyordu.
Future<String> _diskAsset(String path) async => File(path).readAsStringSync();

MockRepository _repo() => MockRepository(
      latency: Duration.zero,
      today: _today,
      loadAsset: _diskAsset,
    );

/// Ekranı mock kaynakla sarar.
///
/// Gecikme SIFIR: MockRepository normalde 400 ms bekliyor (yükleniyor
/// göstergesi görünsün diye) ve testte bu, her ekran için boşuna zaman
/// ilerletmek demekti.
Widget wrap(Widget child) => ProviderScope(
      overrides: [
        repositoryProvider.overrideWith((ref) => _repo() as MilkTraceRepository),
      ],
      child: MaterialApp(home: Scaffold(body: child)),
    );

/// Fixture'dan sınıfa göre hayvan seçer.
///
/// runAsync ŞART: MockRepository Future.delayed kullanıyor ve testWidgets'ın
/// sahte saati pump dışında ilerlemiyor — doğrudan await edilirse test
/// sonsuza kadar bekler.
Future<Animal> animalOf(WidgetTester tester, YieldClass c) async {
  final animals = await tester.runAsync(() => _repo().animals());
  return animals!.firstWhere((a) => a.yieldClass == c);
}

/// Hayvan listesindeki (filtre çubuğu DEĞİL) metinler, ekrandaki sırayla.
Iterable<String> listTexts(WidgetTester tester) => tester
    .widgetList<Text>(
        find.descendant(of: find.byType(ListView).at(1), matching: find.byType(Text)))
    .map((t) => t.data ?? '');

void main() {
  // Listenin SINIFA göre sıralandığını doğrular.
  //
  // Küpe numarasına göre sıralamak, 30 hayvanlık bir sürüde bile sorunlu
  // olanı tek tek aramak demekti.
  testWidgets('ilgilenilmesi gereken hayvanlar listenin başında', (tester) async {
    await tester.pumpWidget(wrap(const HistoryScreen()));
    await tester.pumpAndSettle();

    final badges = listTexts(tester)
        .where((t) => YieldClass.values.any((c) => c.label == t));

    expect(badges.first, YieldClass.noMilk.label);
  });

  testWidgets('sınıf filtresi listeyi daraltır, tekrar basınca kalkar',
      (tester) async {
    await tester.pumpWidget(wrap(const HistoryScreen()));
    await tester.pumpAndSettle();

    final all = find.byIcon(Icons.chevron_right).evaluate().length;

    await tester.tap(find.widgetWithText(FilterChip, YieldClass.declining.label));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.chevron_right).evaluate().length, lessThan(all));
    expect(listTexts(tester), isNot(contains(YieldClass.noMilk.label)));

    await tester.tap(find.widgetWithText(FilterChip, YieldClass.declining.label));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.chevron_right).evaluate(), hasLength(all));
  });

  // Normal sınıfın rozet GÖSTERMEDİĞİNİ doğrular (§6.4 UI sütunu "—").
  //
  // Sürünün çoğu normaldir; hepsini rozetlemek gerçekten ilgilenilmesi
  // gereken üç hayvanı görünmez yapardı.
  testWidgets('normal sınıf rozetsizdir', (tester) async {
    await tester.pumpWidget(wrap(const HistoryScreen()));
    await tester.pumpAndSettle();

    expect(listTexts(tester), isNot(contains(YieldClass.normal.label)));
  });

  testWidgets('oturumlar sekmesi açık oturumu işaretler', (tester) async {
    await tester.pumpWidget(wrap(const HistoryScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Oturumlar'));
    await tester.pumpAndSettle();

    expect(find.text('Sürüyor'), findsOneWidget);
    expect(find.textContaining('Sağımı'), findsWidgets);
  });

  testWidgets('hayvan detayı sınıfı, trendi ve son sağımları gösterir',
      (tester) async {
    final animal = await animalOf(tester, YieldClass.high);

    await tester.pumpWidget(wrap(AnimalDetailScreen(animalId: animal.id)));
    await tester.pumpAndSettle();

    expect(find.text(animal.earTag), findsOneWidget);
    expect(find.text(YieldClass.high.label), findsOneWidget);
    expect(find.text('Verim trendi'), findsOneWidget);
    expect(find.text('Son sağımlar'), findsOneWidget);
  });

  // "Karar destek" uyarısının riskli sınıfta EKRANDA DURDUĞUNU doğrular
  // (§6.4). Bu cümle olmadan rozet bir teşhis gibi okunurdu.
  testWidgets('riskli sınıfta veteriner uyarısı görünür', (tester) async {
    final animal = await animalOf(tester, YieldClass.dryOffCandidate);

    await tester.pumpWidget(wrap(AnimalDetailScreen(animalId: animal.id)));
    await tester.pumpAndSettle();

    expect(find.textContaining('teşhis değildir'), findsOneWidget);
  });

  testWidgets('yüksek verimli hayvanda uyarı metni yoktur', (tester) async {
    final animal = await animalOf(tester, YieldClass.high);

    await tester.pumpWidget(wrap(AnimalDetailScreen(animalId: animal.id)));
    await tester.pumpAndSettle();

    expect(find.textContaining('teşhis değildir'), findsNothing);
  });

  testWidgets('kayıtsız hayvan kimliğinde hata gösterilir', (tester) async {
    await tester.pumpWidget(wrap(const AnimalDetailScreen(animalId: 'yok')));
    await tester.pumpAndSettle();

    expect(find.text('Bu hayvan kayıtlı değil'), findsOneWidget);
  });
}
