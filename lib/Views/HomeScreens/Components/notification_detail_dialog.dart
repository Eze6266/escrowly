import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';

void showNotificationDetailDialog({
  required BuildContext context,
  required String title,
  required String type,
  required String dateTime,
  required String description,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: NotificationDetailDialog(
          title: title,
          type: type,
          description: description,
          dateTime: dateTime,
        ),
      );
    },
  );
}

class NotificationDetailDialog extends StatefulWidget {
  NotificationDetailDialog({
    super.key,
    required this.title,
    required this.dateTime,
    required this.type,
    required this.description,
  });

  String title, dateTime, type, description;

  @override
  State<NotificationDetailDialog> createState() =>
      _NotificationDetailDialogState();
}

class _NotificationDetailDialogState extends State<NotificationDetailDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 95 * size.width / 100,
      height: 20 * size.height / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                    height: 3 * size.height / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kColors.primaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: kTxt(
                        text: '${widget.title}',
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      goBack(context);
                    },
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: kColors.textGrey.withOpacity(0.2),
                      child: Icon(
                        Icons.close,
                        color: kColors.blackColor,
                        size: 13,
                      ),
                    ),
                  ),
                ],
              ),
              Height(h: 2),
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: kColors.primaryColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Image.asset(
                        kImages.appicon,
                      ),
                    ),
                  ),
                  Width(w: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kTxt(
                        text: widget.dateTime,
                        size: 10,
                        color: kColors.textGrey,
                      ),
                      SizedBox(
                        width: 65 * size.width / 100,
                        child: kTxt(
                          text: '${widget.title}',
                          color: kColors.blackColor,
                          weight: FontWeight.w600,
                          size: 12,
                          maxLine: 100,
                          textalign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Height(h: 2),
              // Row(
              //   children: [
              //     kTxt(
              //       text: 'Amount: ',
              //       color: kColors.textGrey,
              //       size: 12,
              //       weight: FontWeight.w500,
              //     ),
              //     kTxt(
              //       text: 'N${formatNumberWithCommas(widget.amount)}',
              //       color: kColors.red,
              //       weight: FontWeight.w700,
              //       size: 16,
              //     ),
              //   ],
              // ),
              // Height(h: 0.8),
              // Row(
              //   children: [
              //     kTxt(
              //       text: 'Order ID: ',
              //       color: kColors.textGrey,
              //       size: 12,
              //       weight: FontWeight.w500,
              //     ),
              //     kTxt(
              //       text: '${widget.network}',
              //       color: kColors.blackColor,
              //       size: 13,
              //       weight: FontWeight.w600,
              //     ),
              //   ],
              // ),

              // Row(
              //   children: [
              //     kTxt(
              //       text: 'Phone number: ',
              //       color: kColors.textGrey,
              //       weight: FontWeight.w500,
              //       size: 12,
              //     ),
              //     SizedBox(
              //       width: 60 * size.width / 100,
              //       child: kTxt(
              //         text: '${widget.phone}',
              //         color: kColors.blackColor,
              //         weight: FontWeight.w600,
              //         size: 12,
              //         maxLine: 2,
              //       ),
              //     ),
              //   ],
              // ),
              Height(h: 0.8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kTxt(
                    text: 'Description: ',
                    color: kColors.textGrey,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  SizedBox(
                    width: 60 * size.width / 100,
                    child: kTxt(
                      text: widget.description,
                      size: 12,
                      color: kColors.blackColor,
                      weight: FontWeight.w600,
                      maxLine: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showWithdrawDetailDialog({
  required BuildContext context,
  required String title,
  required String status,
  required String accNumber,
  required String accName,
  required String amount,
  required String bankName,
  required String dateTime,
  required String description,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: WithdrawDetailDialog(
          title: title,
          status: status,
          accNumber: accNumber,
          accname: accName,
          bankName: bankName,
          amount: amount,
          description: description,
          dateTime: dateTime,
        ),
      );
    },
  );
}

class WithdrawDetailDialog extends StatefulWidget {
  WithdrawDetailDialog({
    super.key,
    required this.title,
    required this.dateTime,
    required this.status,
    required this.amount,
    required this.accNumber,
    required this.accname,
    required this.bankName,
    required this.description,
  });

  String title,
      dateTime,
      description,
      amount,
      accNumber,
      accname,
      status,
      bankName;

  @override
  State<WithdrawDetailDialog> createState() => _WithdrawDetailDialogState();
}

class _WithdrawDetailDialogState extends State<WithdrawDetailDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 95 * size.width / 100,
      height: 31 * size.height / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kColors.whiteColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                    height: 3 * size.height / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kColors.primaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: kTxt(
                        text: 'Withdrawal',
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      goBack(context);
                    },
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: kColors.textGrey.withOpacity(0.2),
                      child: Icon(
                        Icons.close,
                        color: kColors.blackColor,
                        size: 13,
                      ),
                    ),
                  ),
                ],
              ),
              Height(h: 2),
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: kColors.primaryColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Image.asset(
                        kImages.appicon,
                      ),
                    ),
                  ),
                  Width(w: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kTxt(
                        text: widget.dateTime,
                        size: 10,
                        color: kColors.textGrey,
                      ),
                      SizedBox(
                        width: 65 * size.width / 100,
                        child: kTxt(
                          text: 'ID: ${widget.title}',
                          color: kColors.blackColor,
                          weight: FontWeight.w600,
                          size: 12,
                          maxLine: 100,
                          textalign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Height(h: 2),
              Row(
                children: [
                  kTxt(
                    text: 'Amount: ',
                    color: kColors.textGrey,
                    size: 12,
                    weight: FontWeight.w500,
                  ),
                  kTxt(
                    text: 'N${formatNumberWithCommas(widget.amount)}',
                    color: kColors.red,
                    weight: FontWeight.w700,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 0.8),
              Row(
                children: [
                  kTxt(
                    text: 'Account Number: ',
                    color: kColors.textGrey,
                    size: 12,
                    weight: FontWeight.w500,
                  ),
                  kTxt(
                    text: '${widget.accNumber}',
                    color: kColors.blackColor,
                    size: 13,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              Row(
                children: [
                  kTxt(
                    text: 'Account Name: ',
                    color: kColors.textGrey,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  SizedBox(
                    width: 60 * size.width / 100,
                    child: kTxt(
                      text: '${widget.accname}',
                      color: kColors.blackColor,
                      weight: FontWeight.w600,
                      size: 12,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  kTxt(
                    text: 'Bank Name: ',
                    color: kColors.textGrey,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  SizedBox(
                    width: 60 * size.width / 100,
                    child: kTxt(
                      text: '${widget.bankName}',
                      color: kColors.blackColor,
                      weight: FontWeight.w600,
                      size: 12,
                      maxLine: 2,
                    ),
                  ),
                ],
              ),
              Height(h: 0.8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kTxt(
                    text: 'Description: ',
                    color: kColors.textGrey,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  SizedBox(
                    width: 60 * size.width / 100,
                    child: kTxt(
                      text: widget.description,
                      size: 12,
                      color: kColors.blackColor,
                      weight: FontWeight.w600,
                      maxLine: 2,
                    ),
                  ),
                ],
              ),
              Height(h: 0.8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kTxt(
                    text: 'Status: ',
                    color: kColors.textGrey,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                  SizedBox(
                    width: 60 * size.width / 100,
                    child: kTxt(
                      text: widget.status == '0'
                          ? 'Pending'
                          : widget.status == '1'
                              ? 'Successful'
                              : widget.status == '2'
                                  ? 'Failed'
                                  : 'Rejected',
                      size: 12,
                      color: getStatusTxtColor(widget.status),
                      weight: FontWeight.w600,
                      maxLine: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
