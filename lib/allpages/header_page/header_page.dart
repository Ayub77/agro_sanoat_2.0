// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/header_page/header_page_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'widget/animation_container.dart';
import 'widget/scrol_service_vidget.dart';
import 'widget/scroll_info_widget.dart';
import 'widget/scroll_new_widget.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({Key? key}) : super(key: key);

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  HeaderPageProvider provider = HeaderPageProvider();
  @override
  void initState() {
    super.initState();
    provider.onStart(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<HeaderPageProvider>(
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
                    provider.nextInfo(context);
                  },
                  icon: SvgPicture.asset(
                    "assets/images/account.svg",
                    color: MainColors.fromHex(MainColors.colorGreen),
                  ))
            ],
          ),
          body: provider.allItemsEmpty
              ? Center(
                  child: Text(
                    "Ma'lumotlar mavjud emas!",
                    style: TextStyle(
                        color: MainColors.fromHex(MainColors.colorBlack),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //     width: size.width,
                      //     height: 400,
                      //     margin: EdgeInsets.only(bottom: 10),
                      //     //color: Colors.yellow,
                      //     child: LineChart(
                      //       LineChartData(
                      //         backgroundColor: Colors.green,
                      //       ),
                      //       swapAnimationDuration:
                      //           Duration(milliseconds: 150), // Optional
                      //       swapAnimationCurve: Curves.linear, // Optional
                      //     )),
                      provider.itemNews.isEmpty
                          ? SizedBox()
                          : Container(
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
                                        color: MainColors.fromHex(
                                            MainColors.colorBlack),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 10),
                                  provider.loading1
                                      ? Container(
                                          height: 200,
                                          width: size.width,
                                          color: Colors.white,
                                          child: Loading(),
                                        )
                                      : provider.itemNews.length < 5
                                          ? Column(
                                              children: [
                                                Container(
                                                    width: size.width,
                                                    height: 380,
                                                    child: PageView(
                                                      controller: provider
                                                          .newsController,
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                provider
                                                                    .itemNews
                                                                    .length;
                                                            i++)
                                                          ScrollNewsWidget(
                                                            size: size,
                                                            item: provider
                                                                .itemNews[i],
                                                            ontap: () {
                                                              provider.ontapNews(
                                                                  context,
                                                                  provider
                                                                      .itemNews[i]);
                                                            },
                                                          ),
                                                      ],
                                                      onPageChanged: (index) {
                                                        provider
                                                            .changeNews(index);
                                                      },
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            provider.itemNews
                                                                .length;
                                                        i++)
                                                      AnimationContainerWidget(
                                                          check: provider
                                                                  .animateindexNews ==
                                                              i),
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
                                                      controller: provider
                                                          .newsController,
                                                      children: [
                                                        ScrollNewsWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemNews[0],
                                                          ontap: () {
                                                            provider.ontapNews(
                                                                context,
                                                                provider
                                                                    .itemNews[0]);
                                                          },
                                                        ),
                                                        ScrollNewsWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemNews[1],
                                                          ontap: () {
                                                            provider.ontapNews(
                                                                context,
                                                                provider
                                                                    .itemNews[1]);
                                                          },
                                                        ),
                                                        ScrollNewsWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemNews[2],
                                                          ontap: () {
                                                            provider.ontapNews(
                                                                context,
                                                                provider
                                                                    .itemNews[2]);
                                                          },
                                                        ),
                                                        ScrollNewsWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemNews[3],
                                                          ontap: () {
                                                            provider.ontapNews(
                                                                context,
                                                                provider
                                                                    .itemNews[3]);
                                                          },
                                                        ),
                                                        ScrollNewsWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemNews[4],
                                                          ontap: () {
                                                            provider.ontapNews(
                                                                context,
                                                                provider
                                                                    .itemNews[4]);
                                                          },
                                                        ),
                                                      ],
                                                      onPageChanged: (index) {
                                                        provider
                                                            .changeNews(index);
                                                      },
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexNews ==
                                                            0),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexNews ==
                                                            1),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexNews ==
                                                            2),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexNews ==
                                                            3),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexNews ==
                                                            4),
                                                  ],
                                                ),
                                              ],
                                            ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                      provider.itemInfo.isEmpty
                          ? SizedBox(height: 0)
                          : SizedBox(height: 40),
                      provider.itemInfo.isEmpty
                          ? SizedBox()
                          : Container(
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
                                        color: MainColors.fromHex(
                                            MainColors.colorBlack),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  provider.loading2
                                      ? Container(
                                          height: 200,
                                          width: size.width,
                                          color: Colors.white,
                                          child: Loading(),
                                        )
                                      : provider.itemInfo.length < 5
                                          ? Column(
                                              children: [
                                                Container(
                                                  width: size.width,
                                                  height: 350,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1),
                                                  child: PageView(
                                                    controller:
                                                        provider.infoController,
                                                    children: [
                                                      for (int i = 0;
                                                          i <
                                                              provider.itemInfo
                                                                  .length;
                                                          i++)
                                                        ScrollInfoWidget(
                                                          item: provider
                                                              .itemInfo[i],
                                                          size: size,
                                                          ontap: () {
                                                            provider.ontapInfo(
                                                                context,
                                                                provider
                                                                    .itemInfo[i]);
                                                          },
                                                        ),
                                                    ],
                                                    onPageChanged: (index) {
                                                      provider
                                                          .changeInfo(index);
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            provider.itemInfo
                                                                .length;
                                                        i++)
                                                      AnimationContainerWidget(
                                                          check: provider
                                                                  .animateindexInfo ==
                                                              i),
                                                  ],
                                                )
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Container(
                                                  width: size.width,
                                                  height: 350,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1),
                                                  child: PageView(
                                                    controller:
                                                        provider.infoController,
                                                    children: [
                                                      ScrollInfoWidget(
                                                        item: provider
                                                            .itemInfo[0],
                                                        size: size,
                                                        ontap: () {
                                                          provider.ontapInfo(
                                                              context,
                                                              provider
                                                                  .itemInfo[0]);
                                                        },
                                                      ),
                                                      ScrollInfoWidget(
                                                        item: provider
                                                            .itemInfo[1],
                                                        size: size,
                                                        ontap: () {
                                                          provider.ontapInfo(
                                                              context,
                                                              provider
                                                                  .itemInfo[1]);
                                                        },
                                                      ),
                                                      ScrollInfoWidget(
                                                        item: provider
                                                            .itemInfo[2],
                                                        size: size,
                                                        ontap: () {
                                                          provider.ontapInfo(
                                                              context,
                                                              provider
                                                                  .itemInfo[2]);
                                                        },
                                                      ),
                                                      ScrollInfoWidget(
                                                        item: provider
                                                            .itemInfo[3],
                                                        size: size,
                                                        ontap: () {
                                                          provider.ontapInfo(
                                                              context,
                                                              provider
                                                                  .itemInfo[3]);
                                                        },
                                                      ),
                                                      ScrollInfoWidget(
                                                        item: provider
                                                            .itemInfo[4],
                                                        size: size,
                                                        ontap: () {
                                                          provider.ontapInfo(
                                                              context,
                                                              provider
                                                                  .itemInfo[4]);
                                                        },
                                                      )
                                                    ],
                                                    onPageChanged: (index) {
                                                      provider
                                                          .changeInfo(index);
                                                    },
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexInfo ==
                                                            0),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexInfo ==
                                                            1),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexInfo ==
                                                            2),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexInfo ==
                                                            3),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexInfo ==
                                                            4),
                                                  ],
                                                )
                                              ],
                                            )
                                ],
                              ),
                            ),
                      provider.itemService.isEmpty
                          ? SizedBox(height: 0)
                          : SizedBox(height: 40),
                      provider.itemService.isEmpty
                          ? SizedBox(height: 0)
                          : Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  color: MainColors.fromHex("#FFFFFF"),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "   Xizmatlar",
                                    style: TextStyle(
                                        color: MainColors.fromHex(
                                            MainColors.colorBlack),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 10),
                                  provider.loading3
                                      ? Container(
                                          height: 200,
                                          width: size.width,
                                          color: Colors.white,
                                          child: Loading(),
                                        )
                                      : provider.itemService.length < 5
                                          ? Column(
                                              children: [
                                                Container(
                                                    width: size.width,
                                                    height: 380,
                                                    child: PageView(
                                                      controller: provider
                                                          .serviceController,
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                provider
                                                                    .itemService
                                                                    .length;
                                                            i++)
                                                          ScrollNewsWidget(
                                                            size: size,
                                                            item: provider
                                                                .itemService[i],
                                                            ontap: () {
                                                              provider.ontapService(
                                                                  context,
                                                                  provider
                                                                      .itemService[i]);
                                                            },
                                                          ),
                                                      ],
                                                      onPageChanged: (index) {
                                                        provider.changeService(
                                                            index);
                                                      },
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            provider.itemService
                                                                .length;
                                                        i++)
                                                      AnimationContainerWidget(
                                                          check: provider
                                                                  .animateindexService ==
                                                              i),
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
                                                      controller: provider
                                                          .serviceController,
                                                      children: [
                                                        ScrollServiceWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemService[0],
                                                          ontap: () {
                                                            provider.ontapService(
                                                                context,
                                                                provider
                                                                    .itemService[0]);
                                                          },
                                                        ),
                                                        ScrollServiceWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemService[1],
                                                          ontap: () {
                                                            provider.ontapService(
                                                                context,
                                                                provider
                                                                    .itemService[1]);
                                                          },
                                                        ),
                                                        ScrollServiceWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemService[2],
                                                          ontap: () {
                                                            provider.ontapService(
                                                                context,
                                                                provider
                                                                    .itemService[2]);
                                                          },
                                                        ),
                                                        ScrollServiceWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemService[3],
                                                          ontap: () {
                                                            provider.ontapService(
                                                                context,
                                                                provider
                                                                    .itemService[3]);
                                                          },
                                                        ),
                                                        ScrollServiceWidget(
                                                          size: size,
                                                          item: provider
                                                              .itemService[4],
                                                          ontap: () {
                                                            provider.ontapService(
                                                                context,
                                                                provider
                                                                    .itemService[4]);
                                                          },
                                                        ),
                                                      ],
                                                      onPageChanged: (index) {
                                                        provider.changeService(
                                                            index);
                                                      },
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexService ==
                                                            0),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexService ==
                                                            1),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexService ==
                                                            2),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexService ==
                                                            3),
                                                    AnimationContainerWidget(
                                                        check: provider
                                                                .animateindexService ==
                                                            4),
                                                  ],
                                                ),
                                              ],
                                            ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                      SizedBox(height: 30),
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
}
