import 'package:milktrace/models/vacuum_info.dart';

class Hall {
  final int id;
  final String name;

  Hall({required this.id, required this.name});

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}