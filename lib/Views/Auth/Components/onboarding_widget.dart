import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class OnboardingContent extends StatelessWidget {
  OnboardingContent({
    super.key,
    required this.size,
    required this.imgUrl,
    required this.subText,
    this.align,
  });

  final Size size;
  String subText, imgUrl;
  TextAlign? align;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80 * size.width / 100,
          child: kTxt(
            text: '$subText',
            weight: FontWeight.w700,
            color: kColors.blackColor,
            size: 18,
            textalign: TextAlign.center,
            maxLine: 10,
          ),
        ),
        Height(h: 7),
        Image.asset(
          imgUrl,
          height: 33 * size.height / 100,
          width: 80 * size.width / 100,
        ),
      ],
    );
  }
}
