import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:milktrace/models/animal.dart';
import 'package:milktrace/models/hall.dart';
import 'package:milktrace/models/spout.dart';
import 'dart:convert';

import 'package:milktrace/models/vacuum_info.dart';

class Api {

  static Future<List<Hall>> fetchHalls() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      String hallsStr = await rootBundle.loadString('assets/data/hall.json');
      var hallDecode = jsonDecode(hallsStr);
      List<Hall> halls = (hallDecode as List).map((hallMap) => Hall.fromJson(hallMap)).toList() ;
      return halls;
    }catch(e){
      return Future.error(e);
    }
  }

  static Future<List<VacuumInfo>> fetchVacuums() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      String vacuumStr = await rootBundle.loadString('assets/data/vacuum.json');
      var vacuumsDecode = jsonDecode(vacuumStr);
      List<VacuumInfo> vacuums = (vacuumsDecode as List).map((vacuumMap) => VacuumInfo.fromJson(vacuumMap)).toList();
      return vacuums;
    }catch(e){
      return Future.error(e);
    }
  }

  static Future<List<Spout>> fetchSpouts() async {
    try {
      //await Future.delayed(Duration(seconds: 1));
      debugPrint("spout list-1");
      String spoutStr = await rootBundle.loadString('assets/data/spout.json');
      var spoutsDecode = jsonDecode(spoutStr);
      List<Spout> spouts = (spoutsDecode as List).map((spoutMap) => Spout.fromJson(spoutMap)).toList();
      debugPrint("spout list");
      debugPrint(spouts.length.toString());
      return spouts;
    }catch(e){
      return Future.error(e);
    }
  }

  static Future<List<Animal>> fetchAnimals() async {
    try {
      await Future.delayed(Duration(seconds: 1));

      String animalStr = await rootBundle.loadString('assets/data/animal.json');
      var animalsDecode = jsonDecode(animalStr);
      List<Animal> animals = (animalsDecode as List).map((animalMap) => Animal.fromJson(animalMap)).toList();
      debugPrint("animals");
      debugPrint(animals.length.toString());
      return animals;

    }catch(e){
      return Future.error(e);
    }
  }
}