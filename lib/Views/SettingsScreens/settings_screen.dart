// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/Functions/get_first_letters.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';
import 'package:trustbridge/Views/SettingsScreens/Components/profile_tiles.dart';
import 'package:trustbridge/Views/bottom_nav.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColors.whitishGrey.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            Height(h: 6),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 8 * size.height / 100,
                  width: 17 * size.width / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kColors.textGrey,
                  ),
                  child: Center(
                    child: kTxt(
                      text: getFirstTwoLetters('Emmanuel Eze'),
                      size: 20,
                      weight: FontWeight.w600,
                      color: kColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            Height(h: 1),
            kTxt(
              text: 'Emmanuel Ezejiobi',
              size: 16,
              weight: FontWeight.w600,
            ),
            Height(h: 0.3),
            kTxt(
              text: 'eze6266@gmail.com',
              size: 14,
              weight: FontWeight.w500,
              color: kColors.textGrey,
            ),
            Height(h: 5),
            ProfileScreenTile(
              txt: 'Account',
              img: kImages.accounticon,
              onTap: () {},
            ),
            Height(h: 1.5),
            ProfileScreenTile(
              txt: 'Preference',
              img: kImages.shopicon,
              onTap: () {},
            ),
            Height(h: 1.5),
            ProfileScreenTile(
              txt: 'Security',
              img: kImages.shopicon,
              onTap: () {},
            ),
            Height(h: 1.5),
            ProfileScreenTile(
              txt: 'Help',
              img: kImages.callcentericon,
              onTap: () async {
                goTo(context, BottomNav(chosenmyIndex: 2));
                // String email = Uri.encodeComponent("fastfastsocials@gmail.com");

                // //output: Hello%20Flutter
                // Uri mail = Uri.parse("mailto:$email?subject=&body=");
                // if (await launchUrl(mail)) {
                //   //email app opened
                // } else {
                //   showCustomErrorToast(context, 'Unable to open Email App');
                //   //email app is not opened
                // }
              },
            ),
            // Height(h: 1.5),
            // ProfileScreenTile(
            //   txt: 'Privacy policy',
            //   img: kImages.securityicon,
            //   onTap: () {
            //     //  launchUrl(Uri.parse('https://fastfastapp.com/privacy-policy'));
            //   },
            // ),
            // Height(h: 1.5),
            // ProfileScreenTile(
            //   txt: 'Terms of use',
            //   img: kImages.infoicon,
            //   onTap: () {
            //     // launchUrl(
            //     //     Uri.parse('https://fastfastapp.com/terms-and-condition'));
            //   },
            // ),
            Height(h: 1.5),
            ProfileScreenTile(
              txt: 'Logout',
              img: kImages.infoicon,
              color: kColors.red,
              onTap: () {
                goTo(context, LoginScreen());
                //showConfirmLogoutAccountDialog(context);
              },
            ),
            Height(h: 2),
            kTxt(
              text: 'Version 2.1',
              color: kColors.textGrey,
              weight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
