import 'package:flutter/material.dart';
import 'package:milktrace/models/dashboard_data.dart';
import 'package:milktrace/models/hall.dart';

import '../../theme.dart';

class HallListScreen extends StatefulWidget {
  const HallListScreen({super.key});

  @override
  State<HallListScreen> createState() => _HallListScreenState();
}

class _HallListScreenState extends State<HallListScreen> {
  List<Hall> hls = halls;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.count(
        crossAxisCount: 2,
        children: hls.map((item) {
          return InkWell(
            onTap: () {
              
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.lightGreenColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "${item.hallName} Bölümü",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
