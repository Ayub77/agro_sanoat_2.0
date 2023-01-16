import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class DrawerPageProvider extends ChangeNotifier {
  bool visible = false;

  getInfo() async {
    Box box = await Hive.openBox("db");
    var person = await box.get("person");
    if (person == null) {
      visible = false;
    } else {
      visible = true;
    }
    notifyListeners();
  }
}
