import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class IncomePageProvider extends ChangeNotifier {
  bool loading = false;
  List items = [];

  onStart() async {
    Box box = await Hive.openBox("db");
    var person = await box.get("personInfo");
    loading = true;
    notifyListeners();

    Map<String, dynamic> param = {"farmerId": person["id"].toString()};
    var response = await HttpService.GET(HttpConstant.myIncome, params: param);
    if (response["status"] == HttpConnection.data) {
      items = response["data"];
    }
    loading = false;
    notifyListeners();
  }
}
