import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:milktrace/screens/home/home_screen.dart';
import 'package:milktrace/screens/splash/splash_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../theme.dart';

class BottomNavigatorBar extends StatefulWidget {
  const BottomNavigatorBar({super.key});

  @override
  State<BottomNavigatorBar> createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar> {
  int currentPageIndex = 0;
  late List<Widget> pages;
  late HomeScreen home;

  @override
  void initState() {
    home = HomeScreen();
    pages = <Widget>[home, home, home, home];
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("Home dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller = PersistentTabController(
      initialIndex: 0,
    );

    RouteAndNavigatorSettings routeAndNavigatorSettings =
        RouteAndNavigatorSettings(
          initialRoute: "/home",
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/splash':
                return routeBuilder(settings, SplashScreen());
              case '/home':
                return routeBuilder(settings, HomeScreen());
              default:
                return null;
            }
          },
        );

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.dashboard,
            color: AppColors.iconGreyColor,
          ),
          title: ("Dashboard"),
          activeColorPrimary: AppColors.lightGreenColor,
          activeColorSecondary: AppColors.iconGreyColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings: routeAndNavigatorSettings,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.area_chart, color: AppColors.iconGreyColor),
          title: ("Live"),
          activeColorPrimary: AppColors.lightGreenColor,
          activeColorSecondary: AppColors.iconGreyColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings: routeAndNavigatorSettings,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.history,
            color: AppColors.iconGreyColor,
          ),
          title: ("History"),
          activeColorPrimary: AppColors.lightGreenColor,
          activeColorSecondary: AppColors.iconGreyColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings: routeAndNavigatorSettings,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.settings_input_component,
            color: AppColors.iconGreyColor,
          ),
          title: ("Devices"),
          activeColorPrimary: AppColors.lightGreenColor,
          activeColorSecondary: AppColors.iconGreyColor,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings: routeAndNavigatorSettings,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: pages,
      items: navBarsItems(),
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      //popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: AppColors.primaryColor,
      isVisible: true,
      /*      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),*/
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      //navBarStyle: _navBarStyle, // Choose the nav bar style with this property
    );
  }
}

PageRoute<dynamic> routeBuilder(RouteSettings settings, Widget page) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return CupertinoPageRoute(builder: (context) => page, settings: settings);
  }
  return MaterialPageRoute(builder: (context) => page, settings: settings);
}
