// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/person_info/person_info_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonInfo extends StatefulWidget {
  const PersonInfo({Key? key}) : super(key: key);

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  PersonInfoProvider provider = PersonInfoProvider();

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
              "O'zim haqimda",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            toolbarHeight: 50,
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MainColors.fromHex(MainColors.colorGreen),
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                          color: MainColors.fromHex(MainColors.colorGreySoft)),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Text(
                        "Nomonov Muhammdayubxon Adxamjon o'g'li",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Text(
                  "  Tug'ilgan sana",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(height: 5),
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
                  child: Text(
                    "11.06.1998",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "  Faoliyat turi",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(height: 5),
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
                  child: Text(
                    "Dexqonchilik",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "  Telefon raqam",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(height: 5),
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
                  child: Text(
                    "+998 90-586-79-91",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "  Kamchiliklar",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(height: 5),
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
                  child: Text(
                    "-",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
