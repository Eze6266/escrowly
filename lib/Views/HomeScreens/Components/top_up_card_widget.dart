import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class AccountNumberCard extends StatelessWidget {
  AccountNumberCard({
    super.key,
    required this.size,
    required this.accName,
    required this.accNumber,
    required this.bankName,
    required this.gradColor,
    required this.gradColor2,
    required this.onTap,
  });

  final Size size;

  String accNumber, accName, bankName;
  Color gradColor, gradColor2;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 20 * size.height / 100,
      width: 95 * size.width / 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: 5,
          image: AssetImage(kImages.appword),
          opacity: 0.25,
          alignment: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        // color: Colors.orange,
        gradient: LinearGradient(
          colors: [
            gradColor,
            gradColor2,
          ], // Define your gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kTxt(
                color: Colors.white,
                size: 13.0,
                text: 'Escrowly Account',
                weight: FontWeight.w400,
              ),
              kTxt(
                color: Colors.white,
                size: 14.0,
                text: '$bankName',
                weight: FontWeight.w500,
              ),
            ],
          ),
          Height(h: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(5),
                height: 4.5 * size.height / 100,
                width: 35 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$accNumber',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Width(w: 2),
                    SvgPicture.asset(
                      kImages.copyIcon,
                      color: Colors.white,
                      height: 2 * size.height / 100,
                      width: 3 * size.width / 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Height(h: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 52 * size.width / 100,
                child: Text(
                  accName,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              kTxt(
                color: kColors.whiteColor,
                size: 12.0,
                text: '0 Fees',
                weight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
