// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/reusables.dart';

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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                BckBtn(),
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
              onChanged: (value) {},
            ),
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
              onChanged: (value) {},
            ),
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
              tap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
