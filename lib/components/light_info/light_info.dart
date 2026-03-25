import 'package:flutter/material.dart';

import '../../theme.dart';

class LightInfo extends StatelessWidget {
  final Color lightColor;
  final Color? textColor, backgroundColor;
  final String title;
  const LightInfo({super.key, required this.lightColor, required this.title, this.textColor, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.brightness_1_rounded,
              color: lightColor,
              size: 10,
            ),
            SizedBox(width: 5,),
            Text(
              title,
              style: TextStyle(
                color: textColor ?? AppColors.darkGreenColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
