// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';

class LoginWidget1 extends StatelessWidget {
  const LoginWidget1({
    Key? key,
    required this.size,
    required this.name,
    required this.icon,
  }) : super(key: key);

  final Size size;
  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MainColors.fromHex(MainColors.colorGreen).withAlpha(50)),
      child: TextField(
        cursorColor: MainColors.fromHex(MainColors.colorGreen),
        decoration: InputDecoration(
            icon: icon, hintText: name, border: InputBorder.none),
      ),
    );
  }
}
