import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/utils.dart';
import 'package:milktrace/features/auth/account_sheet.dart';

/// Uygulamanın üst çubuğu.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.sensors, size: 26, color: AppColors.darkGreenColor),
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
      actions: actions ?? _defaultActions(context),
    );
  }

  List<Widget> _defaultActions(BuildContext context) => [
        IconButton(
          tooltip: 'Bildirimler',
          onPressed: () => Utils.showSnackBar(
            context,
            const Text('Bildirim merkezi Faz 4 ile gelecek'),
          ),
          icon: const Icon(Icons.notifications_none_outlined),
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
