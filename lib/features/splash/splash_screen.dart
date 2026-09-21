import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milktrace/app/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go('/live');
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Milk Trace",
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: AppColors.darkGreenColor,
          ),
        ),
      ),
    );
  }
}
