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
    box.put("service", null);

    //box.put("person", null);
    Timer(const Duration(milliseconds: 300), () {
      a = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 300), () {
      b = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 1200), () {
      c = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 1600), () {
      e = true;
      notifyListeners();
    });
    Timer(const Duration(milliseconds: 3300), () async {
      d = true;

      var newsResponse = await HttpService.GET(HttpConstant.yangilaklar);
      if (newsResponse["status"] == HttpConnection.data) {
        Box box = await Hive.openBox("db");
        box.put("news", json.encode(newsResponse["data"]));
      }
      var serviceResponse = await HttpService.GET(HttpConstant.xizmatlar);
      if (serviceResponse["status"] == HttpConnection.data) {
        Box box = await Hive.openBox("db");
        box.put("service", json.encode(serviceResponse["data"]));
      }
      var infoResponse = await HttpService.GET(HttpConstant.foydalanish);
      if (infoResponse["status"] == HttpConnection.data) {
        Box box = await Hive.openBox("db");
        box.put("infos", json.encode(infoResponse["data"]));
      }
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
