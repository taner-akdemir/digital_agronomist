import 'package:milktrace/models/vacuum_info.dart';

class Hall {
  final int id;
  final String hallName;
  final List<VacuumInfo> vacuums;

  Hall({required this.id, required this.hallName, required this.vacuums});
}