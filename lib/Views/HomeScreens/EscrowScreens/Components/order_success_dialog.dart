import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/bottom_nav.dart';

void showCashoutSuccessDialog(BuildContext context, String email) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: CashoutSuccessDialog(
          size: size,
          email: email,
        ),
      );
    },
  );
}

class CashoutSuccessDialog extends StatefulWidget {
  CashoutSuccessDialog({
    super.key,
    required this.size,
    required this.email,
  });

  final Size size;
  String email;

  @override
  State<CashoutSuccessDialog> createState() => _CashoutSuccessDialogState();
}

class _CashoutSuccessDialogState extends State<CashoutSuccessDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 80 * widget.size.width / 100,
      height: 25 * widget.size.height / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kColors.whiteColor,
      ),
      child: SingleChildScrollView(
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
              Height(h: 3),
              kTxt(
                text: 'Invitation link successfully sent',
                color: kColors.blackColor,
                weight: FontWeight.w700,
                size: 14,
              ),
              Height(h: 2),
              SizedBox(
                width: 60 * size.width / 100,
                child: kTxt(
                  text: 'An invite link has been sent to \n ${widget.email}. ',
                  color: kColors.blackColor.withOpacity(0.7),
                  weight: FontWeight.w500,
                  maxLine: 4,
                  textalign: TextAlign.center,
                  size: 12,
                ),
              ),
              Height(h: 4),
              GenBtn(
                size: widget.size,
                width: 60,
                borderRadius: 10,
                height: 5,
                btnColor: kColors.primaryColor,
                btnText: 'View order',
                borderColor: kColors.primaryColor,
                txtColor: kColors.whiteColor,
                txtWeight: FontWeight.w500,
                tap: () {
                  goBack(context);
                  goTo(context, BottomNav(chosenmyIndex: 1));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
