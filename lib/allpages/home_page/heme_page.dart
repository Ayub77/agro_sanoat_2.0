// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/drawer_page/drawer_page.dart';
import 'package:agro_sanoat/allpages/home_page/home_page_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rect_getter/rect_getter.dart';

import 'widgets/bottom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageProvider provider = HomePageProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onstart(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<HomePageProvider>(
        builder: (context, value, child) => WillPopScope(
          onWillPop: () => provider.onWillPop(),
          child: Stack(
            children: [
              Scaffold(
                body: provider.allWindows[provider.currenttab],
                drawer: Drawer(
                  child: DrawerPage(),
                ),
                floatingActionButton: RectGetter(
                  key: provider.rectGetterKey,
                  child: FloatingActionButton(
                    onPressed: () {
                      provider.nextAddPage(context);
                    },
                    backgroundColor: MainColors.fromHex(MainColors.colorGreen),
                    child: Icon(Icons.add),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.miniCenterDocked,
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  child: Container(
                    height: 60,
                    width: size.width,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BottomButton(
                            name: "Bosh sahifa",
                            index: 0,
                            currnttab: provider.currenttab,
                            icon: "assets/images/dashboard.svg",
                            provider: provider),
                        BottomButton(
                            name: "Yangiliklar",
                            index: 1,
                            currnttab: provider.currenttab,
                            icon: "assets/images/news.svg",
                            provider: provider),
                        SizedBox(
                          width: 30,
                        ),
                        BottomButton(
                            name: "Loyihalar",
                            index: 2,
                            currnttab: provider.currenttab,
                            icon: "assets/images/project.svg",
                            provider: provider),
                        BottomButton(
                            name: "Xizmatlar",
                            index: 3,
                            currnttab: provider.currenttab,
                            icon: "assets/images/servis.svg",
                            provider: provider),
                      ],
                    ),
                  ),
                ),
              ),
              ripple()
            ],
          ),
        ),
      ),
    );
  }

  Widget ripple() {
    if (provider.rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      //<--replace Positioned with AnimatedPositioned
      duration: provider.animationDuration, //<--specify the animation duration
      left: provider.rect!.left,
      right: MediaQuery.of(context).size.width - provider.rect!.right,
      top: provider.rect!.top,
      bottom: MediaQuery.of(context).size.height - provider.rect!.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MainColors.fromHex(MainColors.colorGreen),
        ),
      ),
    );
  }
}
