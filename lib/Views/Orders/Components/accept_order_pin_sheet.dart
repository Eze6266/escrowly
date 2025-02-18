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
import 'package:trustbridge/Views/HomeScreens/Components/withdraw_processing.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/order_success_dialog.dart';
import 'package:trustbridge/Views/Orders/Components/accept_order_payment_success_sheet.dart';

class AcceptOrderPinSheet extends StatefulWidget {
  AcceptOrderPinSheet({
    super.key,
    required this.orderid,
  });
  var orderid;
  @override
  State<AcceptOrderPinSheet> createState() => _AcceptOrderPinSheetState();
}

class _AcceptOrderPinSheetState extends State<AcceptOrderPinSheet> {
  final confetticontroller = ConfettiController();
  String enteredPin = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);
    isLoading =
        orderProvider.acceptOrderLoading[widget.orderid.toString()] ?? false;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 38 * size.height / 100,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GenBtn(
                    size: size,
                    width: 15,
                    height: 0.3,
                    btnColor: kColors.textGrey.withOpacity(0.5),
                    btnText: '',
                  ),
                  Width(w: 31),
                  GestureDetector(
                    onTap: () {
                      isLoading ? null : goBack(context);
                    },
                    child: Icon(
                      Icons.close_rounded,
                      color: kColors.red,
                    ),
                  ),
                  Width(w: 2),
                ],
              ),
              Height(h: 3),
              kTxt(
                text: 'Input transaction pin',
                size: 18,
                weight: FontWeight.w500,
                color: kColors.blackColor.withOpacity(0.8),
              ),
              Height(h: 1),
              kTxt(
                text: 'Kindly input your transaction pin',
                size: 13,
                weight: FontWeight.w500,
                color: kColors.textGrey.withOpacity(0.9),
              ),
              Height(h: 3),
              OtpPinField(
                autoFocus: true,
                autoFillEnable: true,
                textInputAction: TextInputAction.done,
                onSubmit: (text) {
                  setState(() {
                    print('Entered pin is $text');
                    enteredPin = text;
                  });
                },
                onChange: (text) {},
                otpPinFieldStyle: OtpPinFieldStyle(
                  filledFieldBorderColor: kColors.primaryColor,
                  fieldBorderWidth: 1.5,
                  activeFieldBorderColor: kColors.textGrey,
                ),
                maxLength: 4,
                showCursor: true,
                cursorColor: kColors.primaryColor,
                cursorWidth: 1,
                otpPinFieldDecoration:
                    OtpPinFieldDecoration.defaultPinBoxDecoration,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Height(h: 5),
              GenBtn(
                size: size,
                width: 85,
                isLoading: isLoading,
                height: 5.5,
                btnColor: kColors.primaryColor,
                btnText: 'Done',
                txtColor: kColors.whiteColor,
                tap: () {
                  if (enteredPin.length < 4) {
                    showCustomErrorToast(context, 'Enter complete pin');
                  } else {
                    orderProvider
                        .acceptOrder(
                      orderid: widget.orderid,
                      pin: enteredPin,
                      context: context,
                    )
                        .then((value) {
                      if (value == 'success') {
                        goBack(context);
                        showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          builder: (context) => AcceptOrderSuccessSheet(),
                        );
                      } else {
                        showCustomErrorToast(
                            context, orderProvider.acceptOrderMessage);
                      }
                    });
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
