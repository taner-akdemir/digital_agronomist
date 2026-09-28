// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Destek numaraları (backend ADR 0077). Okunamazsa (çevrimdışı, eski
/// backend) null: destek bölümü sessizce gizlenir, hata ekranı olmaz.
/// Mock modda sunucu yok. keepAlive: numara oturum boyunca değişmez ve
/// hesap kartı her açıldığında yeniden sorulmasın.

@ProviderFor(supportInfo)
final supportInfoProvider = SupportInfoProvider._();

/// Destek numaraları (backend ADR 0077). Okunamazsa (çevrimdışı, eski
/// backend) null: destek bölümü sessizce gizlenir, hata ekranı olmaz.
/// Mock modda sunucu yok. keepAlive: numara oturum boyunca değişmez ve
/// hesap kartı her açıldığında yeniden sorulmasın.

final class SupportInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<SupportInfo?>,
          SupportInfo?,
          FutureOr<SupportInfo?>
        >
    with $FutureModifier<SupportInfo?>, $FutureProvider<SupportInfo?> {
  /// Destek numaraları (backend ADR 0077). Okunamazsa (çevrimdışı, eski
  /// backend) null: destek bölümü sessizce gizlenir, hata ekranı olmaz.
  /// Mock modda sunucu yok. keepAlive: numara oturum boyunca değişmez ve
  /// hesap kartı her açıldığında yeniden sorulmasın.
  SupportInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportInfoHash();

  @$internal
  @override
  $FutureProviderElement<SupportInfo?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SupportInfo?> create(Ref ref) {
    return supportInfo(ref);
  }
}

String _$supportInfoHash() => r'7f327a5b1523865d41687b10393d4b4bcadb86cb';

/// Dış uygulamayı (WhatsApp, telefon) açar. Ayrı sağlayıcı: testte sahtesi.

@ProviderFor(supportLauncher)
final supportLauncherProvider = SupportLauncherProvider._();

/// Dış uygulamayı (WhatsApp, telefon) açar. Ayrı sağlayıcı: testte sahtesi.

final class SupportLauncherProvider
    extends
        $FunctionalProvider<
          Future<bool> Function(Uri),
          Future<bool> Function(Uri),
          Future<bool> Function(Uri)
        >
    with $Provider<Future<bool> Function(Uri)> {
  /// Dış uygulamayı (WhatsApp, telefon) açar. Ayrı sağlayıcı: testte sahtesi.
  SupportLauncherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportLauncherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportLauncherHash();

  @$internal
  @override
  $ProviderElement<Future<bool> Function(Uri)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<bool> Function(Uri) create(Ref ref) {
    return supportLauncher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<bool> Function(Uri) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<bool> Function(Uri)>(value),
    );
  }
}

String _$supportLauncherHash() => r'efa2bb05f59f9ab4407c7efe006f588e2361cd0b';

/// Uygulama sürümü, WhatsApp'taki hazır metne girer: "hangi sürüm?"
/// sorusu ilk mesajda cevaplanmış olsun.

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

/// Uygulama sürümü, WhatsApp'taki hazır metne girer: "hangi sürüm?"
/// sorusu ilk mesajda cevaplanmış olsun.

final class AppVersionProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Uygulama sürümü, WhatsApp'taki hazır metne girer: "hangi sürüm?"
  /// sorusu ilk mesajda cevaplanmış olsun.
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return appVersion(ref);
  }
}

String _$appVersionHash() => r'c21e14c088793e4657abda1b68f3ab3269801ad4';
