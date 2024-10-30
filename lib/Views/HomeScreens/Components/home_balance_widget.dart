import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4 * size.width / 100,
        vertical: 1 * size.height / 100,
      ),
      height: 16 * size.height / 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: LinearGradient(
          colors: [
            kColors.primaryColor,
            kColors.darkPrimaryColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: kTxt(
              text: 'Wallet Balance',
              color: kColors.whiteColor,
              weight: FontWeight.w400,
            ),
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
                  color: kColors.whiteColor,
                  size: 20,
                ),
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
                    'ESCROWLY',
                    style: GoogleFonts.acme(
                      textStyle: TextStyle(
                        color: kColors.whiteColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                borderRadius: BorderRadius.circular(5),
                elevation: 2,
                child: GenBtn(
                  size: size,
                  width: 30,
                  borderRadius: 5,
                  height: 3.5,
                  btnColor: kColors.darkGreenColor,
                  btnText: 'Withdraw',
                  textSize: 14,
                  txtWeight: FontWeight.w500,
                  txtColor: kColors.whiteColor,
                  tap: widget.withdraw,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
