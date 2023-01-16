// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/job_type/job_type_provider.dart';
import 'package:agro_sanoat/allpages/statistic_page/widgets/info_widget.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class JobType extends StatefulWidget {
  const JobType({Key? key}) : super(key: key);

  @override
  State<JobType> createState() => _JobTypeState();
}

class _JobTypeState extends State<JobType> {
  JobTypeProvider provider = JobTypeProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.onStart();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<JobTypeProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorWhite),
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Faoliyat turi",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MainColors.fromHex(MainColors.colorWhite)),
            ),
          ),
          body: provider.loading
              ? Loading()
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: pieChart(),
                ),
        ),
      ),
    );
  }

  Widget pieChart() {
    return Column(
      children: [
        PieChart(
          dataMap: provider.dataMap,
          colorList: provider.colors,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 30,
          chartRadius: 200,
          chartType: ChartType.ring,
          centerText: provider.allperson.toString() + " ta",
          ringStrokeWidth: 35,
          centerTextStyle: TextStyle(
              color: MainColors.fromHex("#003171"),
              fontWeight: FontWeight.bold,
              fontSize: 15),
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: false,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              color: MainColors.fromHex("#003171"),
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              decimalPlaces: 20,
              showChartValues: false,
              showChartValuesInPercentage: true,
              showChartValuesOutside: true,
              chartValueBackgroundColor: Colors.white),
        ),
        SizedBox(height: 20),
        Expanded(
            child: ListView.builder(
                itemCount: provider.itemStat.length,
                itemBuilder: (context, index) {
                  return InfoWidget(
                    text: "",
                    color: provider.colors[index],
                    name: provider.itemStat[index]["name"],
                    number:
                        provider.itemStat[index]["count"].toString() + " ta",
                  );
                })),
      ],
    );
  }
}
