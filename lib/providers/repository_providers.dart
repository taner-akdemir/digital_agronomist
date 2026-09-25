import 'package:milktrace/core/env.dart';
import 'package:milktrace/data/repositories/api_repository.dart';
import 'package:milktrace/data/repositories/caching_repository.dart';
import 'package:milktrace/data/repositories/milktrace_repository.dart';
import 'package:milktrace/data/repositories/mock_repository.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/offline_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

/// Uygulamanın veri kaynağı.
///
/// Mock mu gerçek API mi olduğu YALNIZCA burada bilinir; ekranlar arayüzü
/// görür. Mock'a dönüş `--dart-define=MT_API=mock` ile yapılır (§15.2).
///
/// Dio'yu BURADA kurmuyoruz: kimlik doğrulamalı istemci AuthSession'a ait.
/// İki ayrı Dio olsaydı token yenileme yalnızca birinde çalışır, diğeri
/// sessizce 401 almaya devam ederdi.
@Riverpod(keepAlive: true)
MilkTraceRepository repository(Ref ref) {
  if (Env.apiMode == ApiMode.mock) {
    return MockRepository();
  }

  final session = ref.watch(authSessionProvider);

  // Canlı akış WebSocket'ten gelir (§8.5). Token'ı interceptor'dan
  // FONKSİYONLA okuyoruz: yenilendiğinde değişiyor ve her yeniden
  // bağlanmada güncel olanı gerekiyor.
  final status = ref.read(offlineStatusProvider.notifier);
  final api = ApiRepository(
    dio: session.authed,
    wsBaseUrl: Env.wsBaseUrl,
    accessToken: () => session.interceptor.accessToken,
    // Canlı bağlantı koptu: bant canlı tahtada da çıksın.
    onLiveLost: status.offline,
  );

  // Çevrimdışı okuma önbelleği (§18/7): ahırda kapsama koptuğunda son veri
  // gösterilir. Kapsam işletme + kullanıcı: aynı telefonda başka hesap,
  // öncekinin verisini görmemeli.
  final user = ref.watch(authProvider).user;
  return CachingRepository(
    inner: api,
    store: ref.watch(cacheStoreProvider),
    scope: '$offlineCachePrefix${user?.tenantId ?? '-'}:${user?.id ?? '-'}:',
    onOffline: status.offline,
    onOnline: status.online,
  );
}
