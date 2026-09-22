import 'package:milktrace/data/push/push_message.dart';

/// Push altyapısının uygulamaya bakan yüzü (§15.2).
///
/// Arayüz ARKASINDA durmasının sebebi, Firebase'in yokluğunun normal bir
/// durum olması: proje henüz bağlanmadı ve uygulama push'suz çalışmak
/// zorunda. Ayrıca testler Firebase'siz koşuyor.
abstract interface class PushGateway {
  /// Bildirim iznini ister, kanalı kurar ve FCM jetonunu döner.
  ///
  /// Firebase YAPILANDIRILMAMIŞSA ya da kullanıcı izni reddederse `null`
  /// döner — bu bir hata değil, "push yok" durumudur.
  Future<String?> start();

  /// Kullanıcının bildirime dokunmasıyla açılması gereken hedefler.
  Stream<PushMessage> get taps;

  /// FCM jetonu yenilendiğinde. Jeton uygulama ömrü boyunca değişebilir ve
  /// eski jetona gönderilen push kimseye ulaşmaz.
  Stream<String> get tokenRefresh;

  /// Dinlemeyi bırakır. Yeniden [start] edilebilir: kullanıcı çıkış yapıp
  /// tekrar giriş yaptığında aynı nesne kullanılır.
  Future<void> stop();

  /// Nesne tamamen bırakılırken. [stop]'tan farkı, akışların da
  /// kapatılması — bundan sonra [start] edilemez.
  Future<void> dispose();
}

/// Push'un kapalı olduğu durum: mock mod ve Firebase bağlanmamışken.
///
/// Boş uygulama, `if (push != null)` kontrollerini çağrı yerlerinden
/// siliyor — o kontroller eninde sonunda birinde unutulurdu.
class DisabledPushGateway implements PushGateway {
  const DisabledPushGateway();

  @override
  Future<String?> start() async => null;

  @override
  Stream<PushMessage> get taps => const Stream.empty();

  @override
  Stream<String> get tokenRefresh => const Stream.empty();

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {}
}
