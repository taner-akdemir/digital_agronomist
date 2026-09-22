import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/data/push/firebase_push_gateway.dart';
import 'package:milktrace/data/push/push_gateway.dart';
import 'package:milktrace/data/push/push_message.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_providers.g.dart';

/// Push altyapısı.
///
/// Mock modda KAPALI: o modda kimlik sunucusu yok, jetonu yazacak bir uç da
/// yok ve izin penceresi demo sırasında ekranın önüne düşerdi.
@Riverpod(keepAlive: true)
PushGateway pushGateway(Ref ref) {
  if (Env.apiMode == ApiMode.mock) return const DisabledPushGateway();

  final gateway = FirebasePushGateway();
  ref.onDispose(gateway.dispose);
  return gateway;
}

/// Push'un o anki durumu.
enum PushStatus {
  /// Oturum yok; push başlatılmadı.
  idle,

  /// Firebase bağlı değil ya da kullanıcı izni reddetti.
  unavailable,

  /// Jeton alındı ve sunucuya yazıldı.
  registered,
}

/// Jeton kaydını oturuma bağlar.
///
/// Oturum AÇILINCA başlar, KAPANINCA jetonun bağını koparır. Jeton oturumdan
/// bağımsız kaydedilseydi, telefonu devreden çıkan kullanıcıya artık onun
/// olmayan sürünün uyarıları gitmeye devam ederdi.
///
/// keepAlive: ekran değiştiğinde yeniden kurulursa izin penceresi tekrar
/// açılır ve jeton her seferinde yeniden yazılırdı.
@Riverpod(keepAlive: true)
class PushRegistration extends _$PushRegistration {
  @override
  Future<PushStatus> build() async {
    final gateway = ref.watch(pushGatewayProvider);
    final signedIn = ref.watch(authProvider).isSignedIn;

    if (!signedIn) {
      await _unregister(gateway);
      return PushStatus.idle;
    }

    final token = await gateway.start();
    if (token == null) return PushStatus.unavailable;

    // Jeton yenilenirse yenisi de yazılır: eskisine gönderilen push kimseye
    // ulaşmaz ve kullanıcı sessizce uyarı almaz hâle gelirdi.
    final sub = gateway.tokenRefresh.listen(_register);
    ref.onDispose(sub.cancel);

    await _register(token);
    return PushStatus.registered;
  }

  Future<void> _register(String token) async {
    _lastToken = token;
    try {
      await ref
          .read(repositoryProvider)
          .registerPushToken(token: token, platform: _platform);
    } catch (e) {
      // Kayıt başarısızlığı uygulamayı DURDURMAZ: push olmadan da sağım
      // yapılır. Bir sonraki açılışta yeniden denenir.
      debugPrint('[push] jeton kaydedilemedi: $e');
    }
  }

  Future<void> _unregister(PushGateway gateway) async {
    await gateway.stop();

    final token = _lastToken;
    _lastToken = null;
    if (token == null) return;

    try {
      await ref.read(repositoryProvider).unregisterPushToken(token);
    } catch (e) {
      // Çıkış anında token da geçersizleşmiş olabilir; sunucu tarafında
      // oturuma bağlı jetonların temizlenmesi asıl güvencedir.
      debugPrint('[push] jeton silinemedi: $e');
    }
  }

  String? _lastToken;

  /// Sunucunun jetonu hangi sağlayıcıya göndereceğini bilmesi için.
  static String get _platform {
    if (kIsWeb) return 'web';
    return Platform.isIOS ? 'ios' : 'android';
  }
}

/// Bildirime dokunulduğunda gidilecek yol.
///
/// Yönlendirmeyi provider DEĞİL, dinleyen widget yapar: gezinme bir yan
/// etkidir ve provider'ın içinden router'a dokunmak, iki ayrı durum
/// makinesini birbirine düğümlerdi.
@Riverpod(keepAlive: true)
Stream<PushMessage> pushTaps(Ref ref) => ref.watch(pushGatewayProvider).taps;
