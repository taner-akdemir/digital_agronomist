import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/env.dart';
import 'package:milktrace/data/auth/auth_api.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'support.g.dart';

/// Destek numaraları (backend ADR 0077). Okunamazsa (çevrimdışı, eski
/// backend) null: destek bölümü sessizce gizlenir, hata ekranı olmaz.
/// Mock modda sunucu yok. keepAlive: numara oturum boyunca değişmez ve
/// hesap kartı her açıldığında yeniden sorulmasın.
@Riverpod(keepAlive: true)
Future<SupportInfo?> supportInfo(Ref ref) async {
  if (Env.apiMode == ApiMode.mock) return null;
  try {
    return await ref.watch(authSessionProvider).api.support();
  } on Object {
    return null;
  }
}

/// Dış uygulamayı (WhatsApp, telefon) açar. Ayrı sağlayıcı: testte sahtesi.
@riverpod
Future<bool> Function(Uri) supportLauncher(Ref ref) =>
    (uri) => launchUrl(uri, mode: LaunchMode.externalApplication);

/// Uygulama sürümü, WhatsApp'taki hazır metne girer: "hangi sürüm?"
/// sorusu ilk mesajda cevaplanmış olsun.
@Riverpod(keepAlive: true)
Future<String> appVersion(Ref ref) async {
  try {
    final p = await PackageInfo.fromPlatform();
    return '${p.version}+${p.buildNumber}';
  } on Object {
    return '';
  }
}

/// wa.me bağlantısı: numara + işaretsiz, metin hazır.
Uri whatsAppUri(String e164, String version) =>
    Uri.https('wa.me', '/${e164.replaceAll('+', '')}', {
      'text':
          'Merhaba, Milk Trace hakkında destek istiyorum.'
          '${version.isEmpty ? '' : ' (Uygulama $version)'}',
    });

/// "Destek" düğmeleri: WhatsApp'ta yaz, ara. Numara yoksa hiçbir şey.
class SupportButtons extends ConsumerWidget {
  const SupportButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = ref.watch(supportInfoProvider).value;
    if (info == null || (info.phone == null && info.whatsapp == null)) {
      return const SizedBox.shrink();
    }

    Future<void> open(Uri uri) async {
      final ok = await ref.read(supportLauncherProvider)(uri);
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Açılamadı: ${info.phone ?? info.whatsapp}')),
        );
      }
    }

    final style = OutlinedButton.styleFrom(
      foregroundColor: AppColors.darkGreenColor,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Destek',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMuted),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            if (info.whatsapp case final wa?)
              Expanded(
                child: OutlinedButton.icon(
                  style: style,
                  onPressed: () async => open(
                    whatsAppUri(wa, await ref.read(appVersionProvider.future)),
                  ),
                  icon: const Icon(Icons.chat_outlined),
                  label: const Text('WhatsApp'),
                ),
              ),
            if (info.whatsapp != null && info.phone != null)
              const SizedBox(width: AppSpacing.sm),
            if (info.phone case final phone?)
              Expanded(
                child: OutlinedButton.icon(
                  style: style,
                  onPressed: () => open(Uri(scheme: 'tel', path: phone)),
                  icon: const Icon(Icons.call_outlined),
                  label: const Text('Ara'),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
