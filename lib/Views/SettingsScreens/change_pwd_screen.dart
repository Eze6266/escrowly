// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPwdCtrler = TextEditingController();
  TextEditingController newpwdCtrler = TextEditingController();
  TextEditingController confNewPwdCtrler = TextEditingController();
  bool oldPwd = true;
  bool newPwd = true;

  bool confNewPwd = true;
  bool isLoading = false;
  bool oldPwdError = false;
  bool newPwdError = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).changePwdIsLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5 * size.width / 100),
        child: Column(
          children: [
            Height(h: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isLoading ? SizedBox.shrink() : BckBtn(),
                Width(w: 22),
                kTxt(
                  text: 'Change Password',
                  size: 16,
                  weight: FontWeight.w400,
                ),
              ],
            ),
            Height(h: 10),
            TitleTField(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    oldPwd = !oldPwd;
                  });
                },
                child: Icon(
                  oldPwd
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              width: 93 * size.width / 100,
              obscure: oldPwd ? true : false,
              elevated: true,
              title: 'Old Password',
              hint: 'Type in your old password',
              controller: oldPwdCtrler,
              isLoading: isLoading,
              keyType: TextInputType.text,
              onChanged: (value) {
                if (oldPwdCtrler.text.length < 6) {
                  setState(() {
                    oldPwdError = true;
                  });
                } else {
                  setState(() {
                    oldPwdError = false;
                  });
                }
              },
            ),
            oldPwdError
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
            TitleTField(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    newPwd = !newPwd;
                  });
                },
                child: Icon(
                  newPwd
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              width: 93 * size.width / 100,
              obscure: oldPwd ? true : false,
              elevated: true,
              title: 'New Password',
              hint: 'Type in your new password',
              controller: newpwdCtrler,
              isLoading: isLoading,
              keyType: TextInputType.text,
              onChanged: (value) {
                if (newpwdCtrler.text.length < 6) {
                  setState(() {
                    newPwdError = true;
                  });
                } else {
                  setState(() {
                    newPwdError = false;
                  });
                }
              },
            ),
            newPwdError
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
            TitleTField(
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    confNewPwd = !confNewPwd;
                  });
                },
                child: Icon(
                  confNewPwd
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              width: 93 * size.width / 100,
              obscure: confNewPwd ? true : false,
              elevated: true,
              title: 'Confirm New Password',
              hint: 'Type in your new password',
              controller: confNewPwdCtrler,
              isLoading: isLoading,
              keyType: TextInputType.text,
              onChanged: (value) {},
            ),
            Height(h: 10),
            GenBtn(
              size: size,
              width: 90,
              height: 6,
              btnColor: kColors.primaryAccent,
              btnText: 'Reset Password',
              txtColor: kColors.whiteColor,
              textSize: 16,
              isLoading: isLoading,
              txtWeight: FontWeight.w500,
              borderRadius: 8,
              tap: () {
                if (oldPwdCtrler.text.isEmpty ||
                    newpwdCtrler.text.isEmpty ||
                    confNewPwdCtrler.text.isEmpty) {
                  showCustomErrorToast(
                      context, 'make sure all fields are filled');
                } else {
                  if (oldPwdError == true || newPwdError == true) {
                    showCustomErrorToast(
                        context, 'Please input a proper password');
                  } else {
                    if (newpwdCtrler.text == confNewPwdCtrler.text) {
                      authProvider
                          .changePwd(
                              oldPwd: oldPwdCtrler.text,
                              newPwd: newpwdCtrler.text,
                              context: context)
                          .then((value) {
                        if (value == 'success') {
                          showCustomSuccessToast(
                              context, 'Password changed successfully!');
                          goTo(context, LoginScreen());
                        } else {
                          showCustomErrorToast(
                              context, authProvider.changePwdMessage);
                        }
                      });
                    } else {
                      showCustomErrorToast(context, 'Passwords don\'t match');
                    }
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
