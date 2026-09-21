import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milktrace/data/legacy/hall.dart';

import 'package:milktrace/features/shell/shell_providers.dart';
import 'package:milktrace/data/api.dart';
import 'package:milktrace/app/theme.dart';

class HallListScreen extends ConsumerStatefulWidget {
  const HallListScreen({super.key});

  @override
  ConsumerState<HallListScreen> createState() => _HallListScreenState();
}

class _HallListScreenState extends ConsumerState<HallListScreen> {
  late final Future<List<Hall>> hls;

  @override
  void initState() {
    super.initState();
    hls = Api.fetchHalls();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<List<Hall>>(
        future: hls,
        initialData: [],
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Hall> halls = snapShot.data!;
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: halls.map((h) {
                return InkWell(
                  onTap: () {
                    ref.read(dashboardProvider.notifier).update((state) => state = "hall" );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "${h.name} - Sağım Bölgesi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (snapShot.hasError) {
            return Center(child: Text(snapShot.error.toString()));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
