// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BigviewInfo extends StatelessWidget {
  const BigviewInfo({Key? key, this.item}) : super(key: key);
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: MainColors.fromHex(MainColors.colorBack),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: MainColors.fromHex(MainColors.colorGreen),
            )),
        centerTitle: true,
        title: Text(
          "To'liq ma'lumot",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.green),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteGeneration.bigImageInfo,
                      arguments: item["image_url"]);
                },
                child: Container(
                  height: 250,
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
                height: 15,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      item["short_context"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item["short_text"],
                      style: TextStyle(fontSize: 16, height: 1.4),
                    ),

                    // Row(
                    //   children: [
                    //     Text(
                    //       "Kategoriya:",
                    //       style: TextStyle(
                    //           fontSize: 17, fontWeight: FontWeight.w600),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       "Poliz",
                    //       style: TextStyle(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.w500,
                    //           color: Colors.green),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
