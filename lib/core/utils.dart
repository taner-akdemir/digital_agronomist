import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';

class Utils {
  static void showSnackBar(
    BuildContext context,
    Widget widget, [
    Color? color = AppColors.lightGreenColor,
    int duration = 1,
  ]) {
    final SnackBar s = SnackBar(
      content: widget,
      backgroundColor: color,
      padding: const EdgeInsets.all(10),
      duration: Duration(seconds: duration),
    );
    ScaffoldMessenger.of(context).showSnackBar(s);
  }
}
