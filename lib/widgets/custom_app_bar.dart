import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/features/alerts/alerts_providers.dart';
import 'package:milktrace/features/auth/account_sheet.dart';

/// Uygulamanın üst çubuğu.
class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Row(
        children: [
          // Marka işareti (tool/brand): ikonla aynı damla ve debi çizgisi.
          Image.asset('assets/brand/mark.png', height: 26, width: 26),
          const SizedBox(width: AppSpacing.sm),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkGreenColor,
            ),
          ),
        ],
      ),
      elevation: 1,
      shadowColor: AppColors.primaryColor,
      backgroundColor: AppColors.primaryColor,
      actions: actions ?? _defaultActions(context, ref),
    );
  }

  List<Widget> _defaultActions(BuildContext context, WidgetRef ref) => [
    IconButton(
      tooltip: 'Uyarılar',
      onPressed: () => context.push('/alerts'),
      icon: _BellWithBadge(count: ref.watch(openAlertCountProvider)),
    ),
    IconButton(
      tooltip: 'Hesap',
      onPressed: () => showAccountSheet(context),
      icon: const Icon(CupertinoIcons.person_circle),
    ),
  ];

  // kToolbarHeight kullanılır: sabit 50 px, Material'ın varsayılan 56 px'inden
  // küçüktü ve ikonlar dikeyde sıkışıyordu.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Zil + açık uyarı sayısı.
///
/// Sayı SIFIRSA rozet çizilmez: her zaman görünen bir rozet, gerçekten
/// bekleyen bir uyarı olduğunda dikkat çekmezdi.
class _BellWithBadge extends StatelessWidget {
  const _BellWithBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.notifications_none_outlined);
    if (count == 0) return icon;

    return Badge(
      label: Text('$count'),
      backgroundColor: AppColors.flowRed,
      child: icon,
    );
  }
}
