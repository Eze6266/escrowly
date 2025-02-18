import 'package:clipboard/clipboard.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/Components/otp_boxes.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/setup_trxn_pin.dart';
import 'package:trustbridge/Views/HomeScreens/Components/withdraw_processing.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/order_success_dialog.dart';
import 'package:trustbridge/Views/Orders/Components/accept_order_pin_sheet.dart';

class OrderPaymentInfoSheet extends StatefulWidget {
  OrderPaymentInfoSheet({
    super.key,
    required this.amount,
    required this.fee,
    required this.total,
    required this.orderid,
  });
  var amount, fee, total, orderid;
  @override
  State<OrderPaymentInfoSheet> createState() => _OrderPaymentInfoSheetState();
}

class _OrderPaymentInfoSheetState extends State<OrderPaymentInfoSheet> {
  final confetticontroller = ConfettiController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 47 * size.height / 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: kColors.whiteColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 4 * size.width / 100,
          vertical: 2 * size.height / 100,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GenBtn(
                size: size,
                width: 15,
                height: 0.3,
                btnColor: kColors.textGrey.withOpacity(0.5),
                btnText: '',
              ),
              Height(h: 3),
              kTxt(
                text: 'Payment confirmation',
                size: 18,
                weight: FontWeight.w500,
                color: kColors.blackColor.withOpacity(0.8),
              ),
              Height(h: 1),
              SizedBox(
                width: 90 * size.width / 100,
                child: kTxt(
                  text:
                      'The payment you are about to make will be held securely in escrowly to indicate your interest. It will not be released to the seller immediately.',
                  maxLine: 3,
                  textalign: TextAlign.center,
                  size: 12,
                  weight: FontWeight.w500,
                  color: kColors.textGrey.withOpacity(0.9),
                ),
              ),
              Height(h: 3),
              RowTxtWitUnderline(lTxt: 'Amount', rtxt: 'N${widget.amount}'),
              Height(h: 1.8),
              RowTxtWitUnderline(lTxt: 'Fee', rtxt: 'N${widget.fee}'),
              Height(h: 1.8),
              RowTxtWitUnderline(lTxt: 'Total', rtxt: 'N${widget.total}'),
              Height(h: 6),
              GenBtn(
                size: size,
                width: 90,
                borderRadius: 10,
                height: 5.8,
                btnColor: kColors.primaryColor,
                btnText: 'Done',
                txtColor: kColors.whiteColor,
                tap: () {
                  if (authProvider.checkPinStatus == 'success') {
                    goBack(context);

                    showModalBottomSheet(
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (context) => AcceptOrderPinSheet(
                        orderid: widget.orderid,
                      ),
                    );
                  }
                  {
                    showModalBottomSheet(
                      isDismissible: false,
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (context) => SetupPinSheet(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowTopUpCopy extends StatefulWidget {
  RowTopUpCopy({
    super.key,
    required this.accIndex,
    required this.accountNum,
    required this.accountname,
    required this.bankName,
  });
  String accIndex, accountNum, accountname, bankName;

  @override
  State<RowTopUpCopy> createState() => _RowTopUpCopyState();
}

class _RowTopUpCopyState extends State<RowTopUpCopy> {
  void copyToClipboard(BuildContext context, text2copy, toastMessage) {
    FlutterClipboard.copy(text2copy).then((value) {
      Fluttertoast.showToast(
        msg: "$toastMessage",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: kTxt(
              text: 'Account ${widget.accIndex}',
              size: 12,
              color: kColors.textGrey,
            ),
          ),
          Height(h: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kTxt(
                text: 'Account name',
                size: 13,
                color: kColors.textGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 60 * size.width / 100,
                    child: kTxt(
                      text: '${widget.accountname}',
                      maxLine: 1,
                      size: 13,
                      color: kColors.blackColor,
                      textalign: TextAlign.end,
                    ),
                  ),
                  Width(w: 2),
                  GestureDetector(
                    onTap: () {
                      copyToClipboard(
                          context, widget.accountname, 'Account name copied!');
                    },
                    child: SvgPicture.asset(kImages.copysvg),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kTxt(
                text: 'Account number',
                size: 13,
                color: kColors.textGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 55 * size.width / 100,
                    child: kTxt(
                      text: '${widget.accountNum}',
                      maxLine: 1,
                      size: 13,
                      color: kColors.blackColor,
                      textalign: TextAlign.end,
                    ),
                  ),
                  Width(w: 2),
                  GestureDetector(
                    onTap: () {
                      copyToClipboard(
                          context, widget.accountNum, 'Account number copied!');
                    },
                    child: SvgPicture.asset(kImages.copysvg),
                  ),
                  Width(w: 3),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kTxt(
                text: 'Bank name',
                size: 13,
                color: kColors.textGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 60 * size.width / 100,
                    child: kTxt(
                      text: '${widget.bankName}',
                      maxLine: 1,
                      size: 13,
                      color: kColors.blackColor,
                      textalign: TextAlign.end,
                    ),
                  ),
                  Width(w: 2),
                  GestureDetector(
                    onTap: () {
                      copyToClipboard(
                          context, widget.bankName, 'Bank name copied!');
                    },
                    child: SvgPicture.asset(kImages.copysvg),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
