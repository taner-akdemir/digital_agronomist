import 'package:milktrace/models/hall.dart';

import 'animal.dart';

class VacuumInfo {
  final int id;
  final int totalSpout;
  final int hallID;
  final Hall hall;

  VacuumInfo({
    required this.id,
    required this.totalSpout,
    required this.hallID,
    required this.hall,
  });

  factory VacuumInfo.fromJson(Map<String, dynamic> json) => VacuumInfo(
    id: json["id"],
    totalSpout: json["totalSpout"],
    hallID: json["hallID"],
    hall: Hall.fromJson(json["hall"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalSpout": totalSpout,
    "hallID": hallID,
    "hall": hall,
  };
}
