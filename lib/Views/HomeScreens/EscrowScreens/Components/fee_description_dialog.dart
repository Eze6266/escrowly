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

void showFeeDescriptionDialog(
  BuildContext context,
  String which,
) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: FeeDescriptionDialog(which: which),
      );
    },
  );
}

class FeeDescriptionDialog extends StatefulWidget {
  FeeDescriptionDialog({
    super.key,
    required this.which,
  });
  String which;
  @override
  State<FeeDescriptionDialog> createState() => _FeeDescriptionDialogState();
}

class _FeeDescriptionDialogState extends State<FeeDescriptionDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kTxt(
                  text: 'Transaction fee?',
                  size: 14,
                  weight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () {
                    goBack(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: kColors.blackColor,
                  ),
                ),
              ],
            ),
            Height(h: 4),
            Center(
              child: kTxt(
                text: widget.which == '1'
                    ? 'Escrowly applies a minimal transaction fee of 2.5%, with a maximum limit of NGN5,000. By selecting the checkbox, the fee will be included in your entered amount.'
                    : 'Escrowly applies a minimal transaction fee of 2.5%, with a maximum limit of NGN5,000. By selecting the checkbox, the fee will be included to the total amount paid by the customer',
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
              btnText: 'I Understand',
              borderColor: kColors.primaryColor,
              txtColor: kColors.whiteColor,
              txtWeight: FontWeight.w500,
              tap: () {
                goBack(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
