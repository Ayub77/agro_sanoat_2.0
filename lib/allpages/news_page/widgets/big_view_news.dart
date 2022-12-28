// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BigViewNews extends StatelessWidget {
  const BigViewNews({Key? key, this.item}) : super(key: key);
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: MainColors.fromHex(MainColors.colorGreen),
            )),
        title: Text(
          "To'liq ma'lumot",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteGeneration.bigImageNews,
                    arguments: item["image_url"]);
              },
              child: Container(
                height: 220,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl: item["image_url"],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: MainColors.fromHex(MainColors.colorGreen),
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  Text(
                    item["short_context"],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    item["short_text"],
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chiqarilgan sanasi:",
                        style: TextStyle(
                            fontSize: 14,
                            color: MainColors.fromHex(MainColors.colorBlack)),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/calendar.svg",
                            height: 20,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            item["created_date"].toString().startsWith("-")
                                ? item["created_date"].toString().substring(1)
                                : item["created_date"],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    MainColors.fromHex(MainColors.colorBlack)),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
