import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/bottom_nav.dart';

class HomeBalanceCard extends StatefulWidget {
  HomeBalanceCard({
    super.key,
    required this.amount,
    required this.withdraw,
  });
  String amount;
  Function() withdraw;
  @override
  State<HomeBalanceCard> createState() => _HomeBalanceCardState();
}

class _HomeBalanceCardState extends State<HomeBalanceCard> {
  bool hideBal = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4 * size.width / 100,
            vertical: 0.8 * size.height / 100,
          ),
          height: 16 * size.height / 100,
          width: 95 * size.width / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            image: DecorationImage(
              scale: 4.9,
              image: AssetImage(
                kImages.cardcross,
              ),
              alignment: Alignment.topRight,
            ),
            color: kColors.primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kTxt(
                    text: 'Balance in escrow',
                    color: kColors.whiteColor.withOpacity(0.5),
                    weight: FontWeight.w400,
                  ),
                  Width(w: 2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        hideBal = !hideBal;
                      });
                    },
                    child: Icon(
                      hideBal
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: kColors.whiteColor.withOpacity(0.5),
                      size: 14,
                    ),
                  ),
                ],
              ),
              Height(h: 0.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kTxt(
                    text: hideBal
                        ? '******'
                        : 'N${formatNumberWithCommas(widget.amount)}',
                    color: kColors.whiteColor,
                    size: 18,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Shimmer.fromColors(
                      period: Duration(seconds: 8),
                      baseColor: kColors.red,
                      highlightColor: kColors.starYellow,
                      child: Text(
                        '',
                        style: GoogleFonts.acme(
                          textStyle: TextStyle(
                            color: kColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      goTo(context, BottomNav(chosenmyIndex: 1));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        kTxt(
                          text: 'Transaction history ',
                          size: 12,
                          color: kColors.whiteColor,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: kColors.whiteColor,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10.5 * size.height / 100,
          child: Transform.rotate(
            angle: 160 * (3.1415926535897932 / 180),
            child: Image.asset(
              kImages.cardcross,
              height: 7 * size.height / 100,
            ),
          ),
        ),
      ],
    );
  }
}

class HomePayoutBalanceCard extends StatefulWidget {
  HomePayoutBalanceCard({
    super.key,
    required this.amount,
    required this.withdraw,
  });
  String amount;
  Function() withdraw;
  @override
  State<HomePayoutBalanceCard> createState() => _HomePayoutBalanceCardState();
}

class _HomePayoutBalanceCardState extends State<HomePayoutBalanceCard> {
  bool hideBal = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4 * size.width / 100,
            vertical: 0.8 * size.height / 100,
          ),
          height: 16 * size.height / 100,
          width: 95 * size.width / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            image: DecorationImage(
              scale: 4.9,
              image: AssetImage(
                kImages.cardcross,
              ),
              alignment: Alignment.topRight,
            ),
            color: kColors.primaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kTxt(
                    text: 'Payout balance',
                    color: kColors.whiteColor.withOpacity(0.5),
                    weight: FontWeight.w400,
                  ),
                  Width(w: 2),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        hideBal = !hideBal;
                      });
                    },
                    child: Icon(
                      hideBal
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: kColors.whiteColor.withOpacity(0.5),
                      size: 14,
                    ),
                  ),
                ],
              ),
              Height(h: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: hideBal
                        ? '******'
                        : 'N${formatNumberWithCommas(widget.amount)}',
                    color: kColors.whiteColor,
                    size: 18,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Shimmer.fromColors(
                      period: Duration(seconds: 8),
                      baseColor: kColors.red,
                      highlightColor: kColors.starYellow,
                      child: Text(
                        '',
                        style: GoogleFonts.acme(
                          textStyle: TextStyle(
                            color: kColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      goTo(context, BottomNav(chosenmyIndex: 2));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        kTxt(
                          text: 'View withdrawal history ',
                          size: 12,
                          color: kColors.whiteColor,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: kColors.whiteColor,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10.5 * size.height / 100,
          child: Transform.rotate(
            angle: 160 * (3.1415926535897932 / 180),
            child: Image.asset(
              kImages.cardcross,
              height: 7 * size.height / 100,
            ),
          ),
        ),
      ],
    );
  }
}
