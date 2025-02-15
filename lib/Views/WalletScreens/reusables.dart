import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class TransactionDetailBox extends StatelessWidget {
  TransactionDetailBox({
    super.key,
    required this.amount,
    required this.statusColor,
    required this.statusTxt,
    required this.title,
  });
  String amount, statusTxt, title;
  Color statusColor;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 4 * size.height / 100,
              color: kColors.whiteColor,
            ),
            Container(
              height: 16 * size.height / 100,
              width: 90 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kColors.lightGrey,
              ),
              child: Column(
                children: [
                  Height(h: 4.5),
                  kTxt(
                    text: '$title',
                    size: 12,
                    color: kColors.textGrey,
                    weight: FontWeight.w500,
                  ),
                  Height(h: 1),
                  kTxt(
                    text: 'N$amount',
                    size: 16,
                    color: kColors.blackColor,
                    weight: FontWeight.w600,
                  ),
                  Height(h: 1),
                  kTxt(
                    text: '$statusTxt',
                    size: 11,
                    color: statusColor,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 13.6 * size.height / 100,
          left: 41 * size.width / 100,
          child: SvgPicture.asset(
            kImages.depositicon,
            height: 5 * size.height / 100,
          ),
        ),
      ],
    );
  }
}
