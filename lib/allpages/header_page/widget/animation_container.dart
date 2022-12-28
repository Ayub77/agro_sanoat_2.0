import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';

class AnimationContainerWidget extends StatelessWidget {
  const AnimationContainerWidget({
    Key? key,
    required this.check,
  }) : super(key: key);
  final bool check;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: check ? 18 : 15,
      width: check ? 18 : 15,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color:
              check ? MainColors.fromHex(MainColors.colorGreen) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 1.4, color: MainColors.fromHex(MainColors.colorGreen))),
      duration: const Duration(milliseconds: 500),
    );
  }
}
