// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Views/HomeScreens/home_screen.dart';
import 'package:trustbridge/Views/Orders/orders_screen.dart';
import 'package:trustbridge/Views/SettingsScreens/settings_screen.dart';
import 'package:trustbridge/Views/SupportScreens/support_screen.dart';
import 'package:trustbridge/Views/WalletScreens/wallet_screen.dart';

class BottomNav extends StatefulWidget {
  BottomNav({super.key, required this.chosenmyIndex});
  final int chosenmyIndex;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int myIndex;
  bool isLoggedIn = false;
  DateTime currentTime = DateTime.now();
  List<Widget> widgetList = [
    HomeScreen(),
    OrdersScreen(),
    WalletScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    myIndex = widget.chosenmyIndex;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(currentTime);
        final isExitWarning = difference >= Duration(seconds: 2);
        currentTime = DateTime.now();
        if (isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 14);
          return false;
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return Future.value(false);
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: GoogleFonts.inter(
            textStyle: TextStyle(
              color: kColors.primaryColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          selectedItemColor: kColors.primaryColor,
          unselectedItemColor: kColors.textGrey,
          unselectedLabelStyle: GoogleFonts.inter(
            textStyle: TextStyle(
              color: kColors.textGrey,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.homesvg,
                  height: 1.9 * size.height / 100,
                  color: kColors.primaryColor,
                ),
              ),
              label: 'Home',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.homesvg,
                  height: 1.9 * size.height / 100,
                  color: kColors.textGrey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.orderssvg,
                  height: 1.9 * size.height / 100,
                  color: kColors.primaryColor,
                ),
              ),
              label: 'Orders',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.orderssvg,
                  height: 1.9 * size.height / 100,
                  color: kColors.textGrey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.walletsvg,
                  height: 1.9 * size.height / 100,
                  color: kColors.primaryColor,
                ),
              ),
              label: 'Wallet',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.walletsvg,
                  height: 1.9 * size.height / 100,
                  color: kColors.textGrey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.profilesvg,
                  height: 2 * size.height / 100,
                  color: kColors.primaryColor,
                ),
              ),
              label: 'Settings',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 0.5 * size.height / 100),
                child: SvgPicture.asset(
                  kImages.profilesvg,
                  height: 2 * size.height / 100,
                  color: kColors.textGrey,
                ),
              ),
            ),
          ],
        ),
        body: widgetList[myIndex],
      ),
    );
  }
}
