// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InfoPageProvider extends ChangeNotifier {
  List items = [];
  List itemsVideo = [];
  bool loading1 = true;
  bool loading2 = true;

  int index = 0;
  onStart1() async {
    loading1 = true;
    notifyListeners();
    var response = await HttpService.GET(HttpConstant.foydalanish);
    if (response["status"] == HttpConnection.data) {
      items = response["data"];
    }

    loading1 = false;
    notifyListeners();
  }

  onStart2() async {
    loading2 = true;
    notifyListeners();

    var response = await HttpService.GET(HttpConstant.videoInfo);
    if (response["status"] == HttpConnection.data) {
      itemsVideo = response["data"];
    }

    loading2 = false;
    notifyListeners();
  }

  bigView(context, item) async {
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

  openVideo(videoUrl, context) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    Navigator.of(context).pushNamed(RouteGeneration.video, arguments: videoId);
  }

  chooseChange(value) {
    index = value;
    notifyListeners();
  }
}
