// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListWidgetNews extends StatelessWidget {
  const ListWidgetNews({
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
        height: 330,
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
              height: 200,
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
              height: 5,
            ),
            Text(
              item["short_context"],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Yangilik turi:",
                      style: TextStyle(
                          fontSize: 14,
                          color: MainColors.fromHex(MainColors.colorBlack)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Chiqarilgan sanasi:",
                      style: TextStyle(
                          fontSize: 14,
                          color: MainColors.fromHex(MainColors.colorBlack)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item["type"],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: MainColors.fromHex(MainColors.colorGreen)),
                    ),
                    SizedBox(
                      height: 5,
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
                              color: MainColors.fromHex(MainColors.colorBlack)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//Atrof-muhit radiojurnalining o‘tgan sonida ta’kidlanganidek, Qur’oni Karimning ko‘plab oyatlari atrof-muhitning muhimligidan dalolat beradi. Muqaddas Kitob oyatlaridan ma'lum bo'lganidek, tabiat va hamma narsa. Atrof-muhit radiojurnalining o‘tgan sonida ta’kidlanganidek, Qur’oni Karimning ko‘plab oyatlari atrof-muhitning muhimligidan dalolat beradi. Muqaddas Kitob oyatlaridan ma'lum bo'lganidek, tabiat va hamma narsa.