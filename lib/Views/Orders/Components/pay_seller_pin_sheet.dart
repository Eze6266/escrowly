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
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/order_success_dialog.dart';
import 'package:trustbridge/Views/Orders/Components/order_completed_dialog.dart';

class PaySellerPinSheet extends StatefulWidget {
  PaySellerPinSheet({
    super.key,
    required this.orderid,
  });
  var orderid;
  @override
  State<PaySellerPinSheet> createState() => _PaySellerPinSheetState();
}

class _PaySellerPinSheetState extends State<PaySellerPinSheet> {
  final confetticontroller = ConfettiController();

  String enteredPin = '';

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);
    isLoading = Provider.of<OrderProvider>(context).completeOrderIsLoading;

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
              SizedBox(
                width: 90 * size.width / 100,
                child: kTxt(
                  text: 'Kindly input your transaction pin.',
                  size: 12,
                  maxLine: 4,
                  textalign: TextAlign.center,
                  weight: FontWeight.w500,
                  color: kColors.textGrey.withOpacity(0.9),
                ),
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
                width: 83,
                isLoading: isLoading,
                height: 5.5,
                btnColor: kColors.primaryColor,
                btnText: 'Done',
                txtColor: kColors.whiteColor,
                tap: () {
                  orderProvider
                      .completeOrder(
                          orderid: widget.orderid,
                          pin: enteredPin,
                          context: context)
                      .then((value) {
                    if (value == 'success') {
                      goBack(context);
                      showOrderCompletedDialog(context, confetticontroller);
                    } else {
                      showCustomErrorToast(
                          context, orderProvider.completeOrderMessage);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
