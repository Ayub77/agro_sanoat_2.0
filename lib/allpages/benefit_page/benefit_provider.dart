import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class BenifitPageProvider extends ChangeNotifier {
  bool loading = false;
  List items = [];
  int index = 0;
  String change = "Summasi";
  Map<String, double> dataMap = {};
  String birthDay = "";
  DateTime selectedDate = DateTime.now();
  Map<String, String> param = {};
  String year = "";
  int month = 0;
  onStart(context) async {
    param = {
      "year": DateTime.now().year.toString(),
      "month": DateTime.now().month.toString()
    };
    year = DateTime.now().year.toString();
    month = DateTime.now().month;
    getInfo();
  }

  getInfo() async {
    loading = true;
    notifyListeners();
    var response =
        await HttpService.GET(HttpConstant.statisticRegion, params: param);
    if (response["status"] == HttpConnection.data) {
      items = response["data"];
    }
    changeType(0);
  }

  changeType(id) {
    index = id;
    dataMap.clear();
    if (id == 0) {
      change = "Summasi";
      for (var item in items) {
        dataMap.addAll({item["name"]: item["sum"]});
      }
    }
    if (id == 1) {
      change = "Miqdori";
      for (var item in items) {
        dataMap.addAll({item["name"]: item["amount"]});
      }
    }
    loading = false;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      param = {
        "year": picked.year.toString(),
        "month": picked.month.toString()
      };
      year = picked.year.toString();
      month = picked.month;
      getInfo();
    }
  }

  String setMonthName(int index) {
    switch (index) {
      case 1:
        return "Yanvar";
      case 2:
        return "Fevral";
      case 3:
        return "Mart";
      case 4:
        return "Aprel";
      case 5:
        return "May";
      case 6:
        return "Iyun";
      case 7:
        return "Iyul";
      case 8:
        return "Avgust";
      case 9:
        return "Sentyabr";
      case 10:
        return "Oktyabr";
      case 11:
        return "Noyabr";
      case 12:
        return "Dekabr";
    }
    return "";
  }

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
}
