import 'package:flutter/material.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/app/theme.dart';

class MilkTraceApp extends StatefulWidget {
  const MilkTraceApp({super.key});

  @override
  State<MilkTraceApp> createState() => _MilkTraceAppState();
}

class _MilkTraceAppState extends State<MilkTraceApp> {
  // Router initState'te kurulur, build içinde DEĞİL: build içinde kurulsaydı
  // her yeniden çizimde yeni bir router doğar ve gezinme geçmişi sıfırlanırdı.
  // Eski kabuktaki PersistentTabController'ın hatası tam olarak buydu.
  late final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Milk Trace',
      theme: buildAppTheme(),
      routerConfig: _router,
    );
  }
}
