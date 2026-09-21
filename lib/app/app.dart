import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/app/theme.dart';

class MilkTraceApp extends ConsumerWidget {
  const MilkTraceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Router keepAlive bir provider'dan gelir: build içinde kurulsaydı her
    // yeniden çizimde yeni bir router doğar ve gezinme geçmişi sıfırlanırdı.
    // Eski kabuktaki PersistentTabController'ın hatası tam olarak buydu.
    return MaterialApp.router(
      title: 'Milk Trace',
      theme: buildAppTheme(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
