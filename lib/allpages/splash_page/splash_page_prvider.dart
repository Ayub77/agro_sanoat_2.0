import 'dart:async';
import 'dart:convert';

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SplashPageProvider extends ChangeNotifier {
  bool a = false;
  bool b = false;
  bool c = false;
  bool d = false;
  bool e = false;
  onStart(context) async {
    Box box = await Hive.openBox("db");
    box.put("projects", null);
    box.put("news", null);
    box.put("service", null);
    box.put("infos", null);
    box.put("video", null);
    box.put("st1", null);
    box.put("st2", null);
    box.put("person", null);
    Timer(const Duration(milliseconds: 400), () {
      a = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 400), () {
      b = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 1300), () {
      c = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 1700), () {
      e = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 3400), () async {
      var respons = await HttpService.GET(HttpConstant.yangilaklar);
      if (respons["status"] == HttpConnection.data) {
        Box box = await Hive.openBox("db");
        box.put("new", json.encode(respons["data"]));
      }
      var response = await HttpService.GET(HttpConstant.foydalanish);
      if (response["status"] == HttpConnection.data) {
        Box box = await Hive.openBox("db");
        box.put("info", json.encode(response["data"]));
      }
      d = true;
      notifyListeners();
      nextPage(context);
    });
  }

  nextPage(context) async {
    Timer(const Duration(milliseconds: 500), () async {
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteGeneration.homepage, (Route<dynamic> route) => false);
    });
  }
}
