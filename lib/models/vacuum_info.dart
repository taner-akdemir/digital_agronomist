import 'animal.dart';

class VacuumInfo {
  final int id;
  final int totalSpout;
  final int hallID;

  VacuumInfo({
    required this.id,
    required this.totalSpout,
    required this.hallID,
  });

  factory VacuumInfo.fromJson(Map<String, dynamic> json) => VacuumInfo(
    id: json["id"],
    totalSpout: json["totalSpout"],
    hallID: json["hallID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "totalSpout": totalSpout,
    "hallID": hallID,
  };
}
