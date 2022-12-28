import 'dart:convert';

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ServicePageProvider extends ChangeNotifier {
  List items = [];
  bool loading = false;

  onStart() async {
    Box box = await Hive.openBox("db");
    var newsJson = await box.get("service");
    if (newsJson == null) {
      loading = true;
      notifyListeners();
      var respons = await HttpService.GET(HttpConstant.xizmatlar);
      if (respons["status"] == HttpConnection.data) {
        items = respons["data"];
        Box box = await Hive.openBox("db");
        box.put("service", json.encode(items));
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
    var respons = await HttpService.GET(HttpConstant.xizmatlar);
    if (respons["status"] == HttpConnection.data) {
      items = respons["data"];
      Box box = await Hive.openBox("db");
      box.put("service", json.encode(items));
    }
    loading = false;
    notifyListeners();
  }

  bigView(context, value) async {
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigImageNews, arguments: value);
  }
}
