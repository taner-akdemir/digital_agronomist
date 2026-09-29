import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feedback_screen.g.dart';

/// Seçilen görüntünün baytları.
typedef FeedbackImage = ({String name, Uint8List bytes});

/// Görüntü seçici (galeri/dosyalar); testte yerine sahte konur.
@riverpod
Future<FeedbackImage?> Function() feedbackImagePicker(Ref ref) => () async {
  final files = await FilePicker.pickFiles(type: FileType.image);
  final f = files.firstOrNull;
  if (f == null) return null;
  return (name: f.name, bytes: await f.readAsBytes());
};

/// Sunucunun kabul ettiği en büyük görüntü (backend ADR 0106).
const feedbackMaxImageBytes = 2 * 1024 * 1024;

/// En uzun mesaj (karakter); sunucu da aynı sınırı uygular.
const feedbackMaxMessage = 4000;

/// Görüntünün türü İÇERİKTEN: galeri HEIC ya da GIF de verebilir, sunucu
/// yalnızca PNG/JPEG/WebP kabul ediyor. Tanınmazsa null.
String? feedbackImageType(Uint8List b) {
  bool at(int i, List<int> sig) {
    if (b.length < i + sig.length) return false;
    for (var k = 0; k < sig.length; k++) {
      if (b[i + k] != sig[k]) return false;
    }
    return true;
  }

  if (at(0, const [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A])) {
    return 'image/png';
  }
  if (at(0, const [0xFF, 0xD8, 0xFF])) return 'image/jpeg';
  if (at(0, 'RIFF'.codeUnits) && at(8, 'WEBPVP'.codeUnits)) {
    return 'image/webp';
  }
  return null;
}

/// Uygulama içi geri bildirim (backend ADR 0106): hesap kartından, bütün
/// rollere. Metin zorunlu; ekran görüntüsünü kullanıcı SEÇER. Sürüm, platform
/// ve cihazı depo ekler (`AppBuild.feedbackInfo`).
class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  final _form = GlobalKey<FormState>();
  final _message = TextEditingController();
  FeedbackImage? _image;
  String? _imageType;
  String? _imageError;
  bool _busy = false;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final f = await ref.read(feedbackImagePickerProvider)();
    if (f == null || !mounted) return;
    final type = feedbackImageType(f.bytes);
    final error = type == null
        ? l10n.feedbackScreenshotType
        : f.bytes.length > feedbackMaxImageBytes
        ? l10n.feedbackScreenshotTooLarge
        : null;
    setState(() {
      _imageError = error;
      _image = error == null ? f : null;
      _imageType = error == null ? type : null;
    });
  }

  Future<void> _send() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(repositoryProvider)
          .sendFeedback(
            message: _message.text.trim(),
            screenshot: _image?.bytes,
            contentType: _imageType,
          );
      messenger.showSnackBar(SnackBar(content: Text(l10n.feedbackSent)));
      if (mounted) context.canPop() ? context.pop() : context.go('/live');
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(userMessage(e) ?? l10n.feedbackSendFailed('$e')),
          backgroundColor: AppColors.dangerFill,
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = _image;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.feedbackTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              l10n.feedbackIntro,
              style: TextStyle(color: AppColors.onSurfaceMuted),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextFormField(
              key: const Key('feedbackMessage'),
              controller: _message,
              enabled: !_busy,
              minLines: 5,
              maxLines: 10,
              maxLength: feedbackMaxMessage,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: l10n.feedbackMessageLabel,
                hintText: l10n.feedbackMessageHint,
                alignLabelWithHint: true,
                border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
              ),
              validator: (v) => (v ?? '').trim().isEmpty
                  ? l10n.feedbackMessageRequired
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),
            if (image != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: AppRadius.smAll,
                    child: Image.memory(
                      image.bytes,
                      key: const Key('feedbackThumbnail'),
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) =>
                          const Icon(Icons.image_outlined, size: 48),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      image.name,
                      style: TextStyle(color: AppColors.onSurfaceMuted),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.feedbackRemoveScreenshot,
                    onPressed: _busy
                        ? null
                        : () => setState(() {
                            _image = null;
                            _imageType = null;
                          }),
                    icon: const Icon(Icons.close),
                  ),
                ],
              )
            else
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  onPressed: _busy ? null : _pick,
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: Text(l10n.feedbackAddScreenshot),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkGreenColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.mdAll,
                    ),
                  ),
                ),
              ),
            if (_imageError case final err?)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(err, style: TextStyle(color: AppColors.flowRed)),
              ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.icon(
              onPressed: _busy ? null : _send,
              icon: _busy
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              label: Text(l10n.feedbackSend),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brandFill,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.mdAll,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
