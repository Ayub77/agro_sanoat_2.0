import 'dart:convert';

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

class StatisticPageProvider extends ChangeNotifier {
  String? selectedValue;
  String change = "Dehqonlar soni";
  bool isloading = false;
  bool isloading1 = false;
  List itemName = [];
  List itemNumber = [];
  String farmar = "Dehqonlar";
  List<Color> colors = [
    Colors.red,
    Colors.teal,
    Colors.cyan,
    Colors.blue,
    Colors.green,
    Colors.greenAccent,
    Colors.indigo,
    Colors.lightBlueAccent,
    Colors.indigoAccent,
    Colors.orange,
    Colors.lightBlue,
    Colors.lime,
    Colors.lightGreen,
    Colors.deepPurpleAccent,
    Colors.deepOrange,
    Colors.pink,
    Colors.deepOrangeAccent,
    Colors.grey,
    Colors.purple,
    Colors.cyanAccent,
    Colors.deepPurple,
    Colors.amber,
    Colors.yellow,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.blue,
    Colors.red,
    Colors.teal,
    Colors.green,
    Colors.greenAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightGreen,
    Colors.orange,
    Colors.deepOrange,
    Colors.lime,
    Colors.pink,
    Colors.purple,
    Colors.deepPurpleAccent,
    Colors.amber,
    Colors.brown,
    Colors.grey,
    Colors.deepPurple,
    Colors.deepOrangeAccent,
    Colors.yellow,
    Colors.blueGrey,
    Colors.cyanAccent,
  ];
  int index = 0;
  Map<String, double> dataMap = {};
  Map<String, double> count = {};
  Map<String, double> area = {};

  selectDropDown(value) {
    selectedValue = value as String;
    notifyListeners();
  }

  onStart() async {
    isloading = true;
    notifyListeners();
    Box box = await Hive.openBox("db");
    var st1 = await box.get("st1");
    if (st1 == null) {
      var response = await HttpService.GET(HttpConstant.statistikadehqon);
      if (response["status"] == HttpConnection.data) {
        dataMap.clear();
        count.clear();
        area.clear();
        box.put("st1", jsonEncode(response["data"]));
        for (var item in response["data"]) {
          dataMap
              .addAll({item["name"]: double.parse(item["count"].toString())});
          count.addAll({item["name"]: double.parse(item["count"].toString())});
          area.addAll({item["name"]: double.parse(item["area"].toString())});
        }
        itemName = dataMap.keys.toList();
        itemNumber = dataMap.values.toList();
      }
    } else {
      dataMap.clear();
      count.clear();
      area.clear();
      var response = jsonDecode(st1);
      for (var item in response) {
        dataMap.addAll({item["name"]: double.parse(item["count"].toString())});
        count.addAll({item["name"]: double.parse(item["count"].toString())});
        area.addAll({item["name"]: double.parse(item["area"].toString())});
      }
      itemName = dataMap.keys.toList();
      itemNumber = dataMap.values.toList();
    }
    isloading = false;
    notifyListeners();
  }

  onStart1() async {
    isloading1 = true;
    notifyListeners();
    Box box = await Hive.openBox("db");
    var st2 = await box.get("st2");
    if (st2 == null) {
      var response = await HttpService.GET(HttpConstant.statistikafermer);
      if (response["status"] == HttpConnection.data) {
        dataMap.clear();
        count.clear();
        area.clear();
        box.put("st2", jsonEncode(response["data"]));
        for (var item in response["data"]) {
          dataMap
              .addAll({item["name"]: double.parse(item["count"].toString())});
          count.addAll({item["name"]: double.parse(item["count"].toString())});
          area.addAll({item["name"]: double.parse(item["area"].toString())});
        }
        itemName = dataMap.keys.toList();
        itemNumber = dataMap.values.toList();
      }
    } else {
      dataMap.clear();
      count.clear();
      area.clear();
      var response = jsonDecode(st2);
      for (var item in response) {
        dataMap.addAll({item["name"]: double.parse(item["count"].toString())});
        count.addAll({item["name"]: double.parse(item["count"].toString())});
        area.addAll({item["name"]: double.parse(item["area"].toString())});
      }
      itemName = dataMap.keys.toList();
      itemNumber = dataMap.values.toList();
    }
    isloading1 = false;
    notifyListeners();
  }

  chooseChange(value) {
    index = value;
    if (index == 0) {
      farmar = "Dehqonlar";
      change = "Dehqonlar soni";
      colors = colorlist1;
      dataMap = count;
      onStart();
    } else {
      farmar = "Fermerlar";
      change = "Fermerlar soni";
      colors = colorlist1;
      dataMap = count;
      onStart1();
    }
  }

  selectItem(value) {
    switch (value) {
      case 1:
        change = "Maydon hajmi";
        colors = colorlist;
        dataMap = area;
        break;

      case 2:
        dataMap = count;
        colors = colorlist1;
        change = farmar + " soni";
        break;
    }
    itemName = dataMap.keys.toList();
    itemNumber = dataMap.values.toList();
    notifyListeners();
  }

  List<Color> colorlist = [
    Colors.blue,
    Colors.red,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.greenAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightGreen,
    Colors.orange,
    Colors.deepOrange,
    Colors.lime,
    Colors.pink,
    Colors.deepPurpleAccent,
    Colors.purple,
    Colors.grey,
    Colors.amber,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.cyanAccent,
    Colors.yellow,
    Colors.blueGrey,
    Colors.brown,
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.greenAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightGreen,
    Colors.orange,
    Colors.deepOrange,
    Colors.lime,
    Colors.pink,
    Colors.deepPurpleAccent,
    Colors.purple,
    Colors.grey,
    Colors.amber,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    Colors.cyanAccent,
    Colors.yellow,
    Colors.blueGrey,
    Colors.brown,
  ];
  List<Color> colorlist1 = [
    Colors.red,
    Colors.teal,
    Colors.cyan,
    Colors.blue,
    Colors.green,
    Colors.greenAccent,
    Colors.indigo,
    Colors.lightBlueAccent,
    Colors.indigoAccent,
    Colors.orange,
    Colors.lightBlue,
    Colors.lime,
    Colors.lightGreen,
    Colors.deepPurpleAccent,
    Colors.deepOrange,
    Colors.pink,
    Colors.deepOrangeAccent,
    Colors.grey,
    Colors.purple,
    Colors.cyanAccent,
    Colors.deepPurple,
    Colors.amber,
    Colors.yellow,
    Colors.blueGrey,
    Colors.brown,
    Colors.cyan,
    Colors.blue,
    Colors.red,
    Colors.teal,
    Colors.green,
    Colors.greenAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightGreen,
    Colors.orange,
    Colors.deepOrange,
    Colors.lime,
    Colors.pink,
    Colors.purple,
    Colors.deepPurpleAccent,
    Colors.amber,
    Colors.brown,
    Colors.grey,
    Colors.deepPurple,
    Colors.deepOrangeAccent,
    Colors.yellow,
    Colors.blueGrey,
    Colors.cyanAccent,
  ];
}
