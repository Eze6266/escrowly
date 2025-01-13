import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
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
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                //   child: Container(
                //     height: 2.5 * size.height / 100,
                //     width: 5.5 * size.width / 100,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(100),
                //       color: kColors.blackColor,
                //     ),
                //     child: Center(
                //       child: kTxt(
                //         text: getFirstTwoLetters(product),
                //         size: 8,
                //         weight: FontWeight.w600,
                //         color: kColors.whiteColor,
                //       ),
                //     ),
                //   ),
                // ),
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
            Height(h: 0.5),
            Align(
              alignment: Alignment.centerLeft,
              child: kTxt(
                text: '$product',
                size: 12,
                weight: FontWeight.w500,
                maxLine: 1,
                textalign: TextAlign.left,
              ),
            ),
            Height(h: 0.5),
            Text(
              'N$amount',
              style: GoogleFonts.acme(
                textStyle: TextStyle(
                  fontSize: 13,
                  color: kColors.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            // Divider(
            //   color: kColors.textGrey,
            //   thickness: 0.5,
            // ),
            // Height(h: 2),
            // type == '1'
            //     ? GenBtn(
            //         size: size,
            //         width: 35,
            //         borderRadius: 5,
            //         height: 3.5,
            //         btnColor: kColors.blackColor,
            //         btnText: 'Send reminder',
            //         textSize: 10,
            //         txtColor: kColors.whiteColor,
            //       )
            //     : GenBtn(
            //         size: size,
            //         width: 35,
            //         borderRadius: 5,
            //         height: 3.5,
            //         btnColor: kColors.greenColor,
            //         btnText: 'Pay seller',
            //         txtColor: kColors.whiteColor,
            //         textSize: 11,
            //       ),
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
    required this.datetime,
    required this.title,
  });
  String type, amount, status, datetime, title;
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
                text: '${formatDateTime(datetime)}',
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
                color: kColors.blackColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WalletTransactionTile extends StatelessWidget {
  WalletTransactionTile({
    super.key,
    required this.amount,
    required this.type,
    required this.status,
    required this.datetime,
    required this.title,
  });
  String type, amount, status, datetime, title;
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
                text: '${formatDateTime(datetime)}',
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
                color: kColors.blackColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Color getStatusTxtColor(String status) {
  if (status == '0') {
    return kColors.orange;
  } else if (status == '1') {
    return kColors.primaryColor;
  } else if (status == '2') {
    return kColors.purple;
  } else if (status == '3') {
    return kColors.greenColor;
  } else {
    return kColors.red;
  }
}

String getStatusTxt(String status) {
  if (status == '0') {
    return 'Pending';
  } else if (status == '1') {
    return 'Accepted';
  } else if (status == '2') {
    return 'In Progress';
  } else if (status == '3') {
    return 'Completed';
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

class AddFundsWithdrawBtn extends StatelessWidget {
  AddFundsWithdrawBtn({
    super.key,
    required this.img,
    required this.onTap,
    required this.txt,
    this.contentColor,
    this.width,
    this.txtSize,
    this.height,
    this.radius,
  });
  Function() onTap;
  String txt, img;
  double? width, txtSize, radius, height;
  Color? contentColor;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 6 * size.height / 100,
        width: width ?? 45 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 20),
          border: Border.all(color: kColors.whitishGrey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              img,
              height: 2 * size.height / 100,
              color: contentColor ?? kColors.blackColor,
            ),
            Width(w: 3),
            kTxt(
              text: '$txt',
              size: txtSize ?? 16,
              color: contentColor ?? kColors.blackColor,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

class RowTxtWitUnderline extends StatelessWidget {
  RowTxtWitUnderline({
    super.key,
    required this.lTxt,
    required this.rtxt,
    this.rColor,
  });
  String lTxt, rtxt;
  Color? rColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kColors.textGrey.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 30 * size.width / 100,
            child: kTxt(
              text: lTxt,
              size: 13,
              maxLine: 1,
            ),
          ),
          SizedBox(
            width: 63 * size.width / 100,
            child: kTxt(
              text: rtxt,
              color: rColor ?? kColors.blackColor,
              weight: FontWeight.w500,
              textalign: TextAlign.end,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class IncomingOrdersBox extends StatelessWidget {
  IncomingOrdersBox({
    super.key,
    required this.amount,
    required this.fee,
    required this.date,
    required this.acceptTap,
    required this.rejectTap,
    required this.viewTap,
    required this.sender,
    required this.type,
    required this.orderID,
    required this.acceptIsLoading,
    required this.rejectIsLoading,
    this.width,
  });
  bool acceptIsLoading, rejectIsLoading;
  String date, amount, fee, sender, type, orderID;
  Function() acceptTap, rejectTap, viewTap;
  double? width;
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
        width: (width ?? 84) * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kColors.whiteColor,
          border: Border.all(
            color: kColors.whitishGrey,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: kColors.primaryColor.withOpacity(0.2),
                      child: Icon(
                        Icons.shopping_cart,
                        color: kColors.primaryColor,
                        size: 18,
                      ),
                    ),
                    Width(w: 3),
                    kTxt(
                      text: '$orderID',
                      maxLine: 1,
                      color: kColors.textGrey,
                      size: 14,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: viewTap,
                  child: kTxt(
                    text: 'View',
                    maxLine: 1,
                    color: kColors.textGrey,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Height(h: 1),
            kTxt(
              text: 'You have an order invitation to join, From $sender',
              maxLine: 2,
              color: kColors.blackColor,
              size: 14,
              textalign: TextAlign.left,
              weight: FontWeight.w500,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: kTxt(
                text: 'Amount: N${formatNumberWithCommas(amount)}',
                maxLine: 1,
                color: kColors.textGrey,
                size: 14,
                textalign: TextAlign.left,
                weight: FontWeight.w500,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: kTxt(
                text: 'Order Fee: N${formatNumberWithCommas(fee)}',
                maxLine: 1,
                color: kColors.textGrey,
                size: 14,
                textalign: TextAlign.left,
                weight: FontWeight.w500,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: kTxt(
                text: 'Sent on $date',
                maxLine: 1,
                color: kColors.textGrey,
                size: 14,
                textalign: TextAlign.left,
                weight: FontWeight.w500,
              ),
            ),
            Height(h: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                acceptIsLoading
                    ? Padding(
                        padding: EdgeInsets.only(left: 2 * size.width / 100),
                        child: Center(
                          child: SizedBox(
                            height: 1.8 * size.height / 100,
                            width: 4.2 * size.width / 100,
                            child: CircularProgressIndicator(
                              color: kColors.primaryColor,
                            ),
                          ),
                        ),
                      )
                    : rejectIsLoading
                        ? kTxt(
                            text: '  Accept',
                            size: 15,
                            color: kColors.textGrey,
                            weight: FontWeight.w500,
                            maxLine: 1,
                          )
                        : GestureDetector(
                            onTap: acceptTap,
                            child: kTxt(
                              text: '  Accept',
                              size: 15,
                              color: kColors.primaryColor,
                              weight: FontWeight.w500,
                              maxLine: 1,
                            ),
                          ),
                rejectIsLoading
                    ? Padding(
                        padding: EdgeInsets.only(left: 2 * size.width / 100),
                        child: Center(
                          child: SizedBox(
                            height: 1.8 * size.height / 100,
                            width: 4.2 * size.width / 100,
                            child: CircularProgressIndicator(
                              color: kColors.red,
                            ),
                          ),
                        ),
                      )
                    : acceptIsLoading
                        ? kTxt(
                            text: 'Reject  ',
                            size: 15,
                            color: kColors.textGrey,
                            weight: FontWeight.w500,
                            maxLine: 1,
                          )
                        : GestureDetector(
                            onTap: rejectTap,
                            child: kTxt(
                              text: 'Reject  ',
                              size: 15,
                              color: kColors.red,
                              weight: FontWeight.w500,
                              maxLine: 1,
                            ),
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RowTxtWitUnderlineScrolling extends StatelessWidget {
  RowTxtWitUnderlineScrolling({
    super.key,
    required this.lTxt,
    required this.rtxt,
    this.rColor,
  });
  String lTxt, rtxt;
  Color? rColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kColors.textGrey.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 30 * size.width / 100,
            child: kTxt(
              text: lTxt,
              size: 13,
              maxLine: 1,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 63 * size.width / 100,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextScroll(
                  rtxt,
                  mode: TextScrollMode.endless,
                  velocity: Velocity(pixelsPerSecond: Offset(70, 0)),
                  delayBefore: Duration(seconds: 4),
                  numberOfReps: null,
                  pauseBetween: Duration(seconds: 5),
                  style: GoogleFonts.acme(
                    textStyle: TextStyle(
                      color: rColor ?? kColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  textAlign: TextAlign.end,
                  selectable: true,
                  fadedBorder: true,
                  fadedBorderWidth: 0.05,
                  fadeBorderVisibility: FadeBorderVisibility.auto,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
