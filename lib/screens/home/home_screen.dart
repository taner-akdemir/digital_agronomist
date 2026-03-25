import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milktrace/models/dashboard_data.dart';
import 'package:milktrace/models/vacuum_info.dart';

import '../../components/custom_app_bar/custom_app_bar.dart';
import '../../components/light_info/light_info.dart';
import '../../components/live_info_card/live_info_card.dart';
import '../../models/animal.dart';
import '../../models/hall.dart';
import '../../theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final cartProducts = ref.watch(cartProvider);

    //final List<String> prdIdsInCart = cartProducts.map((p){return p.id;}).toList();

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 350) / 2;
    final double itemWidth = (size.width - 10) / 2;

    List<Hall> hls = halls;

    return Scaffold(
      appBar: CustomAppBar(title: "Dijital Ziraat Mühendisi"),
      body: ListView.builder(
        itemCount: hls.length,
        itemBuilder: (BuildContext context, int index) {
          Hall h = hls[index];
          List<VacuumInfo> v = h.vacuums;

          int totalSpout = 0;
          int totalActiveSpout = 0;
          int totalPassiveSpout = 0;

          for(VacuumInfo v in vacuums){
            totalSpout += v.totalVacuum;
            totalActiveSpout += v.animals.length;
          }

          totalPassiveSpout = totalSpout - totalActiveSpout;

          VacuumInfo vFirst = vacuums[0];

          List<LiveInfoCard> cards = [];

          for(VacuumInfo v in vacuums){
            List<Animal> animals = v.animals;
            for (Animal a in animals){
              LiveInfoCard l = LiveInfoCard(
                lightColor: AppColors.lightGreenColor,
                title: "Vakum #${v.id}, Musluk #${a.currentInfo.spout.id}",
                name: "İnek #${a.id}",
                sessionYield: a.currentInfo.currentAmount,
                targetAmount: a.targetAmount,
                currentFlow: a.currentInfo.flowRate,
                lowFlowRate: a.currentInfo.lowFlowRate,
                sessionYieldIndicator: 'L',
                targetAmountIndicator: 'L',
                currentFlowIndicator: 'L/min',
              );

              cards.add(l);
            }
          }

          return Container(
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
                              "${h.hallName} Süt Sağma Alanı",
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
                                title: '$totalActiveSpout Aktif',
                              ),
                              SizedBox(width: 10),
                              LightInfo(
                                lightColor: AppColors.redColor,
                                title: '$totalPassiveSpout Pasif',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    child: /*ListView.separated(
                      itemCount: vFirst.animals.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index){
                        Animal a = vFirst.animals[index];
                        return LiveInfoCard(
                          lightColor: AppColors.lightGreenColor,
                          title: "Vakum #${vFirst.id}, Spout #${a.currentInfo.spout.id}",
                          name: "İnek #${a.id}",
                          sessionYield: a.currentInfo.currentAmount,
                          targetAmount: a.targetAmount,
                          currentFlow: a.currentInfo.flowRate,
                          sessionYieldIndicator: 'L',
                          targetAmountIndicator: 'L',
                          currentFlowIndicator: 'L/min',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),

                    )*/ GridView.count(
                      padding: const EdgeInsets.all(5),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 7,
                      shrinkWrap: true,
                    controller: ScrollController(keepScrollOffset: false),
                    scrollDirection: Axis.vertical,
                    childAspectRatio: (itemWidth / itemHeight),
                      children: cards,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
