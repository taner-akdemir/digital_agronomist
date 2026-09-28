import 'package:flutter_test/flutter_test.dart';
import 'package:milktrace/data/models/auth_user.dart';
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
    final m = PushMessage.fromRemote(data: {'type': 'alert', 'alertId': 'al1'});

    expect(m.route, PushMessage.alertsRoute);
  });

  // BOŞ ve EKSİK alanların kullanıcıyı boş ekranda bırakmadığını doğrular.
  //
  // '/history/animal/' gibi yarım bir yol router'ın hata sayfasına düşerdi.
  test('boş ya da eksik alanlar uyarı listesine düşer', () {
    expect(
      PushMessage.fromRemote(data: {'animalId': ''}).route,
      PushMessage.alertsRoute,
    );
    expect(
      PushMessage.fromRemote(data: {'animalId': '   '}).route,
      PushMessage.alertsRoute,
    );
    expect(PushMessage.fromRemote().route, PushMessage.alertsRoute);
  });

  // FCM data değerleri STRING gelir; başka tip sızarsa da çökmemeli.
  test('string olmayan kimlik metne çevrilir', () {
    expect(
      PushMessage.fromRemote(data: {'animalId': 42}).route,
      '/history/animal/42',
    );
  });

  group('işletme geçişi (backend ADR 0085)', () {
    const user = AuthUser(
      id: 'u',
      email: 'vet@x.tr',
      fullName: 'Dr',
      role: 'tenant_viewer',
      tenantId: 't1',
      tenants: [
        TenantRef(id: 't1', name: 'A', role: 'tenant_viewer'),
        TenantRef(id: 't2', name: 'B', role: 'tenant_operator'),
      ],
    );
    PushMessage tap(String? tenant) =>
        PushMessage.fromRemote(data: {'animalId': 'a1', 'tenantId': ?tenant});

    test('başka işletmenin bildirimi o işletmeye geçirir', () {
      expect(tap('t2').tenantToSwitch(user), 't2');
      expect(tap('t2').route, '/history/animal/a1');
    });
    test('aynı işletme, tenantId yok ya da üye değil: geçiş yok', () {
      expect(tap('t1').tenantToSwitch(user), isNull);
      expect(tap(null).tenantToSwitch(user), isNull);
      expect(tap('t9').tenantToSwitch(user), isNull);
      expect(tap('t2').tenantToSwitch(null), isNull);
    });
  });
}
