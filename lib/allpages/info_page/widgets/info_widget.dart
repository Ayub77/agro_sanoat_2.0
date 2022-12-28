// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/info_page/widgets/list_widget.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';

class InfoWidgetStock extends StatelessWidget {
  const InfoWidgetStock({Key? key, required this.ontab, this.items})
      : super(key: key);
  final Function ontab;
  final dynamic items;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: MainColors.fromHex(MainColors.colorBack),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListWidgetInfo(
                item: items[index],
                size: size,
                ontap: (item) {
                  ontab(item);
                },
              );
            }));
  }
}
