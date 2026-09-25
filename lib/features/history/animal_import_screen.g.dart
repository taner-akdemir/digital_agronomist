// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_import_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dosya seçici; testte yerine sahte konur.

@ProviderFor(importFilePicker)
final importFilePickerProvider = ImportFilePickerProvider._();

/// Dosya seçici; testte yerine sahte konur.

final class ImportFilePickerProvider
    extends
        $FunctionalProvider<
          Future<ImportFile?> Function(),
          Future<ImportFile?> Function(),
          Future<ImportFile?> Function()
        >
    with $Provider<Future<ImportFile?> Function()> {
  /// Dosya seçici; testte yerine sahte konur.
  ImportFilePickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importFilePickerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$importFilePickerHash();

  @$internal
  @override
  $ProviderElement<Future<ImportFile?> Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<ImportFile?> Function() create(Ref ref) {
    return importFilePicker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<ImportFile?> Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<ImportFile?> Function()>(
        value,
      ),
    );
  }
}

String _$importFilePickerHash() => r'a528c9caae07db1300080cb71d27dc29ff7b1586';
