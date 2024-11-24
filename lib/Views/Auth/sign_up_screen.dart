// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/Functions/check_email_function.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';
import 'package:trustbridge/Views/Auth/verify_otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameCtrler = TextEditingController();
  TextEditingController emailCtrler = TextEditingController();
  TextEditingController pwdCtrler = TextEditingController();
  TextEditingController confPwdCtrler = TextEditingController();
  TextEditingController phoneCtrler = TextEditingController();
  bool pwd = true;
  bool confirmPwd = true;
  bool isLoading = false;
  bool nameError = false;
  bool emailError = false;
  bool pwdError = false;
  bool confPwdError = false;
  bool phoneError = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              Image.asset(
                kImages.appwordwhite,
                height: 8 * size.height / 100,
              ),
              kTxt(
                text: 'Get Started',
                size: 19,
                weight: FontWeight.w700,
              ),
              Height(h: 3),
              TitleTField(
                width: 93 * size.width / 100,
                elevated: true,
                title: 'Full Name',
                hint: 'Enter full name',
                isLoading: isLoading,
                controller: nameCtrler,
                onChanged: (value) {
                  if (nameCtrler.text.length < 3) {
                    setState(() {
                      nameError = true;
                    });
                  } else {
                    setState(() {
                      nameError = false;
                    });
                  }
                },
              ),
              nameError
                  ? Padding(
                      padding: EdgeInsets.only(left: 2 * size.width / 100),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: kTxt(
                          text: 'Name must be more than 3',
                          color: kColors.red,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              Height(h: 2),
              TitleTField(
                width: 93 * size.width / 100,
                elevated: true,
                title: 'Email',
                hint: 'Enter your email',
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
              Height(h: 2),
              TitleTField(
                width: 93 * size.width / 100,
                elevated: true,
                title: 'Phone Number',
                hint: 'Enter phone',
                controller: phoneCtrler,
                isLoading: isLoading,
                keyType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    if (phoneCtrler.text.length < 7) {
                      phoneError = true;
                    } else {
                      phoneError = false;
                    }
                  });
                },
              ),
              phoneError
                  ? Padding(
                      padding: EdgeInsets.only(left: 2 * size.width / 100),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: kTxt(
                          text: 'Enter a valid phone number',
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
              Height(h: 4),
              GenBtn(
                size: size,
                width: 90,
                isLoading: isLoading,
                height: 6,
                btnColor: nameCtrler.text.isEmpty ||
                        emailCtrler.text.isEmpty ||
                        pwdCtrler.text.isEmpty ||
                        nameError == true ||
                        emailError == true ||
                        pwdError == true ||
                        confPwdError == true
                    // phoneCtrler.text.isEmpty ||
                    // phoneError == true
                    ? kColors.textGrey.withOpacity(0.5)
                    : kColors.primaryAccent,
                btnText: 'Next',
                txtColor: kColors.whiteColor,
                textSize: 16,
                txtWeight: FontWeight.w500,
                borderRadius: 8,
                tap: () {
                  if (nameCtrler.text.isEmpty ||
                      emailCtrler.text.isEmpty ||
                      pwdCtrler.text.isEmpty ||
                      nameError == true ||
                      emailError == true ||
                      pwdError == true ||
                      // phoneCtrler.text.isEmpty ||
                      // phoneError == true ||
                      confPwdError == true) {
                    showCustomErrorToast(
                        context, 'Make sure all fields are filled');
                  } else {
                    if (pwdCtrler.text == confPwdCtrler.text) {
                      goTo(context, VerifyOtpScreen(email: emailCtrler.text));
                    } else {
                      showCustomErrorToast(context, 'Passwords don\'t match');
                    }
                  }
                },
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
                      text: "Already have an account?  ",
                    ),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: kColors.primaryAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goTo(context, LoginScreen());
                        },
                    ),
                  ],
                ),
              ),
              Height(h: 2),
              Height(h: 4),
            ],
          ),
        ),
      ),
    );
  }
}
