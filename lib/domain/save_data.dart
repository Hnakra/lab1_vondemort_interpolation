import 'dart:async';

import 'package:vondemort_interpolation/data/models/dot.dart';

class SaveData{
  static final StreamController controllerOutput = StreamController();
  static final StreamController controllerInput= StreamController();

  static List<Dot> list = [];
  static init(){
    controllerInput.stream.listen((map) {
      for(String key in map.keys) {
        key == "add" ? list.add(map[key]) : list.remove(map[key]);
        list.sort((a, b) => a.x.compareTo(b.x));
        controllerOutput.add(list);
      }
    });
  }
}