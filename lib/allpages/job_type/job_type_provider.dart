import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:flutter/material.dart';

class JobTypeProvider extends ChangeNotifier {
  Map<String, double> dataMap = {};
  bool loading = false;
  List itemStat = [];
  int allperson = 0;
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

  onStart() async {
    loading = true;
    notifyListeners();
    var response = await HttpService.GET(HttpConstant.typesOfJob);
    if (response["status"] == HttpConnection.data) {
      itemStat = response["data"];
      for (var item in response["data"]) {
        allperson = allperson + int.parse(item["count"].toString());
        dataMap.addAll({item["name"]: double.parse(item["count"].toString())});
      }
    }
    loading = false;
    notifyListeners();
  }
}
