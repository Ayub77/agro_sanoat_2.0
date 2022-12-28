// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:agro_sanoat/allpages/animation_loading/loading_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  LoadingProvider provider = LoadingProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    provider.animation(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<LoadingProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.transparent,
          body: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Container(
                    height: 100,
                    width: 100,
                    child: CustomPaint(
                      painter: MyPainter(
                          provider.firstAnimation.value,
                          provider.secondAnimation.value,
                          provider.thirdAnimation.value,
                          provider.fourthAnimation.value,
                          provider.fifthAnimation.value),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstAngle;
  final double secondAngle;
  final double thirdAngle;
  final double fourthAngle;
  final double fifthAngle;

  MyPainter(this.firstAngle, this.secondAngle, this.thirdAngle,
      this.fourthAngle, this.fifthAngle);

  void paint(Canvas canvas, Size size) {
    Paint myArc = Paint()
      ..color = MainColors.fromHex(MainColors.colorGreen)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromLTRB(0, 0, size.width, size.height), firstAngle, 2,
        false, myArc);

    canvas.drawArc(
        Rect.fromLTRB(size.width * .1, size.height * .1, size.width * .9,
            size.height * .9),
        secondAngle,
        2,
        false,
        myArc);

    canvas.drawArc(
        Rect.fromLTRB(size.width * .2, size.height * .2, size.width * .8,
            size.height * .8),
        thirdAngle,
        2,
        false,
        myArc);

    canvas.drawArc(
        Rect.fromLTRB(size.width * .3, size.height * .3, size.width * .7,
            size.height * .7),
        fourthAngle,
        2,
        false,
        myArc);

    canvas.drawArc(
        Rect.fromLTRB(size.width * .4, size.height * .4, size.width * .6,
            size.height * .6),
        fifthAngle,
        2,
        false,
        myArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
