import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/domain/yield_class.dart';
import 'package:milktrace/features/history/history_providers.dart';

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
}
