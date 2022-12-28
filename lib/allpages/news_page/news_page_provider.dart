import 'dart:convert';

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';

class NewsPageProvider extends ChangeNotifier {
  List items = [];
  final controller = ScrollController();
  bool loading = false;
  double topContainer = 0;
  onStart() async {
    Box box = await Hive.openBox("db");
    var newsJson = await box.get("news");
    if (newsJson == null) {
      loading = true;
      notifyListeners();
      var respons = await HttpService.GET(HttpConstant.yangilaklar);
      if (respons["status"] == HttpConnection.data) {
        items = respons["data"];
        Box box = await Hive.openBox("db");
        box.put("news", json.encode(items));
      }
    } else {
      items = json.decode(newsJson) as List;
    }

    loading = false;
    notifyListeners();
  }

  refresh() async {
    loading = true;
    notifyListeners();
    var respons = await HttpService.GET(HttpConstant.yangilaklar);
    if (respons["status"] == HttpConnection.data) {
      items = respons["data"];
      Box box = await Hive.openBox("db");
      box.put("news", json.encode(items));
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
    Map<String, String> param = {"path": value["context_path"]};
    var response = await HttpService.GET(HttpConstant.yangilaklar + "-by-path",
        params: param);
    EasyLoading.dismiss();
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigviewnews, arguments: response["data"][0]);
  }
}
