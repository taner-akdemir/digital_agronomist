import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/data/push/push_gateway.dart';
import 'package:milktrace/data/push/push_message.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Gerçek FCM bağlantısı (§15.2).
///
/// FIREBASE PROJESİ BAĞLANMADIYSA SESSİZCE DEVRE DIŞI KALIR: `google-
/// services.json` yokken `Firebase.initializeApp` hata atıyor ve bu hatayı
/// yukarı taşımak, uygulamanın açılışta çökmesi demekti. Proje bağlandığında
/// tek satır bile değişmeden çalışmaya başlar.
class FirebasePushGateway implements PushGateway {
  FirebasePushGateway({FlutterLocalNotificationsPlugin? local})
    : _local = local ?? FlutterLocalNotificationsPlugin();

  /// Ön planda gelen bildirimleri gösteren eklenti.
  ///
  /// GEREKLİ: uygulama açıkken FCM bildirimi sistem tepsisine DÜŞMEZ,
  /// yalnızca `onMessage` tetiklenir. Bu olmadan sağım ekranındaki operatör
  /// düşük debi uyarısını hiç görmezdi.
  final FlutterLocalNotificationsPlugin _local;

  final _taps = StreamController<PushMessage>.broadcast();
  final _tokens = StreamController<String>.broadcast();
  final _subs = <StreamSubscription<dynamic>>[];

  /// Kanal kimliği AndroidManifest'teki
  /// `default_notification_channel_id` ile birebir aynı olmalı; farklı
  /// olsaydı uygulama kapalıyken gelen bildirim başka bir kanala düşer ve
  /// kullanıcının sessize aldığı kanal işe yaramazdı.
  static AndroidNotificationChannel get _channel => AndroidNotificationChannel(
    'milktrace_alerts',
    l10n.pushChannelName,
    description: l10n.pushChannelDescription,
    importance: Importance.high,
  );

  /// Sessiz saat kanalı (backend ADR 0107): backend sessiz saatte kritik
  /// olmayan uyarıyı bu kimlikle gönderir (`fcm.QuietChannelID`); düşük
  /// önem = tepsiye düşer, ses çıkarmaz.
  static AndroidNotificationChannel get _quietChannel =>
      AndroidNotificationChannel(
        'milktrace_quiet',
        l10n.pushQuietChannelName,
        description: l10n.pushQuietChannelDescription,
        importance: Importance.low,
        playSound: false,
      );

  @override
  Stream<PushMessage> get taps => _taps.stream;

  @override
  Stream<String> get tokenRefresh => _tokens.stream;

  @override
  Future<String?> start() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      // Proje bağlanmamış. Tek gerçekçi sebep bu; loglayıp push'suz devam.
      debugPrint('[push] Firebase başlatılamadı, push kapalı: $e');
      return null;
    }

    final settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('[push] bildirim izni reddedildi');
      return null;
    }

    await _setupLocalNotifications();

    _subs.add(FirebaseMessaging.onMessage.listen(_showForeground));
    _subs.add(
      FirebaseMessaging.onMessageOpenedApp.listen(
        (m) => _taps.add(_toMessage(m)),
      ),
    );
    _subs.add(FirebaseMessaging.instance.onTokenRefresh.listen(_tokens.add));

    // Uygulama KAPALIYKEN gelen bildirime dokunularak açıldıysa, o bildirim
    // onMessageOpenedApp'e düşmez; yalnızca burada görünür.
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) _taps.add(_toMessage(initial));

    try {
      if (defaultTargetPlatform == TargetPlatform.iOS &&
          await _waitForApnsToken() == null) {
        // Push yeteneği/imza eksik ya da APNs'e ulaşılamıyor. getToken bu
        // durumda hata atar; hatayı taşımak sağımı push yüzünden düşürürdü.
        debugPrint('[push] APNs jetonu alınamadı, push kapalı');
        return null;
      }
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      debugPrint('[push] FCM jetonu alınamadı, push kapalı: $e');
      return null;
    }
  }

  /// iOS'ta FCM jetonu APNs jetonundan türer ve APNs jetonu izin verildikten
  /// SONRA eşzamansız gelir; hemen `getToken` çağırmak `apns-token-not-set`
  /// hatası verir. Birkaç saniye beklenir.
  static Future<String?> _waitForApnsToken() async {
    for (var i = 0; i < 10; i++) {
      final token = await FirebaseMessaging.instance.getAPNSToken();
      if (token != null) return token;
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    return null;
  }

  Future<void> _setupLocalNotifications() async {
    await _local.initialize(
      settings: const InitializationSettings(
        // Uygulama ikonu kullanılıyor: ayrı bir bildirim ikonu eklenene
        // kadar Android'in varsayılanı boş kare gösteriyordu.
        android: AndroidInitializationSettings('@drawable/ic_stat_milktrace'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null) return;
        _taps.add(_fromPayload(payload));
      },
    );

    final android = _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.createNotificationChannel(_channel);
    await android?.createNotificationChannel(_quietChannel);
  }

  Future<void> _showForeground(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    // Sessiz saatte (backend ADR 0107) uygulama açıkken de çalmasın.
    final quiet = message.data['quiet'] == '1';
    final channel = quiet ? _quietChannel : _channel;
    await _local.show(
      // Kimlik UYARIDAN türetilir: aynı uyarının "geri geldi" duyurusu,
      // uygulama açıkken de tepsideki "çevrimdışı" bildiriminin yerine
      // geçsin (backend FCM tag ile aynı davranış).
      id: (message.data['alertId'] as String?)?.hashCode ?? message.hashCode,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: quiet ? Importance.low : Importance.high,
          priority: quiet ? Priority.low : Priority.high,
          playSound: !quiet,
          // Tepside simgenin ve uygulama adının rengi (manifestteki
          // notification_accent ile aynı).
          color: AppColors.darkGreenColor,
        ),
        iOS: DarwinNotificationDetails(presentSound: !quiet),
      ),
      payload: jsonEncode(message.data),
    );
  }

  static PushMessage _toMessage(RemoteMessage m) => PushMessage.fromRemote(
    title: m.notification?.title,
    body: m.notification?.body,
    data: m.data,
  );

  /// Ön plandaki bildirime dokunulduğunda payload JSON olarak geri gelir.
  static PushMessage _fromPayload(String payload) {
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      return PushMessage.fromRemote(data: data);
    } catch (_) {
      // Bozuk payload kullanıcıyı ekransız bırakmasın.
      return const PushMessage(route: PushMessage.alertsRoute);
    }
  }

  /// Dinlemeyi bırakır ama AKIŞLARI KAPATMAZ: kullanıcı çıkıp tekrar giriş
  /// yaptığında aynı nesne yeniden başlatılıyor ve kapalı bir akışa yazmak
  /// çalışma zamanı hatası olurdu.
  @override
  Future<void> stop() async {
    for (final s in _subs) {
      await s.cancel();
    }
    _subs.clear();
  }

  @override
  Future<void> dispose() async {
    await stop();
    await _taps.close();
    await _tokens.close();
  }
}
