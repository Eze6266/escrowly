// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Utilities/Functions/get_first_letters.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';
import 'package:trustbridge/Views/SettingsScreens/Components/confirm_logout.dart';
import 'package:trustbridge/Views/SettingsScreens/Components/profile_tiles.dart';
import 'package:trustbridge/Views/SettingsScreens/account_details_screen.dart';
import 'package:trustbridge/Views/SettingsScreens/change_pwd_screen.dart';
import 'package:trustbridge/Views/SettingsScreens/preference_screen.dart';
import 'package:trustbridge/Views/bottom_nav.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);

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
              text: '${authProvider.firstName} ${authProvider.lastName}',
              size: 16,
              weight: FontWeight.w600,
            ),
            Height(h: 0.3),
            kTxt(
              text: '${authProvider.email}',
              size: 14,
              weight: FontWeight.w500,
              color: kColors.textGrey,
            ),
            Height(h: 5),
            ProfileScreenTile(
              txt: 'Account',
              img: kImages.accounticon,
              onTap: () {
                goTo(context, AccountProfileScreen());
              },
            ),
            Height(h: 1.5),
            ToggleDarkModeScreenTile(
              txt: 'Enable Dark Mode',
              img: kImages.shopicon,
              onTap: () {
                //  goTo(context, PreferenceScreen());
              },
            ),
            Height(h: 1.5),
            ProfileScreenTile(
              txt: 'Change Password',
              img: kImages.securityicon,
              onTap: () {
                goTo(context, ChangePasswordScreen());
              },
            ),
            Height(h: 1.5),
            ProfileScreenTile(
              txt: 'Help',
              img: kImages.callcentericon,
              onTap: () async {
                String email = Uri.encodeComponent("eze6266@gmail.com");

                //output: Hello%20Flutter
                Uri mail = Uri.parse("mailto:$email?subject=&body=");
                if (await launchUrl(mail)) {
                  //email app opened
                } else {
                  showCustomErrorToast(context, 'Unable to open Email App');
                  //email app is not opened
                }
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
                showConfirmLogoutAccountDialog(context);
              },
            ),
            Height(h: 2),
            kTxt(
              text: 'Version 1.0',
              color: kColors.textGrey,
              weight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
