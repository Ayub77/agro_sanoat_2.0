import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class IncomePageProvider extends ChangeNotifier {
  bool loading = false;
  List items = [];
  DateTime selectedDate = DateTime.now();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();
  String type = "";

  onStart() async {
    Box box = await Hive.openBox("db");
    var person = await box.get("personInfo");
    type = person["type_activities_name"].toString();
    loading = true;
    notifyListeners();

    Map<String, dynamic> param = {
      "farmerId": person["id"].toString(),
      "month": month,
      "year": year
    };
    var response = await HttpService.GET(HttpConstant.myIncome, params: param);
    if (response["status"] == HttpConnection.data) {
      items = response["data"];
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
      year = picked.year.toString();
      month = picked.month < 10
          ? "0" + picked.month.toString()
          : picked.month.toString();
      onStart();
    }
  }
}
