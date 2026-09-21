// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Uygulamanın veri kaynağı.
///
/// Mock mu gerçek API mi olduğu YALNIZCA burada bilinir; ekranlar arayüzü
/// görür. Geçiş `--dart-define=MT_API=mock` ile yapılır (§15.2).
///
/// Dio'yu BURADA kurmuyoruz: kimlik doğrulamalı istemci AuthSession'a ait.
/// İki ayrı Dio olsaydı token yenileme yalnızca birinde çalışır, diğeri
/// sessizce 401 almaya devam ederdi.

@ProviderFor(repository)
final repositoryProvider = RepositoryProvider._();

/// Uygulamanın veri kaynağı.
///
/// Mock mu gerçek API mi olduğu YALNIZCA burada bilinir; ekranlar arayüzü
/// görür. Geçiş `--dart-define=MT_API=mock` ile yapılır (§15.2).
///
/// Dio'yu BURADA kurmuyoruz: kimlik doğrulamalı istemci AuthSession'a ait.
/// İki ayrı Dio olsaydı token yenileme yalnızca birinde çalışır, diğeri
/// sessizce 401 almaya devam ederdi.

final class RepositoryProvider
    extends
        $FunctionalProvider<
          MilkTraceRepository,
          MilkTraceRepository,
          MilkTraceRepository
        >
    with $Provider<MilkTraceRepository> {
  /// Uygulamanın veri kaynağı.
  ///
  /// Mock mu gerçek API mi olduğu YALNIZCA burada bilinir; ekranlar arayüzü
  /// görür. Geçiş `--dart-define=MT_API=mock` ile yapılır (§15.2).
  ///
  /// Dio'yu BURADA kurmuyoruz: kimlik doğrulamalı istemci AuthSession'a ait.
  /// İki ayrı Dio olsaydı token yenileme yalnızca birinde çalışır, diğeri
  /// sessizce 401 almaya devam ederdi.
  RepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'repositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$repositoryHash();

  @$internal
  @override
  $ProviderElement<MilkTraceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MilkTraceRepository create(Ref ref) {
    return repository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MilkTraceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MilkTraceRepository>(value),
    );
  }
}

String _$repositoryHash() => r'851c3f698d62211bee88c301c820f9a42776a21b';
