// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';
import 'package:trustbridge/Views/Auth/onboarding_screen.dart'; // Import shared_preferences

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var token = '';
  @override
  void initState() {
    super.initState();
    initPref();

    navigateToNextScreen();
  }

  void initPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token').toString();
  }

  void navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 5)); // Simulate splash screen delay
    goTo(context, OnBoardingScreen());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasViewedOnboarding = prefs.getBool('hasViewedOnboarding');

    String? token = prefs.getString('token'); // Get the token from storage

    if (hasViewedOnboarding == true) {
      // Check if the token exists and is not empty
      if (token == null || token.isEmpty) {
        // Navigate to login if token is missing or invalid
        goTo(context, LoginScreen());
      } else {
        // Token exists, set it and try to fetch user data
      }
    } else {
      // Navigate to onboarding if it hasn't been viewed
      goTo(context, OnBoardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColors.whiteColor,
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.0001 * size.height / 100,
      ),
      body: SafeArea(
        child: Container(
          height: 100 * size.height / 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kColors.whiteColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Height(h: 0.5),
              Image.asset(
                kImages.appicon,
                height: 10 * size.height / 100,
              ),
              Height(h: 1),
              Text(
                'Escrowly',
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: kColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
