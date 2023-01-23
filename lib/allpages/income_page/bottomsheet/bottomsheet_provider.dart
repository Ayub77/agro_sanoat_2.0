import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class BottomSheetProvider extends ChangeNotifier {
  bool loading = false;
  String birthDay = "";
  DateTime selectedDate = DateTime.now();

  setBirthday(DateTime picked) {
    String month = picked.month < 10
        ? "0" + picked.month.toString()
        : picked.month.toString();
    String year = selectedDate.year.toString();

    birthDay = month + "." + year;
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setBirthday(picked);
    }
  }
}
