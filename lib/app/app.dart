import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/core/route_builder.dart';
import 'package:milktrace/features/shell/bottom_navigator_bar.dart';
import 'package:milktrace/features/splash/splash_screen.dart';

class MilkTraceApp extends StatelessWidget {
  const MilkTraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milk Trace',
      theme: buildAppTheme(),
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return routeBuilder(settings, const SplashScreen());
          case '/':
            return routeBuilder(settings, BottomNavigatorBar());
          default:
            return routeBuilder(settings, const _NotFoundScreen());
        }
      },
    );
  }
}

class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sayfa bulunamadı')),
      body: const Center(child: Text('Aradığınız sayfa bulunamadı.')),
    );
  }
}
