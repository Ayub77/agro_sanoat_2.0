// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/statistic_page/statistic_page_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'widgets/info_widget.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key, this.id}) : super(key: key);
  final dynamic id;
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  StatisticPageProvider provider = StatisticPageProvider();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.chooseChange(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<StatisticPageProvider>(
        builder: (context, value, child) => Scaffold(
            backgroundColor: MainColors.fromHex(MainColors.colorBack),
            appBar: AppBar(
              backgroundColor: MainColors.fromHex(MainColors.colorGreen),
              elevation: 0,
              toolbarHeight: 50,
              centerTitle: true,
              // actions: [
              //   IconButton(
              //       onPressed: () {
              //         Navigator.of(context).pushNamed(RouteGeneration.jobType);
              //       },
              //       icon: SvgPicture.asset(
              //         "assets/images/statistic.svg",
              //         height: 16,
              //         color: MainColors.fromHex(MainColors.colorWhite),
              //       ))
              // ],
              title: Text(
                provider.index == 0 ? "Dehqon" : "Fermer",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MainColors.fromHex(MainColors.colorWhite)),
              ),
            ),
            body: provider.index == 0
                ? provider.isloading
                    ? Loading()
                    : pieChart(size)
                : provider.isloading1
                    ? Loading()
                    : pieChart(size)),
      ),
    );
  }

  Widget pieChart(size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          provider.dataMap.isEmpty
              ? Container(
                  height: size.height,
                  alignment: Alignment.center,
                  child: Text(
                    "ma'lumot mavjud emas",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
              : Container(
                  height: size.height,
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.change,
                            style: GoogleFonts.poppins(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color:
                                    MainColors.fromHex(MainColors.colorBlack)),
                          ),
                          PopupMenuButton(
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    MainColors.fromHex(MainColors.colorBlack),
                              ),
                              onSelected: (value) {
                                provider.selectItem(value);
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Text("Maydon hajmi"),
                                    ),
                                    PopupMenuItem(
                                      value: 2,
                                      child: Text(provider.farmar + ' soni'),
                                    ),
                                  ]),
                        ],
                      ),
                      SizedBox(height: 30),
                      PieChart(
                        dataMap: provider.dataMap,
                        colorList: provider.colors,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 20,
                        chartRadius: size.width * 0.45,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 30,
                        centerTextStyle: TextStyle(
                            color: MainColors.fromHex("#003171"),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        legendOptions: LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.bottom,
                          showLegends: false,
                          legendShape: BoxShape.circle,
                          legendTextStyle: TextStyle(
                            color: MainColors.fromHex("#003171"),
                          ),
                        ),
                        chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: false,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: true,
                            decimalPlaces: 1,
                            chartValueBackgroundColor: Colors.white),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                          child: ListView.builder(
                              itemCount: provider.itemName.length,
                              itemBuilder: (context, index) {
                                return InfoWidget(
                                  text: provider.change ==
                                          (provider.farmar + " soni")
                                      ? "ta"
                                      : "sotix",
                                  color: provider.colors[index],
                                  name: provider.itemName[index],
                                  number: provider.itemNumber[index].toString(),
                                );
                              }))
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
