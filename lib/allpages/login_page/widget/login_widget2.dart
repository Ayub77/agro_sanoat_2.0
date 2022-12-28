import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget2 extends StatelessWidget {
  const LoginWidget2({
    Key? key,
    required this.size,
    required this.name,
    required this.ontab,
  }) : super(key: key);

  final Size size;
  final String name;
  final Function ontab;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MainColors.fromHex(MainColors.colorGreen),
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: () {
          ontab();
        },
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: size.width * 0.9,
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Text(
            name,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MainColors.fromHex(MainColors.colorBack)),
          ),
        ),
      ),
    );
  }
}
