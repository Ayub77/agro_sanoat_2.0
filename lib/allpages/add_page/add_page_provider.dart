// ignore_for_file: avoid_single_cascade_in_expression_statements, prefer_const_constructors

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/object/universal.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vibration/vibration.dart';

class AddPageProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final infoController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode infoFocus = FocusNode();
  List<UniversalModel> regions = [];
  List<UniversalModel> provins = [];
  UniversalModel? selectRegion;
  UniversalModel? selectProvins;
  bool wrongname = false;
  bool wrongphone = false;
  bool wronginfo = false;
  bool wrongProvince = false;
  bool wrongRegion = false;
  bool loading = false;

  onStart() async {
    var regionJson = await HttpService.GET(HttpConstant.viloyat);
    if (regionJson["status"] == HttpConnection.data) {
      regions = regionFromMap(regionJson["data"]["rows"]);
    }
    provins.clear();
    selectProvins = null;
    notifyListeners();
  }

  sendInfo(context) async {
    String name = nameController.text.trim();
    String phone = "+998 " + phoneController.text.trim();
    String info = infoController.text.trim();
    // String provinseId = selectProvins!.id.toString();
    // String regionId = selectRegion!.id.toString();
    if (name.length < 4 ||
        phone.length < 19 ||
        info.length < 20 ||
        selectProvins == null ||
        selectRegion == null) {
      if (name.length < 4) {
        onErrorTextFieldName();
      } else {
        wrongname = false;
      }
      if (phone.length < 19) {
        onErrorTextFieldPhone();
      } else {
        wrongphone = false;
      }
      if (info.length < 20) {
        onErrorTextFieldInfo();
      } else {
        wronginfo = false;
      }
      if (selectProvins == null) {
        onErrorProvinse();
      } else {
        wrongProvince = false;
      }
      if (selectRegion == null) {
        onErrorRegion();
      } else {
        wrongRegion = false;
      }
    } else {
      String provinseId = selectProvins!.id.toString();
      String regionId = selectRegion!.id.toString();
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 1000)
        ..backgroundColor = Colors.white
        ..indicatorColor = Colors.black
        ..maskType = EasyLoadingMaskType.black
        ..maskColor = Colors.black
        ..userInteractions = false;
      EasyLoading.show(status: 'loading...');
      Map<String, String> param = {
        "fio": name,
        "regions_id": regionId,
        "areas_id": provinseId,
        "phone_number": phone,
        "text": info
      };

      var response = await HttpService.POST(HttpConstant.murojat, param);
      if (response["status"] == HttpConnection.none) {
        EasyLoading.showInfo(response["data"]["message"]);
      }
      if (response["status"] == HttpConnection.data) {
        EasyLoading.dismiss();
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: Center(
            child: Text(
              'Muvofaqiyatli yuborildi',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        )..show();
      } else {
        EasyLoading.dismiss();
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.error,
          body: Center(
            child: Text(
              "Qandaydir xatolik ro'y berdi",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkOnPress: () {
            Navigator.pop(context);
          },
        )..show();
      }
    }
  }

  getProvince(String id) async {
    loading = true;
    notifyListeners();
    Map<String, String> param = {"regions_id": id};
    var provinsJson = await HttpService.GET(HttpConstant.tuman, params: param);
    if (provinsJson["status"] == HttpConnection.data) {
      provins = regionFromMap(provinsJson["data"]["rows"]);
    }
    selectProvins = null;
    loading = false;
    notifyListeners();
  }

  onErrorTextFieldName() async {
    Vibration.vibrate(duration: 500);
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      wrongname = false;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 100));
      wrongname = true;
      notifyListeners();
    }
  }

  onErrorTextFieldPhone() async {
    Vibration.vibrate(duration: 500);
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      wrongphone = false;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 100));
      wrongphone = true;
      notifyListeners();
    }
  }

  onErrorProvinse() async {
    Vibration.vibrate(duration: 500);
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      wrongProvince = false;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 100));
      wrongProvince = true;
      notifyListeners();
    }
  }

  onErrorRegion() async {
    Vibration.vibrate(duration: 500);
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      wrongRegion = false;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 100));
      wrongRegion = true;
      notifyListeners();
    }
  }

  onErrorTextFieldInfo() async {
    Vibration.vibrate(duration: 500);
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      wronginfo = false;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 100));
      wronginfo = true;
      notifyListeners();
    }
  }
}
