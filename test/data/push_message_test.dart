import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/push/push_message.dart';

void main() {
  // Hayvan bildiriminin HAYVAN DETAYINA götürdüğünü doğrular.
  //
  // "Benekli düşük debiyle sağılıyor" bildirimine dokunan kullanıcının ilk
  // sorusu "bu hayvan daha önce de böyle miydi?".
  test('hayvan kimliği varsa hayvan detayına gider', () {
    final m = PushMessage.fromRemote(
      title: 'Düşük debi',
      body: 'Benekli (TR340000003) düşük debiyle sağılıyor.',
      data: {'type': 'alert', 'alertId': 'al1', 'animalId': 'a1'},
    );

    expect(m.route, '/history/animal/a1');
    expect(m.title, 'Düşük debi');
  });

  test('hayvan kimliği yoksa uyarı listesine gider', () {
    final m = PushMessage.fromRemote(
      data: {'type': 'alert', 'alertId': 'al1'},
    );

    expect(m.route, PushMessage.alertsRoute);
  });

  // BOŞ ve EKSİK alanların kullanıcıyı boş ekranda bırakmadığını doğrular.
  //
  // '/history/animal/' gibi yarım bir yol router'ın hata sayfasına düşerdi.
  test('boş ya da eksik alanlar uyarı listesine düşer', () {
    expect(PushMessage.fromRemote(data: {'animalId': ''}).route,
        PushMessage.alertsRoute);
    expect(PushMessage.fromRemote(data: {'animalId': '   '}).route,
        PushMessage.alertsRoute);
    expect(PushMessage.fromRemote().route, PushMessage.alertsRoute);
  });

  // FCM data değerleri STRING gelir; başka tip sızarsa da çökmemeli.
  test('string olmayan kimlik metne çevrilir', () {
    expect(PushMessage.fromRemote(data: {'animalId': 42}).route,
        '/history/animal/42');
  });
}
