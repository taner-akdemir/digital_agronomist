// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_queue_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Kuyruğun saati; testte sabitlenir.

@ProviderFor(writeQueueClock)
final writeQueueClockProvider = WriteQueueClockProvider._();

/// Kuyruğun saati; testte sabitlenir.

final class WriteQueueClockProvider
    extends
        $FunctionalProvider<
          DateTime Function(),
          DateTime Function(),
          DateTime Function()
        >
    with $Provider<DateTime Function()> {
  /// Kuyruğun saati; testte sabitlenir.
  WriteQueueClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'writeQueueClockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$writeQueueClockHash();

  @$internal
  @override
  $ProviderElement<DateTime Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DateTime Function() create(Ref ref) {
    return writeQueueClock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime Function()>(value),
    );
  }
}

String _$writeQueueClockHash() => r'c8d8468293b85bb1e977374dc9ae7f4d4ae6878d';

/// Kuyruktan kayıt teslim edildikçe artar. Kayıt listelerini okuyan
/// sağlayıcılar (notlar, tedaviler, üreme, aşı, hayvanlar) bunu izler:
/// "Bekliyor" satırı kalkınca gerçek kayıt yerine gelsin.

@ProviderFor(WriteQueueDelivered)
final writeQueueDeliveredProvider = WriteQueueDeliveredProvider._();

/// Kuyruktan kayıt teslim edildikçe artar. Kayıt listelerini okuyan
/// sağlayıcılar (notlar, tedaviler, üreme, aşı, hayvanlar) bunu izler:
/// "Bekliyor" satırı kalkınca gerçek kayıt yerine gelsin.
final class WriteQueueDeliveredProvider
    extends $NotifierProvider<WriteQueueDelivered, int> {
  /// Kuyruktan kayıt teslim edildikçe artar. Kayıt listelerini okuyan
  /// sağlayıcılar (notlar, tedaviler, üreme, aşı, hayvanlar) bunu izler:
  /// "Bekliyor" satırı kalkınca gerçek kayıt yerine gelsin.
  WriteQueueDeliveredProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'writeQueueDeliveredProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$writeQueueDeliveredHash();

  @$internal
  @override
  WriteQueueDelivered create() => WriteQueueDelivered();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$writeQueueDeliveredHash() =>
    r'dbf09ead3d3c4bd1a2ae790e17036bfe5b9eca1a';

/// Kuyruktan kayıt teslim edildikçe artar. Kayıt listelerini okuyan
/// sağlayıcılar (notlar, tedaviler, üreme, aşı, hayvanlar) bunu izler:
/// "Bekliyor" satırı kalkınca gerçek kayıt yerine gelsin.

abstract class _$WriteQueueDelivered extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Çevrimdışı yazma kuyruğu (backend ADR 0140).
///
/// Durum: seçili kullanıcı + işletmenin kuyruğu, oluşturulma sırasıyla.
/// Ekranlar [submit] ile yazar: önce doğrudan gönderilir, yalnızca sunucuya
/// ULAŞILAMAZSA ([isNetworkError]) kayıt kuyruğa girer. Sunucunun verdiği
/// hata (4xx, 500) eskisi gibi ekrana çıkar.
///
/// Boşaltma ([flush]) katı FIFO'dur: yeniden denenecek hata boşaltmayı
/// durdurur, reddedilen kayıt gönderilemeyenlere alınır ve sıradakine
/// geçilir. Tetikleyiciler: bağlantı dönünce (burada), uygulama öne gelince
/// ve bekleyen varken periyodik (`WriteQueueListener`).

@ProviderFor(WriteQueue)
final writeQueueProvider = WriteQueueProvider._();

/// Çevrimdışı yazma kuyruğu (backend ADR 0140).
///
/// Durum: seçili kullanıcı + işletmenin kuyruğu, oluşturulma sırasıyla.
/// Ekranlar [submit] ile yazar: önce doğrudan gönderilir, yalnızca sunucuya
/// ULAŞILAMAZSA ([isNetworkError]) kayıt kuyruğa girer. Sunucunun verdiği
/// hata (4xx, 500) eskisi gibi ekrana çıkar.
///
/// Boşaltma ([flush]) katı FIFO'dur: yeniden denenecek hata boşaltmayı
/// durdurur, reddedilen kayıt gönderilemeyenlere alınır ve sıradakine
/// geçilir. Tetikleyiciler: bağlantı dönünce (burada), uygulama öne gelince
/// ve bekleyen varken periyodik (`WriteQueueListener`).
final class WriteQueueProvider
    extends $NotifierProvider<WriteQueue, List<PendingWrite>> {
  /// Çevrimdışı yazma kuyruğu (backend ADR 0140).
  ///
  /// Durum: seçili kullanıcı + işletmenin kuyruğu, oluşturulma sırasıyla.
  /// Ekranlar [submit] ile yazar: önce doğrudan gönderilir, yalnızca sunucuya
  /// ULAŞILAMAZSA ([isNetworkError]) kayıt kuyruğa girer. Sunucunun verdiği
  /// hata (4xx, 500) eskisi gibi ekrana çıkar.
  ///
  /// Boşaltma ([flush]) katı FIFO'dur: yeniden denenecek hata boşaltmayı
  /// durdurur, reddedilen kayıt gönderilemeyenlere alınır ve sıradakine
  /// geçilir. Tetikleyiciler: bağlantı dönünce (burada), uygulama öne gelince
  /// ve bekleyen varken periyodik (`WriteQueueListener`).
  WriteQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'writeQueueProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$writeQueueHash();

  @$internal
  @override
  WriteQueue create() => WriteQueue();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PendingWrite> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PendingWrite>>(value),
    );
  }
}

String _$writeQueueHash() => r'797065d1034aec9cf9b96ce4a842273f88d80c88';

/// Çevrimdışı yazma kuyruğu (backend ADR 0140).
///
/// Durum: seçili kullanıcı + işletmenin kuyruğu, oluşturulma sırasıyla.
/// Ekranlar [submit] ile yazar: önce doğrudan gönderilir, yalnızca sunucuya
/// ULAŞILAMAZSA ([isNetworkError]) kayıt kuyruğa girer. Sunucunun verdiği
/// hata (4xx, 500) eskisi gibi ekrana çıkar.
///
/// Boşaltma ([flush]) katı FIFO'dur: yeniden denenecek hata boşaltmayı
/// durdurur, reddedilen kayıt gönderilemeyenlere alınır ve sıradakine
/// geçilir. Tetikleyiciler: bağlantı dönünce (burada), uygulama öne gelince
/// ve bekleyen varken periyodik (`WriteQueueListener`).

abstract class _$WriteQueue extends $Notifier<List<PendingWrite>> {
  List<PendingWrite> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<PendingWrite>, List<PendingWrite>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<PendingWrite>, List<PendingWrite>>,
              List<PendingWrite>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
