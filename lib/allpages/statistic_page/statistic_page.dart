// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  bool visible = false;
  getInfo() async {
    Box box = await Hive.openBox("db");
    var person = await box.get("person");
    if (person == null) {
      visible = false;
    } else {
      visible = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.fromHex(MainColors.colorBack),
      appBar: AppBar(
        backgroundColor: MainColors.fromHex(MainColors.colorGreen),
        elevation: 0,
        toolbarHeight: 50,
        centerTitle: true,
        title: Text(
          "Statistika",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: MainColors.fromHex(MainColors.colorWhite)),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteGeneration.store, arguments: 1);
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: MainColors.fromHex(MainColors.colorWhite),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                        color: MainColors.fromHex(MainColors.colorGreen),
                        width: 1.5)),
                child: Row(
                  children: [
                    Container(
                      height: 69,
                      width: 85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MainColors.fromHex(MainColors.colorGreen)
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: SvgPicture.asset(
                        "assets/images/circle1.svg",
                        height: 30,
                        color: MainColors.fromHex(MainColors.colorWhite),
                      ),
                    ),
                    Container(
                      color: MainColors.fromHex(MainColors.colorGreen),
                      height: 69,
                      width: 1.5,
                    ),
                    Expanded(
                        child: Text(
                      "      Fermerlar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: MainColors.fromHex(MainColors.colorBlack)),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(RouteGeneration.store, arguments: 0);
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: MainColors.fromHex(MainColors.colorWhite),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                        color: MainColors.fromHex(MainColors.colorGreen),
                        width: 1.5)),
                child: Row(
                  children: [
                    Container(
                      height: 69,
                      width: 85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MainColors.fromHex(MainColors.colorGreen)
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: SvgPicture.asset(
                        "assets/images/circle3.svg",
                        height: 30,
                        color: MainColors.fromHex(MainColors.colorWhite),
                      ),
                    ),
                    Container(
                      color: MainColors.fromHex(MainColors.colorGreen),
                      height: 69,
                      width: 1.5,
                    ),
                    Expanded(
                        child: Text(
                      "      Dehqonlar",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: MainColors.fromHex(MainColors.colorBlack)),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGeneration.jobType);
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: MainColors.fromHex(MainColors.colorWhite),
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                        color: MainColors.fromHex(MainColors.colorGreen),
                        width: 1.5)),
                child: Row(
                  children: [
                    Container(
                      height: 69,
                      width: 85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: MainColors.fromHex(MainColors.colorGreen)
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: SvgPicture.asset(
                        "assets/images/statistic.svg",
                        height: 20,
                        color: MainColors.fromHex(MainColors.colorWhite),
                      ),
                    ),
                    Container(
                      color: MainColors.fromHex(MainColors.colorGreen),
                      height: 69,
                      width: 1.5,
                    ),
                    Expanded(
                        child: Text(
                      "      Faoliyat turi",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: MainColors.fromHex(MainColors.colorBlack)),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Visibility(
              visible: visible,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteGeneration.benefit);
                },
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: MainColors.fromHex(MainColors.colorWhite),
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                          color: MainColors.fromHex(MainColors.colorGreen),
                          width: 1.5)),
                  child: Row(
                    children: [
                      Container(
                        height: 69,
                        width: 85,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MainColors.fromHex(MainColors.colorGreen)
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                        child: SvgPicture.asset(
                          "assets/images/money.svg",
                          height: 30,
                          color: MainColors.fromHex(MainColors.colorWhite),
                        ),
                      ),
                      Container(
                        color: MainColors.fromHex(MainColors.colorGreen),
                        height: 69,
                        width: 1.5,
                      ),
                      Expanded(
                          child: Text(
                        "      Daromadlar tarixi",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: MainColors.fromHex(MainColors.colorBlack)),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
