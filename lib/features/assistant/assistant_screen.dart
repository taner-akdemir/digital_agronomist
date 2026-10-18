import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/data/models/assistant.dart';
import 'package:milktrace/domain/assistant_history.dart';
import 'package:milktrace/features/assistant/assistant_markdown.dart';
import 'package:milktrace/features/assistant/assistant_providers.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/l10n/l10n.dart';

/// Yardım asistanı (backend ADR 0138, aşama 1): yardım merkezi içeriğinden
/// cevap verir. Cevap tek parça gelir (akış yok) ve birkaç saniye sürebilir.
///
/// Geçmiş YALNIZCA bu ekranın belleğinde (KVKK): `assistantChatProvider`
/// autoDispose, ekran kapanınca metin gider; cihaza hiçbir şey yazılmaz.
class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _input.addListener(() => setState(() {}));
    // Durum oturum boyunca tutulur; ekran her açılışta kalan hakkı tazeler.
    ref.invalidate(assistantStatusProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) => _notice());
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _close() => context.canPop() ? context.pop() : context.go('/live');

  /// İlk kullanımda bir kez: sorular Anthropic'e gider, çiftlik verisi
  /// gitmez, metin saklanmaz. Onaylamayan ekrandan çıkar.
  Future<void> _notice() async {
    final acked = await ref.read(assistantNoticeAckProvider.future);
    if (acked || !mounted) return;
    final ok = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.assistantNoticeTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.assistantNoticeBody),
            const SizedBox(height: AppSpacing.sm),
            TextButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: AppColors.darkGreenColor,
              ),
              onPressed: () => _open(Uri.parse(Env.privacyPolicyUrl)),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: Text(l10n.assistantNoticePrivacy),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.brandFill),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.assistantNoticeAccept),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (ok ?? false) {
      await ref.read(assistantNoticeAckProvider.notifier).accept();
    } else {
      _close();
    }
  }

  /// Bağlantılar dış tarayıcıda açılır.
  Future<void> _open(Uri uri) async {
    final messenger = ScaffoldMessenger.of(context);
    var ok = false;
    try {
      ok = await ref.read(supportLauncherProvider)(uri);
    } on Object {
      ok = false;
    }
    if (!ok) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.assistantLinkFailed('$uri'))),
      );
    }
  }

  Future<void> _send() async {
    final text = _input.text;
    final sent = ref.read(assistantChatProvider.notifier).send(text);
    _scrollToEnd();
    if (await sent && mounted) {
      _input.clear();
      _scrollToEnd();
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chat = ref.watch(assistantChatProvider);
    final status = ref.watch(assistantStatusProvider).value;
    final remaining = chat.remainingToday ?? status?.remainingToday;
    final canType = !chat.busy && !chat.blocked && chat.canAskMore;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.commonBack,
          onPressed: _close,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          l10n.assistantTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
        actions: [
          IconButton(
            key: const Key('assistantNewConversation'),
            tooltip: l10n.assistantNewConversation,
            onPressed: chat.busy || chat.entries.isEmpty
                ? null
                : () {
                    ref.read(assistantChatProvider.notifier).newConversation();
                    _input.clear();
                  },
            icon: const Icon(Icons.add_comment_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (remaining != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.assistantRemainingToday(remaining),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceMuted,
                    ),
                  ),
                ),
              ),
            Expanded(
              child: ListView(
                controller: _scroll,
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  if (chat.entries.isEmpty && !chat.busy)
                    Text(
                      l10n.assistantIntro,
                      style: TextStyle(color: AppColors.onSurfaceMuted),
                    ),
                  for (final e in chat.entries)
                    e.message.role == assistantUser
                        ? _UserBubble(text: e.message.text)
                        : _AnswerBubble(entry: e, onLink: _open),
                  if (chat.pending case final q?) ...[
                    _UserBubble(text: q),
                    const _Thinking(),
                  ],
                ],
              ),
            ),
            if (chat.failure case final f?)
              _Notice(text: f.message, danger: true),
            if (!chat.canAskMore && chat.failure == null)
              _Notice(text: l10n.assistantLimitReached, danger: false),
            _InputBar(
              controller: _input,
              enabled: canType,
              onSend: _input.text.trim().isEmpty || !canType ? null : _send,
            ),
          ],
        ),
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(
          left: AppSpacing.xxl,
          bottom: AppSpacing.md,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.lightGreenColor,
          borderRadius: AppRadius.mdAll,
        ),
        child: Text(text, style: TextStyle(color: AppColors.onSurface)),
      ),
    );
  }
}

class _AnswerBubble extends StatelessWidget {
  const _AnswerBubble({required this.entry, required this.onLink});

  final AssistantEntry entry;
  final void Function(Uri uri) onLink;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          right: AppSpacing.xl,
          bottom: AppSpacing.md,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AssistantMarkdown(data: entry.message.text, onLink: onLink),
            if (entry.sources.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.assistantSources,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurfaceMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final s in entry.sources) _SourceChip(s, onLink),
                ],
              ),
            ],
            if (entry.handoff) ...[
              const SizedBox(height: AppSpacing.md),
              _HandoffCard(onLink: onLink),
            ],
          ],
        ),
      ),
    );
  }
}

class _SourceChip extends StatelessWidget {
  const _SourceChip(this.source, this.onLink);

  final AssistantSource source;
  final void Function(Uri uri) onLink;

  @override
  Widget build(BuildContext context) {
    final uri = assistantLinkUri(
      source.url.isNotEmpty ? source.url : '/yardim/${source.slug}',
    );
    return ActionChip(
      avatar: Icon(
        Icons.article_outlined,
        size: 16,
        color: AppColors.darkGreenColor,
      ),
      label: Text(source.title.isNotEmpty ? source.title : source.slug),
      onPressed: uri == null ? null : () => onLink(uri),
    );
  }
}

/// Devretme (ADR 0138 madde 8): numara sunucudan (`GET /auth/support`,
/// `supportInfoProvider`), uygulamaya gömülmez. Numara yoksa yardım merkezi.
class _HandoffCard extends ConsumerWidget {
  const _HandoffCard({required this.onLink});

  final void Function(Uri uri) onLink;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(supportInfoProvider).value;
    final hasNumber = info != null && (info.phone ?? info.whatsapp) != null;
    return Container(
      key: const Key('assistantHandoff'),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: AppRadius.mdAll,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.assistantHandoffTitle,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.assistantHandoffBody,
            style: TextStyle(color: AppColors.onSurfaceMuted),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (hasNumber)
            const SupportButtons()
          else
            OutlinedButton.icon(
              onPressed: () => onLink(Uri.parse(Env.helpCenterUrl)),
              icon: const Icon(Icons.help_outline),
              label: Text(l10n.assistantHandoffHelpCenter),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.darkGreenColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.mdAll,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Thinking extends StatelessWidget {
  const _Thinking();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          const SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            l10n.assistantThinking,
            style: TextStyle(color: AppColors.onSurfaceMuted),
          ),
        ],
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({required this.text, required this.danger});

  final String text;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: danger ? AppColors.flowRedSurface : AppColors.flowYellowSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: danger ? AppColors.darkRedColor : AppColors.darkAmberColor,
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.enabled,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool enabled;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              key: const Key('assistantInput'),
              controller: controller,
              enabled: enabled,
              minLines: 1,
              maxLines: 5,
              maxLength: AssistantLimits.maxMessageChars,
              textCapitalization: TextCapitalization.sentences,
              // Sayaç yalnızca sınıra yaklaşınca: her an "12/2000" görmek
              // kısa soruda gürültü.
              buildCounter:
                  (
                    context, {
                    required currentLength,
                    required isFocused,
                    required maxLength,
                  }) => currentLength < AssistantLimits.counterFrom
                  ? null
                  : Text('$currentLength/$maxLength'),
              decoration: InputDecoration(
                hintText: l10n.assistantInputHint,
                border: const OutlineInputBorder(borderRadius: AppRadius.mdAll),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: IconButton.filled(
              key: const Key('assistantSend'),
              tooltip: l10n.assistantSend,
              style: IconButton.styleFrom(backgroundColor: AppColors.brandFill),
              onPressed: onSend,
              icon: Icon(Icons.send, color: AppColors.onFill),
            ),
          ),
        ],
      ),
    );
  }
}
