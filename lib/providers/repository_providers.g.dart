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
/// görür. Geçiş `--dart-define=MT_API=http` ile yapılır (§15.2).

@ProviderFor(repository)
final repositoryProvider = RepositoryProvider._();

/// Uygulamanın veri kaynağı.
///
/// Mock mu gerçek API mi olduğu YALNIZCA burada bilinir; ekranlar arayüzü
/// görür. Geçiş `--dart-define=MT_API=http` ile yapılır (§15.2).

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
  /// görür. Geçiş `--dart-define=MT_API=http` ile yapılır (§15.2).
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

String _$repositoryHash() => r'9362a8d80a75601ea911147edd70b58e2eb4a60d';
