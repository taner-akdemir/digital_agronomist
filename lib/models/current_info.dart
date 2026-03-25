import 'package:milktrace/models/spout.dart';

class CurrentInfo {
  final double flowRate;
  final double lowFlowRate;
  final double currentAmount;
  final Spout spout;

  CurrentInfo({
    required this.flowRate,
    required this.currentAmount,
    required this.lowFlowRate,
    required this.spout,
  });
}
