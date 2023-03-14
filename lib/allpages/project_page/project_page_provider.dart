import 'dart:convert';

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

class ProjectPageProvider extends ChangeNotifier {
  List items = [];
  bool loading = true;
  onStart() async {
    Box box = await Hive.openBox("db");
    var newsJson = await box.get("projects");
    if (newsJson == null) {
      loading = true;
      notifyListeners();
      var response = await HttpService.GET(HttpConstant.loyihalar);
      if (response["status"] == HttpConnection.data) {
        items = response["data"];
        Box box = await Hive.openBox("db");
        box.put("projects", jsonEncode(items));
      }
    } else {
      items = jsonDecode(newsJson);
    }
    loading = false;
    notifyListeners();
  }

  refresh() async {
    loading = true;
    notifyListeners();
    var response = await HttpService.GET(HttpConstant.loyihalar);
    if (response["status"] == HttpConnection.data) {
      items = response["data"];
      Box box = await Hive.openBox("db");
      box.put("projects", jsonEncode(items));
    }
    loading = false;
    notifyListeners();
  }

  bigView(context, value) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    Map<String, String> param = {"path": value};
    var response = await HttpService.GET(HttpConstant.yangilaklar + "-by-path",
        params: param);
    EasyLoading.dismiss();
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigviewnews, arguments: response["data"][0]);
  }
}
