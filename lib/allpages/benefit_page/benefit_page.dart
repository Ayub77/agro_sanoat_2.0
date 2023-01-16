// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/benefit_page/benefit_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BenifitPage extends StatefulWidget {
  const BenifitPage({Key? key}) : super(key: key);

  @override
  State<BenifitPage> createState() => _BenifitPageState();
}

class _BenifitPageState extends State<BenifitPage> {
  BenifitPageProvider provider = BenifitPageProvider();

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
                    toolbarHeight: 40,
                    title: Text(
                      "Daromadlar tarixi",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MainColors.fromHex(MainColors.colorWhite)),
                    ),
                  ),
                )));
  }
}
