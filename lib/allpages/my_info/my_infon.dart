// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/my_info/my_info_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MyInfo extends StatefulWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  MyInfoProvider provider = MyInfoProvider();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<MyInfoProvider>(
        builder: (context, provider, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorBack),
          appBar: AppBar(
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            elevation: 0,
            toolbarHeight: 50,
            centerTitle: true,
            title: Text(
              "Biz haqimizda",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MainColors.fromHex(MainColors.colorWhite)),
            ),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Shimmer.fromColors(
                          baseColor: MainColors.fromHex(MainColors.colorGreen),
                          period: Duration(seconds: 5),
                          highlightColor:
                              MainColors.fromHex(MainColors.colorGreen)
                                  .withOpacity(0.3),
                          child: Container(
                            height: 140,
                            width: 140,
                            child: Image.asset(
                              "assets/images/logo.png",
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "O'zbekiston",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  color: MainColors.fromHex(
                                      MainColors.colorBlack)),
                            ),
                            Text(
                              "Yosh fermerlar",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: MainColors.fromHex(
                                      MainColors.colorBlack)),
                            ),
                            Text(
                              "Kengashi",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  color: MainColors.fromHex(
                                      MainColors.colorBlack)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    provider.text,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Text(
                    provider.text1,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Text(
                    provider.text2,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Text(
                    provider.text3,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Murojaat uchun aloqalar:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Telefon:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "+998944420707",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              provider.launchURL(
                                "https://www.facebook.com/yoshfermer",
                              );
                            },
                            child:
                                SvgPicture.asset("assets/images/facebook.svg")),
                        InkWell(
                            onTap: () {
                              provider.launchURL(
                                "https://youtube.com/@Yoshfermerlar",
                              );
                            },
                            child:
                                SvgPicture.asset("assets/images/youtube.svg")),
                        InkWell(
                            onTap: () {
                              provider.launchURL(
                                "https://twitter.com/yoshfermer",
                              );
                            },
                            child:
                                SvgPicture.asset("assets/images/twitter.svg")),
                        InkWell(
                            onTap: () {
                              provider.launchURL(
                                "https://t.me/yoshfermer",
                              );
                            },
                            child:
                                SvgPicture.asset("assets/images/telegram.svg")),
                        InkWell(
                            onTap: () {
                              provider.launchURL(
                                "https://www.instagram.com/yoshfermer",
                              );
                            },
                            child: SvgPicture.asset(
                                "assets/images/instagram.svg")),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
