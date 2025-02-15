import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class WithdrawFaqScreen extends StatefulWidget {
  const WithdrawFaqScreen({super.key});

  @override
  State<WithdrawFaqScreen> createState() => _WithdrawFaqScreenState();
}

class _WithdrawFaqScreenState extends State<WithdrawFaqScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.whiteColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            Height(h: 1.5),
            Row(
              children: [
                BckBtn(),
                Width(w: 20),
                kTxt(
                  text: 'Withdrawal FAQs',
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ],
            ),
            Height(h: 2.5),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 8,
                        backgroundImage: AssetImage(kImages.appicon),
                      ),
                      Width(w: 2),
                      SizedBox(
                        width: 85 * size.width / 100,
                        child: kTxt(
                          text:
                              'How long does it takes for my withdraw to be processed?',
                          size: 12,
                          weight: FontWeight.w500,
                          maxLine: 3,
                        ),
                      ),
                    ],
                  ),
                  Height(h: 1),
                  SizedBox(
                    width: 90 * size.width / 100,
                    child: kTxt(
                      text:
                          'withdrawals typically takes 30 minutes to 1 hour to process. However, delays may occur due to bank processing times or incomplete account information',
                      size: 10,
                      weight: FontWeight.w300,
                      maxLine: 10,
                      color: kColors.textGrey,
                      textalign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
