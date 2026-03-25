import 'animal.dart';

class VacuumInfo {
  final int id;
  final int totalVacuum;
  final List<Animal> animals;

  VacuumInfo({
    required this.id,
    required this.totalVacuum,
    required this.animals,
  });
}
