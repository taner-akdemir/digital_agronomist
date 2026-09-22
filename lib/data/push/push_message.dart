/// Kullanıcıya gösterilen ve dokunulduğunda bir yere götüren push bildirimi.
///
/// Firebase tiplerinden BAĞIMSIZDIR: yönlendirme kuralını Firebase olmadan
/// test edebilmek için. Gerçek `RemoteMessage` bu sınıfa çevrilir.
class PushMessage {
  const PushMessage({this.title, this.body, required this.route});

  /// Metinler BACKEND'DEN gelir ve olduğu gibi gösterilir (§16): hangi
  /// kuralın tetiklendiğini `notification` servisi biliyor, uygulama kendi
  /// metnini uydurmaz.
  final String? title;
  final String? body;

  /// Dokunulduğunda gidilecek yol.
  final String route;

  /// Uyarı listesi — bildirimin hangi hayvana ait olduğu anlaşılamazsa.
  static const String alertsRoute = '/alerts';

  /// FCM data payload'ından yol çözer.
  ///
  /// VARSAYIM: payload alanları §8.5'te tanımlı değil. `notification`
  /// servisi yazılırken doğrulanmalı (§18). Bilinmeyen ya da eksik alanlar
  /// uyarı listesine düşer — push'a dokunan kullanıcıyı boş bir ekranda
  /// bırakmaktansa ilgili listeye götürmek her zaman doğru.
  factory PushMessage.fromRemote({
    String? title,
    String? body,
    Map<String, dynamic> data = const {},
  }) {
    final animalId = _string(data['animalId']);

    return PushMessage(
      title: title,
      body: body,
      route: animalId == null ? alertsRoute : '/history/animal/$animalId',
    );
  }

  /// FCM data değerleri her zaman STRING gelir ama mock ve testlerde başka
  /// tip sızabiliyor; boş string alan olmaması ile aynı sayılır.
  static String? _string(Object? v) {
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }
}
