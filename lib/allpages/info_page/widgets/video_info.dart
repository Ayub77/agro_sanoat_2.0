// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({Key? key, this.items, required this.ontap})
      : super(key: key);
  final dynamic items;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColors.fromHex(MainColors.colorBack),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                    color: MainColors.fromHex("#FFFFFF"),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 3,
                          color: Colors.grey.withOpacity(0.5))
                    ]),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 220,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: items[index]["image_url"],
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
                            child: InkWell(
                              onTap: () {
                                ontap(items[index]["videos_url"]);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 220,
                                child: SvgPicture.asset(
                                  "assets/images/play.svg",
                                  color:
                                      MainColors.fromHex(MainColors.colorGreen),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      items[index]["short_context"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
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
                              items[index]["created_date"]
                                      .toString()
                                      .startsWith("-")
                                  ? items[index]["created_date"]
                                      .toString()
                                      .substring(1)
                                  : items[index]["created_date"],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: MainColors.fromHex(
                                      MainColors.colorBlack)),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            }));
  }
}
