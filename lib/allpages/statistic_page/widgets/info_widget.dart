// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/funcsions/trenumber.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.number,
    required this.color,
    required this.name,
    required this.text,
  }) : super(key: key);
  final String name;
  final String number;
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      decoration: BoxDecoration(
          //color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color:
                    MainColors.fromHex(MainColors.colorGrey).withOpacity(0.1))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 23,
                width: 23,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(5)),
              ),
              SizedBox(width: 6),
              Container(
                width: 200,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Text(
            TreeNumber.toProcessCost(number.toString()) + " " + text,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
