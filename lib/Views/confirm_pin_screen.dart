import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class ConfirmPinScreen extends StatefulWidget {
  ConfirmPinScreen({
    super.key,
    required this.pin,
  });
  var pin;
  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  bool isLoading = false;
  var confirmpin = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).setPinIsLoading;
    var trxnProvider = Provider.of<TransactionProvider>(context, listen: false);
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kColors.whiteColor,
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            Height(h: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    isLoading ? null : goBack(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kColors.blackColor,
                    size: 18,
                  ),
                ),
                Width(w: 25),
                kTxt(
                  text: 'Input transaction pin',
                  color: kColors.blackColor,
                  size: 16,
                  weight: FontWeight.w400,
                ),
              ],
            ),
            Height(h: 5),
            SizedBox(
              width: 70 * size.width / 100,
              child: kTxt(
                text: 'Confirm pin to continue',
                size: 13,
                maxLine: 6,
                textalign: TextAlign.center,
                weight: FontWeight.w500,
                color: kColors.textGrey.withOpacity(0.9),
              ),
            ),
            Height(h: 3),
            OtpPinField(
              fieldHeight: 6 * size.height / 100,
              fieldWidth: 12 * size.width / 100,
              autoFocus: true,
              autoFillEnable: true,
              textInputAction: TextInputAction.done,
              onSubmit: (text) {
                setState(() {
                  print('Entered pin is $text');
                });
              },
              onChange: (text) {
                setState(() {
                  confirmpin = text;
                });
                print(confirmpin);
              },
              otpPinFieldStyle: OtpPinFieldStyle(
                filledFieldBorderColor: kColors.primaryColor,
                fieldBorderWidth: 1.3,
                activeFieldBorderColor: kColors.textGrey,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              maxLength: 4,
              showCursor: true,
              cursorColor: kColors.primaryColor,
              cursorWidth: 1,
              otpPinFieldDecoration:
                  OtpPinFieldDecoration.defaultPinBoxDecoration,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Height(h: 8),
            GenBtn(
              size: size,
              width: 80,
              isLoading: isLoading,
              height: 6,
              btnColor: confirmpin.length < 4
                  ? kColors.textGrey
                  : kColors.primaryColor,
              btnText: 'Done',
              txtColor: kColors.whiteColor,
              tap: () {
                if (confirmpin.length < 4) {
                  showCustomErrorToast(context, 'Pin must be a 4 digit');
                } else {
                  if (confirmpin == widget.pin) {
                    authProvider
                        .setPin(pin: confirmpin, context: context)
                        .then((value) {
                      if (value == 'success') {
                        showCustomSuccessToast(
                            context, 'Pin set successfully!');
                        goBack(context);
                        goBack(context);

                        authProvider.getUser(context: context);
                        authProvider.getNotifcations(context: context);
                        authProvider.checkUserPin(context: context);

                        trxnProvider.fetchAccNumbers(context: context);
                        trxnProvider.fetchWalletTrxns(context: context);

                        trxnProvider.fetchBalances(context: context);
                        trxnProvider.fetchWithdrawals(context: context);

                        trxnProvider.fetchBankList(context: context);
                        orderProvider.fetchIncomingOrder(context: context);
                        orderProvider.fetchTrxns(context: context);
                        orderProvider.fetchRecenttrxn(context: context);
                      } else {
                        showCustomErrorToast(
                            context, authProvider.setPinMessage);
                      }
                    });
                  } else {
                    showCustomErrorToast(context, 'Pin don\'t match');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
