import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/Functions/get_first_letters.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class PendingEscrowsBox extends StatelessWidget {
  PendingEscrowsBox({
    super.key,
    required this.amount,
    required this.product,
    required this.date,
    required this.reference,
    required this.type,
    required this.title,
  });
  String product, amount, type, reference, date;
  String? title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3 * size.width / 100,
        vertical: 1 * size.height / 100,
      ),
      // height: 18 * size.height / 100,
      width: 42 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kColors.ongoingBg,
        border: Border.all(color: kColors.dimPrimary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            kImages.box,
            height: 2 * size.height / 100,
          ),
          Width(w: 3),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Shimmer.fromColors(
              //       period: Duration(seconds: 2),
              //       baseColor: type == '1' ? kColors.red : kColors.primaryColor,
              //       highlightColor: kColors.starYellow,
              //       child: kTxt(
              //         text: type == '1' ? 'SELLING' : 'BUYING',
              //         color: kColors.primaryColor,
              //         size: 10,
              //         weight: FontWeight.w900,
              //       ),
              //     ),
              //   ],
              // ),
              // Height(h: 0.5),
              Align(
                alignment: Alignment.centerLeft,
                child: kTxt(
                  text: title ?? product,
                  size: 12,
                  weight: FontWeight.w500,
                  maxLine: 1,
                  textalign: TextAlign.left,
                ),
              ),
              Height(h: 0.5),
              Align(
                alignment: Alignment.centerLeft,
                child: kTxt(
                  text: '$reference',
                  size: 11,
                  weight: FontWeight.w500,
                  color: kColors.textGrey,
                  maxLine: 1,
                  textalign: TextAlign.left,
                ),
              ),
              Height(h: 0.5),
              Align(
                alignment: Alignment.centerLeft,
                child: kTxt(
                  text: '${formatDateTime(date)}',
                  size: 10,
                  weight: FontWeight.w500,
                  maxLine: 1,
                  color: kColors.textGrey.withOpacity(0.5),
                  textalign: TextAlign.left,
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
        ],
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
    required this.sender,
    required this.userid,
    required this.fee,
    required this.description,
  });
  String type,
      amount,
      status,
      datetime,
      title,
      sender,
      userid,
      fee,
      description;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3 * size.width / 100,
        vertical: 0.6 * size.height / 100,
      ),
      width: (size.width ?? 84) * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kColors.ongoingBg,
        border: Border.all(color: kColors.whitishGrey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 80 * size.width / 100,
              child: kTxt(
                text: (userid == Provider.of<AuthProvider>(context).userID)
                    ? 'Order to $sender'
                    : 'Order From $sender',
                maxLine: 2,
                color: kColors.blackColor.withOpacity(0.8),
                size: 13,
                textalign: TextAlign.left,
                weight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40 * size.width / 100,
                child: kTxt(
                  text: 'Service: $description',
                  maxLine: 1,
                  color: kColors.textGrey,
                  size: 12,
                  textalign: TextAlign.left,
                  weight: FontWeight.w500,
                ),
              ),
              kTxt(
                text: '- N${formatNumberWithCommas(amount)}',
                maxLine: 1,
                color: kColors.textGrey,
                size: 12,
                textalign: TextAlign.left,
                weight: FontWeight.w500,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: kTxt(
              text: 'Order Fee: N${formatNumberWithCommas(fee)}',
              maxLine: 1,
              color: kColors.textGrey,
              size: 12,
              textalign: TextAlign.left,
              weight: FontWeight.w500,
            ),
          ),

          Height(h: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kTxt(
                text: '${formatDateTime(datetime)}',
                maxLine: 1,
                color: kColors.textGrey,
                size: 12,
                textalign: TextAlign.left,
                weight: FontWeight.w500,
              ),
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
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     kTxt(
          //       // text: getTitleTxt(status),
          //       text: title,
          //       size: 13,
          //       weight: FontWeight.w500,
          //     ),
          //     Height(h: 0.3),
          //     kTxt(
          //       text: '${formatDateTime(datetime)}',
          //       size: 11,
          //       weight: FontWeight.w400,
          //       color: kColors.textGrey,
          //     ),
          //   ],
          // ),
          // Column(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(
          //         horizontal: 2 * size.width / 100,
          //         vertical: 0.1 * size.height / 100,
          //       ),
          //       decoration: BoxDecoration(
          //         color: getStatusTxtColor(status).withOpacity(0.2),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: Center(
          //         child: kTxt(
          //           text: getStatusTxt(status),
          //           size: 10,
          //           color: getStatusTxtColor(status),
          //           weight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //     Height(h: 1),
          //     kTxt(
          //       text: 'N${formatNumberWithCommas(amount)}',
          //       size: 12,
          //       weight: FontWeight.w600,
          //       color: kColors.blackColor,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class HomeRecentTransactionTile extends StatelessWidget {
  HomeRecentTransactionTile({
    super.key,
    required this.amount,
    required this.type,
    required this.status,
    required this.datetime,
  });
  String type, amount, status, datetime;
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
                text: getHomeTitleTxt(type),
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.8 * size.width / 100,
                  vertical: 0.1 * size.height / 100,
                ),
                decoration: BoxDecoration(
                  color: getHomeStatusTxtColor(status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: kTxt(
                    text: getHomeStatusTxt(status),
                    size: 10,
                    color: getHomeStatusTxtColor(status),
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
    required this.bank,
  });
  String type, amount, status, datetime, title, bank;
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
        color: kColors.whiteColor,
        border: Border(
          bottom: BorderSide(
            color: kColors.textGrey.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                kImages.withdrawicon,
                height: 2.5 * size.height / 100,
              ),
              Width(w: 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      kTxt(
                        text: 'N${formatNumberWithCommas(amount)}',
                        size: 13,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(
                        width: 55 * size.width / 100,
                        child: kTxt(
                          maxLine: 1,
                          textalign: TextAlign.start,
                          text: ' withdrawal to $bank',
                          size: 12.5,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Height(h: 0.3),
                  kTxt(
                    text: '${datetime}',
                    size: 11,
                    weight: FontWeight.w400,
                    color: kColors.textGrey,
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
                    text: getWithdrawStatusTxt(status),
                    size: 10,
                    color: getStatusTxtColor(status),
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              Height(h: 1),
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

Color getHomeStatusTxtColor(String status) {
  if (status == '0') {
    return kColors.orange;
  } else if (status == '1') {
    return kColors.greenColor;
  } else if (status == '2') {
    return kColors.red;
  } else if (status == '3') {
    return kColors.purple;
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

String getHomeStatusTxt(String status) {
  if (status == '0') {
    return 'Pending';
  } else if (status == '1') {
    return 'Successful';
  } else if (status == '2') {
    return 'Failed';
  } else if (status == '3') {
    return 'Reversed';
  } else {
    return 'Unknown';
  }
}

String getWithdrawStatusTxt(String status) {
  if (status == '0') {
    return 'Processing';
  } else if (status == '1') {
    return 'Successful';
  } else if (status == '2') {
    return 'Failed';
  } else if (status == '3') {
    return 'Rejected';
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

String getHomeTitleTxt(String type) {
  if (type == '0') {
    return 'Deposit';
  } else if (type == '1') {
    return 'Withdrawal';
  } else if (type == '2') {
    return 'Order Payment';
  } else {
    return 'Unknown';
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
            // bottom: BorderSide(
            //   color: kColors.textGrey.withOpacity(0.2),
            // ),
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
              color: kColors.textGrey,
              weight: FontWeight.w500,
            ),
          ),
          SizedBox(
            width: 62 * size.width / 100,
            child: kTxt(
              text: rtxt,
              color: rColor ?? kColors.blackColor.withOpacity(0.7),
              weight: FontWeight.w600,
              size: 13,
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
    required this.userid,
    required this.isAcceptLoading,
    required this.description,
    required this.isRejectLoading,
    this.width,
  });

  final bool isAcceptLoading, isRejectLoading;
  final String date, amount, fee, sender, type, orderID, userid, description;
  final Function() acceptTap, rejectTap, viewTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3 * size.width / 100,
          vertical: 0.6 * size.height / 100,
        ),
        width: (width ?? 84) * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: kColors.ongoingBg,
          border: Border.all(color: kColors.whitishGrey),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kTxt(
                  text: '$orderID',
                  maxLine: 1,
                  color: kColors.textGrey,
                  size: 12,
                  weight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: viewTap,
                  child: kTxt(
                    text: 'View',
                    maxLine: 1,
                    color: kColors.textGrey,
                    size: 12,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Height(h: 0.4),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 80 * size.width / 100,
                child: kTxt(
                  text: (userid == Provider.of<AuthProvider>(context).userID)
                      ? 'Order to $sender'
                      : 'Order From $sender',
                  maxLine: 2,
                  color: kColors.blackColor,
                  size: 13,
                  textalign: TextAlign.left,
                  weight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40 * size.width / 100,
                  child: kTxt(
                    text: 'Service: $description',
                    maxLine: 1,
                    color: kColors.textGrey,
                    size: 12,
                    textalign: TextAlign.left,
                    weight: FontWeight.w500,
                  ),
                ),
                kTxt(
                  text: '- N${formatNumberWithCommas(amount)}',
                  maxLine: 1,
                  color: kColors.textGrey,
                  size: 12,
                  textalign: TextAlign.left,
                  weight: FontWeight.w500,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: kTxt(
                text: 'Order Fee: N${formatNumberWithCommas(fee)}',
                maxLine: 1,
                color: kColors.textGrey,
                size: 12,
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
                size: 12,
                textalign: TextAlign.left,
                weight: FontWeight.w500,
              ),
            ),
            Height(h: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isAcceptLoading
                    ? Center(
                        child: SizedBox(
                          height: 1.8 * size.height / 100,
                          width: 4.2 * size.width / 100,
                          child: CircularProgressIndicator(
                            color: kColors.primaryColor,
                          ),
                        ),
                      )
                    : (userid == Provider.of<AuthProvider>(context).userID)
                        ? SizedBox.shrink()
                        : GestureDetector(
                            onTap: acceptTap,
                            child: kTxt(
                              text: '  Accept',
                              size: 13,
                              color: kColors.primaryColor,
                              weight: FontWeight.w500,
                              maxLine: 1,
                            ),
                          ),
                isRejectLoading
                    ? Center(
                        child: SizedBox(
                          height: 1.8 * size.height / 100,
                          width: 4.2 * size.width / 100,
                          child: CircularProgressIndicator(
                            color: kColors.red,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: rejectTap,
                        child: kTxt(
                          text: (userid ==
                                  Provider.of<AuthProvider>(context).userID)
                              ? 'Cancel'
                              : 'Reject  ',
                          size: 13,
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
            // bottom: BorderSide(
            //   color: kColors.textGrey.withOpacity(0.2),
            // ),
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
              color: kColors.textGrey,
              weight: FontWeight.w500,
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
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 13,
                      color: rColor ?? kColors.blackColor.withOpacity(0.7),
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

class TopupTransactionTile extends StatelessWidget {
  TopupTransactionTile({
    super.key,
    required this.amount,
    required this.status,
    required this.datetime,
    required this.name,
  });
  String amount, status, datetime, name;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2 * size.width / 100,
        vertical: 1.3 * size.height / 100,
      ),
      //height: 7 * size.height / 100,
      width: double.infinity,
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        color: kColors.whiteColor,
        border: Border(
          bottom: BorderSide(
            color: kColors.textGrey.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                kImages.depositicon,
                height: 2.5 * size.height / 100,
              ),
              Width(w: 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 55 * size.width / 100,
                    child: kTxt(
                      text: '$name',
                      size: 13,
                      weight: FontWeight.w500,
                      maxLine: 1,
                      color: kColors.textGrey,
                      textalign: TextAlign.start,
                    ),
                  ),
                  Height(h: 0.8),
                  kTxt(
                    text: '${datetime}',
                    size: 11,
                    weight: FontWeight.w400,
                    color: kColors.textGrey,
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 4 * size.width / 100,
                vertical: 0.2 * size.height / 100,
              ),
              decoration: BoxDecoration(
                color: getStatusTxtColor(status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: kTxt(
                  text: getWithdrawStatusTxt(status),
                  size: 10,
                  color: getStatusTxtColor(status),
                  weight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
