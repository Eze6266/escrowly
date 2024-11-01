import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/get_first_letters.dart';
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
                    width: 6.4 * size.width / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kColors.blackColor,
                    ),
                    child: Center(
                      child: kTxt(
                        text: getFirstTwoLetters(product),
                        size: 8,
                        weight: FontWeight.w600,
                        color: kColors.whiteColor,
                      ),
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

class RecentTransactionTile extends StatelessWidget {
  RecentTransactionTile({
    super.key,
    required this.amount,
    required this.type,
    required this.status,
  });
  String type, amount, status;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2 * size.width / 100,
        vertical: 1 * size.height / 100,
      ),
      height: 7 * size.height / 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kTxt(
                text: getTitleTxt(type),
                size: 13,
                weight: FontWeight.w500,
              ),
              Height(h: 0.3),
              kTxt(
                text: '25 Oct 2024, 01:53PM',
                size: 11,
                weight: FontWeight.w400,
                color: kColors.textGrey,
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * size.width / 100,
                  vertical: 0.1 * size.height / 100,
                ),
                decoration: BoxDecoration(
                  color: getStatusTxtColor(status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: kTxt(
                    text: getStatusTxt(status),
                    size: 10,
                    color: getStatusTxtColor(status),
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              Height(h: 1),
              kTxt(
                text: 'N${formatNumberWithCommas(amount)}',
                size: 12,
                weight: FontWeight.w600,
                color: kColors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Color getStatusTxtColor(String status) {
  if (status == '1') {
    return kColors.greenColor;
  } else if (status == '2') {
    return kColors.orange;
  } else if (status == '3') {
    return kColors.red;
  } else {
    return kColors.red;
  }
}

String getStatusTxt(String status) {
  if (status == '1') {
    return 'Completed';
  } else if (status == '2') {
    return 'Pending';
  } else if (status == '3') {
    return 'Failed';
  } else {
    return 'Cancelled';
  }
}

String getTitleTxt(String type) {
  if (type == '1') {
    return 'Escrow Payment(You paid)';
  } else if (type == '2') {
    return 'Withdrawal';
  } else if (type == '3') {
    return 'Account Topup';
  } else {
    return 'Cancelled Escrow';
  }
}
