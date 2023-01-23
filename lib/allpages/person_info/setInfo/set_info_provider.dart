import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

class SetInfoProvider extends ChangeNotifier {
  final oldController = TextEditingController();
  final newController = TextEditingController();
  String login = "";
  String oldPass = "";
  bool loading = false;
  bool eyeView = false;
  dynamic personInfo;

  chooseEye() {
    eyeView = !eyeView;
    notifyListeners();
  }

  onStart() async {
    loading = true;
    notifyListeners();
    Box box = await Hive.openBox("db");
    var person = await box.get("person");
    personInfo = await box.get("personInfo");
    login = person["login"];
    oldPass = person["password"];
    loading = false;
    notifyListeners();
  }

  editProfil(context) async {
    String old = oldController.text.trim();
    String neew = newController.text.trim();
    if (old.isEmpty || neew.isEmpty) {
      EasyLoading.showInfo("Ma'lumotlarni to'ldiring");
    } else {
      if (old == oldPass) {
        Map<String, dynamic> param = {
          "id": personInfo["farmer_user_id"],
          "password": neew
        };
        var response = await HttpService.PUT(HttpConstant.editLogin, param);
        if (response["status"] == HttpConnection.data) {
          EasyLoading.showSuccess("Parol muvofaqqiyatli o'zgartirildi");
          Box box = await Hive.openBox("db");
          box.put("person", {"login": login, "password": neew});
          Navigator.pop(context);
        }
      } else {
        EasyLoading.showInfo("Eski parol noto'g'ri kiritildi");
      }
    }
  }
}
