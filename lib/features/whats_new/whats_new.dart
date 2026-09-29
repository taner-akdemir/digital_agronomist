import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/settings_providers.dart';

/// Yenilikler (backend ADR 0123). Notlar uygulamanın içinde, iki dilde
/// (ARB `whatsNewItem*`). YENİ SÜRÜMDE: [whatsNewId]'yi değiştir ve
/// maddeleri güncelle; kullanıcı güncellemeden sonra bir kez görür.
const whatsNewId = '2026-09-29';

/// Bu sürümün maddeleri.
List<String> get whatsNewItems => [
  l10n.whatsNewItem1,
  l10n.whatsNewItem2,
  l10n.whatsNewItem3,
  l10n.whatsNewItem4,
  l10n.whatsNewItem5,
];

const _seenKey = 'whatsNew.seen';

/// Yenilikler penceresini açar.
Future<void> showWhatsNew(BuildContext context) => showModalBottomSheet<void>(
  context: context,
  // Küçük ekranda ya da büyük yazı boyutunda taşmasın: içerik kayar.
  isScrollControlled: true,
  backgroundColor: AppColors.surface,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
  ),
  builder: (context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.whatsNewTitle,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreenColor,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final item in whatsNewItems)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 16,
                    color: AppColors.darkGreenColor,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brandFill,
              ),
              child: Text(l10n.whatsNewOk),
            ),
          ),
        ],
      ),
    ),
  ),
);

/// Kabuğun çocuğu: güncellemeden sonra Yenilikler'i BİR KEZ gösterir.
///
/// İLK KURULUMDA GÖSTERMEZ: kayıt hiç yoksa bu sürüm görülmüş sayılır —
/// yeni kullanıcıya "yenilik" anlatmak anlamsız. Sonraki sürümde
/// [whatsNewId] değişince gösterilir.
class WhatsNewListener extends ConsumerStatefulWidget {
  const WhatsNewListener({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<WhatsNewListener> createState() => _WhatsNewListenerState();
}

class _WhatsNewListenerState extends ConsumerState<WhatsNewListener> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  Future<void> _check() async {
    final store = ref.read(settingsStoreProvider);
    String? seen;
    try {
      seen = await store.readString(_seenKey);
    } on Object {
      return; // okunamazsa rahatsız etme
    }
    if (seen == whatsNewId) return;
    try {
      await store.writeString(_seenKey, whatsNewId);
    } on Object {
      return; // yazılamazsa her açılışta göstermesin
    }
    if (seen == null || !mounted) return;
    await showWhatsNew(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
