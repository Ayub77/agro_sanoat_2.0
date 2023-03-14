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
  bool allItemsEmpty = false;
  bool loading1 = false;
  bool loading2 = false;
  bool loading3 = false;
  late BuildContext thiscontext;
  PageController infoController = PageController();
  PageController newsController = PageController();
  PageController serviceController = PageController();
  int animateindexInfo = 0;
  int animateindexNews = 0;
  int animateindexService = 0;
  List itemNews = [];
  List itemInfo = [];
  List itemService = [];
  onStart(context) async {
    loading1 = true;
    loading2 = true;
    loading3 = true;
    notifyListeners();
    thiscontext = context;
    Box box = await Hive.openBox("db");
    var infoJson = await box.get("infos");
    if (infoJson != null) {
      itemInfo = json.decode(infoJson) as List;
      loading2 = false;
      notifyListeners();
    } else {
      loading2 = false;
      notifyListeners();
      // var infoResponse = await HttpService.GET(HttpConstant.foydalanish);
      // if (infoResponse["status"] == HttpConnection.data) {
      //   itemInfo = infoResponse["data"];
      //   Box box = await Hive.openBox("db");
      //   box.put("infos", json.encode(infoResponse["data"]));
      //   loading2 = false;
      //   notifyListeners();
      // }
    }
    var newsJson = await box.get("news");
    if (newsJson != null) {
      itemNews = jsonDecode(newsJson) as List;
      loading1 = false;
      notifyListeners();
    } else {
      loading1 = false;
      notifyListeners();
      // var newsResponse = await HttpService.GET(HttpConstant.yangilaklar);
      // if (newsResponse["status"] == HttpConnection.data) {
      //   itemNews = newsResponse["data"];
      //   Box box = await Hive.openBox("db");
      //   box.put("news", json.encode(newsResponse["data"]));
      //   loading1 = false;
      //   notifyListeners();
      //}
    }

    var serviceJson = await box.get("service");
    if (serviceJson != null) {
      itemService = jsonDecode(serviceJson) as List;
      loading3 = false;
      notifyListeners();
    } else {
      loading3 = false;
      notifyListeners();
      // var serviceResponse = await HttpService.GET(HttpConstant.xizmatlar);
      // if (serviceResponse["status"] == HttpConnection.data) {
      //   itemService = serviceResponse["data"];
      //   Box box = await Hive.openBox("db");
      //   box.put("service", json.encode(serviceResponse["data"]));
      //   loading3 = false;
      //   notifyListeners();
      // }
    }
    if (itemInfo.isEmpty && itemNews.isEmpty && itemService.isEmpty) {
      allItemsEmpty = true;
      notifyListeners();
    }
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

  changeService(index) {
    animateindexService = index;
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

  ontapService(context, info) {
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigviewinfo, arguments: info);
  }
}
