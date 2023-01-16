// ignore_for_file: avoid_single_cascade_in_expression_statements, prefer_const_constructors

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

class LoginPageProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  ontapChek(context) async {
    loading = true;
    notifyListeners();
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    if (name.isEmpty || password.isEmpty) {
      EasyLoading.showInfo("Ma'lumotlarni kiriting!");
    } else {
      Map<String, String> param = {"login": name, "password": password};
      var response = await HttpService.POST(HttpConstant.login, param);
      if (response["status"] == HttpConnection.data) {
        Box box = await Hive.openBox("db");
        box.put("person", {"login": name, "password": password});
        //Navigator.pop(context);
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: Center(
            child: Text(
              "Muvofaqiyyatli o'tdingiz",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        )..show();
      } else {
        EasyLoading.showInfo(response["data"]["message"]);
      }
    }
    loading = false;
    notifyListeners();
  }
}
