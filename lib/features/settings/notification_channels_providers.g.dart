// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_channels_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// İşletmenin bildirim kanalları. Ada göre sıralı: yeni eklenen kanalın
/// listenin neresinde çıkacağı tahmin edilebilir olsun.

@ProviderFor(notificationChannelList)
final notificationChannelListProvider = NotificationChannelListProvider._();

/// İşletmenin bildirim kanalları. Ada göre sıralı: yeni eklenen kanalın
/// listenin neresinde çıkacağı tahmin edilebilir olsun.

final class NotificationChannelListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NotificationChannel>>,
          List<NotificationChannel>,
          FutureOr<List<NotificationChannel>>
        >
    with
        $FutureModifier<List<NotificationChannel>>,
        $FutureProvider<List<NotificationChannel>> {
  /// İşletmenin bildirim kanalları. Ada göre sıralı: yeni eklenen kanalın
  /// listenin neresinde çıkacağı tahmin edilebilir olsun.
  NotificationChannelListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationChannelListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationChannelListHash();

  @$internal
  @override
  $FutureProviderElement<List<NotificationChannel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NotificationChannel>> create(Ref ref) {
    return notificationChannelList(ref);
  }
}

String _$notificationChannelListHash() =>
    r'6ecc6f416a36efef0001cc597b4bd55c5b0906f2';

/// Kanal türleri ve ayar alanları; formu çizmek için.

@ProviderFor(notificationProviderList)
final notificationProviderListProvider = NotificationProviderListProvider._();

/// Kanal türleri ve ayar alanları; formu çizmek için.

final class NotificationProviderListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NotificationProvider>>,
          List<NotificationProvider>,
          FutureOr<List<NotificationProvider>>
        >
    with
        $FutureModifier<List<NotificationProvider>>,
        $FutureProvider<List<NotificationProvider>> {
  /// Kanal türleri ve ayar alanları; formu çizmek için.
  NotificationProviderListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationProviderListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationProviderListHash();

  @$internal
  @override
  $FutureProviderElement<List<NotificationProvider>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NotificationProvider>> create(Ref ref) {
    return notificationProviderList(ref);
  }
}

String _$notificationProviderListHash() =>
    r'f6a3681ea2a0f90af1cfa4f9ae9bf57bfe8a7f64';
