// ignore_for_file: prefer_const_constructors
import 'package:agro_sanoat/allpages/login_page/widget/login_widget2.dart';
import 'package:agro_sanoat/allpages/login_page/widget/loginwidget1.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPageView extends StatelessWidget {
  const LoginPageView({
    Key? key,
    required this.size,
    required this.nameController,
    required this.passwordController,
    required this.ontap,
    required this.eyeOntap,
    required this.eyeView,
  }) : super(key: key);

  final Size size;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final Function ontap;
  final Function eyeOntap;
  final bool eyeView;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        //height: size.height - 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/farmer.png",
              height: 220,
            ),
            SizedBox(height: 100),
            LoginWidget1(
              controller: nameController,
              size: size,
              icon: Icon(Icons.person,
                  color: MainColors.fromHex(MainColors.colorGreen)),
              name: 'Login',
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color:
                      MainColors.fromHex(MainColors.colorGreen).withAlpha(50)),
              child: TextField(
                controller: passwordController,
                cursorColor: MainColors.fromHex(MainColors.colorGreen),
                obscureText: eyeView,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          eyeOntap();
                        },
                        icon: eyeView
                            ? SvgPicture.asset("assets/images/closeEye.svg")
                            : SvgPicture.asset("assets/images/openEye.svg")),
                    icon: Icon(Icons.lock,
                        color: MainColors.fromHex(MainColors.colorGreen)),
                    hintText: 'Parol',
                    border: InputBorder.none),
              ),
            ),
            SizedBox(height: 70),
            LoginWidget2(
              size: size,
              name: 'KIRISH',
              ontab: () {
                ontap();
              },
            )
          ],
        ),
      ),
    );
  }
}
