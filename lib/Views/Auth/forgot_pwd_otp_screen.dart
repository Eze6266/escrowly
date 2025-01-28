// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/new_password_screen.dart';

class ForgotPasswordOtpScren extends StatefulWidget {
  ForgotPasswordOtpScren({super.key, required this.email});
  String email;
  @override
  State<ForgotPasswordOtpScren> createState() => _ForgotPasswordOtpScrenState();
}

class _ForgotPasswordOtpScrenState extends State<ForgotPasswordOtpScren> {
  TextEditingController otpCtrler = TextEditingController();
  bool sendcodeagain = false;
  late Timer timer;
  int start = 30;
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
      start = 30;
      sendcodeagain = true;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  bool isLoading = false;
  bool otpIsLoading = false;
  bool sendCodeIsLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).verifyOtpIsLoading;
    otpIsLoading = Provider.of<AuthProvider>(context).sendPwdOtpIsLoading;

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
            isLoading || sendCodeIsLoading
                ? SizedBox.shrink()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: BckBtn(),
                  ),
            Height(h: 2),
            kTxt(
              text: 'Enter OTP',
              color: kColors.blackColor,
              weight: FontWeight.w600,
              size: 18,
            ),
            Height(h: 2),
            SizedBox(
              width: 70 * size.width / 100,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Rany',
                    color: kColors.textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "OTP code sent to ",
                    ),
                    TextSpan(
                      text: '${widget.email}. ',
                      style: TextStyle(
                        color: kColors.primaryAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goBack(context);
                        },
                    ),
                    TextSpan(
                      text: 'This code will expire in  ',
                    ),
                    TextSpan(
                      text: '01:30',
                      style: TextStyle(
                        color: kColors.primaryAccent,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
            Height(h: 3),
            TitleTField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(5),
              ],
              isLoading: isLoading,
              width: 93 * size.width / 100,
              controller: otpCtrler,
              elevated: true,
              title: 'OTP Code',
              hint: 'Input Code',
              keyType: TextInputType.number,
            ),
            Height(h: 3),
            sendcodeagain
                ? SizedBox.shrink()
                : GenBtn(
                    size: size,
                    width: 27,
                    height: 4,
                    btnColor: kColors.whiteColor,
                    isLoading: otpIsLoading,
                    btnText: 'Resend code',
                    txtColor: kColors.primaryColor,
                    textSize: 14,
                    txtWeight: FontWeight.w600,
                    borderRadius: 10,
                    tap: () {
                      authProvider
                          .sendPwdOtp(email: widget.email, context: context)
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
            Height(h: 3),
            GenBtn(
              size: size,
              width: 80,
              isLoading: isLoading,
              height: 6,
              btnColor: kColors.primaryColor,
              btnText: 'Proceed',
              txtColor: kColors.whiteColor,
              textSize: 16,
              txtWeight: FontWeight.w500,
              borderRadius: 10,
              tap: () {
                if (otpCtrler.text.isEmpty || otpCtrler.text.length < 4) {
                  showCustomErrorToast(context, 'Enter a valid code');
                } else {
                  authProvider.verifyOtp(
                      email: widget.email,
                      otp: otpCtrler.text,
                      context: context)
                    ..then((value) {
                      if (value == 'success') {
                        goTo(
                            context,
                            EnterNewPasswordScreen(
                              email: widget.email,
                              otp: otpCtrler.text,
                            ));
                      } else {
                        showCustomErrorToast(
                            context, authProvider.verifyOtpMessage);
                      }
                    });
                }
              },
            ),
            Height(h: 2),
            kTxt(
              text: 'Need help',
              color: kColors.primaryColor,
              weight: FontWeight.w600,
            ),
            Height(h: 2),
          ],
        ),
      ),
    );
  }
}
