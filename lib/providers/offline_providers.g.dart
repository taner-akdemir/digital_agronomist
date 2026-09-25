// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Çevrimdışı önbelleğin deposu (§18/7). Testte bellek içi depoyla ezilir.

@ProviderFor(cacheStore)
final cacheStoreProvider = CacheStoreProvider._();

/// Çevrimdışı önbelleğin deposu (§18/7). Testte bellek içi depoyla ezilir.

final class CacheStoreProvider
    extends $FunctionalProvider<CacheStore, CacheStore, CacheStore>
    with $Provider<CacheStore> {
  /// Çevrimdışı önbelleğin deposu (§18/7). Testte bellek içi depoyla ezilir.
  CacheStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheStoreHash();

  @$internal
  @override
  $ProviderElement<CacheStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CacheStore create(Ref ref) {
    return cacheStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheStore>(value),
    );
  }
}

String _$cacheStoreHash() => r'752757242b36e36a21e528bd0d4a8021a3529fda';

/// Bağlantı durumu: null = çevrimiçi; dolu = son okumalar önbellekten geldi
/// ve gösterilen verinin ne zamana ait olduğu.
///
/// Ağ durumunu cihazdan (connectivity) değil İSTEKLERDEN öğreniyoruz: Wi-Fi
/// bağlı ama ahırın interneti yok olabilir; kullanıcı için önemli olan
/// sunucuya ulaşılıp ulaşılamadığı.

@ProviderFor(OfflineStatus)
final offlineStatusProvider = OfflineStatusProvider._();

/// Bağlantı durumu: null = çevrimiçi; dolu = son okumalar önbellekten geldi
/// ve gösterilen verinin ne zamana ait olduğu.
///
/// Ağ durumunu cihazdan (connectivity) değil İSTEKLERDEN öğreniyoruz: Wi-Fi
/// bağlı ama ahırın interneti yok olabilir; kullanıcı için önemli olan
/// sunucuya ulaşılıp ulaşılamadığı.
final class OfflineStatusProvider
    extends $NotifierProvider<OfflineStatus, DateTime?> {
  /// Bağlantı durumu: null = çevrimiçi; dolu = son okumalar önbellekten geldi
  /// ve gösterilen verinin ne zamana ait olduğu.
  ///
  /// Ağ durumunu cihazdan (connectivity) değil İSTEKLERDEN öğreniyoruz: Wi-Fi
  /// bağlı ama ahırın interneti yok olabilir; kullanıcı için önemli olan
  /// sunucuya ulaşılıp ulaşılamadığı.
  OfflineStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineStatusHash();

  @$internal
  @override
  OfflineStatus create() => OfflineStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$offlineStatusHash() => r'8eb6692046d56d8436091be5b70a7974bd18afd8';

/// Bağlantı durumu: null = çevrimiçi; dolu = son okumalar önbellekten geldi
/// ve gösterilen verinin ne zamana ait olduğu.
///
/// Ağ durumunu cihazdan (connectivity) değil İSTEKLERDEN öğreniyoruz: Wi-Fi
/// bağlı ama ahırın interneti yok olabilir; kullanıcı için önemli olan
/// sunucuya ulaşılıp ulaşılamadığı.

abstract class _$OfflineStatus extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
