// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/home_page/home_page_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    required this.name,
    required this.index,
    required this.currnttab,
    required this.provider,
    required this.icon,
  }) : super(key: key);
  final String name;
  final int index;
  final int currnttab;
  final HomePageProvider provider;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MaterialButton(
      onPressed: () {
        provider.selectCurrentTab(index);
      },
      padding: EdgeInsets.all(0),
      splashColor: Colors.green.withOpacity(0.5),
      child: Column(
        children: [
          Container(
              height: 3,
              width: double.infinity,
              color: index == currnttab
                  ? MainColors.fromHex("#54BF14")
                  : Colors.white),
          SizedBox(
            height: 7,
          ),
          SvgPicture.asset(
            icon,
            color: index == currnttab
                ? MainColors.fromHex("#54BF14")
                : MainColors.fromHex(MainColors.colorGrey),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            name,
            style: TextStyle(
                color: index == currnttab
                    ? MainColors.fromHex("#54BF14")
                    : MainColors.fromHex(MainColors.colorGrey),
                fontSize: 10,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
      minWidth: 35,
    ));
  }
}
