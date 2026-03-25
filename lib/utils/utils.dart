import 'package:flutter/material.dart';
import 'package:milktrace/theme.dart';

class Utils {
  static void showSnackBar(
    BuildContext context,
    Widget widget, [
    Color? color = AppColors.lightGreenColor,
    int duration = 1,
  ]) {
    SnackBar s = SnackBar(
      content: widget,
      backgroundColor: color,
      padding: EdgeInsets.all(10),
      duration: Duration(seconds: duration),
    );
    ScaffoldMessenger.of(context).showSnackBar(s);
  }
}
