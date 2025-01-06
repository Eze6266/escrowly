// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/Components/otp_boxes.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  VerifyOtpScreen({
    super.key,
    required this.email,
    required this.number,
    required this.nin,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
  String email, number, nin, password, firstName, lastName;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  TextEditingController pin5 = TextEditingController();

  bool sendcodeagain = false;
  late Timer timer;
  int start = 60;
  void startTimer() {
    var consec = Duration(seconds: 1);
    timer = Timer.periodic(consec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          sendcodeagain = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTimer();
    setState(() {
      start = 60;
      sendcodeagain = true;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  bool isLoading = false;
  bool sendCodeIsLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    isLoading = (Provider.of<AuthProvider>(context).registerUserIsLoading ||
        Provider.of<AuthProvider>(context).verifyOtpIsLoading);
    sendCodeIsLoading = Provider.of<AuthProvider>(context).senOtpIsLoading;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.001,
        backgroundColor: kColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            Height(h: 2),
            isLoading
                ? SizedBox.shrink()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        goBack(context);
                      },
                      child: BckBtn(),
                    ),
                  ),
            Height(h: 2),
            kTxt(
              text: 'Enter 4-digit Verification code',
              color: kColors.blackColor,
              weight: FontWeight.w600,
              size: 18,
            ),
            Height(h: 2),
            SizedBox(
              width: 70 * size.width / 100,
              child: kTxt(
                text:
                    'Code sent to ${widget.email}. This code will expire in 01:30',
                color: kColors.textGrey,
                weight: FontWeight.w500,
                size: 14,
                maxLine: 3,
                textalign: TextAlign.center,
              ),
            ),
            Height(h: 3),
            // OtpPinField(
            //   autoFocus: true,
            //   autoFillEnable: true,
            //   textInputAction: TextInputAction.done,
            //   onSubmit: (text) {
            //     setState(() {
            //       print('Entered pin is $text');
            //     });
            //   },
            //   onChange: (text) {},
            //   otpPinFieldStyle: OtpPinFieldStyle(
            //     filledFieldBorderColor: kColors.primaryColor,
            //     fieldBorderWidth: 1.5,
            //     activeFieldBorderColor: kColors.textGrey,
            //   ),
            //   maxLength: 4,
            //   showCursor: true,
            //   cursorColor: kColors.primaryColor,
            //   cursorWidth: 1,
            //   otpPinFieldDecoration:
            //       OtpPinFieldDecoration.defaultPinBoxDecoration,
            //   mainAxisAlignment: MainAxisAlignment.center,
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPBoxes(
                  size: size,
                  pinController: pin1,
                  otpclick: () {
                    setState(() {});
                  },
                ),
                SizedBox(width: 2 * size.width / 100),
                OTPBoxes(
                  size: size,
                  pinController: pin2,
                  otpclick: () {
                    setState(() {});
                  },
                ),
                SizedBox(width: 2 * size.width / 100),
                OTPBoxes(
                  size: size,
                  pinController: pin3,
                  otpclick: () {
                    setState(() {});
                  },
                ),
                SizedBox(width: 2 * size.width / 100),
                OTPBoxes(
                  size: size,
                  pinController: pin4,
                  otpclick: () {
                    setState(() {});
                  },
                ),
                SizedBox(width: 2 * size.width / 100),
                OTPBoxes(
                  size: size,
                  pinController: pin5,
                  otpclick: () {
                    setState(() {});
                  },
                ),
              ],
            ),
            Height(h: 3),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Rany',
                  color: kColors.blackColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: sendcodeagain ? "Request new code in  " : '',
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () async {},
                    text: sendcodeagain ? "Resend in $start" : '',
                    style: TextStyle(
                      color: sendcodeagain
                          ? kColors.textGrey
                          : kColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Height(h: 2),
            sendcodeagain
                ? SizedBox.shrink()
                : GenBtn(
                    size: size,
                    width: 27,
                    height: 4,
                    btnColor: kColors.primaryBg,
                    isLoading: sendCodeIsLoading,
                    btnText: 'Resend code',
                    txtColor: kColors.primaryColor,
                    textSize: 14,
                    txtWeight: FontWeight.w600,
                    borderRadius: 10,
                    tap: () {
                      authProvider
                          .senOtp(
                              email: widget.email,
                              password: widget.password,
                              context: context)
                          .then((value) {
                        if (value == 'success') {
                          sendcodeagain = true;
                          showCustomSuccessToast(
                              context, 'Otp sent successfully');
                          setState(() {
                            start = 60;
                            startTimer();
                          });
                        } else {
                          showCustomErrorToast(
                              context, authProvider.senOtpMessage);
                        }
                      });
                    },
                  ),
            Height(h: 15),
            GenBtn(
              size: size,
              width: 86,
              height: 6,
              isLoading: isLoading == true ? true : false,
              btnColor: kColors.primaryAccent,
              btnText: 'Proceed',
              txtColor: kColors.whiteColor,
              textSize: 16,
              txtWeight: FontWeight.w500,
              borderRadius: 30,
              tap: () {
                var pin =
                    pin1.text + pin2.text + pin3.text + pin4.text + pin5.text;
                if (pin1.text.isEmpty ||
                    pin2.text.isEmpty ||
                    pin3.text.isEmpty ||
                    pin4.text.isEmpty ||
                    pin5.text.isEmpty) {
                  showCustomErrorToast(context, 'Enter complete pin');
                } else {
                  authProvider
                      .verifyOtp(
                          email: widget.email, otp: pin, context: context)
                      .then((value) {
                    if (value == 'success') {
                      authProvider
                          .registerUser(
                              email: widget.email,
                              otp: pin,
                              phone: widget.number,
                              firstName: widget.firstName,
                              nin: widget.nin,
                              lastName: widget.lastName,
                              context: context)
                          .then((value) {
                        if (value == 'success') {
                          goTo(context, LoginScreen());
                        } else {
                          showCustomErrorToast(
                              context, authProvider.registerUserMessage);
                        }
                      });
                    } else {
                      showCustomErrorToast(
                          context, authProvider.verifyOtpMessage);
                    }
                  });
                }
              },
            ),
            Height(h: 3),
          ],
        ),
      ),
    );
  }
}
