// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/income_page/income_page_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/funcsions/trenumber.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  IncomePageProvider provider = IncomePageProvider();
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
      child: Consumer<IncomePageProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorBack),
          appBar: AppBar(
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 50,
            title: Text(
              "Daromadlar tarixi",
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
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 180,
                          width: double.infinity,
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              color: MainColors.fromHex(MainColors.colorWhite),
                              border: Border.all(
                                  color:
                                      MainColors.fromHex(MainColors.colorGreen)
                                          .withOpacity(0.5),
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      provider.items[index]
                                              ["type_of_activites_name"]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: MainColors.fromHex(
                                              MainColors.colorBlack)),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/nomer.svg",
                                          height: 14,
                                        ),
                                        Text(
                                            provider.items[index]["id"]
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: MainColors.fromHex(
                                                    MainColors.colorBlack)))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Miqdori:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: MainColors.fromHex(
                                                  "#8896A1")),
                                        ),
                                        SizedBox(height: 1),
                                        Text(
                                          TreeNumber.toProcessCost(provider
                                                  .items[index]["amount"]
                                                  .toString()) +
                                              " kg",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: MainColors.fromHex(
                                                  MainColors.colorBlack)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Qiymati:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: MainColors.fromHex(
                                                  "#8896A1")),
                                        ),
                                        SizedBox(height: 1),
                                        Text(
                                          TreeNumber.toProcessCost((provider
                                                          .items[index]["sum"] /
                                                      1000000)
                                                  .toString()) +
                                              " mln",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: MainColors.fromHex(
                                                  MainColors.colorBlack)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              DottedLine(
                                  dashColor: Colors.grey.withOpacity(0.6)),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Kiritilgan sana:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: MainColors.fromHex(
                                                  "#8896A1")),
                                        ),
                                        SizedBox(height: 1),
                                        Text(
                                          provider.items[index]["created_date"]
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: MainColors.fromHex(
                                                  MainColors.colorBlack)),
                                        )
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/images/leftright.svg",
                                      //height: 14,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Olingan sana:",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: MainColors.fromHex(
                                                  "#8896A1")),
                                        ),
                                        SizedBox(height: 1),
                                        Text(
                                          provider.items[index]["pay_date"],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: MainColors.fromHex(
                                                  MainColors.colorBlack)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      })),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteGeneration.addIncome,
                  arguments: provider.type);
            },
            child: Icon(Icons.add),
            backgroundColor: MainColors.fromHex(MainColors.colorGreen),
          ),
        ),
      ),
    );
  }
}
