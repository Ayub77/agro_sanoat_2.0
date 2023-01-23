// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'bottomsheet_provider.dart';

class BottomSheetWidget {
  static modalBottomSheetMenu(context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return ChangeNotifierProvider<BottomSheetProvider>(
            create: (context) => BottomSheetProvider(),
            child: Consumer<BottomSheetProvider>(
                builder: (context, provider, child) => Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    decoration: BoxDecoration(
                        color: MainColors.fromHex(MainColors.colorWhite),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: provider.loading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 7),
                                    height: 5,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: MainColors.fromHex(
                                            MainColors.colorBlack)),
                                  ),
                                  Text("Saralash",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: MainColors.fromHex(
                                              MainColors.colorBlack),
                                          fontSize: 22)),
                                  SizedBox(height: 20),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "  ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 3),
                                  Container(
                                      height: 45,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 15),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: MainColors.fromHex(
                                                  MainColors.colorGreen),
                                              width: 1.5),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(provider.birthDay,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black)),
                                          IconButton(
                                              onPressed: () {
                                                provider.selectDate(context);
                                              },
                                              padding: EdgeInsets.all(0),
                                              icon: SvgPicture.asset(
                                                "assets/images/calendar.svg",
                                                height: 23,
                                                color: Colors.black,
                                              )),
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(),
                              Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      //provider.close(context);
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MainColors.fromHex(
                                                  MainColors.colorRed),
                                              width: 1.5)),
                                      child: Text(
                                        "Bekor qilish",
                                        style: TextStyle(
                                            color: MainColors.fromHex(
                                                MainColors.colorRed),
                                            fontSize: 18),
                                      ),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      //provider.closePage(context);
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    splashColor: Colors.grey,
                                    child: Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: MainColors.fromHex(
                                                  MainColors.colorGreen),
                                              width: 1.5)),
                                      child: InkWell(
                                        child: Text(
                                          "Qidirish",
                                          style: TextStyle(
                                              color: MainColors.fromHex(
                                                  MainColors.colorGreen),
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              )
                            ],
                          ))),
          );
        });
  }
}
