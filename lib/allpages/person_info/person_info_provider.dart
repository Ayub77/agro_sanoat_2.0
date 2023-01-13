import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class PersonInfoProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final birthController = TextEditingController();
  final jobController = TextEditingController();
  final phoneController = TextEditingController();
  final needController = TextEditingController();
  bool textEnebled = false;
  double size = 0;
  late File image;
  bool chek = false;

  onStart() async {
    Box box = await Hive.openBox("db");
    var person = await box.get("person");
    nameController.text = person["confirmed_users_fio"];
    birthController.text = person["birth_date"];
    jobController.text = person["type_activities_name"];
    phoneController.text = person["phone"];
    needController.text = person["problems_name"];
    notifyListeners();
  }

  textvisible() {
    textEnebled = !textEnebled;
    if (textEnebled) {
      size = 35;
    } else {
      size = 0;
    }
    notifyListeners();
  }

  setImage(bool choose, context) async {
    final ImagePicker _picker = ImagePicker();
    if (choose) {
      XFile? ximage = await _picker.pickImage(source: ImageSource.gallery);
      if (ximage != null) {
        image = File(ximage.path);
        chek = true;
      }
    } else {
      XFile? ximage = await _picker.pickImage(source: ImageSource.camera);
      if (ximage != null) {
        image = File(ximage.path);
        chek = true;
      }
    }
    Navigator.pop(context);
    notifyListeners();
  }
}
