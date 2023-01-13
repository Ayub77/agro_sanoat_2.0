// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/header_page/header_page_provider.dart';
import 'package:agro_sanoat/allpages/header_page/widget/bottomsheet.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'widget/animation_container.dart';
import 'widget/scroll_info_widget.dart';
import 'widget/scroll_new_widget.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({Key? key}) : super(key: key);

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  HeaderPageProvidr providr = HeaderPageProvidr();
  @override
  void initState() {
    super.initState();
    providr.onStart(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => providr,
      child: Consumer<HeaderPageProvidr>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorBack),
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset(
                  "assets/images/drawer.svg",
                  color: MainColors.fromHex(MainColors.colorGreen),
                )),
            title: Text(
              "Bosh sahifa",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MainColors.fromHex("#54BF14")),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    providr.nextInfo(context);

                    // bottomsheetMap(context, providr.regions,
                    //         providr.selectProvins, providr.selectRegion)
                    //     .then((value) {
                    //   if (value != null) {
                    //     providr.mapService(value);
                    //   } else {
                    //     providr.marEmpty(context);
                    //   }
                    // });
                  },
                  icon: SvgPicture.asset(
                    "assets/images/account.svg",
                    color: MainColors.fromHex(MainColors.colorGreen),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            controller: providr.controller,
            physics: providr.switchMap
                ? NeverScrollableScrollPhysics()
                : AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                    width: size.width,
                    height: 400,
                    margin: EdgeInsets.only(bottom: 10),
                    child: LineChart(
                      LineChartData(
                        backgroundColor: Colors.green,
                      ),
                      swapAnimationDuration:
                          Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    )
                    // providr.loading
                    //     ? Loading()
                    //     : Stack(
                    //         children: [
                    //           providr.cluster
                    //               ? GoogleMap(
                    //                   markers: providr.markers,
                    //                   onMapCreated:
                    //                       (GoogleMapController controller) {
                    //                     providr.manager
                    //                         ?.setMapId(controller.mapId);
                    //                   },
                    //                   onCameraMove: providr.manager?.onCameraMove,
                    //                   onCameraIdle: providr.manager?.updateMap,
                    //                   initialCameraPosition: CameraPosition(
                    //                       target: providr.sourselocation,
                    //                       zoom: providr.zoom))
                    //               : GoogleMap(
                    //                   markers: providr.markers,
                    //                   initialCameraPosition: CameraPosition(
                    //                       target: providr.sourselocation,
                    //                       zoom: providr.zoom)),
                    //           Visibility(
                    //             visible: !providr.switchMap,
                    //             child: ClipRect(
                    //               child: BackdropFilter(
                    //                 filter:
                    //                     ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    //                 child: Container(
                    //                   height: 550,
                    //                   width: double.infinity,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Positioned(
                    //               top: 0,
                    //               right: 0,
                    //               child: Switch(
                    //                   activeColor: MainColors.fromHex(
                    //                       MainColors.colorGreen),
                    //                   value: providr.switchMap,
                    //                   onChanged: (value) {
                    //                     providr.mapSwitch(value);
                    //                   })),
                    //         ],
                    //       ),
                    ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: MainColors.fromHex("#FFFFFF"),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "   Yangiliklar",
                        style: TextStyle(
                            color: MainColors.fromHex(MainColors.colorBlack),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      providr.itemNews.length < 5
                          ? Column(
                              children: [
                                Container(
                                    width: size.width,
                                    height: 380,
                                    child: PageView(
                                      controller: providr.newsController,
                                      children: [
                                        for (int i = 0;
                                            i < providr.itemNews.length;
                                            i++)
                                          ScrollNewsWidget(
                                            size: size,
                                            item: providr.itemNews[i],
                                            ontap: () {
                                              providr.ontapNews(
                                                  context, providr.itemNews[i]);
                                            },
                                          ),
                                      ],
                                      onPageChanged: (index) {
                                        providr.changeNews(index);
                                      },
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0;
                                        i < providr.itemNews.length;
                                        i++)
                                      AnimationContainerWidget(
                                          check: providr.animateindexNews == i),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                    width: size.width,
                                    height: 380,
                                    child: PageView(
                                      controller: providr.newsController,
                                      children: [
                                        ScrollNewsWidget(
                                          size: size,
                                          item: providr.itemNews[0],
                                          ontap: () {
                                            providr.ontapNews(
                                                context, providr.itemNews[0]);
                                          },
                                        ),
                                        ScrollNewsWidget(
                                          size: size,
                                          item: providr.itemNews[1],
                                          ontap: () {
                                            providr.ontapNews(
                                                context, providr.itemNews[1]);
                                          },
                                        ),
                                        ScrollNewsWidget(
                                          size: size,
                                          item: providr.itemNews[2],
                                          ontap: () {
                                            providr.ontapNews(
                                                context, providr.itemNews[2]);
                                          },
                                        ),
                                        ScrollNewsWidget(
                                          size: size,
                                          item: providr.itemNews[3],
                                          ontap: () {
                                            providr.ontapNews(
                                                context, providr.itemNews[3]);
                                          },
                                        ),
                                        ScrollNewsWidget(
                                          size: size,
                                          item: providr.itemNews[4],
                                          ontap: () {
                                            providr.ontapNews(
                                                context, providr.itemNews[4]);
                                          },
                                        ),
                                      ],
                                      onPageChanged: (index) {
                                        providr.changeNews(index);
                                      },
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimationContainerWidget(
                                        check: providr.animateindexNews == 0),
                                    AnimationContainerWidget(
                                        check: providr.animateindexNews == 1),
                                    AnimationContainerWidget(
                                        check: providr.animateindexNews == 2),
                                    AnimationContainerWidget(
                                        check: providr.animateindexNews == 3),
                                    AnimationContainerWidget(
                                        check: providr.animateindexNews == 4),
                                  ],
                                ),
                              ],
                            ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: MainColors.fromHex("#FFFFFF"),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "   Qo'llanmalar",
                        style: TextStyle(
                            color: MainColors.fromHex(MainColors.colorBlack),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      providr.itemInfo.length < 5
                          ? Column(
                              children: [
                                Container(
                                  width: size.width,
                                  height: 350,
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  child: PageView(
                                    controller: providr.infoController,
                                    children: [
                                      for (int i = 0;
                                          i < providr.itemInfo.length;
                                          i++)
                                        ScrollInfoWidget(
                                          item: providr.itemInfo[i],
                                          size: size,
                                          ontap: () {
                                            providr.ontapInfo(
                                                context, providr.itemInfo[i]);
                                          },
                                        ),
                                    ],
                                    onPageChanged: (index) {
                                      providr.changeInfo(index);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (int i = 0;
                                        i < providr.itemInfo.length;
                                        i++)
                                      AnimationContainerWidget(
                                          check: providr.animateindexInfo == i),
                                  ],
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width: size.width,
                                  height: 350,
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  child: PageView(
                                    controller: providr.infoController,
                                    children: [
                                      ScrollInfoWidget(
                                        item: providr.itemInfo[0],
                                        size: size,
                                        ontap: () {
                                          providr.ontapInfo(
                                              context, providr.itemInfo[0]);
                                        },
                                      ),
                                      ScrollInfoWidget(
                                        item: providr.itemInfo[1],
                                        size: size,
                                        ontap: () {
                                          providr.ontapInfo(
                                              context, providr.itemInfo[1]);
                                        },
                                      ),
                                      ScrollInfoWidget(
                                        item: providr.itemInfo[2],
                                        size: size,
                                        ontap: () {
                                          providr.ontapInfo(
                                              context, providr.itemInfo[2]);
                                        },
                                      ),
                                      ScrollInfoWidget(
                                        item: providr.itemInfo[3],
                                        size: size,
                                        ontap: () {
                                          providr.ontapInfo(
                                              context, providr.itemInfo[3]);
                                        },
                                      ),
                                      ScrollInfoWidget(
                                        item: providr.itemInfo[4],
                                        size: size,
                                        ontap: () {
                                          providr.ontapInfo(
                                              context, providr.itemInfo[4]);
                                        },
                                      )
                                    ],
                                    onPageChanged: (index) {
                                      providr.changeInfo(index);
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimationContainerWidget(
                                        check: providr.animateindexInfo == 0),
                                    AnimationContainerWidget(
                                        check: providr.animateindexInfo == 1),
                                    AnimationContainerWidget(
                                        check: providr.animateindexInfo == 2),
                                    AnimationContainerWidget(
                                        check: providr.animateindexInfo == 3),
                                    AnimationContainerWidget(
                                        check: providr.animateindexInfo == 4),
                                  ],
                                )
                              ],
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          //
        ),
      ),
    );
  }

  PopupMenuEntry popupMenu(name, id) {
    return PopupMenuItem(
      value: {"id": id, "name": name},
      child: Text(name),
    );
  }

  Widget shimmerEffect() {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.green,
          ),
          SizedBox(height: 30),
          Container(
            height: 20,
            width: 120,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
          ),
          SizedBox(height: 10),
          Container(
            height: 215,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                )
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 20,
            width: 120,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
          ),
          SizedBox(height: 10),
          Container(
            height: 215,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.green),
          ),
          SizedBox(height: 10),
          Container(
            height: 80,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
          ),
          SizedBox(height: 20),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
