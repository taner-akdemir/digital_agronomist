import 'package:flutter/material.dart';
import 'package:milktrace/models/spout.dart';

import '../../components/light_info/light_info.dart';
import '../../components/live_info_card/live_info_card.dart';
import '../../models/animal.dart';
import '../../models/hall.dart';
import '../../models/vacuum_info.dart';
import '../../services/api.dart';
import '../../theme.dart';

class SpoutListScreen extends StatefulWidget {
  const SpoutListScreen({super.key});

  @override
  State<SpoutListScreen> createState() => _SpoutListScreenState();
}

class _SpoutListScreenState extends State<SpoutListScreen> {
  late final Future<List<Hall>> hls;
  late final Future<List<VacuumInfo>> vacuums;
  late final Future<List<Spout>> spouts;
  late final Future<List<Animal>> animals;

  @override
  void initState() {
    super.initState();
    hls = Api.fetchHalls();
    vacuums = Api.fetchVacuums();
    spouts = Api.fetchSpouts();
    animals = Api.fetchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 350) / 2;
    final double itemWidth = (size.width - 10) / 2;
    int currentHallIndex = 0;
    int currentVacuumIndex = 0;

    return FutureBuilder<List<Hall>>(
      future: hls,
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          List<Hall> halls = snapShot.data!;
          Hall h = halls[currentHallIndex];
          debugPrint(h.name);
          return FutureBuilder<List<VacuumInfo>>(
            future: vacuums,
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                List<VacuumInfo> vacuums = snapShot.data!;
                List<VacuumInfo> hlsVacuums = vacuums
                    .where((v) => v.hallID == h.id)
                    .toList();
                VacuumInfo currentVI = hlsVacuums[currentVacuumIndex];
                debugPrint(currentVI.totalSpout.toString());
                return FutureBuilder<List<Spout>>(
                  future: spouts,
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      List<Spout> spouts = snapShot.data!;
                      List<Spout> viSpouts = spouts
                          .where((s) => s.vacuumID == currentVI.id)
                          .toList();
                      viSpouts.map((vs) => debugPrint(vs.id.toString()));
                      return FutureBuilder(
                        future: animals,
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            List<Animal> animals = snapShot.data!;
                            List<Animal> currentAnimals = animals
                                .where((a) => viSpouts.contains(a.currentInfo.spout))
                                .toList();

                            return ListView.builder(
                              itemCount: currentAnimals.length,
                              itemBuilder: (BuildContext context, int index) {
                                int totalSpout = 0;
                                int totalActiveSpout = 0;
                                int totalPassiveSpout = 0;

                                for (VacuumInfo v in vacuums) {
                                  totalSpout += v.totalSpout;
                                  totalActiveSpout += currentAnimals.length;
                                }

                                totalPassiveSpout = totalSpout - totalActiveSpout;

                                List<LiveInfoCard> cards = [];

                                for (Animal a in currentAnimals) {
                                  LiveInfoCard l = LiveInfoCard(
                                    lightColor: AppColors.lightGreenColor,
                                    title: "Vakum #${currentVI.id}, Musluk #${a.currentInfo.spout.id}",
                                    name: "İnek #${a.id}",
                                    sessionYield: a.currentInfo.currentAmount,
                                    targetAmount: a.targetAmount,
                                    currentFlow: a.currentInfo.flowRate,
                                    lowFlowRate: a.currentInfo.lowFlowRate,
                                    sessionYieldUnit: 'L',
                                    targetAmountUnit: 'L',
                                    currentFlowUnit: a.currentInfo.flowRateUnit,
                                  );

                                  cards.add(l);
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
                                                    "${h.name} Süt Sağma Alanı",
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
                          sessionYieldUnit: 'L',
                          targetAmountUnit: 'L',
                          currentFlowUnit: 'L/min',
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
                            );
                            
                            
                          } else if (snapShot.hasError) {
                            return Center(
                              child: Text(snapShot.error.toString()),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      );
                    } else if (snapShot.hasError) {
                      return Center(child: Text(snapShot.error.toString()));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else if (snapShot.hasError) {
                return Center(child: Text(snapShot.error.toString()));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        } else if (snapShot.hasError) {
          return Center(child: Text(snapShot.error.toString()));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
