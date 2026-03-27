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
  late  Future<List<Hall>> hls;
  late  Future<List<VacuumInfo>> vacuums;
  late  Future<List<Spout>> spouts;
  late  Future<List<Animal>> animals;

  late int totalSpout = 0;
  late int totalActiveSpout = 0;
  late int totalPassiveSpout = 0;
  late String hallId = "1";

  @override
  void initState() {
    super.initState();
    fetchData(hallId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 300) / 2;
    final double itemWidth = (size.width - 10) / 2;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Column(
        children: [
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
                    Row(
                      children: [
                        FutureBuilder(
                          future: hls,
                          builder: (context, snapShot) {
                            if(snapShot.hasData){
                              List<Hall> halls = snapShot.data!;
                              return DropdownButton<String>(
                                value: hallId,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(color: Colors.deepPurple),
                                underline: Container(height: 2, color: Colors.deepPurpleAccent),
                                onChanged: (String? value) {
                                  setState(() {
                                    hallId = value!;
                                    fetchData(hallId);
                                  });
                                },
                                items: halls.map<DropdownMenuItem<String>>((Hall h) {
                                  return DropdownMenuItem<String>(value: h.id.toString(), child: Text(h.name));
                                }).toList(),
                              );
                            }

                            return SizedBox();
                          },
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Süt Sağma Alanı",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
          SizedBox(height: 10),
          FutureBuilder(
            future: animals,
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                List<Animal> animals = snapShot.data!;
                List<LiveInfoCard> cards = [];
                for (Animal a in animals) {
                  LiveInfoCard l = LiveInfoCard(
                    lightColor: AppColors.lightGreenColor,
                    title:
                        "Vakum #${a.currentInfo.spout.vacuumInfo.id}, Musluk #${a.currentInfo.spout.id}",
                    name: "${a.name} #${a.id}",
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

                return Expanded(
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // top side
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
                                controller: ScrollController(
                                  keepScrollOffset: false,
                                ),
                                scrollDirection: Axis.vertical,
                                childAspectRatio: (itemWidth / itemHeight),
                                children: cards,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapShot.hasError) {
                return Center(child: Text(snapShot.error.toString()));
              } else {
                debugPrint("waiting");
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> fetchData(String hallId) async {
    debugPrint("geldi $hallId");
    hls = Api.fetchHalls();
    vacuums = Api.fetchVacuums(hallId);
    //spouts = Api.fetchSpouts();
    animals = Api.fetchAnimals(hallId);
    var ts = 0;

    vacuums.then((v){
      for(VacuumInfo vv in v){
        ts += vv.totalSpout;
      }
    }).whenComplete(() {
      setState(() {
        totalSpout = ts;
      });
    });

    var tAs = 0;
    animals
        .then((a) {
         for(Animal aa in a){
           tAs += 1;
         }
        })
        .whenComplete(() {
          setState(() {
            totalActiveSpout = tAs;
            totalPassiveSpout = ts - tAs;
          });
        });
  }
}
