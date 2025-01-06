// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/check_email_function.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/forgot_pwd_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailCtrler = TextEditingController();

  bool emailError = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).sendPwdOtpIsLoading;

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
            Align(
              alignment: Alignment.centerLeft,
              child: BckBtn(),
            ),
            Height(h: 2),
            kTxt(
              text: 'Forgot your Password?',
              color: kColors.blackColor,
              weight: FontWeight.w600,
              size: 18,
            ),
            Height(h: 2),
            SizedBox(
              width: 70 * size.width / 100,
              child: kTxt(
                text: 'Let\'s help you reset it. Please enter your email below',
                color: kColors.textGrey,
                weight: FontWeight.w500,
                size: 14,
                maxLine: 3,
                textalign: TextAlign.center,
              ),
            ),
            Height(h: 3),
            TitleTField(
              width: 93 * size.width / 100,
              elevated: true,
              title: 'Business Email',
              hint: 'Enter business email',
              controller: emailCtrler,
              isLoading: isLoading,
              keyType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  if (isValidEmail(emailCtrler.text)) {
                    emailError = false;
                  } else {
                    emailError = true;
                  }
                });
              },
            ),
            emailError
                ? Padding(
                    padding: EdgeInsets.only(left: 2 * size.width / 100),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: kTxt(
                        text: 'Enter a valid email',
                        color: kColors.red,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Height(h: 4),
            GenBtn(
              size: size,
              width: 90,
              isLoading: isLoading,
              height: 6,
              btnColor: kColors.primaryAccent,
              btnText: 'Reset Password',
              txtColor: kColors.whiteColor,
              textSize: 16,
              txtWeight: FontWeight.w500,
              borderRadius: 8,
              tap: () {
                if (emailError == true || emailCtrler.text.isEmpty) {
                  showCustomErrorToast(context, 'Enter a valid email');
                } else {
                  authProvider
                      .sendPwdOtp(email: emailCtrler.text, context: context)
                      .then((value) {
                    if (value == 'success') {
                      goTo(context,
                          ForgotPasswordOtpScren(email: emailCtrler.text));
                    } else {
                      showCustomErrorToast(
                          context, authProvider.sendPwdOtpMessage);
                    }
                  });
                }
              },
            ),
            Height(h: 2),
          ],
        ),
      ),
    );
  }
}
