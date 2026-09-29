import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/app/router.dart';
import 'package:milktrace/app/theme.dart';
import 'package:milktrace/l10n/l10n.dart';
import 'package:milktrace/providers/auth_providers.dart';
import 'package:milktrace/providers/push_providers.dart';
import 'package:milktrace/providers/settings_providers.dart';

class MilkTraceApp extends ConsumerWidget {
  const MilkTraceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dil (backend ADR 0093): hesap kartındaki seçim, yoksa cihaz dili
    // (İngilizce cihazda İngilizce, diğer her dilde Türkçe). Global l10n
    // BURADA yazılır; dil değişince kök yeniden çizilir ve her ekran yeni
    // metinle kurulur.
    final chosen = ref.watch(appLanguageProvider);
    final locale = chosen == null
        ? resolveAppLocale(WidgetsBinding.instance.platformDispatcher.locales)
        : Locale(chosen);
    // Global l10n EN BAŞTA yazılır: aşağıda izlenen push kaydı jetonu
    // bu dille yazar.
    setL10nLocale(locale);

    // Tema (backend ADR 0109): renk token'ları (AppColors) geçerli
    // parlaklıktan okunur ve widget'larda sabit DEĞİLDİR; parlaklık da dil
    // gibi BURADA yazılır ve anahtara girer — değişince ağaç baştan kurulur,
    // her ekran yeni renklerle çizilir.
    final themeMode = ref.watch(appThemeModeProvider);
    final brightness = ref.watch(effectiveBrightnessProvider);
    AppColors.brightness = brightness;

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
      final auth = ref.read(authProvider);
      if (!auth.isSignedIn) return;

      // Başka işletmenin bildirimi (backend ADR 0085): önce o işletmeye
      // geç, sonra aç — yoksa hayvan başka işletmede "bulunamadı" derdi.
      final other = tap.tenantToSwitch(auth.user);
      if (other == null) {
        router.go(tap.route);
        return;
      }
      unawaited(() async {
        try {
          await ref.read(authProvider.notifier).switchTenant(other);
        } catch (_) {
          // Geçilemediyse (ağ, üyelik kalktı) yine açılır; ekran kendi
          // hatasını gösterir.
        }
        router.go(tap.route);
      }());
    });

    return MaterialApp.router(
      key: ValueKey('${locale.languageCode}-${brightness.name}'),
      title: 'Milk Trace',
      theme: buildAppTheme(),
      darkTheme: buildAppTheme(Brightness.dark),
      themeMode: themeMode,
      routerConfig: router,
      // Material'in kendi metinleri de (tarih seçici, düğmeler) aynı dilde.
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
    );
  }
}
