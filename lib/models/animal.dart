import 'package:milktrace/models/vacuum_info.dart';

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
}
