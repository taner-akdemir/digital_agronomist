import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/notification_channel.dart';
import 'package:milktrace/features/settings/channel_labels.dart';
import 'package:milktrace/features/settings/notification_channels_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// Bildirim kanalı ekleme ve düzenleme.
///
/// ALANLAR SAĞLAYICIDAN ÇİZİLİR (GET /notification-providers): yeni bir
/// sağlayıcı backend'e eklendiğinde uygulama güncellenmeden de
/// yapılandırılabilsin. Tanınmayan alan adıyla gösterilir.
class NotificationChannelFormScreen extends ConsumerWidget {
  /// Düzenleme: [channelId]. Ekleme: [kind] + [provider].
  const NotificationChannelFormScreen({
    super.key,
    this.channelId,
    this.kind,
    this.provider,
  });

  final String? channelId;
  final String? kind;
  final String? provider;

  bool get _isEdit => channelId != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providers = ref.watch(notificationProviderListProvider);
    final channels = _isEdit
        ? ref.watch(notificationChannelListProvider)
        : const AsyncData(<NotificationChannel>[]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEdit ? 'Kanalı düzenle' : 'Yeni kanal',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      body: AsyncView(
        value: providers,
        errorMessage: 'Kanal türleri yüklenemedi',
        builder: (specs) => AsyncView(
          value: channels,
          errorMessage: 'Kanal yüklenemedi',
          builder: (list) {
            final existing = _isEdit
                ? list.where((c) => c.id == channelId).firstOrNull
                : null;
            if (_isEdit && existing == null) {
              return const Center(child: Text('Kanal bulunamadı'));
            }
            final k = existing?.kind ?? kind;
            final p = existing?.provider ?? provider;
            final spec = specs
                .where((s) => s.kind == k && s.provider == p)
                .firstOrNull;
            if (spec == null) {
              return Center(child: Text('Bu kanal türü desteklenmiyor: $k/$p'));
            }
            return _Form(spec: spec, existing: existing);
          },
        ),
      ),
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.spec, this.existing});

  final NotificationProvider spec;
  final NotificationChannel? existing;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _recipients;
  late final Map<String, TextEditingController> _fields;
  late String _minSeverity;
  late bool _sendResolved;
  late bool _enabled;
  late Set<String> _sources;
  bool _busy = false;

  NotificationChannel? get _existing => widget.existing;
  bool get _isEdit => _existing != null;

  @override
  void initState() {
    super.initState();
    final e = _existing;
    final kind = widget.spec.kind;
    _name = TextEditingController(text: e?.name ?? channelKindLabel(kind));
    _recipients = TextEditingController(text: e?.recipients.join('\n') ?? '');
    // Sırlar hiçbir zaman önceden doldurulmaz: sunucu onları göndermiyor.
    _fields = {
      for (final f in widget.spec.fields)
        f.name: TextEditingController(
          text: f.secret ? '' : (e?.config[f.name] ?? ''),
        ),
    };
    // SMS ve arama pahalı ve rahatsız edici: varsayılan yalnızca kritik
    // (backend'in varsayılanıyla aynı).
    _minSeverity =
        e?.minSeverity ??
        (kind == 'sms' || kind == 'ivr' ? 'critical' : 'warning');
    _sendResolved = e?.sendResolved ?? true;
    _enabled = e?.enabled ?? true;
    _sources = {...(e?.sources ?? defaultChannelSources)};
  }

  @override
  void dispose() {
    _name.dispose();
    _recipients.dispose();
    for (final c in _fields.values) {
      c.dispose();
    }
    super.dispose();
  }

  List<String> get _recipientList => [
    for (final line in _recipients.text.split(RegExp(r'[\n,;]')))
      if (line.trim().isNotEmpty) line.trim(),
  ];

  @override
  Widget build(BuildContext context) {
    final spec = widget.spec;
    return Form(
      key: _formKey,
      child: ListView(
        // Alt pay sistem hareket çubuğu için: en alttaki düğme onun altında
        // kalıyordu.
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg + MediaQuery.paddingOf(context).bottom,
        ),
        children: [
          Row(
            children: [
              Icon(channelKindIcon(spec.kind), color: AppColors.darkGreenColor),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '${channelKindLabel(spec.kind)} · '
                '${channelProviderLabel(spec.provider)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _text(
            controller: _name,
            label: 'Kanal adı',
            validator: (v) =>
                (v ?? '').trim().isEmpty ? 'Kanal adı gerekli' : null,
          ),
          if (spec.recipients != 'none') _recipientField(spec.recipients),
          const _SectionTitle('Bağlantı ayarları'),
          for (final f in spec.fields) _configField(f),
          const _SectionTitle('Ne zaman gönderilsin'),
          const Text(
            'En düşük önem',
            style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
          ),
          const SizedBox(height: AppSpacing.xs),
          SegmentedButton<String>(
            segments: [
              for (final s in const ['info', 'warning', 'critical'])
                ButtonSegment(value: s, label: Text(severityLabel(s))),
            ],
            selected: {_minSeverity},
            onSelectionChanged: (s) => setState(() => _minSeverity = s.first),
            // Varsayılan tema seçimi açık maviyle çiziyordu; palet yeşil.
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: AppColors.lightGreenColor,
              selectedForegroundColor: AppColors.darkGreenColor,
              foregroundColor: AppColors.onSurfaceMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final s in channelSources)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _sources.contains(s),
              activeColor: AppColors.darkGreenColor,
              title: Text(sourceLabel(s)),
              subtitle: Text(
                sourceHint(s),
                style: const TextStyle(fontSize: 12),
              ),
              onChanged: (on) => setState(
                () => on == true ? _sources.add(s) : _sources.remove(s),
              ),
            ),
          if (_sources.isEmpty)
            const Text(
              'En az bir bildirim türü seçin',
              style: TextStyle(color: AppColors.flowRed, fontSize: 12),
            ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _sendResolved,
            activeThumbColor: AppColors.darkGreenColor,
            title: const Text('Çözüldüğünde de bildir'),
            onChanged: (v) => setState(() => _sendResolved = v),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: _enabled,
            activeThumbColor: AppColors.darkGreenColor,
            title: const Text('Kanal açık'),
            onChanged: (v) => setState(() => _enabled = v),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: _busy ? null : _save,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.darkGreenColor,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.mdAll,
              ),
            ),
            child: Text(_busy ? 'Kaydediliyor…' : 'Kaydet'),
          ),
          if (_isEdit) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: _busy ? null : _sendTest,
              icon: const Icon(Icons.send_outlined),
              label: const Text('Deneme bildirimi gönder'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.darkGreenColor,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: const RoundedRectangleBorder(
                  borderRadius: AppRadius.mdAll,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            TextButton.icon(
              onPressed: _busy ? null : _delete,
              icon: const Icon(Icons.delete_outline),
              label: const Text('Kanalı sil'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.darkRedColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _recipientField(String kind) {
    final phone = kind == 'phone';
    return _text(
      controller: _recipients,
      label: phone ? 'Telefon numaraları' : 'E-posta adresleri',
      helper: phone
          ? 'Her satıra bir numara, ülke koduyla: +905xxxxxxxxx'
          : 'Her satıra bir adres',
      minLines: 2,
      maxLines: 5,
      keyboard: phone ? TextInputType.phone : TextInputType.emailAddress,
      validator: (_) {
        final list = _recipientList;
        if (list.isEmpty) return 'En az bir alıcı gerekli';
        if (list.length > 50) return 'En fazla 50 alıcı';
        for (final r in list) {
          final ok = phone ? _e164.hasMatch(r) : _email.hasMatch(r);
          if (!ok) {
            return phone
                ? 'Uluslararası biçimde olmalı (+905…): $r'
                : 'Geçersiz e-posta: $r';
          }
        }
        return null;
      },
    );
  }

  Widget _configField(ProviderField f) {
    final saved = _existing?.secrets[f.name] == true;
    return _text(
      controller: _fields[f.name]!,
      label: fieldLabel(f.name) + (f.required ? ' *' : ''),
      helper: f.secret && saved
          ? 'Kayıtlı. Değiştirmek için yeni değeri yazın; boş bırakılırsa '
                'korunur.'
          : fieldHint(f.name),
      obscure: f.secret && !fieldMultiline(f.name),
      minLines: fieldMultiline(f.name) ? 3 : 1,
      maxLines: fieldMultiline(f.name) ? 6 : 1,
      validator: (v) {
        final empty = (v ?? '').trim().isEmpty;
        // Kayıtlı sır boş bırakılabilir: güncelleme kısmi, eskisi korunur.
        if (f.required && empty && !(f.secret && saved)) {
          return '${fieldLabel(f.name)} gerekli';
        }
        return null;
      },
    );
  }

  Widget _text({
    required TextEditingController controller,
    required String label,
    String? helper,
    FormFieldValidator<String>? validator,
    bool obscure = false,
    int minLines = 1,
    int maxLines = 1,
    TextInputType? keyboard,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: TextFormField(
      controller: controller,
      obscureText: obscure,
      minLines: obscure ? 1 : minLines,
      maxLines: obscure ? 1 : maxLines,
      keyboardType: keyboard,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        helperText: helper,
        helperMaxLines: 3,
        isDense: true,
        border: const OutlineInputBorder(borderRadius: AppRadius.smAll),
      ),
    ),
  );

  /// Gövde. Boş sır HİÇ gönderilmez: güncellemede boş dize "sil" demek ve
  /// kayıtlı parolayı silerdi. Eklemede boş isteğe bağlı alan da gönderilmez.
  NotificationChannelDraft _draft() {
    final config = <String, String>{};
    for (final f in widget.spec.fields) {
      final v = _fields[f.name]!.text.trim();
      if (v.isEmpty && (f.secret || !_isEdit)) continue;
      config[f.name] = v;
    }
    return NotificationChannelDraft(
      name: _name.text.trim(),
      kind: widget.spec.kind,
      provider: widget.spec.provider,
      config: config,
      recipients: widget.spec.recipients == 'none' ? const [] : _recipientList,
      minSeverity: _minSeverity,
      sendResolved: _sendResolved,
      enabled: _enabled,
      sources: [
        for (final s in channelSources)
          if (_sources.contains(s)) s,
      ],
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false) || _sources.isEmpty) {
      return;
    }
    setState(() => _busy = true);
    final repo = ref.read(repositoryProvider);
    try {
      if (_isEdit) {
        await repo.updateNotificationChannel(_existing!.id, _draft());
      } else {
        await repo.createNotificationChannel(_draft());
      }
      ref.invalidate(notificationChannelListProvider);
      if (!mounted) return;
      _toast(_isEdit ? 'Kanal kaydedildi' : 'Kanal eklendi');
      context.pop();
    } catch (e) {
      if (mounted) _toast(_message(e, 'Kaydedilemedi'), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Deneme, KAYITLI ayarlarla gönderilir: formdaki kaydedilmemiş
  /// değişiklik denenmez. Kullanıcı önce kaydetmeli.
  Future<void> _sendTest() async {
    setState(() => _busy = true);
    try {
      await ref.read(repositoryProvider).testNotificationChannel(_existing!.id);
      if (mounted) _toast('Deneme bildirimi gönderildi');
    } catch (e) {
      if (mounted) _toast(_message(e, 'Gönderilemedi'), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kanal silinsin mi?'),
        content: Text(
          '"${_existing!.name}" kanalına artık bildirim gitmeyecek. '
          'Bu işlem geri alınamaz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.darkRedColor,
            ),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(repositoryProvider)
          .deleteNotificationChannel(_existing!.id);
      ref.invalidate(notificationChannelListProvider);
      if (!mounted) return;
      _toast('Kanal silindi');
      context.pop();
    } catch (e) {
      if (mounted) _toast(_message(e, 'Silinemedi'), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Backend'in mesajı Türkçe ve doğrudan gösterilebilir (§16).
  String _message(Object e, String fallback) =>
      userMessage(e) ?? '$fallback: $e';

  void _toast(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? AppColors.flowRed : AppColors.darkGreenColor,
      ),
    );
  }
}

final _e164 = RegExp(r'^\+[1-9][0-9]{7,14}$');
final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );
}
