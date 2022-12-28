import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/object/universal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BottomSheetProvider extends ChangeNotifier {
  List<UniversalModel> provins = [];
  UniversalModel? selectRegion;
  UniversalModel? selectProvins;
  bool loading = false;
  BottomSheetProvider(UniversalModel? provis, UniversalModel? region) {
    onStart(provis, region);
  }

  onStart(UniversalModel? provins, UniversalModel? region) async {
    selectRegion = region;
    selectProvins = provins;
    if (selectRegion != null) {
      getProvince(selectRegion!.id.toString(), false);
    }
    notifyListeners();
  }

  getProvince(String id, bool cheek) async {
    if (cheek) {
      loading = true;
      notifyListeners();
    }
    Map<String, String> param = {"regions_id": id};
    var provinsJson = await HttpService.GET(HttpConstant.tuman, params: param);
    if (provinsJson["status"] == HttpConnection.data) {
      provins = regionFromMap(provinsJson["data"]["rows"]);
    }
    if (cheek) {
      selectProvins = null;
      loading = false;
    }
    notifyListeners();
  }

  getRegion(String id) async {
    loading = true;
    notifyListeners();
    Map<String, String> param = {"area_id": id};
    var provinsJson =
        await HttpService.GET(HttpConstant.dashboard, params: param);
    if (provinsJson["status"] == HttpConnection.data) {
      provins = regionFromMap(provinsJson["data"]["rows"]);
    }
    selectProvins = null;
    loading = false;
    notifyListeners();
  }

  close(context) {
    Navigator.pop(context);
  }

  closePage(context) {
    if (selectRegion == null) {
      EasyLoading.showInfo("Iltimos viloyatni tanlang");
    } else {
      Map<String, dynamic> param = {
        "provins": selectProvins ?? "0",
        "region": selectRegion ?? "0",
      };
      Navigator.pop(context, param);
    }
  }
}
