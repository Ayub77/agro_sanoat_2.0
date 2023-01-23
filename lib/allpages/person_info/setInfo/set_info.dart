// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/person_info/setInfo/set_info_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SetInfo extends StatefulWidget {
  const SetInfo({Key? key}) : super(key: key);

  @override
  State<SetInfo> createState() => _SetInfoState();
}

class _SetInfoState extends State<SetInfo> {
  SetInfoProvider provider = SetInfoProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<SetInfoProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorBack),
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Parolni o'zgartirish",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MainColors.fromHex(MainColors.colorWhite)),
            ),
          ),
          body: provider.loading
              ? Loading()
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Login",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          SizedBox(height: 3),
                          Container(
                              height: 50,
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MainColors.fromHex(
                                          MainColors.colorGreen),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.centerLeft,
                              child: Text(provider.login,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black))),
                          SizedBox(height: 20),
                          Text(
                            "  Eski parol",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          SizedBox(height: 3),
                          Container(
                              height: 50,
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MainColors.fromHex(
                                          MainColors.colorGreen),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: provider.oldController,
                                scrollPadding: EdgeInsets.all(0),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Eski parolni kiriting",
                                    hintStyle: TextStyle(
                                        color: MainColors.fromHex(
                                            MainColors.colorGrey)),
                                    contentPadding: EdgeInsets.all(0),
                                    border: InputBorder.none),
                              )),
                          SizedBox(height: 20),
                          Text(
                            "  Yangi parol",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          SizedBox(height: 3),
                          Container(
                              height: 50,
                              width: double.infinity,
                              padding: EdgeInsets.only(top: 7, left: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MainColors.fromHex(
                                          MainColors.colorGreen),
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: provider.newController,
                                scrollPadding: EdgeInsets.all(0),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    hintText: "Yangi parolni kiriting",
                                    hintStyle: TextStyle(
                                        color: MainColors.fromHex(
                                            MainColors.colorGrey)),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          provider.chooseEye();
                                        },
                                        icon: provider.eyeView
                                            ? SvgPicture.asset(
                                                "assets/images/closeEye.svg")
                                            : SvgPicture.asset(
                                                "assets/images/openEye.svg")),
                                    border: InputBorder.none),
                              )),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          provider.editProfil(context);
                        },
                        child: Container(
                          height: 50,
                          //width: size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: MainColors.fromHex(MainColors.colorGreen),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "SAQLASH",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
