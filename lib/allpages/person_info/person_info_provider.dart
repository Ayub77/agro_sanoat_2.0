// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'dart:convert';

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/object/type_model.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class PersonInfoProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final needController = TextEditingController();
  bool loading = false;
  bool textEnebled = false;
  int id = 0;
  late LatLng latLng;
  String imageUrl = "";
  String lat = "";
  String birthDay = "";
  bool chek = false;
  List<TypeModel> typeItems = [];
  List<TypeModel> typeNeeds = [];
  TypeModel? selctType;
  TypeModel? selctNeeds;
  bool errorName = false;
  bool errorPhone = false;

  onStart() async {
    loading = true;
    notifyListeners();
    Box box = await Hive.openBox("db");
    var person = await box.get("person");
    var respons = await HttpService.POST(HttpConstant.login, person);
    if (respons["status"] == HttpConnection.data) {
      id = respons["data"]["id"];
      nameController.text = respons["data"]["name"];
      birthDay = respons["data"]["birth_date"];
      selctNeeds = TypeModel(
          id: respons["data"]["disvantages_and_problems_id"],
          name: respons["data"]["problems_name"]);
      selctType = TypeModel(
          id: respons["data"]["type_activities_id"],
          name: respons["data"]["type_activities_name"]);
      phoneController.text = respons["data"]["phone"];
      needController.text = respons["data"]["problems_name"];
      imageUrl = respons["data"]["resources_uuid"];
      latLng = LatLng(jsonDecode(respons["data"]["location"])["lat"],
          jsonDecode(respons["data"]["location"])["lng"]);
      lat = latLng.latitude.toString() + "," + latLng.longitude.toString();
    }

    var response = await HttpService.GET(HttpConstant.job);
    if (response["status"] == HttpConnection.data) {
      typeItems = typeFromMap(response["data"]["rows"]);
    }

    var responseNeeds = await HttpService.GET(HttpConstant.needs);
    if (responseNeeds["status"] == HttpConnection.data) {
      typeNeeds = typeFromMap(responseNeeds["data"]["rows"]);
    }

    loading = false;
    notifyListeners();
  }

  textvisible() {
    if (textEnebled) {
      onStart();
    }
    textEnebled = !textEnebled;
    notifyListeners();
  }

  setMarker(context) {
    Navigator.of(context)
        .pushNamed(RouteGeneration.map_marker, arguments: latLng)
        .then((value) {
      latLng = value as LatLng;
      lat = latLng.latitude.toString() + "," + latLng.longitude.toString();
      notifyListeners();
    });
  }

  editProfil(context) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    if (nameController.text.length < 4 || phoneController.text.length < 14) {
      if (nameController.text.length < 4) {
        errorName = true;
      } else {
        errorName = false;
      }
      if (phoneController.text.length < 14) {
        errorPhone = true;
      } else {
        errorPhone = false;
      }
      notifyListeners();
      EasyLoading.dismiss();
    } else {
      Map<String, dynamic> location = {
        "lat": latLng.latitude,
        "lng": latLng.longitude
      };
      Map<String, dynamic> param = {
        "id": id,
        "name": nameController.text.trim(),
        "birth_date": birthDay,
        "type_activities_id": selctType?.id,
        "phone": phoneController.text.trim(),
        "disvantages_and_problems_id": selctNeeds?.id,
        "location": jsonEncode(location)
      };
      var response = await HttpService.PUT(HttpConstant.editPerson, param);
      if (response["status"] == HttpConnection.data) {
        
        EasyLoading.dismiss();
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: Center(
            child: Text(
              "Muvofaqiyatli o'zgartirildi",
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

  setBirthday(DateTime picked) {
    selectedDate = picked;
    String day = selectedDate.day < 10
        ? "0" + selectedDate.day.toString()
        : selectedDate.day.toString();
    String month = selectedDate.month < 10
        ? "0" + selectedDate.month.toString()
        : selectedDate.month.toString();
    String year = selectedDate.year.toString();

    birthDay = day + "." + month + "." + year;
    notifyListeners();
  }

  selectItem(index, context) {
    if (index == 1) {
      textvisible();
    }
    if (index == 2) {
      AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: Center(
            child: Text(
              "Rostdan ham chiqmoqchimisiz?",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkText: "Ha",
          btnCancelText: "Yo'q",
          btnOkOnPress: () async {
            Box box = await Hive.openBox("db");
            box.put("person", null);
            Navigator.pop(context);
          },
          btnCancelOnPress: () {})
        ..show();
    }
    if (index == 3) {
      Navigator.of(context).pushNamed(RouteGeneration.setInfo);
    }
  }
}
