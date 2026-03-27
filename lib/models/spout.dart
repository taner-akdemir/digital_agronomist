import 'package:milktrace/models/vacuum_info.dart';

class Spout {
  final int id;
  final int vacuumID;
  final VacuumInfo vacuumInfo;

  Spout({required this.id, required this.vacuumID, required this.vacuumInfo});

  factory Spout.fromJson(Map<String, dynamic> json) => Spout(
    id: json["id"],
    vacuumID: json["vacuumID"],
    vacuumInfo: VacuumInfo.fromJson(json["vacuumInfo"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vacuumID": vacuumID,
    "vacuumInfo": vacuumInfo,
  };
}
