import 'package:milktrace/models/current_info.dart';
import 'package:milktrace/models/hall.dart';
import 'package:milktrace/models/vacuum_info.dart';

import 'animal.dart';

class DashboardData {
  final List<Animal> animals;
  final VacuumInfo vacuumInfo;

  DashboardData({required this.animals, required this.vacuumInfo});
}



Animal animal1 = Animal(
  id: 1,
  name: 'İnek',
  type: 'cow',
  targetAmount: 20,
  currentInfo: CurrentInfo(flowRate: 1.5, currentAmount: 12, lowFlowRate: 1),
);

Animal animal2 = Animal(
  id: 2,
  name: 'İnek',
  type: 'cow',
  targetAmount: 20,
  currentInfo: CurrentInfo(flowRate: 1.6, currentAmount: 10, lowFlowRate: 1),
);

Animal animal3 = Animal(
  id: 3,
  name: 'İnek',
  type: 'cow',
  targetAmount: 20,
  currentInfo: CurrentInfo(flowRate: 0.9, currentAmount: 8, lowFlowRate: 1),
);

Animal animal4 = Animal(
  id: 4,
  name: 'İnek',
  type: 'cow',
  targetAmount: 20,
  currentInfo: CurrentInfo(flowRate: 1.7, currentAmount: 14, lowFlowRate: 1),
);

List<Animal> animals = [animal1];

VacuumInfo vi1 = VacuumInfo(id: 1, totalVacuum: 10, animals: animals);

List<VacuumInfo> vacuums = [vi1];

Hall h1 = Hall(id: 1, hallName: "A", vacuums: vacuums);
