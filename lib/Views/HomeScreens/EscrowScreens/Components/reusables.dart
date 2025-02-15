import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class SelectTypeBtn extends StatelessWidget {
  SelectTypeBtn({
    super.key,
    required this.borderColor,
    required this.btnColor,
    required this.img,
    required this.onTap,
    required this.txt,
    required this.txtColor,
    this.iconColor,
  });
  String txt, img;
  Function() onTap;
  Color btnColor, borderColor, txtColor;
  Color? iconColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3 * size.width / 100,
          vertical: 0.5 * size.height / 100,
        ),
        width: 88 * size.width / 100,
        height: 6 * size.height / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: btnColor,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              img,
              color: iconColor ?? kColors.blackColor,
              height: 2 * size.height / 100,
            ),
            Width(w: 3),
            kTxt(
              text: '$txt',
              weight: FontWeight.w500,
              color: txtColor,
            ),
          ],
        ),
      ),
    );
  }
}

class WhoGoPayFee extends StatelessWidget {
  WhoGoPayFee({
    super.key,
    required this.naMe,
    required this.onTap,
    required this.txt,
  });
  bool naMe;
  Function() onTap;
  String txt;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        kTxt(
          text: '$txt',
          size: 10,
          weight: FontWeight.w400,
          color: kColors.primaryColor,
        ),
        Width(w: 2),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 2 * size.height / 100,
            width: 4.5 * size.width / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: naMe ? kColors.primaryColor : kColors.textGrey),
              color: naMe ? kColors.primaryColor : kColors.whiteColor,
            ),
            child: Icon(
              Icons.check,
              color: naMe ? kColors.whiteColor : kColors.whiteColor,
              size: 10,
            ),
          ),
        ),
      ],
    );
  }
}
