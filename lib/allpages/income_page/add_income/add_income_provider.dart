// ignore_for_file: avoid_single_cascade_in_expression_statements, prefer_const_constructors

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

class AddIncomeProvider extends ChangeNotifier {
  String birthDay = "";
  DateTime selectedDate = DateTime.now();
  final amountController = TextEditingController();
  final priceController = TextEditingController();
  bool loading = false;

  setBirthday(DateTime picked) {
    EasyLoading.dismiss();
    selectedDate = picked;
    String day = selectedDate.day < 10
        ? "0" + selectedDate.day.toString()
        : selectedDate.day.toString();
    String month = selectedDate.month < 10
        ? "0" + selectedDate.month.toString()
        : selectedDate.month.toString();
    String year = selectedDate.year.toString();
    if (picked.year == DateTime.now().year) {
      if (picked.month == DateTime.now().month) {
        birthDay = day + "." + month + "." + year;
      } else {
        EasyLoading.showInfo("Iltimos joriy oyni kiriting");
      }
    } else {
      EasyLoading.showInfo("Iltimos joriy yilni kiriting");
    }
    notifyListeners();
  }

  saveInfo(context) async {
    loading = true;
    notifyListeners();
    Box box = await Hive.openBox("db");
    var person = await box.get("personInfo");
    if (amountController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        birthDay.isEmpty) {
      EasyLoading.showInfo("Iltimos ma'lumotlarni to'ldiring");
    } else {
      double amount = double.parse(amountController.text.trim());
      double sum = double.parse(priceController.text.trim());
      Map<String, dynamic> param = {
        "farmers_id": person["id"],
        "amount": amount,
        "sum": sum,
        "pay_date": birthDay
      };
      var response = await HttpService.POST(HttpConstant.addIncome, param);
      if (response["status"] == HttpConnection.data) {
        EasyLoading.showSuccess("Muvofaqiyyatli saqlandi");
        Navigator.pop(context);
      } else {
        EasyLoading.showInfo(response["data"]["message"]);
      }
    }
    loading = false;
    notifyListeners();
  }
}
