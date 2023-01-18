import 'package:agro_sanoat/allpages/benefit_page/bottomsheet/bottomsheet.dart';
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
  onStart(context) async {
    if (param.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 500));
      selectDate(context);
    } else {
      getInfo();
    }
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

  openBottom(context) {
    BottomSheetWidget.modalBottomSheetMenu(context);
  }

  setBirthday(DateTime picked) {
    String month = picked.month < 10
        ? "0" + picked.month.toString()
        : picked.month.toString();
    String year = selectedDate.year.toString();

    param = {"year": year, "month": month};
    getInfo();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setBirthday(picked);
    }
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
