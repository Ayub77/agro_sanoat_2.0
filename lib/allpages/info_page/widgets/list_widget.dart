// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListWidgetInfo extends StatelessWidget {
  const ListWidgetInfo({
    Key? key,
    required this.size,
    required this.ontap,
    this.item,
  }) : super(key: key);

  final Size size;
  final Function ontap;
  final dynamic item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap(item);
      },
      child: Container(
        width: size.width,
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
            Container(
              height: 220,
              width: size.width,
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
            SizedBox(
              height: 15,
            ),
            Text(
              item["short_context"],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              item["short_text"],
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
