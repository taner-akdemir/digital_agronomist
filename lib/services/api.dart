import 'package:milktrace/models/animal.dart';

class Api {
  static Future<List<Animal>> fetchAnimals() async {
    try {
      await Future.delayed(Duration(seconds: 2));

    }catch(e){
      return Future.error(e);
    }
  }
}