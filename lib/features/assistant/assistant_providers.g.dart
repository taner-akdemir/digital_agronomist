// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assistant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Asistan açık mı (backend ADR 0138)? Açıksa durum, değilse null.
///
/// null — giriş HİÇ görünmez: sunucu kapalı (`enabled: false`), çağrı
/// düştü (çevrimdışı, eski backend, 403) ya da kullanıcı mandıra/tablet
/// hesabı (gateway zaten 403 döner). keepAlive: oturum değişince
/// (authProvider) ya da 503 gelince yeniden sorulur.

@ProviderFor(assistantStatus)
final assistantStatusProvider = AssistantStatusProvider._();

/// Asistan açık mı (backend ADR 0138)? Açıksa durum, değilse null.
///
/// null — giriş HİÇ görünmez: sunucu kapalı (`enabled: false`), çağrı
/// düştü (çevrimdışı, eski backend, 403) ya da kullanıcı mandıra/tablet
/// hesabı (gateway zaten 403 döner). keepAlive: oturum değişince
/// (authProvider) ya da 503 gelince yeniden sorulur.

final class AssistantStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<AssistantStatus?>,
          AssistantStatus?,
          FutureOr<AssistantStatus?>
        >
    with $FutureModifier<AssistantStatus?>, $FutureProvider<AssistantStatus?> {
  /// Asistan açık mı (backend ADR 0138)? Açıksa durum, değilse null.
  ///
  /// null — giriş HİÇ görünmez: sunucu kapalı (`enabled: false`), çağrı
  /// düştü (çevrimdışı, eski backend, 403) ya da kullanıcı mandıra/tablet
  /// hesabı (gateway zaten 403 döner). keepAlive: oturum değişince
  /// (authProvider) ya da 503 gelince yeniden sorulur.
  AssistantStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assistantStatusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assistantStatusHash();

  @$internal
  @override
  $FutureProviderElement<AssistantStatus?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<AssistantStatus?> create(Ref ref) {
    return assistantStatus(ref);
  }
}

String _$assistantStatusHash() => r'4739cab08df81b31dfb0b6b614764a3923e39cbe';

@ProviderFor(AssistantChat)
final assistantChatProvider = AssistantChatProvider._();

final class AssistantChatProvider
    extends $NotifierProvider<AssistantChat, AssistantChatState> {
  AssistantChatProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assistantChatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assistantChatHash();

  @$internal
  @override
  AssistantChat create() => AssistantChat();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AssistantChatState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AssistantChatState>(value),
    );
  }
}

String _$assistantChatHash() => r'152be112b2e8b1f8be6d25e5bff39ab18df68030';

abstract class _$AssistantChat extends $Notifier<AssistantChatState> {
  AssistantChatState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AssistantChatState, AssistantChatState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AssistantChatState, AssistantChatState>,
              AssistantChatState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
