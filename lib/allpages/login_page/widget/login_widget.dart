// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/home_page/heme_page.dart';
import 'package:agro_sanoat/allpages/login_page/widget/login_widget2.dart';
import 'package:agro_sanoat/allpages/login_page/widget/loginwidget1.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome back",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            SvgPicture.asset("assets/images/login.svg"),
            SizedBox(height: 40),
            LoginWidget1(
              size: size,
              icon: Icon(Icons.mail,
                  color: MainColors.fromHex(MainColors.colorGreen)),
              name: 'Username',
            ),
            LoginWidget1(
              size: size,
              icon: Icon(Icons.lock,
                  color: MainColors.fromHex(MainColors.colorGreen)),
              name: 'Password',
            ),
            SizedBox(height: 20),
            LoginWidget2(
              size: size,
              name: 'KIRISH',
              ontab: () {},
            )
          ],
        ),
      ),
    );
  }
}
