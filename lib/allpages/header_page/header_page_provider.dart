// ignore_for_file: prefer_collection_literals, prefer_const_constructors, constant_identifier_names, unused_local_variable
import 'dart:convert';
import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class HeaderPageProvider extends ChangeNotifier {
  //final List<PricePoint> points=[];
  bool loading = false;
  late BuildContext thiscontext;
  PageController infoController = PageController();
  PageController newsController = PageController();
  int animateindexInfo = 0;
  int animateindexNews = 0;
  List itemNews = [];
  List itemInfo = [];
  onStart(context) async {
    loading = true;
    notifyListeners();
    thiscontext = context;
    Box box = await Hive.openBox("db");
    var infoJson = await box.get("info");
    if (infoJson != null) {
      itemInfo = json.decode(infoJson) as List;
    }
    var newsJson = await box.get("new");
    if (newsJson != null) {
      itemNews = jsonDecode(newsJson) as List;
    }

    loading = false;
    notifyListeners();
  }

  nextInfo(context) async {
    Box box = await Hive.openBox("db");
    var person = await box.get("person");
    if (person == null) {
      Navigator.of(context).pushNamed(RouteGeneration.login);
    } else {
      Navigator.of(context).pushNamed(RouteGeneration.personInfo);
    }
  }

  changeInfo(index) {
    animateindexInfo = index;
    notifyListeners();
  }

  changeNews(index) {
    animateindexNews = index;
    notifyListeners();
  }

  ontapInfo(context, item) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    Map<String, String> param = {"path": item["context_path"]};
    var response = await HttpService.GET(HttpConstant.foydalanish + "-by-path",
        params: param);
    EasyLoading.dismiss();
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigviewinfo, arguments: response["data"][0]);
  }

  ontapNews(context, item) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    Map<String, String> param = {"path": item["context_path"]};
    var response = await HttpService.GET(HttpConstant.yangilaklar + "-by-path",
        params: param);
    EasyLoading.dismiss();
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigviewnews, arguments: response["data"][0]);
  }
}
