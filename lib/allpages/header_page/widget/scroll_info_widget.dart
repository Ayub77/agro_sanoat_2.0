// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ScrollInfoWidget extends StatelessWidget {
  const ScrollInfoWidget({
    Key? key,
    required this.size,
    required this.ontap,
    this.item,
  }) : super(key: key);

  final Size size;
  final dynamic item;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        //height: 400,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: MainColors.fromHex("#FFFFFF"),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 215,
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
              height: 8,
            ),
            Text(
              item["short_context"],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              item["short_text"],
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 14),
            ),
            // Row(
            //   // ignore: prefer_const_literals_to_create_immutables
            //   children: [
            //     Text(
            //       "Kategoriya:",
            //       style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
