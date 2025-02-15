import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/confirm_pin_screen.dart';

class SetupTrxnPinScreen extends StatefulWidget {
  const SetupTrxnPinScreen({super.key});

  @override
  State<SetupTrxnPinScreen> createState() => _SetupTrxnPinScreenState();
}

class _SetupTrxnPinScreenState extends State<SetupTrxnPinScreen> {
  var pin = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    goBack(context);
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
                text:
                    'You need to set up a 4 digit pin to enable you make transaction',
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
                  pin = text;
                });
                print(pin);
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
              height: 6,
              btnColor:
                  pin.length < 4 ? kColors.textGrey : kColors.primaryColor,
              btnText: 'Done',
              txtColor: kColors.whiteColor,
              tap: () {
                if (pin.length < 4) {
                  showCustomErrorToast(context, 'Pin must be a 4 digit');
                } else {
                  goTo(context, ConfirmPinScreen(pin: pin));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
