import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/top_up_card_widget.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  void copyToClipboard(BuildContext context, accountNumber) {
    FlutterClipboard.copy(accountNumber).then((value) {
      Fluttertoast.showToast(
        msg: "Account number copied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColors.whiteColor,
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            Height(h: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BckBtn(),
                Width(w: 26),
                kTxt(
                  text: 'Fund Wallet',
                  size: 16,
                  weight: FontWeight.w400,
                ),
              ],
            ),
            Height(h: 3),
            kTxt(
              text:
                  'Make a transfer to your escrowly account number below to automatically topup your wallet',
              maxLine: 10,
              size: 12,
              weight: FontWeight.w600,
              textalign: TextAlign.center,
            ),
            Height(h: 2),
            AccountNumberCard(
              size: size,
              accNumber: '7067581951',
              accName: 'Emmanuel Ezejiobi',
              bankName: 'Opay',
              gradColor: kColors.primaryColor,
              gradColor2: kColors.primaryColor,
              onTap: () {
                copyToClipboard(context, '7067581951');
              },
            ),
          ],
        ),
      ),
    );
  }
}
