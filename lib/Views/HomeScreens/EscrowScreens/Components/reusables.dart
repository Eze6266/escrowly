import 'package:flutter/material.dart';
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
  });
  String txt, img;
  Function() onTap;
  Color btnColor, borderColor, txtColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 2 * size.width / 100,
          vertical: 0.5 * size.height / 100,
        ),
        width: 78 * size.width / 100,
        height: 6 * size.height / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: btnColor,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kTxt(
              text: '$txt',
              weight: FontWeight.w600,
              color: txtColor,
            ),
            Width(w: 4),
            Image.asset(
              img,
              height: 3 * size.height / 100,
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
  });
  bool naMe;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        kTxt(
          text: 'i am paying the transaction fee',
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
