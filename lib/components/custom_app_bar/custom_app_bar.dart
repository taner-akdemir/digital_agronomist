import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milktrace/theme.dart';
import 'package:milktrace/utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.sensors, size: 28, color: AppColors.darkGreenColor),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
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
      actions: actions != null && actions!.isNotEmpty
          ? actions
          : [
              IconButton(
                onPressed: () {
                  Utils.showSnackBar(context, Text("Notification screen",
                    style: TextStyle(color: AppColors.iconGreyColor),
                  ));
                },
                icon: Icon(Icons.notifications_none_outlined),
              ),
              IconButton(
                onPressed: () {
                  Utils.showSnackBar(
                    context,
                    Text(
                      "account screen",
                      style: TextStyle(color: AppColors.iconGreyColor),
                    ),
                  );
                },
                icon: Icon(CupertinoIcons.person_circle),
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
