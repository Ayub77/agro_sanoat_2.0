// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/person_info/person_info_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PersonInfo extends StatefulWidget {
  const PersonInfo({Key? key}) : super(key: key);

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> with TickerProviderStateMixin {
  PersonInfoProvider provider = PersonInfoProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<PersonInfoProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              provider.textEnebled
                  ? "Ma'lumotlarni tahrirlash"
                  : "O'zim haqimda",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            toolbarHeight: 50,
            actions: [
              Visibility(
                visible: !provider.textEnebled,
                child: IconButton(
                    onPressed: () {
                      provider.textvisible();
                    },
                    icon: SvgPicture.asset(
                      "assets/images/edit.svg",
                      color: MainColors.fromHex(MainColors.colorWhite),
                    )),
              ),
            ],
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 185,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    MainColors.fromHex(MainColors.colorGreen),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(20),
                            color:
                                MainColors.fromHex(MainColors.colorGreySoft)),
                      ),
                      Visibility(
                        visible: provider.textEnebled,
                        child: Positioned(
                            bottom: 0,
                            width: size.width - 16.5,
                            child: InkWell(
                              onTap: () {
                                showPicker();
                              },
                              child: Container(
                                height: provider.size,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    bottom: 1.5, left: 1.5, right: 15),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(19),
                                        bottomRight: Radius.circular(19))),
                                child: SvgPicture.asset(
                                  "assets/images/camera.svg",
                                  color: Colors.white,
                                  height: 20,
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    "  F.I.O",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(height: 3),
                  Container(
                      //height: 45,
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MainColors.fromHex(MainColors.colorGreen),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: provider.nameController,
                        enabled: provider.textEnebled,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none),
                      )),
                  SizedBox(height: 15),
                  Text(
                    "  Tug'ilgan sana",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(height: 3),
                  Container(
                      height: 45,
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MainColors.fromHex(MainColors.colorGreen),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: provider.birthController,
                        keyboardType: TextInputType.number,
                        enabled: provider.textEnebled,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none),
                      )),
                  SizedBox(height: 15),
                  Text(
                    "  Faoliyat turi",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(height: 3),
                  Container(
                      height: 45,
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MainColors.fromHex(MainColors.colorGreen),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: provider.jobController,
                        enabled: provider.textEnebled,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none),
                      )),
                  SizedBox(height: 15),
                  Text(
                    "  Telefon raqam",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(height: 3),
                  Container(
                      height: 45,
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MainColors.fromHex(MainColors.colorGreen),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: provider.phoneController,
                        enabled: provider.textEnebled,
                        keyboardType: TextInputType.phone,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none),
                      )),
                  SizedBox(height: 15),
                  Text(
                    "  Kamchiliklar",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  SizedBox(height: 3),
                  Container(
                      height: 45,
                      width: size.width,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MainColors.fromHex(MainColors.colorGreen),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        controller: provider.needController,
                        enabled: provider.textEnebled,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none),
                      )),
                  SizedBox(height: 25),
                  provider.textEnebled
                      ? Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  provider.textvisible();
                                },
                                child: Container(
                                  height: 50,
                                  //width: size.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: MainColors.fromHex(
                                          MainColors.colorRed),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "BEKOK QILISH",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 50,
                                //width: size.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: MainColors.fromHex(
                                        MainColors.colorGreen),
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
                        )
                      : Container(
                          // height: 50,
                          // width: size.width,
                          // alignment: Alignment.center,
                          // decoration: BoxDecoration(
                          //     color: MainColors.fromHex(MainColors.colorRed),
                          //     borderRadius: BorderRadius.circular(10)),
                          // child: Text(
                          //   "CHIQISH",
                          //   style: TextStyle(
                          //       fontSize: 18,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.white),
                          // ),
                          ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  onTap: () {
                    provider.setImage(true, context);
                  },
                  title: Text("Galareya"),
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  onTap: () {
                    provider.setImage(false, context);
                  },
                  title: Text("Camera"),
                )
              ],
            ),
          ));
        });
  }
}
