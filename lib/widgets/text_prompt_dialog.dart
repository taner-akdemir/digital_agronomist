import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Tek alanlı giriş penceresi; girilen metni (kırpılmış) döner, vazgeçilirse
/// null.
///
/// Denetleyici pencerenin KENDİ durumunda: çağıran `showDialog`dan dönünce
/// dispose etseydi, kapanış animasyonu sürerken alan atılmış denetleyiciyi
/// kullanır ve "used after being disposed" hatası verirdi.
Future<String?> showTextPrompt(
  BuildContext context, {
  required String title,
  required String label,
  String initial = '',
  String? helper,
  int? maxLength,
  TextInputType? keyboardType,
}) => showDialog<String>(
  context: context,
  builder: (_) => _TextPromptDialog(
    title: title,
    label: label,
    initial: initial,
    helper: helper,
    maxLength: maxLength,
    keyboardType: keyboardType,
  ),
);

class _TextPromptDialog extends StatefulWidget {
  const _TextPromptDialog({
    required this.title,
    required this.label,
    required this.initial,
    this.helper,
    this.maxLength,
    this.keyboardType,
  });

  final String title;
  final String label;
  final String initial;
  final String? helper;
  final int? maxLength;
  final TextInputType? keyboardType;

  @override
  State<_TextPromptDialog> createState() => _TextPromptDialogState();
}

class _TextPromptDialogState extends State<_TextPromptDialog> {
  late final _ctrl = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: widget.label,
          helperText: widget.helper,
          helperMaxLines: 2,
          border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_ctrl.text.trim()),
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
