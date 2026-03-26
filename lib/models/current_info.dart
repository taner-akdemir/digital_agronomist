import 'package:milktrace/models/spout.dart';

class CurrentInfo {
  final double flowRate;
  final String flowRateUnit;
  final double lowFlowRate;
  final String lowFlowRateUnit;
  final double currentAmount;
  final int spoutId;
  final Spout spout;

  CurrentInfo({
    required this.flowRate,
    required this.currentAmount,
    required this.lowFlowRate,
    required this.spout,
    required this.flowRateUnit,
    required this.lowFlowRateUnit,
    required this.spoutId,
  });

  factory CurrentInfo.fromJson(Map<String, dynamic> json) => CurrentInfo(
    flowRate: json["flowRate"],
    lowFlowRate: json["lowFlowRate"],
    currentAmount: json["currentAmount"],
    spout: Spout.fromJson(json["spout"]),
    spoutId: json["spoutId"],
    flowRateUnit: json["flowRateUnit"],
    lowFlowRateUnit: json["lowFlowRateUnit"],
  );

  Map<String, dynamic> toJson() => {
    "flowRate": flowRate,
    "lowFlowRate": lowFlowRate,
    "currentAmount": currentAmount,
    "spout": spout,
    "spoutId": spoutId,
    "flowRateUnit": flowRateUnit,
    "lowFlowRateUnit": lowFlowRateUnit,
  };
}
