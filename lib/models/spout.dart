class Spout {
  final int id;
  final int vacuumID;

  Spout({required this.id, required this.vacuumID});

  factory Spout.fromJson(Map<String, dynamic> json) => Spout(
    id: json["id"],
    vacuumID: json["vacuumID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vacuumID": vacuumID,
  };
}
