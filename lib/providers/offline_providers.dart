import 'package:milktrace/data/cache/cache_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'offline_providers.g.dart';

/// Önbellek anahtarlarının ortak öneki. Çıkışta bununla başlayan her şey
/// silinir.
const offlineCachePrefix = 'mtcache:v1:';

/// Çevrimdışı önbelleğin deposu (§18/7). Testte bellek içi depoyla ezilir.
@Riverpod(keepAlive: true)
CacheStore cacheStore(Ref ref) => PrefsCacheStore();

/// Bağlantı durumu: null = çevrimiçi; dolu = son okumalar önbellekten geldi
/// ve gösterilen verinin ne zamana ait olduğu.
///
/// Ağ durumunu cihazdan (connectivity) değil İSTEKLERDEN öğreniyoruz: Wi-Fi
/// bağlı ama ahırın interneti yok olabilir; kullanıcı için önemli olan
/// sunucuya ulaşılıp ulaşılamadığı.
@Riverpod(keepAlive: true)
class OfflineStatus extends _$OfflineStatus {
  @override
  DateTime? build() => null;

  /// Bir okuma önbellekten döndü; [dataAt] o verinin kaydedildiği an. En
  /// ESKİSİ tutulur: ekrandaki verinin en eskisi kadar güncel olduğunu
  /// söylemek dürüst olan.
  void offline(DateTime dataAt) {
    final cur = state;
    if (cur == null || dataAt.isBefore(cur)) state = dataAt;
  }

  /// Bir istek sunucuya ulaştı.
  void online() {
    if (state != null) state = null;
  }
}
