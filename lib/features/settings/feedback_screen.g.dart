// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Görüntü seçici (galeri/dosyalar); testte yerine sahte konur.

@ProviderFor(feedbackImagePicker)
final feedbackImagePickerProvider = FeedbackImagePickerProvider._();

/// Görüntü seçici (galeri/dosyalar); testte yerine sahte konur.

final class FeedbackImagePickerProvider
    extends
        $FunctionalProvider<
          Future<FeedbackImage?> Function(),
          Future<FeedbackImage?> Function(),
          Future<FeedbackImage?> Function()
        >
    with $Provider<Future<FeedbackImage?> Function()> {
  /// Görüntü seçici (galeri/dosyalar); testte yerine sahte konur.
  FeedbackImagePickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedbackImagePickerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedbackImagePickerHash();

  @$internal
  @override
  $ProviderElement<Future<FeedbackImage?> Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<FeedbackImage?> Function() create(Ref ref) {
    return feedbackImagePicker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<FeedbackImage?> Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<FeedbackImage?> Function()>(
        value,
      ),
    );
  }
}

String _$feedbackImagePickerHash() =>
    r'8faf9fd062e34091ab064c4af281386245a979eb';
