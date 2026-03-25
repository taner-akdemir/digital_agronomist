import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milktrace/screens/bottom_navigator_bar.dart';
import 'package:milktrace/screens/splash/splash_screen.dart';
import 'package:milktrace/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Dijital Ziraat Mühendisi',
        theme: ThemeData(
            primaryColor: AppColors.primaryColor,
            scaffoldBackgroundColor: AppColors.primaryColor,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.darkBlueColor),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          iconTheme: IconThemeData(color: AppColors.darkGreenColor)
        ),
        //home: const Text("aaa", style: TextStyle(color: Colors.grey)),
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings){
          switch (settings.name) {
            case '/splash':
              return routeBuilder(settings, SplashScreen());
            case '/login':
              //return routeBuilder(settings, Login());
            case '/':
              return routeBuilder(settings, BottomNavigatorBar());
            default:
              if (defaultTargetPlatform == TargetPlatform.iOS) {
                return CupertinoPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: Text("error")),
                    body: Center(child: Text("404 not found")),
                  ),
                );
              }
              return MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text("error")),
                  body: Center(child: Text("404 not found")),
                ),
              );
          }
        },
      ),
    );
  }
}


// Generate routes

PageRoute<dynamic> routeBuilder(RouteSettings settings, Widget page){
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return CupertinoPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
  return MaterialPageRoute(
    builder: (context) => page,
    settings: settings,
  );
}