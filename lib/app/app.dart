import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';

class MilkTraceApp extends ConsumerWidget {
  const MilkTraceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Router keepAlive bir provider'dan gelir: build içinde kurulsaydı her
    // yeniden çizimde yeni bir router doğar ve gezinme geçmişi sıfırlanırdı.
    // Eski kabuktaki PersistentTabController'ın hatası tam olarak buydu.
    final router = ref.watch(routerProvider);

    // Push kaydı oturuma bağlı ve KÖKTE izleniyor: hiçbir ekran onu
    // izlemediği için, burada olmasaydı jeton hiç kaydedilmezdi.
    ref.watch(pushRegistrationProvider);

    // Bildirime dokunma bir YAN ETKİdir; provider'ın içinden router'a
    // dokunmak iki durum makinesini birbirine düğümlerdi.
    ref.listen(pushTapsProvider, (_, next) {
      final tap = next.value;
      if (tap == null) return;

      // Oturum kapalıyken gelen dokunuş yok sayılır: yönlendirme yine
      // giriş ekranına düşerdi ama kullanıcı bir an korumalı ekranı görürdü.
      if (!ref.read(authProvider).isSignedIn) return;

      router.go(tap.route);
    });

    return MaterialApp.router(
      title: 'Milk Trace',
      theme: buildAppTheme(),
      routerConfig: router,
    );
  }
}
