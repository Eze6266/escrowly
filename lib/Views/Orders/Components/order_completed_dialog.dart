import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_add_new_bank_dialog.dart';
import 'package:trustbridge/Views/bottom_nav.dart';

void showOrderCompletedDialog(
  BuildContext context,
  ConfettiController confettiController,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      confettiController.play();

      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: OrderCompletedDialog(
          confetticontroller: confettiController,
        ),
      );
    },
  );
}

class OrderCompletedDialog extends StatefulWidget {
  OrderCompletedDialog({
    super.key,
    required this.confetticontroller,
  });

  ConfettiController confetticontroller;

  @override
  State<OrderCompletedDialog> createState() => _OrderCompletedDialogState();
}

class _OrderCompletedDialogState extends State<OrderCompletedDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: 95 * size.width / 100,
          height: 32 * size.height / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: kColors.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: kTxt(
                    text: 'Order Completed!',
                    size: 18,
                    weight: FontWeight.w500,
                  ),
                ),
                Height(h: 4),
                Center(
                  child: kTxt(
                    text:
                        'Your order has been completed successfully. The seller would be notified and payment would be released to their account',
                    size: 12,
                    weight: FontWeight.w500,
                    color: kColors.textGrey,
                    maxLine: 30,
                    textalign: TextAlign.center,
                  ),
                ),
                Height(h: 6),
                GenBtn(
                  size: size,
                  width: 78,
                  borderRadius: 55,
                  height: 4.5,
                  btnColor: kColors.primaryColor,
                  btnText: 'GoTo Home',
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
        ),
        Positioned(
          left: 50 * size.width / 100,
          child: ConfettiWidget(
            numberOfParticles: 5,
            shouldLoop: true,
            gravity: 0.06,
            blastDirection: pi / 2,
            confettiController: widget.confetticontroller,
          ),
        ),
      ],
    );
  }
}
