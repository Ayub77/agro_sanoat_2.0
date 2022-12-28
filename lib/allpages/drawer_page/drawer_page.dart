// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/drawer_page/drawer_page_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  DrawerPageProvider provider = DrawerPageProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<DrawerPageProvider>(
        builder: (context, value, child) => Scaffold(
          body: Container(
            color: MainColors.fromHex(MainColors.colorWhite),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                          width: 1.5,
                          color: MainColors.fromHex(MainColors.colorGreen))),
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: MainColors.fromHex(MainColors.colorGreen),
                    height: 75,
                    width: 75,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "O'zbekiston qishloq xo'jaligi yorqin kelajagini birgalikda yaratamiz!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MainColors.fromHex(MainColors.colorBlack),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/info.svg",
                    color: MainColors.fromHex(MainColors.colorGreen),
                  ),
                  title: Text(
                    "Qo'llanmalar",
                    style: TextStyle(
                        fontSize: 18,
                        color: MainColors.fromHex(MainColors.colorGreen)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(RouteGeneration.info);
                  },
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/statistic.svg",
                    color: MainColors.fromHex(MainColors.colorGreen),
                  ),
                  title: Text(
                    "Statistika",
                    style: TextStyle(
                        fontSize: 18,
                        color: MainColors.fromHex(MainColors.colorGreen)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(RouteGeneration.statistic);
                  },
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/myinfo.svg",
                    color: MainColors.fromHex(MainColors.colorGreen),
                  ),
                  title: Text(
                    "Biz haqimizda",
                    style: TextStyle(
                        fontSize: 18,
                        color: MainColors.fromHex(MainColors.colorGreen)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(RouteGeneration.myInfo);
                  },
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
