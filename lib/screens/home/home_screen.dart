import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/providers/common_providers.dart';
import 'package:milktrace/screens/home/hall_list_screen.dart';
import 'package:milktrace/screens/home/spout_list_screen.dart';
import 'package:milktrace/screens/home/vacuum_list_screen.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final cartProducts = ref.watch(cartProvider);
    String currentPage = ref.watch(dashboardProvider);
    //String currentPage = "hall";
    Widget page = SpoutListScreen();
    if (currentPage == "hall") {
      page = HallListScreen();
    } else if (currentPage == "vacuum") {
      page = VacuumListScreen();
    } else if (currentPage == "spout") {
      page = SpoutListScreen();
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Dijital Ziraat Mühendisi"),
      body: page,
    );
  }
}
