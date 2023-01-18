// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/benefit_page/benefit_provider.dart';
import 'package:agro_sanoat/allpages/statistic_page/widgets/info_widget.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class BenifitPage extends StatefulWidget {
  const BenifitPage({Key? key}) : super(key: key);

  @override
  State<BenifitPage> createState() => _BenifitPageState();
}

class _BenifitPageState extends State<BenifitPage> {
  BenifitPageProvider provider = BenifitPageProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => provider,
        child: Consumer<BenifitPageProvider>(
            builder: (context, value, child) => Scaffold(
                  backgroundColor: MainColors.fromHex(MainColors.colorBack),
                  appBar: AppBar(
                    backgroundColor: MainColors.fromHex(MainColors.colorGreen),
                    elevation: 0,
                    centerTitle: true,
                    toolbarHeight: 50,
                    title: Text(
                      "Daromadlar",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MainColors.fromHex(MainColors.colorWhite)),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            provider.selectDate(context);
                          },
                          icon: SvgPicture.asset("assets/images/filter.svg"))
                    ],
                  ),
                  body: provider.loading
                      ? Loading()
                      : provider.dataMap.isEmpty
                          ? Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "ma'lumot mavjud emas",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            )
                          : Column(
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
                                          color: MainColors.fromHex(
                                              MainColors.colorBlack)),
                                    ),
                                    PopupMenuButton(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: MainColors.fromHex(
                                              MainColors.colorBlack),
                                        ),
                                        onSelected: (value) {
                                          provider.changeType(value);
                                        },
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry>[
                                              const PopupMenuItem(
                                                value: 0,
                                                child: Text("Summasi"),
                                              ),
                                              PopupMenuItem(
                                                value: 1,
                                                child: Text("Miqdori"),
                                              ),
                                            ]),
                                  ],
                                ),
                                SizedBox(height: 30),
                                PieChart(
                                  dataMap: provider.dataMap,
                                  colorList: provider.colors,
                                  animationDuration:
                                      Duration(milliseconds: 800),
                                  chartLegendSpacing: 20,
                                  chartRadius: 150,
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
                                        itemCount: provider.items.length,
                                        itemBuilder: (context, index) {
                                          return InfoWidget(
                                            text: provider.index == 0
                                                ? "so'm"
                                                : "kg",
                                            color: provider.colors[index],
                                            name: provider.items[index]["name"],
                                            number: provider.index == 0
                                                ? provider.items[index]["sum"]
                                                    .toString()
                                                : provider.items[index]
                                                        ["amount"]
                                                    .toString(),
                                          );
                                        }))
                              ],
                            ),
                )));
  }
}
