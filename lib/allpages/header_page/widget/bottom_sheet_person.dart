// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Future bottomsheetPerson(BuildContext context, dynamic item) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
            color: MainColors.fromHex(MainColors.colorWhite),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7), topRight: Radius.circular(7))),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              height: 5,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: MainColors.fromHex(MainColors.colorBlack)),
            ),
            Text("Ma'lumot",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: MainColors.fromHex(MainColors.colorBlack),
                    fontSize: 22)),
            Container(
              height: 150,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "http://208.85.23.14:8070/api/file/view?uuid=" +
                          item["resources_uuid"],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
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
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "F.I.SH",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: MainColors.fromHex(MainColors.colorGrey)),
                        ),
                        Text(
                          item["name"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: MainColors.fromHex(MainColors.colorBlack)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ajratilgan maydon turi:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorGrey)),
                ),
                Text(
                  item["farmer_types_name"],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorBlack)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Maydon hajmi:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorGrey)),
                ),
                Text(
                  item["land_area"] == null
                      ? "-"
                      : item["land_area"] + " sotix",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorBlack)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Faoliyat turi:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorGrey)),
                ),
                Text(
                  item["type_activities_name"],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorBlack)),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Telefon:",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorGrey)),
                ),
                Text(
                  item["phone"] == null ? "-" : item["phone"],
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: MainColors.fromHex(MainColors.colorBlack)),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
