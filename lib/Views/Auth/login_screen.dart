// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/biometric_service.dart';
import 'package:trustbridge/Utilities/Functions/check_email_function.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/biometric_scanner_img.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/forgot_password_screen.dart';
import 'package:trustbridge/Views/Auth/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrler = TextEditingController();
  TextEditingController pwdCtrler = TextEditingController();
  bool isLoading = false;
  bool emailError = false;
  bool pwdError = false;
  bool pwd = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var biometricApi = Provider.of<BiometricService>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.001,
        backgroundColor: kColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kTxt(
                    text: 'Escr',
                    size: 20,
                    weight: FontWeight.w500,
                  ),
                  kTxt(
                    text: 'owly',
                    size: 20,
                    color: kColors.primaryAccent,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
              Height(h: 5),
              kTxt(
                text: 'Login To Your Account',
                size: 19,
                weight: FontWeight.w700,
              ),
              Height(h: 3),
              TitleTField(
                height: 6.5 * size.height / 100,
                width: 93 * size.width / 100,
                elevated: true,
                title: 'Username/Email',
                hint: 'Type in your username or email',
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
                title: 'Password',
                hint: 'Type in your password',
                controller: pwdCtrler,
                isLoading: isLoading,
                keyType: TextInputType.text,
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
                          text: 'Password cannot be less than 3',
                          color: kColors.red,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Height(h: 2),
              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      goTo(context, ForgotPasswordScreen());
                    },
                    child: kTxt(
                      text: 'Forgot Your Password?',
                      color: kColors.primaryColor,
                      size: 12,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Height(h: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenBtn(
                    size: size,
                    width: biometricApi.isBiometricSupported ? 78 : 90,
                    height: 6,
                    btnColor: emailCtrler.text.isEmpty ||
                            emailError == true ||
                            pwdCtrler.text.isEmpty ||
                            pwdError == true
                        ? kColors.textGrey.withOpacity(0.5)
                        : kColors.primaryAccent,
                    btnText: 'Login',
                    txtColor: kColors.whiteColor,
                    textSize: 16,
                    isLoading: isLoading,
                    txtWeight: FontWeight.w500,
                    borderRadius: 8,
                    tap: () {
                      if (emailCtrler.text.isEmpty ||
                          emailError == true ||
                          pwdCtrler.text.isEmpty ||
                          pwdError == true) {
                        showCustomErrorToast(
                            context, 'Make sure all fields are filled');
                      } else {}
                    },
                  ),
                  biometricApi.isBiometricSupported
                      ? Width(w: 2)
                      : SizedBox.shrink(),
                  biometricApi.isBiometricSupported
                      ? BiometricScan()
                      : SizedBox.shrink(),
                ],
              ),
              Height(h: 2),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Rany',
                    color: kColors.blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "Don\'t have an account?  ",
                    ),
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: kColors.primaryAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goTo(context, SignupScreen());
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
