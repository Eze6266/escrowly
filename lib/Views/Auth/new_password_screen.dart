// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';

class EnterNewPasswordScreen extends StatefulWidget {
  EnterNewPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });
  String email, otp;
  @override
  State<EnterNewPasswordScreen> createState() => _EnterNewPasswordScreenState();
}

class _EnterNewPasswordScreenState extends State<EnterNewPasswordScreen> {
  TextEditingController pwdCtrler = TextEditingController();

  TextEditingController confPwdCtrler = TextEditingController();
  bool isLoading = false;
  bool pwdError = false;
  bool confPwdError = false;
  bool pwd = true;
  bool confirmPwd = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).resetPwdIsLoading;
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
              text: 'Enter New Password',
              color: kColors.blackColor,
              weight: FontWeight.w600,
              size: 18,
            ),
            Height(h: 1),
            kTxt(
              text: 'Enter your new password below',
              color: kColors.textGrey,
              weight: FontWeight.w500,
              size: 14,
              maxLine: 3,
              textalign: TextAlign.center,
            ),
            Height(h: 3),
            TitleTField(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    pwd = !pwd;
                  });
                },
                child: Icon(
                  pwd
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              width: 93 * size.width / 100,
              obscure: pwd ? true : false,
              elevated: true,
              title: 'Create Password',
              hint: 'Enter a password',
              controller: pwdCtrler,
              isLoading: isLoading,
              keyType: TextInputType.visiblePassword,
              onChanged: (value) {
                if (pwdCtrler.text.length < 6) {
                  setState(() {
                    pwdError = true;
                  });
                } else {
                  setState(() {
                    pwdError = false;
                  });
                }
              },
            ),
            pwdError
                ? Padding(
                    padding: EdgeInsets.only(left: 2 * size.width / 100),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: kTxt(
                        text: 'Password cannot be less than 6',
                        color: kColors.red,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Height(h: 2),
            TitleTField(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    confirmPwd = !confirmPwd;
                  });
                },
                child: Icon(
                  confirmPwd
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              width: 93 * size.width / 100,
              obscure: confirmPwd ? true : false,
              elevated: true,
              title: 'Confirm Password',
              hint: 'Re-Enter a password',
              controller: confPwdCtrler,
              isLoading: isLoading,
              keyType: TextInputType.visiblePassword,
              onChanged: (value) {
                if (confPwdCtrler.text.length < 6) {
                  setState(() {
                    confPwdError = true;
                  });
                } else {
                  setState(() {
                    confPwdError = false;
                  });
                }
              },
            ),
            confPwdError
                ? Padding(
                    padding: EdgeInsets.only(left: 2 * size.width / 100),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: kTxt(
                        text: 'Password cannot be less than 6',
                        color: kColors.red,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Height(h: 3),
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
              borderRadius: 30,
              tap: () async {
                if (pwdError == true ||
                    confPwdError == true ||
                    pwdCtrler.text.isEmpty ||
                    confPwdCtrler.text.isEmpty) {
                  showCustomErrorToast(
                      context, 'Make sure all fields are filled');
                } else {
                  if (pwdCtrler.text == confPwdCtrler.text) {
                    authProvider
                        .resetPwd(
                            email: widget.email,
                            password: pwdCtrler.text,
                            otp: widget.otp,
                            context: context)
                        .then((value) {
                      if (value == 'success') {
                        goTo(context, LoginScreen());
                      } else {
                        showCustomErrorToast(
                            context, authProvider.resetPwdMessage);
                      }
                    });
                  } else {
                    showCustomErrorToast(context, 'Passwords don\'t match');
                  }
                }
              },
            ),
            Height(h: 2),
            kTxt(
              text: 'Contact Support',
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
