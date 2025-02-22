import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class ReferAndEarnWidget extends StatelessWidget {
  ReferAndEarnWidget({
    super.key,
    required this.size,
    required this.onTap,
  });

  final Size size;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 9 * size.height / 100,
            width: 93 * size.width / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: kColors.primaryColor.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kTxt(
                      color: Color(0xff332b02),
                      size: 14.0,
                      text: 'Refer and earn',
                      weight: FontWeight.w700,
                    ),
                    Height(h: 0.1),
                    SizedBox(
                      width: 75 * size.width / 100,
                      child: kTxt(
                        text:
                            'Get an instant 1.5% discounted fee on escrow transactions—not 2%—for every referral!',
                        textalign: TextAlign.start,
                        size: 12,
                        maxLine: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 68 * size.width / 100,
            top: 2 * size.height / 100,
            child: Container(
              height: 6 * size.height / 100,
              width: 22 * size.width / 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/refer.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showReferDialog(BuildContext context, String referralCode) {
  void _shareText() {
    Share.share('Checkout this amazing offers on Escrowly\n $referralCode!');
  }

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return StatefulBuilder(
        builder: (context, statesetter) {
          return Stack(
            children: [
              // Blurred background
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    // Adjust opacity as needed
                  ),
                ),
              ),
              // Popup dialog

              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 1 * size.height / 100,
                    horizontal: 1 * size.width / 100,
                  ),
                  width: 90 * size.width / 100,
                  height: 27 * size.height / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: 1 * size.width / 100),
                            child: Container(
                              height: 3 * size.height / 100,
                              width: 6 * size.width / 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromARGB(255, 231, 230, 230),
                              ),
                              child: Icon(
                                Icons.close,
                                color: Color.fromARGB(255, 130, 129, 129),
                                size: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Height(h: 1),
                      Container(
                        width: 85 * size.width / 100,
                        height: 18 * size.height / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 244, 239, 213),
                          image: DecorationImage(
                            image: AssetImage('assets/images/lavishmoney.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            kTxt(
                              color: Color(0xff0d0d0d),
                              size: 12.0,
                              text: 'Referral code',
                              weight: FontWeight.w500,
                            ),
                            Height(h: 0.5),
                            kTxt(
                              color: Color(0xff230a02),
                              size: 28.0,
                              text:
                                  '${referralCode == 'null' || referralCode == '' ? '---' : referralCode}',
                              weight: FontWeight.w500,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.5 * size.width / 100),
                              child: SizedBox(
                                width: 78 * size.width / 100,
                                child: kTxt(
                                  text:
                                      'Get an instant 1.5% discounted fee on escrow transactions—not 2%—for every referral!',
                                  textalign: TextAlign.center,
                                  size: 12,
                                  maxLine: 2,
                                ),
                              ),
                            ),
                            Height(h: 1),
                            GestureDetector(
                              onTap: () {
                                _shareText();
                              },
                              child: Container(
                                height: 4.5 * size.height / 100,
                                width: 25 * size.width / 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: kColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/share.svg'),
                                    Width(w: 0.5),
                                    kTxt(
                                      color: Colors.white,
                                      size: 14.0,
                                      text: 'Share',
                                      weight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Height(h: 0.5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
