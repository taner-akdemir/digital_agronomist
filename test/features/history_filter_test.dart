import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/animal.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/history_providers.dart';
import 'package:milktrace/providers/catalog_providers.dart';

void main() {
  // Filtrenin DİNLEYİCİ YOKKEN de korunduğunu doğrular.
  //
  // Dashboard'daki "3 hayvan kuruya aday" satırı, Geçmiş ekranı henüz
  // kurulmadan filtreyi ayarlıyor. Provider autoDispose olduğu sürece bu
  // değer o ekran açılmadan önce siliniyor ve kullanıcı filtrelenmiş liste
  // yerine 30 hayvanın tamamını görüyordu.
  test('sınıf filtresi dinleyici olmadan da korunur', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container
        .read(animalFilterStateProvider.notifier)
        .showOnly(YieldClass.dryOffCandidate);

    // autoDispose'a çalışma fırsatı.
    await Future<void>.delayed(Duration.zero);

    expect(
      container.read(animalFilterStateProvider).yieldClass,
      YieldClass.dryOffCandidate,
    );
  });

  // Sağmal olmayan hayvan (kuruda, satıldı): sınıf süzgecine girmez — pano
  // sınıf dağılımını sağmallardan sayıyor — ve listede en altta durur;
  // sınıfı eskidir.
  test(
    'sağmal olmayan hayvan sınıf süzgecine girmez, en altta durur',
    () async {
      Animal a(String tag, YieldClass c, {String status = 'active'}) => Animal(
        id: tag,
        speciesId: 'cow',
        earTag: tag,
        yieldClass: c,
        status: status,
      );
      final container = ProviderContainer(
        overrides: [
          animalsProvider.overrideWith(
            (ref) async => [
              a('TR3', YieldClass.normal),
              a('TR1', YieldClass.dryOffCandidate, status: 'dry'),
              a('TR2', YieldClass.dryOffCandidate),
            ],
          ),
        ],
      );
      addTearDown(container.dispose);

      final all = await container.read(filteredAnimalsProvider.future);
      expect(all.map((x) => x.earTag), ['TR2', 'TR3', 'TR1']);

      container
          .read(animalFilterStateProvider.notifier)
          .showOnly(YieldClass.dryOffCandidate);
      final only = await container.read(filteredAnimalsProvider.future);
      expect(only.map((x) => x.earTag), ['TR2']);
    },
  );

  test('durumun Türkçe adı ve sağmallık', () {
    const dry = Animal(id: '1', speciesId: 'cow', earTag: 'T', status: 'dry');
    expect(dry.isMilking, isFalse);
    expect(dry.statusLabel, 'Kuruda');
    expect(
      const Animal(id: '2', speciesId: 'cow', earTag: 'T').isMilking,
      isTrue,
    );
    expect(
      const Animal(
        id: '3',
        speciesId: 'cow',
        earTag: 'T',
        status: 'transferred',
      ).statusLabel,
      'transferred',
      reason: 'tanınmayan durum olduğu gibi',
    );
  });

  // Laktasyon günü (backend ADR 0051): takvim günü, saat önemsiz; tarih yoksa
  // ya da gelecekteyse null.
  test('laktasyon günü', () {
    Animal a(DateTime? c) =>
        Animal(id: '1', speciesId: 'cow', earTag: 'T', lastCalvingDate: c);
    final today = DateTime(2026, 9, 24, 7, 30);

    expect(a(DateTime.utc(2026, 9, 14)).daysInMilk(today), 10);
    expect(
      a(DateTime.utc(2026, 9, 24)).daysInMilk(today),
      0,
      reason: 'bugün buzağıladı',
    );
    expect(
      a(DateTime.utc(2026, 9, 23, 23)).daysInMilk(DateTime(2026, 9, 24, 0, 5)),
      1,
      reason: 'saat değil takvim günü',
    );
    expect(a(null).daysInMilk(today), isNull);
    expect(
      a(DateTime.utc(2026, 10, 1)).daysInMilk(today),
      isNull,
      reason: 'gelecek',
    );
  });
}
