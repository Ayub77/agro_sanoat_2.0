import 'package:flutter/material.dart';

class MainColors {
  static const mainColor = "#61BF39";
  static const colorGreyDark = "#717171";
  static const colorGrey = "#959595";
  static const colorGreySoft = "#D8D7D7";
  static const colorYellow = "#FFED00";
  static const colorRed = "#FF3F3F";
  static const colorGreen = "#70D943";
  static const colorWhite = "#FFFFFF";
  static const colorSilver = "#BEC6CA";
  static const colorBronze = "#DEA000";
  static const colorGold = "#F6C441";
  static const colorBlue = "#1592FF";
  static const colorBlack = "#000000";
  static const colorBack = "#F5F5F5";

  static const colorBlueSoft = "#73C1F8";

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
