// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/info_page/info_page_provider.dart';
import 'package:agro_sanoat/allpages/info_page/widgets/info_widget.dart';
import 'package:agro_sanoat/allpages/info_page/widgets/video_info.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  InfoPageProvider provider = InfoPageProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart1();
    provider.onStart2();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<InfoPageProvider>(
          builder: (context, value, child) => Scaffold(
                appBar: AppBar(
                  backgroundColor: MainColors.fromHex(MainColors.colorGreen),
                  elevation: 0,
                  toolbarHeight: 40,
                  centerTitle: true,
                  title: Text(
                    "Qo'llanmalar",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: MainColors.fromHex(MainColors.colorWhite)),
                  ),
                ),
                body: ContainedTabBarView(
                  tabBarProperties: TabBarProperties(
                      indicatorWeight: 3,
                      height: 50,
                      background: Container(
                        color: MainColors.fromHex(MainColors.colorWhite),
                      ),
                      indicatorColor:
                          MainColors.fromHex(MainColors.colorGreen)),
                  tabs: [
                    Text(
                      "Qo'llanma",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: provider.index == 0
                              ? MainColors.fromHex(MainColors.colorGreen)
                              : MainColors.fromHex(MainColors.colorGrey)),
                    ),
                    Text(
                      "Video qo'llanma",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: provider.index == 1
                              ? MainColors.fromHex(MainColors.colorGreen)
                              : MainColors.fromHex(MainColors.colorGrey)),
                    ),
                  ],
                  views: [
                    provider.items.isEmpty && !provider.loading1
                        ? Center(
                            child: Text(
                              "Ma'lumotlar mavjud emas!",
                              style: TextStyle(
                                  color:
                                      MainColors.fromHex(MainColors.colorBlack),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : Stack(
                            children: [
                              InfoWidgetStock(
                                  items: provider.items,
                                  ontab: (item) {
                                    provider.bigView(context, item);
                                  }),
                              Visibility(
                                  visible: provider.loading1, child: Loading())
                            ],
                          ),
                    provider.itemsVideo.isEmpty && !provider.loading2
                        ? Center(
                            child: Text(
                              "Ma'lumotlar mavjud emas!",
                              style: TextStyle(
                                  color:
                                      MainColors.fromHex(MainColors.colorBlack),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : Stack(
                            children: [
                              VideoInfo(
                                items: provider.itemsVideo,
                                ontap: (videoUrl) {
                                  provider.openVideo(videoUrl, context);
                                },
                              ),
                              Visibility(
                                  visible: provider.loading2, child: Loading())
                            ],
                          ),
                  ],
                  onChange: (index) {
                    provider.chooseChange(index);
                  },
                ),
              )),
    );
  }
}
