// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Açık oturumlar (backend ADR 0105).

@ProviderFor(loginSessions)
final loginSessionsProvider = LoginSessionsProvider._();

/// Açık oturumlar (backend ADR 0105).

final class LoginSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserSession>>,
          List<UserSession>,
          FutureOr<List<UserSession>>
        >
    with
        $FutureModifier<List<UserSession>>,
        $FutureProvider<List<UserSession>> {
  /// Açık oturumlar (backend ADR 0105).
  LoginSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginSessionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginSessionsHash();

  @$internal
  @override
  $FutureProviderElement<List<UserSession>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserSession>> create(Ref ref) {
    return loginSessions(ref);
  }
}

String _$loginSessionsHash() => r'6196f61bb8752c05db532315e1a5cd220185dbbe';
