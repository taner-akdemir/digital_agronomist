import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/models/team_member.dart';
import 'package:milktrace/features/auth/role_labels.dart';
import 'package:milktrace/features/team/team_providers.dart';
import 'package:milktrace/providers/repository_providers.dart';
import 'package:milktrace/widgets/async_view.dart';

/// İşletmenin kullanıcıları (backend ADR 0076). YALNIZCA işletme sahibi:
/// operatör ve görüntüleyici ekler, rolünü değiştirir, askıya alır, siler.
/// Sahipler listede salt okunur — sahip eklemek platformun işi.
class TeamScreen extends ConsumerWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team = ref.watch(teamListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Geri',
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/live'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Kullanıcılar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _add(context, ref),
        backgroundColor: AppColors.darkGreenColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Kullanıcı ekle'),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(teamListProvider.future),
        child: AsyncView(
          value: team,
          errorMessage: 'Kullanıcılar yüklenemedi',
          builder: (list) => ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              96, // FAB son kartın üstüne binmesin
            ),
            children: [
              const _Note(),
              const SizedBox(height: AppSpacing.md),
              for (final m in list) _MemberCard(member: m),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final message = await showDialog<String>(
      context: context,
      builder: (_) => const _AddMemberDialog(),
    );
    if (message == null || !context.mounted) return;
    ref.invalidate(teamListProvider);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(_sentence(message))));
  }
}

/// Sunucunun küçük harfle başlayan mesajını cümleye çevirir.
String _sentence(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

void _showError(BuildContext context, Object e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(_sentence(userMessage(e) ?? 'İşlem yapılamadı: $e')),
      backgroundColor: AppColors.flowRed,
    ),
  );
}

class _Note extends StatelessWidget {
  const _Note();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.flowGreenSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: AppColors.darkGreenColor),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Operatör sağımı yürütür; görüntüleyici (veteriner, danışman) '
              'görür ve not yazar. İşletme sahibi eklemek için Milk Trace '
              'desteğine başvurun.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.darkGreenColor,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends ConsumerWidget {
  const _MemberCard({required this.member});

  final TeamMember member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = member;
    final name = m.fullName.isEmpty ? m.email : m.fullName;
    return Card(
      elevation: 0,
      color: AppColors.surface,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.mdAll,
        side: BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: m.isManageable ? () => _actions(context, ref) : null,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: m.isSuspended
                    ? AppColors.veryLightGreyColor
                    : AppColors.lightGreenColor,
                child: Icon(
                  m.role == 'tenant_owner'
                      ? Icons.verified_user_outlined
                      : Icons.person_outline,
                  color: m.isSuspended
                      ? AppColors.lightGreyColor
                      : AppColors.darkGreenColor,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      [
                        roleLabel(m.role),
                        if (m.fullName.isNotEmpty) m.email,
                      ].join(' · '),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (m.isSuspended)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.flowYellowSurface,
                    borderRadius: AppRadius.smAll,
                  ),
                  child: const Text(
                    'Askıda',
                    style: TextStyle(fontSize: 12, color: AppColors.flowYellow),
                  ),
                ),
              if (m.isManageable)
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.lightGreyColor,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _actions(BuildContext context, WidgetRef ref) async {
    final action = await showModalBottomSheet<_Action>(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _ActionSheet(member: member),
    );
    if (action == null || !context.mounted) return;

    final repo = ref.read(repositoryProvider);
    final m = member;
    try {
      switch (action) {
        case _Action.toggleRole:
          await repo.updateTeamMember(
            m.id,
            fullName: m.fullName,
            role: m.role == 'tenant_operator'
                ? 'tenant_viewer'
                : 'tenant_operator',
            status: m.status,
          );
        case _Action.toggleSuspend:
          await repo.updateTeamMember(
            m.id,
            fullName: m.fullName,
            role: m.role,
            status: m.isSuspended ? 'active' : 'suspended',
          );
        case _Action.delete:
          final ok = await _confirmDelete(context, m);
          if (!ok) return;
          await repo.deleteTeamMember(m.id);
      }
    } catch (e) {
      if (context.mounted) _showError(context, e);
    } finally {
      ref.invalidate(teamListProvider);
    }
  }

  Future<bool> _confirmDelete(BuildContext context, TeamMember m) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kullanıcıyı sil'),
        content: Text(
          '${m.fullName.isEmpty ? m.email : m.fullName} kalıcı olarak '
          'silinecek; geri alınamaz. Yazdığı hayvan notları kalır, yazarı '
          '"Silinmiş kullanıcı" görünür.\n\nYalnızca erişimi kesmek için '
          '"Askıya al"ı kullanın.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.flowRed),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
    return ok ?? false;
  }
}

enum _Action { toggleRole, toggleSuspend, delete }

class _ActionSheet extends StatelessWidget {
  const _ActionSheet({required this.member});

  final TeamMember member;

  @override
  Widget build(BuildContext context) {
    final m = member;
    final other = m.role == 'tenant_operator'
        ? 'tenant_viewer'
        : 'tenant_operator';
    void pick(_Action a) => Navigator.of(context).pop(a);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: Text('${roleLabel(other)} yap'),
            subtitle: Text(roleHint(other)),
            onTap: () => pick(_Action.toggleRole),
          ),
          ListTile(
            leading: Icon(
              m.isSuspended
                  ? Icons.play_circle_outline
                  : Icons.pause_circle_outline,
            ),
            title: Text(m.isSuspended ? 'Etkinleştir' : 'Askıya al'),
            subtitle: Text(
              m.isSuspended
                  ? 'Yeniden giriş yapabilir.'
                  : 'Giriş yapamaz; açık oturumu en geç 15 dakikada kapanır.',
            ),
            onTap: () => pick(_Action.toggleSuspend),
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: AppColors.flowRed),
            title: const Text(
              'Sil',
              style: TextStyle(color: AppColors.flowRed),
            ),
            onTap: () => pick(_Action.delete),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  }
}

/// Kullanıcı ekleme. Parola boş bırakılırsa kişiye e-postayla davet gider
/// ve parolasını kendisi belirler; sahip kimsenin parolasını bilmek zorunda
/// kalmaz. Posta kapalıysa sunucu "geçici bir parola girin" der.
class _AddMemberDialog extends ConsumerStatefulWidget {
  const _AddMemberDialog();

  @override
  ConsumerState<_AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends ConsumerState<_AddMemberDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _role = 'tenant_operator';
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_busy) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final r = await ref
          .read(repositoryProvider)
          .addTeamMember(
            email: _email.text.trim(),
            fullName: _name.text.trim(),
            role: _role,
            password: _password.text,
          );
      if (mounted) Navigator.of(context).pop(r.message);
    } catch (e) {
      if (mounted) {
        setState(() => _error = _sentence(userMessage(e) ?? 'Eklenemedi: $e'));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderRadius: AppRadius.mdAll);
    return AlertDialog(
      title: const Text('Kullanıcı ekle'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _name,
                enabled: !_busy,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Ad soyad',
                  border: border,
                ),
                validator: (v) =>
                    (v ?? '').trim().isEmpty ? 'Ad soyad girin.' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _email,
                enabled: !_busy,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  border: border,
                ),
                validator: (v) => EmailValidator.validate((v ?? '').trim())
                    ? null
                    : 'Geçerli bir e-posta girin.',
              ),
              const SizedBox(height: AppSpacing.md),
              SegmentedButton<String>(
                segments: [
                  for (final r in const ['tenant_operator', 'tenant_viewer'])
                    ButtonSegment(value: r, label: Text(roleLabel(r))),
                ],
                selected: {_role},
                onSelectionChanged: _busy
                    ? null
                    : (s) => setState(() => _role = s.first),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                roleHint(_role),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _password,
                enabled: !_busy,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Geçici parola (isteğe bağlı)',
                  helperText: 'Boş bırakırsanız e-postayla davet gider.',
                  helperMaxLines: 2,
                  border: border,
                ),
                validator: (v) => (v ?? '').isNotEmpty && v!.length < 8
                    ? 'En az 8 karakter.'
                    : null,
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _error!,
                  style: const TextStyle(color: AppColors.darkRedColor),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Vazgeç'),
        ),
        FilledButton(
          onPressed: _busy ? null : _save,
          child: const Text('Ekle'),
        ),
      ],
    );
  }
}
