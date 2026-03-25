import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/light_info/light_info.dart';
import '../../components/live_info_card/live_info_card.dart';
import '../../theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final cartProducts = ref.watch(cartProvider);

    //final List<String> prdIdsInCart = cartProducts.map((p){return p.id;}).toList();

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 380) / 2;
    final double itemWidth = (size.width - 10) / 2;

    return Scaffold(
      appBar: CustomAppBar(title: "Dijital Ziraat Mühendisi"),
      body: Container(
        decoration: BoxDecoration(color: AppColors.secondaryColor),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top side
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Canlı Veriler", style: TextStyle(fontSize: 12)),
                        Text(
                          "A Süt Sağma Bölümü",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.veryLightGreyColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LightInfo(
                            lightColor: AppColors.lightGreenColor,
                            title: '14 Aktif',
                          ),
                          SizedBox(width: 10),
                          LightInfo(
                            lightColor: AppColors.redColor,
                            title: '2 Pasif',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Expanded(
                child: GridView.count(
                    padding: const EdgeInsets.all(5),
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  scrollDirection: Axis.vertical,
                  childAspectRatio: (itemWidth / itemHeight),
                    children: [
                      LiveInfoCard(
                        lightColor: AppColors.lightGreenColor,
                        title: "Vakum #01",
                        name: "İnek #101",
                        sessionYield: 12,
                        targetAmount: 20,
                        currentFlow: 1.5,
                        sessionYieldIndicator: 'L',
                        targetAmountIndicator: 'L',
                        currentFlowIndicator: 'L/min',
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
