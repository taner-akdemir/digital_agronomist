import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/screens/bottom_navigator_bar.dart';
import 'package:milktrace/screens/splash/splash_screen.dart';
import 'package:milktrace/theme.dart';
import 'package:milktrace/utils/route_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // ProviderScope runApp'e sarılır, MyApp.build içine DEĞİL: build içinde
  // olduğunda widget ağacının bir parçası olur ve her yeniden çiziminde
  // yeniden değerlendirilir. Kök burada olmalı.
  runApp(const ProviderScope(child: MilkTraceApp()));
}

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
