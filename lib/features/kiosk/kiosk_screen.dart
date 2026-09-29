import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/live/live_board_screen.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/widgets/custom_app_bar.dart';
import 'package:milktrace/widgets/offline_banner.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'kiosk_screen.g.dart';

/// Ekranın kararmasını açıp kapatır; testte sahtesi konur.
@Riverpod(keepAlive: true)
Future<void> Function(bool on) screenAwake(Ref ref) =>
    (on) => WakelockPlus.toggle(enable: on);

/// Sağımhane modu (backend ADR 0091): tablet hesabıyla açılan TEK ekran.
/// Sekme çubuğu, hesap kartı ve bildirim zili yok; ekran kararmaz. Çıkış
/// onayla — tablet ortak ve yanlışlıkla çıkmak sağımı ekransız bırakır.
class KioskScreen extends ConsumerStatefulWidget {
  const KioskScreen({super.key});

  @override
  ConsumerState<KioskScreen> createState() => _KioskScreenState();
}

class _KioskScreenState extends ConsumerState<KioskScreen> {
  late final Future<void> Function(bool) _awake;

  @override
  void initState() {
    super.initState();
    _awake = ref.read(screenAwakeProvider);
    _awake(true).ignore();
  }

  @override
  void dispose() {
    _awake(false).ignore();
    super.dispose();
  }

  Future<void> _signOut() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.kioskExitTitle),
        content: Text(l10n.kioskExitBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.flowRed),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.kioskSignOut),
          ),
        ],
      ),
    );
    if (ok == true) await ref.read(authProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.kioskTitle,
        actions: [
          IconButton(
            tooltip: l10n.kioskSignOut,
            onPressed: _signOut,
            icon: const Icon(Icons.logout, color: AppColors.darkGreenColor),
          ),
        ],
      ),
      body: const Column(
        children: [
          OfflineBanner(),
          Expanded(child: LiveBoardScreen()),
        ],
      ),
    );
  }
}
