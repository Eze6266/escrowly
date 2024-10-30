import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class PendingEscrowsBox extends StatelessWidget {
  PendingEscrowsBox({
    super.key,
    required this.amount,
    required this.img,
    required this.product,
    required this.type,
  });
  String product, amount, img, type;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 2 * size.width / 100,
          vertical: 0.7 * size.height / 100,
        ),
        // height: 18 * size.height / 100,
        width: 42 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kColors.primaryColor.withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 3 * size.height / 100,
                    width: 7 * size.width / 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kColors.whiteColor),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  period: Duration(seconds: 2),
                  baseColor: type == '1' ? kColors.red : kColors.primaryColor,
                  highlightColor: kColors.starYellow,
                  child: kTxt(
                    text: type == '1' ? 'SELLING' : 'BUYING',
                    color: kColors.primaryColor,
                    size: 10,
                    weight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Height(h: 1),
            kTxt(
              text: '$product',
              size: 12,
              weight: FontWeight.w500,
              maxLine: 1,
            ),
            Height(h: 1),
            Text(
              'N${formatNumberWithCommas(amount)}',
              style: GoogleFonts.acme(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: kColors.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Divider(
              color: kColors.textGrey,
              thickness: 0.5,
            ),
            Height(h: 2),
            type == '1'
                ? GenBtn(
                    size: size,
                    width: 35,
                    borderRadius: 5,
                    height: 3.5,
                    btnColor: kColors.blackColor,
                    btnText: 'Send reminder',
                    textSize: 10,
                    txtColor: kColors.whiteColor,
                  )
                : GenBtn(
                    size: size,
                    width: 35,
                    borderRadius: 5,
                    height: 3.5,
                    btnColor: kColors.greenColor,
                    btnText: 'Pay seller',
                    txtColor: kColors.whiteColor,
                    textSize: 11,
                  ),
          ],
        ),
      ),
    );
  }
}
