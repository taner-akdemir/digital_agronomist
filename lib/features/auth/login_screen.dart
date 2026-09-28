import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/api_exception.dart';
import 'package:milktrace/features/support/support.dart';
import 'package:milktrace/providers/auth_providers.dart';

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

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
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
      await ref
          .read(authProvider.notifier)
          .signIn(email: _email.text.trim(), password: _password.text);
      // Yönlendirme router'ın işi: oturum açılınca redirect devreye girer.
      // Burada context.go çağırmak İKİ yönlendirme kaynağı yaratırdı.
    } on ApiException catch (e) {
      // Sunucunun Türkçe mesajı doğrudan gösterilir (§16).
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                    const Text(
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
                    const Text(
                      'İşletmenizin sağım takibi',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.onSurfaceMuted),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    TextFormField(
                      controller: _email,
                      enabled: !_busy,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.username],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'E-posta',
                        prefixIcon: Icon(Icons.alternate_email),
                        border: OutlineInputBorder(
                          borderRadius: AppRadius.mdAll,
                        ),
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'E-posta girin.';
                        if (!EmailValidator.validate(value)) {
                          return 'Geçerli bir e-posta girin.';
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
                        labelText: 'Parola',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(
                          borderRadius: AppRadius.mdAll,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          tooltip: _obscure
                              ? 'Parolayı göster'
                              : 'Parolayı gizle',
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) =>
                          (v == null || v.isEmpty) ? 'Parola girin.' : null,
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      _ErrorBanner(message: _error!),
                    ],
                    const SizedBox(height: AppSpacing.xl),
                    FilledButton(
                      onPressed: _busy ? null : _submit,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.darkGreenColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.lg,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppRadius.mdAll,
                        ),
                      ),
                      child: _busy
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Giriş yap'),
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
                      child: const Text('Parolamı unuttum'),
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
      ),
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
      decoration: const BoxDecoration(
        color: AppColors.flowRedSurface,
        borderRadius: AppRadius.smAll,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.darkRedColor,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: AppColors.darkRedColor),
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
      title: const Text('Parolamı unuttum'),
      content: done != null
          ? Text(done)
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'E-posta adresinize yeni parola belirleme bağlantısı '
                    'gönderelim.',
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  TextFormField(
                    controller: _email,
                    enabled: !_busy,
                    autofocus: widget.initialEmail.isEmpty,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-posta',
                      border: OutlineInputBorder(borderRadius: AppRadius.mdAll),
                    ),
                    validator: (v) => EmailValidator.validate(v?.trim() ?? '')
                        ? null
                        : 'Geçerli bir e-posta girin.',
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
                child: const Text('Tamam'),
              ),
            ]
          : [
              TextButton(
                onPressed: _busy ? null : () => Navigator.of(context).pop(),
                child: const Text('Vazgeç'),
              ),
              FilledButton(
                onPressed: _busy ? null : _send,
                child: const Text('Bağlantı gönder'),
              ),
            ],
    );
  }
}
