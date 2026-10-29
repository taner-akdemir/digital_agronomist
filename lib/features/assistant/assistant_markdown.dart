import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Asistan cevabındaki markdown'ın KÜÇÜK ve güvenli bir alt kümesi:
/// paragraf, başlık, madde ve sıralı liste; satır içinde **kalın**,
/// `kod`, [bağlantı](url) ve çıplak https bağlantısı. HTML, görüntü ve
/// tablo YOK — metin olduğu gibi kalır.
///
/// Markdown paketi eklenmedi: cevaplar kısa ve yardım merkezi biçiminde,
/// bu alt küme yetiyor; tam bir ayrıştırıcı (ve onun HTML/görüntü desteği)
/// burada gereksiz bir saldırı yüzeyi olurdu.
enum MdBlockKind { paragraph, heading, bullet, numbered }

typedef MdInline = ({String text, bool bold, bool code, Uri? link});

typedef MdBlock = ({MdBlockKind kind, String marker, List<MdInline> inlines});

/// Bağlantı yalnızca http(s) olabilir; `/yardim/...` gibi göreli yol sitenin
/// köküne bağlanır ve uygulama dili İngilizceyse `/en/help/...` olur
/// ([Env.localizedSitePath]; tam adres olduğu gibi kalır). Başka şema
/// (javascript:, intent:, file:) null — metin düz yazı olarak kalır.
Uri? assistantLinkUri(String raw, {String? language}) {
  final s = raw.trim();
  if (s.startsWith('/') && !s.startsWith('//')) {
    return Uri.tryParse(
      Env.siteUrl(Env.localizedSitePath(s, language ?? l10nLanguage)),
    );
  }
  final u = Uri.tryParse(s);
  if (u == null || !u.hasAuthority) return null;
  return u.scheme == 'https' || u.scheme == 'http' ? u : null;
}

final _inline = RegExp(
  r'\*\*(.+?)\*\*'
  r'|`([^`]+)`'
  r'|\[([^\]]+)\]\(([^)\s]+)\)'
  r'|(https?://[^\s<>()\[\]]+)',
);

List<MdInline> parseMdInline(String text) {
  final out = <MdInline>[];
  void plain(String t) {
    if (t.isNotEmpty) out.add((text: t, bold: false, code: false, link: null));
  }

  var at = 0;
  for (final m in _inline.allMatches(text)) {
    plain(text.substring(at, m.start));
    at = m.end;
    if (m.group(1) case final b?) {
      out.add((text: b, bold: true, code: false, link: null));
    } else if (m.group(2) case final c?) {
      out.add((text: c, bold: false, code: true, link: null));
    } else if (m.group(3) case final label?) {
      final uri = assistantLinkUri(m.group(4)!);
      out.add((text: label, bold: false, code: false, link: uri));
    } else if (m.group(5) case final bare?) {
      // Cümle sonundaki noktalama bağlantıya dahil değildir.
      final url = bare.replaceFirst(RegExp(r'[.,;:!?]+$'), '');
      out.add((
        text: url,
        bold: false,
        code: false,
        link: assistantLinkUri(url),
      ));
      plain(bare.substring(url.length));
    }
  }
  plain(text.substring(at));
  return out;
}

final _heading = RegExp(r'^#{1,6}\s+(.*)$');
final _bullet = RegExp(r'^\s*[-*•]\s+(.*)$');
final _numbered = RegExp(r'^\s*(\d{1,3})[.)]\s+(.*)$');

List<MdBlock> parseAssistantMarkdown(String source) {
  final blocks = <MdBlock>[];
  final para = <String>[];
  void flush() {
    if (para.isEmpty) return;
    blocks.add((
      kind: MdBlockKind.paragraph,
      marker: '',
      inlines: parseMdInline(para.join('\n')),
    ));
    para.clear();
  }

  for (final line in source.replaceAll('\r\n', '\n').split('\n')) {
    if (line.trim().isEmpty) {
      flush();
    } else if (_heading.firstMatch(line) case final m?) {
      flush();
      blocks.add((
        kind: MdBlockKind.heading,
        marker: '',
        inlines: parseMdInline(m.group(1)!),
      ));
    } else if (_bullet.firstMatch(line) case final m?) {
      flush();
      blocks.add((
        kind: MdBlockKind.bullet,
        marker: '•',
        inlines: parseMdInline(m.group(1)!),
      ));
    } else if (_numbered.firstMatch(line) case final m?) {
      flush();
      blocks.add((
        kind: MdBlockKind.numbered,
        marker: '${m.group(1)}.',
        inlines: parseMdInline(m.group(2)!),
      ));
    } else {
      para.add(line.trim());
    }
  }
  flush();
  return blocks;
}

/// Ayrıştırılmış cevabı çizer; bağlantıya dokunmak [onLink]'i çağırır.
class AssistantMarkdown extends StatefulWidget {
  const AssistantMarkdown({
    required this.data,
    required this.onLink,
    super.key,
  });

  final String data;
  final void Function(Uri uri) onLink;

  @override
  State<AssistantMarkdown> createState() => _AssistantMarkdownState();
}

class _AssistantMarkdownState extends State<AssistantMarkdown> {
  final _recognizers = <TapGestureRecognizer>[];

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  InlineSpan _span(MdInline i) {
    if (i.link case final uri?) {
      final r = TapGestureRecognizer()..onTap = () => widget.onLink(uri);
      _recognizers.add(r);
      return TextSpan(
        text: i.text,
        recognizer: r,
        style: TextStyle(
          color: AppColors.darkGreenColor,
          decoration: TextDecoration.underline,
          fontWeight: i.bold ? FontWeight.w600 : null,
        ),
      );
    }
    return TextSpan(
      text: i.text,
      style: TextStyle(
        fontWeight: i.bold ? FontWeight.w600 : null,
        fontFamily: i.code ? 'monospace' : null,
        backgroundColor: i.code ? AppColors.surfaceAlt : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    final base = TextStyle(color: AppColors.onSurface, height: 1.4);
    final blocks = parseAssistantMarkdown(widget.data);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (i, b) in blocks.indexed)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : AppSpacing.xs),
            child: switch (b.kind) {
              MdBlockKind.paragraph || MdBlockKind.heading => Text.rich(
                TextSpan(children: [for (final s in b.inlines) _span(s)]),
                style: b.kind == MdBlockKind.heading
                    ? base.copyWith(fontWeight: FontWeight.w600)
                    : base,
              ),
              MdBlockKind.bullet || MdBlockKind.numbered => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 22, child: Text(b.marker, style: base)),
                  Expanded(
                    child: Text.rich(
                      TextSpan(children: [for (final s in b.inlines) _span(s)]),
                      style: base,
                    ),
                  ),
                ],
              ),
            },
          ),
      ],
    );
  }
}
