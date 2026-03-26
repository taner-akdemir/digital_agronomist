import 'package:flutter/cupertino.dart';

import 'current_info.dart';

class Animal {
  final int id;
  final String name, type;
  final double targetAmount;
  final CurrentInfo currentInfo;

  Animal({
    required this.id,
    required this.name,
    required this.type,
    required this.targetAmount,
    required this.currentInfo,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return Animal(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      targetAmount: json["targetAmount"] as double,
      currentInfo: CurrentInfo.fromJson(json["currentInfo"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "targetAmount": targetAmount,
    "currentInfo": currentInfo,
  };
}
