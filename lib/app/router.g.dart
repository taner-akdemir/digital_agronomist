// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Uygulamanın tek yönlendirme tablosu.
///
/// Eskiden İKİ tane vardı: main.dart'ta bir onGenerateRoute ve sekme
/// kabuğunun içinde ondan bağımsız ikinci bir tane. İkisi birbirini
/// görmüyordu ve uygulamanın nereye gittiğini takip etmek zordu.
///
/// keepAlive: router yeniden kurulursa gezinme geçmişi sıfırlanır.

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// Uygulamanın tek yönlendirme tablosu.
///
/// Eskiden İKİ tane vardı: main.dart'ta bir onGenerateRoute ve sekme
/// kabuğunun içinde ondan bağımsız ikinci bir tane. İkisi birbirini
/// görmüyordu ve uygulamanın nereye gittiğini takip etmek zordu.
///
/// keepAlive: router yeniden kurulursa gezinme geçmişi sıfırlanır.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// Uygulamanın tek yönlendirme tablosu.
  ///
  /// Eskiden İKİ tane vardı: main.dart'ta bir onGenerateRoute ve sekme
  /// kabuğunun içinde ondan bağımsız ikinci bir tane. İkisi birbirini
  /// görmüyordu ve uygulamanın nereye gittiğini takip etmek zordu.
  ///
  /// keepAlive: router yeniden kurulursa gezinme geçmişi sıfırlanır.
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'd3f25a8aeb96f43e057e37d080fd4edd08de880c';
