import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/bottom_nav.dart';

void showCashoutSuccessDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: CashoutSuccessDialog(size: size),
      );
    },
  );
}

class CashoutSuccessDialog extends StatefulWidget {
  const CashoutSuccessDialog({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<CashoutSuccessDialog> createState() => _CashoutSuccessDialogState();
}

class _CashoutSuccessDialogState extends State<CashoutSuccessDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 92 * widget.size.width / 100,
      height: 38 * widget.size.height / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kColors.whiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GenBtn(
              size: size,
              width: 15,
              height: 0.4,
              btnColor: kColors.textGrey,
              btnText: '',
            ),
            Height(h: 4),
            SvgPicture.asset(kImages.checksvg),
            Height(h: 3),
            kTxt(
              text: 'Success',
              color: kColors.blackColor,
              weight: FontWeight.w700,
              size: 18,
            ),
            Height(h: 2),
            SizedBox(
              width: 60 * size.width / 100,
              child: kTxt(
                text:
                    'You have Successfully Created an Order. You can track this order from the transactions section. ',
                color: kColors.blackColor,
                weight: FontWeight.w500,
                maxLine: 4,
                textalign: TextAlign.center,
                size: 12,
              ),
            ),
            Height(h: 4),
            GenBtn(
              size: widget.size,
              width: 80,
              borderRadius: 55,
              height: 5,
              btnColor: kColors.primaryColor,
              btnText: 'Done',
              borderColor: kColors.primaryColor,
              txtColor: kColors.whiteColor,
              txtWeight: FontWeight.w500,
              tap: () {
                goBack(context);
                goTo(context, BottomNav(chosenmyIndex: 0));
              },
            ),
          ],
        ),
      ),
    );
  }
}
