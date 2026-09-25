// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yield_report.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Rapor dosyasını sistemin paylaşım penceresine verir (WhatsApp, e-posta,
/// Dosyalar). Testte yerine sahte konur.

@ProviderFor(reportSharer)
final reportSharerProvider = ReportSharerProvider._();

/// Rapor dosyasını sistemin paylaşım penceresine verir (WhatsApp, e-posta,
/// Dosyalar). Testte yerine sahte konur.

final class ReportSharerProvider
    extends
        $FunctionalProvider<
          Future<void> Function(ReportFile),
          Future<void> Function(ReportFile),
          Future<void> Function(ReportFile)
        >
    with $Provider<Future<void> Function(ReportFile)> {
  /// Rapor dosyasını sistemin paylaşım penceresine verir (WhatsApp, e-posta,
  /// Dosyalar). Testte yerine sahte konur.
  ReportSharerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportSharerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportSharerHash();

  @$internal
  @override
  $ProviderElement<Future<void> Function(ReportFile)> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<void> Function(ReportFile) create(Ref ref) {
    return reportSharer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<void> Function(ReportFile) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<void> Function(ReportFile)>(
        value,
      ),
    );
  }
}

String _$reportSharerHash() => r'7883aa60f328571fbcf3aa52fa6997ab75dd75d6';
