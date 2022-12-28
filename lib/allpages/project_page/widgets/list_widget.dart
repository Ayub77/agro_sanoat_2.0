// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListVidget extends StatelessWidget {
  const ListVidget(
      {Key? key, required this.size, this.item, required this.ontap})
      : super(key: key);
  final Size size;
  final dynamic item;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width,
            height: 220,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
          SizedBox(height: 15),
          Text(
            item["short_context"],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15),
          Text(
            item["short_text"],
            style: TextStyle(fontSize: 14),
          ),
          Container(
              width: size.width,
              margin: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  ontap(item["context_path"]);
                },
                child: Text(
                  "LOYIHA HAQIDA BATAFSIL",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorGreen)),
                ),
              ))
        ],
      ),
    );
  }
}
