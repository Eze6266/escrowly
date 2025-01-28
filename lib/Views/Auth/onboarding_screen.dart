// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/Components/onboarding_widget.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';
import 'package:trustbridge/Views/Auth/sign_up_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageviewController = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageviewController.dispose();
    super.dispose();
  }

  void startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      int nextPage = pageviewController.page!.toInt() + 1;
      if (nextPage >= 2) {
        nextPage = 0;
      }
      pageviewController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    });
  }

  Future<void> _markOnboardingAsViewed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'hasViewedOnboarding', true); // Mark onboarding as viewed
  }

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
          padding: EdgeInsets.symmetric(
            horizontal: 3 * size.width / 100,
            vertical: 4 * size.height / 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                effect: WormEffect(
                  dotColor: kColors.whitishGrey,
                  dotHeight: 0.3 * size.height / 100,
                  dotWidth: 12 * size.width / 100,
                  spacing: 13,
                  radius: 100,
                  activeDotColor: kColors.blackColor,
                  type: WormType.normal,
                ),
                count: 2,
                controller: pageviewController,
              ),
              Height(h: 2),
              Container(
                height: 65 * size.height / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: PageView(
                  controller: pageviewController,
                  children: [
                    OnboardingContent(
                      size: size,
                      subText:
                          'Shop with confidence,\nevery transaction is secure.',
                      imgUrl: kImages.onboard4,
                    ),
                    OnboardingContent(
                      align: TextAlign.center,
                      size: size,
                      subText: 'Sell smarter,\nget paid securely and on time.',
                      imgUrl: kImages.onboard5,
                    ),
                  ],
                ),
              ),
              Height(h: 3),
              GenBtn(
                borderRadius: 14,
                txtColor: kColors.whiteColor,
                size: size,
                width: 80,
                height: 6,
                btnColor: kColors.primaryColor,
                btnText: 'Create account',
                tap: () async {
                  await _markOnboardingAsViewed();
                  goTo(context, SignupScreen());
                },
              ),
              Height(h: 1.5),
              GenBtn(
                borderRadius: 14,
                borderColor: kColors.textGrey,
                size: size,
                width: 80,
                height: 6,
                btnColor: kColors.whiteColor,
                btnText: 'Login to existing account',
                tap: () async {
                  await _markOnboardingAsViewed();
                  goTo(context, LoginScreen());
                },
              ),
              Height(h: 2),
            ],
          ),
        ),
      ),
    );
  }
}
