// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HTTP yığını. keepAlive: token'lar ve süren yenileme burada yaşıyor;
/// ekran değiştiğinde yeniden kurulursa kullanıcı oturumdan düşerdi.

@ProviderFor(authSession)
final authSessionProvider = AuthSessionProvider._();

/// HTTP yığını. keepAlive: token'lar ve süren yenileme burada yaşıyor;
/// ekran değiştiğinde yeniden kurulursa kullanıcı oturumdan düşerdi.

final class AuthSessionProvider
    extends $FunctionalProvider<AuthSession, AuthSession, AuthSession>
    with $Provider<AuthSession> {
  /// HTTP yığını. keepAlive: token'lar ve süren yenileme burada yaşıyor;
  /// ekran değiştiğinde yeniden kurulursa kullanıcı oturumdan düşerdi.
  AuthSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionHash();

  @$internal
  @override
  $ProviderElement<AuthSession> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthSession create(Ref ref) {
    return authSession(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSession value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSession>(value),
    );
  }
}

String _$authSessionHash() => r'8a8f4df87d54fbc465bcedd5fd3c50a8eb8fb042';

/// Oturum durumu.

@ProviderFor(Auth)
final authProvider = AuthProvider._();

/// Oturum durumu.
final class AuthProvider extends $NotifierProvider<Auth, AuthState> {
  /// Oturum durumu.
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authHash() => r'de4477fab23616f9be7b2d04e0144a4f5fd92969';

/// Oturum durumu.

abstract class _$Auth extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
