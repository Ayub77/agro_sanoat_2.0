import 'dart:convert';

import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/object/type_model.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
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

  onStart() async {
    loading = true;
    notifyListeners();
    Box box = await Hive.openBox("db");
    var person = await box.get("person");
    id = person["id"];
    nameController.text = person["confirmed_users_fio"];
    birthDay = person["birth_date"];
    selctType = TypeModel(
        id: person["type_activities_id"], name: person["type_activities_name"]);
    phoneController.text = "+998 " + person["phone"];
    needController.text = person["problems_name"];
    imageUrl = person["resources_uuid"];
    latLng = LatLng(jsonDecode(person["location"])["lat"],
        jsonDecode(person["location"])["lng"]);
    lat = latLng.latitude.toString() + "," + latLng.longitude.toString();

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

  editProfil() {
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
    print(param);
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
}
