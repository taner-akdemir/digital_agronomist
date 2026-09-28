// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Push altyapısı.
///
/// Mock modda KAPALI: o modda kimlik sunucusu yok, jetonu yazacak bir uç da
/// yok ve izin penceresi demo sırasında ekranın önüne düşerdi.

@ProviderFor(pushGateway)
final pushGatewayProvider = PushGatewayProvider._();

/// Push altyapısı.
///
/// Mock modda KAPALI: o modda kimlik sunucusu yok, jetonu yazacak bir uç da
/// yok ve izin penceresi demo sırasında ekranın önüne düşerdi.

final class PushGatewayProvider
    extends $FunctionalProvider<PushGateway, PushGateway, PushGateway>
    with $Provider<PushGateway> {
  /// Push altyapısı.
  ///
  /// Mock modda KAPALI: o modda kimlik sunucusu yok, jetonu yazacak bir uç da
  /// yok ve izin penceresi demo sırasında ekranın önüne düşerdi.
  PushGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushGatewayHash();

  @$internal
  @override
  $ProviderElement<PushGateway> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PushGateway create(Ref ref) {
    return pushGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushGateway>(value),
    );
  }
}

String _$pushGatewayHash() => r'97901a9aa11285a410452de9077aeefa8b657814';

/// Jeton kaydını oturuma bağlar.
///
/// Oturum AÇILINCA başlar, KAPANINCA jetonun bağını koparır. Jeton oturumdan
/// bağımsız kaydedilseydi, telefonu devreden çıkan kullanıcıya artık onun
/// olmayan sürünün uyarıları gitmeye devam ederdi.
///
/// keepAlive: ekran değiştiğinde yeniden kurulursa izin penceresi tekrar
/// açılır ve jeton her seferinde yeniden yazılırdı.

@ProviderFor(PushRegistration)
final pushRegistrationProvider = PushRegistrationProvider._();

/// Jeton kaydını oturuma bağlar.
///
/// Oturum AÇILINCA başlar, KAPANINCA jetonun bağını koparır. Jeton oturumdan
/// bağımsız kaydedilseydi, telefonu devreden çıkan kullanıcıya artık onun
/// olmayan sürünün uyarıları gitmeye devam ederdi.
///
/// keepAlive: ekran değiştiğinde yeniden kurulursa izin penceresi tekrar
/// açılır ve jeton her seferinde yeniden yazılırdı.
final class PushRegistrationProvider
    extends $AsyncNotifierProvider<PushRegistration, PushStatus> {
  /// Jeton kaydını oturuma bağlar.
  ///
  /// Oturum AÇILINCA başlar, KAPANINCA jetonun bağını koparır. Jeton oturumdan
  /// bağımsız kaydedilseydi, telefonu devreden çıkan kullanıcıya artık onun
  /// olmayan sürünün uyarıları gitmeye devam ederdi.
  ///
  /// keepAlive: ekran değiştiğinde yeniden kurulursa izin penceresi tekrar
  /// açılır ve jeton her seferinde yeniden yazılırdı.
  PushRegistrationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushRegistrationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushRegistrationHash();

  @$internal
  @override
  PushRegistration create() => PushRegistration();
}

String _$pushRegistrationHash() => r'cc1cc972fa07d9d48b755fb79074ac3963c6b9af';

/// Jeton kaydını oturuma bağlar.
///
/// Oturum AÇILINCA başlar, KAPANINCA jetonun bağını koparır. Jeton oturumdan
/// bağımsız kaydedilseydi, telefonu devreden çıkan kullanıcıya artık onun
/// olmayan sürünün uyarıları gitmeye devam ederdi.
///
/// keepAlive: ekran değiştiğinde yeniden kurulursa izin penceresi tekrar
/// açılır ve jeton her seferinde yeniden yazılırdı.

abstract class _$PushRegistration extends $AsyncNotifier<PushStatus> {
  FutureOr<PushStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PushStatus>, PushStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PushStatus>, PushStatus>,
              AsyncValue<PushStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Bildirime dokunulduğunda gidilecek yol.
///
/// Yönlendirmeyi provider DEĞİL, dinleyen widget yapar: gezinme bir yan
/// etkidir ve provider'ın içinden router'a dokunmak, iki ayrı durum
/// makinesini birbirine düğümlerdi.

@ProviderFor(pushTaps)
final pushTapsProvider = PushTapsProvider._();

/// Bildirime dokunulduğunda gidilecek yol.
///
/// Yönlendirmeyi provider DEĞİL, dinleyen widget yapar: gezinme bir yan
/// etkidir ve provider'ın içinden router'a dokunmak, iki ayrı durum
/// makinesini birbirine düğümlerdi.

final class PushTapsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PushMessage>,
          PushMessage,
          Stream<PushMessage>
        >
    with $FutureModifier<PushMessage>, $StreamProvider<PushMessage> {
  /// Bildirime dokunulduğunda gidilecek yol.
  ///
  /// Yönlendirmeyi provider DEĞİL, dinleyen widget yapar: gezinme bir yan
  /// etkidir ve provider'ın içinden router'a dokunmak, iki ayrı durum
  /// makinesini birbirine düğümlerdi.
  PushTapsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushTapsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushTapsHash();

  @$internal
  @override
  $StreamProviderElement<PushMessage> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<PushMessage> create(Ref ref) {
    return pushTaps(ref);
  }
}

String _$pushTapsHash() => r'c4e339a5b9be4f9c04590ae09e6373a4c96a49cb';
