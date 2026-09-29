import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

/// Giriş ekranı (§8.5 POST /auth/login).
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _busy = false;
  bool _obscure = true;
  String? _error;

  /// İki adımlı doğrulama (backend ADR 0102): parola geçince kod adımı.
  String? _mfaToken;
  final _code = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _busy = true;
      _error = null;
    });

    try {
      final auth = ref.read(authProvider.notifier);
      if (_mfaToken case final token?) {
        await auth.signInSecondFactor(mfaToken: token, code: _code.text.trim());
      } else {
        await auth.signIn(email: _email.text.trim(), password: _password.text);
      }
      // Yönlendirme router'ın işi: oturum açılınca redirect devreye girer.
      // Burada context.go çağırmak İKİ yönlendirme kaynağı yaratırdı.
    } on MfaRequired catch (e) {
      if (mounted) setState(() => _mfaToken = e.token);
    } on ApiException catch (e) {
      // Sunucunun Türkçe mesajı doğrudan gösterilir (§16).
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dil değişince ekran yeni dille yeniden çizilsin.
    ref.watch(appLanguageProvider);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/brand/mark.png', height: 72),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Milk Trace',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: AppColors.darkGreenColor,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          l10n.loginTagline,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.onSurfaceMuted),
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        if (_mfaToken != null) ...[
                          Text(l10n.loginMfaHint, textAlign: TextAlign.center),
                          const SizedBox(height: AppSpacing.lg),
                          TextFormField(
                            controller: _code,
                            enabled: !_busy,
                            autofocus: true,
                            autofillHints: const [AutofillHints.oneTimeCode],
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                            decoration: InputDecoration(
                              labelText: l10n.loginMfaCode,
                              prefixIcon: const Icon(Icons.pin_outlined),
                              border: const OutlineInputBorder(
                                borderRadius: AppRadius.mdAll,
                              ),
                            ),
                            validator: (v) => (v ?? '').trim().isEmpty
                                ? l10n.loginMfaCodeRequired
                                : null,
                          ),
                          TextButton(
                            onPressed: _busy
                                ? null
                                : () => setState(() {
                                    _mfaToken = null;
                                    _code.clear();
                                    _error = null;
                                  }),
                            child: Text(l10n.commonBack),
                          ),
                        ] else ...[
                          TextFormField(
                            controller: _email,
                            enabled: !_busy,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.username],
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: l10n.loginEmailLabel,
                              prefixIcon: const Icon(Icons.alternate_email),
                              border: const OutlineInputBorder(
                                borderRadius: AppRadius.mdAll,
                              ),
                            ),
                            validator: (v) {
                              final value = v?.trim() ?? '';
                              if (value.isEmpty) return l10n.loginEmailRequired;
                              if (!EmailValidator.validate(value)) {
                                return l10n.loginEmailInvalid;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          TextFormField(
                            controller: _password,
                            enabled: !_busy,
                            obscureText: _obscure,
                            autofillHints: const [AutofillHints.password],
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                            decoration: InputDecoration(
                              labelText: l10n.loginPasswordLabel,
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(
                                borderRadius: AppRadius.mdAll,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                tooltip: _obscure
                                    ? l10n.loginShowPassword
                                    : l10n.loginHidePassword,
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ),
                            validator: (v) => (v == null || v.isEmpty)
                                ? l10n.loginPasswordRequired
                                : null,
                          ),
                        ],
                        if (_error != null) ...[
                          const SizedBox(height: AppSpacing.lg),
                          _ErrorBanner(message: _error!),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        FilledButton(
                          onPressed: _busy ? null : _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.brandFill,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.lg,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: AppRadius.mdAll,
                            ),
                          ),
                          child: _busy
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.onFill,
                                  ),
                                )
                              : Text(l10n.loginSubmit),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TextButton(
                          onPressed: _busy
                              ? null
                              : () => showDialog<void>(
                                  context: context,
                                  builder: (_) => _ForgotPasswordDialog(
                                    initialEmail: _email.text.trim(),
                                  ),
                                ),
                          child: Text(l10n.loginForgotPassword),
                        ),
                        // Giremeyen kişi (askı, unutulan parola) de bize
                        // ulaşabilsin (backend ADR 0077).
                        const SizedBox(height: AppSpacing.lg),
                        const SupportButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Dil giriş yapmadan seçilir (backend ADR 0093); köşede,
            // formun önüne geçmeden.
            const Positioned(
              top: AppSpacing.xs,
              right: AppSpacing.xs,
              child: _LanguageMenu(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Giriş ekranındaki dil seçimi: cihaz dili, Türkçe, English.
class _LanguageMenu extends ConsumerWidget {
  const _LanguageMenu();

  // PopupMenu null değeri "vazgeçildi" sayar; cihaz dili için işaret.
  static const _auto = 'auto';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(appLanguageProvider) ?? _auto;
    PopupMenuItem<String> item(String value, String label) => PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(
            value == current ? Icons.check : null,
            size: 18,
            color: AppColors.darkGreenColor,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(label),
        ],
      ),
    );
    return PopupMenuButton<String>(
      tooltip: l10n.languageTitle,
      icon: Icon(Icons.language, color: AppColors.onSurfaceMuted),
      onSelected: (v) =>
          ref.read(appLanguageProvider.notifier).set(v == _auto ? null : v),
      itemBuilder: (_) => [
        item(_auto, l10n.languageAuto),
        item('tr', l10n.languageTurkish),
        item('en', l10n.languageEnglish),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.flowRedSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: AppColors.darkRedColor, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: AppColors.darkRedColor),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Parolamı unuttum" (backend ADR 0074): e-postaya tek kullanımlık bağlantı.
/// Bağlantı telefonun tarayıcısında açılır, yeni parola orada belirlenir;
/// uygulama yalnızca isteği gönderir ve sunucunun metnini gösterir.
class _ForgotPasswordDialog extends ConsumerStatefulWidget {
  const _ForgotPasswordDialog({required this.initialEmail});

  final String initialEmail;

  @override
  ConsumerState<_ForgotPasswordDialog> createState() =>
      _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends ConsumerState<_ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: widget.initialEmail);

  bool _busy = false;
  String? _error;
  String? _done;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (_busy) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final msg = await ref.read(passwordResetRequesterProvider)(
        _email.text.trim(),
      );
      if (mounted) setState(() => _done = msg);
    } on ApiException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final done = _done;
    return AlertDialog(
      title: Text(l10n.loginForgotPassword),
      content: done != null
          ? Text(done)
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.loginResetIntro),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _email,
                    enabled: !_busy,
                    autofocus: widget.initialEmail.isEmpty,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: l10n.loginEmailLabel,
                      border: const OutlineInputBorder(
                        borderRadius: AppRadius.mdAll,
                      ),
                    ),
                    validator: (v) => EmailValidator.validate(v?.trim() ?? '')
                        ? null
                        : l10n.loginEmailInvalid,
                    onFieldSubmitted: (_) => _send(),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    _ErrorBanner(message: _error!),
                  ],
                ],
              ),
            ),
      actions: done != null
          ? [
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.commonOk),
              ),
            ]
          : [
              TextButton(
                onPressed: _busy ? null : () => Navigator.of(context).pop(),
                child: Text(l10n.commonCancel),
              ),
              FilledButton(
                onPressed: _busy ? null : _send,
                child: Text(l10n.loginResetSend),
              ),
            ],
    );
  }
}
