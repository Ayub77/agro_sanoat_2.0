// ignore_for_file: prefer_const_constructors
import 'package:agro_sanoat/allpages/splash_page/splash_page_prvider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashPageProvider provider = SplashPageProvider();
  @override
  void initState() {
    super.initState();
    provider.onStart(context);
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<SplashPageProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorGreen),
          body: Center(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: provider.d ? 900 : 2500),
                  curve: provider.d
                      ? Curves.fastLinearToSlowEaseIn
                      : Curves.elasticOut,
                  height: provider.d
                      ? 0
                      : provider.a
                          ? _h / 2
                          : 20,
                  width: 20,
                  // color: Colors.deepPurpleAccent,
                ),
                AnimatedContainer(
                  duration: Duration(
                      seconds: provider.d
                          ? 1
                          : provider.c
                              ? 2
                              : 0),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: provider.d
                      ? _h
                      : provider.c
                          ? 80
                          : 20,
                  width: provider.d
                      ? _w
                      : provider.c
                          ? 200
                          : 20,
                  decoration: BoxDecoration(
                      color: provider.b ? Colors.white : Colors.transparent,
                      borderRadius: provider.d
                          ? const BorderRadius.only()
                          : BorderRadius.circular(30)),
                  child: Center(
                    child: provider.e
                        ? AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FadeAnimatedText(
                                'Yosh fermer',
                                duration: const Duration(milliseconds: 1700),
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// class SplashPage extends StatefulWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   SplashPageProvider provider = SplashPageProvider();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     provider.onStart(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => provider,
//       child: Consumer<SplashPageProvider>(
//         builder: (context, value, child) => Scaffold(
//           backgroundColor: MainColors.fromHex(MainColors.colorWhite),
//           body: Container(
//               alignment: Alignment.center,
//               child: AnimatedTextKit(
//                 animatedTexts: [
//                   ScaleAnimatedText(
//                     'Yosh fermer',
//                     textStyle: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.w600,
//                         color: MainColors.fromHex(MainColors.colorGreen)),
//                   ),
//                 ],
//                 repeatForever: true,
//                 pause: const Duration(milliseconds: 500),
//                 displayFullTextOnTap: true,
//                 stopPauseOnTap: true,
//               )),
//         ),
//       ),
//     );
//   }
// }
