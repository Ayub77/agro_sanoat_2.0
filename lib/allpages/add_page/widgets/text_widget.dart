// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.label,
    required this.maxlines,
    required this.name,
    required this.controller,
    required this.wrong,
    this.focusNode,
  }) : super(key: key);
  final String label;
  final String name;
  final int maxlines;
  final bool wrong;
  final focusNode;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "   " + name,
          style: TextStyle(
              color: wrong
                  ? MainColors.fromHex(MainColors.colorRed)
                  : MainColors.fromHex("#54BF14"),
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: maxlines == 1 ? 55 : 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                color: !wrong
                    ? MainColors.fromHex(MainColors.mainColor)
                    : MainColors.fromHex(MainColors.colorRed)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            autofocus: false,
            focusNode: focusNode,
            cursorColor: MainColors.fromHex("#54BF14"),
            maxLines: maxlines,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: maxlines == 6 ? 18 : 0, horizontal: 15),
              hintText: label,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Visibility(
          visible: wrong,
          child: Text(
            name == "F.I.O"
                ? "   Ism 4 ta harfdan kichik bo'lmasligi kerak"
                : "   Ma'lumot juda ham kam kiritildi",
            style: TextStyle(
                color: wrong
                    ? MainColors.fromHex(MainColors.colorRed)
                    : MainColors.fromHex("#54BF14"),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
