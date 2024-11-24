import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/create_buyer_escrow_screen.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/create_seller_escrow_screen.dart';

class SelectTypeScreen extends StatefulWidget {
  const SelectTypeScreen({super.key});

  @override
  State<SelectTypeScreen> createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kColors.whiteColor,
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5 * size.width / 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Height(h: 2),
              Row(
                children: [
                  BckBtn(),
                  Width(w: 26),
                  kTxt(
                    text: 'Select Type',
                    weight: FontWeight.w500,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 30),
              Center(
                child: SelectTypeBtn(
                  txt: 'I AM THE BUYER',
                  txtColor: kColors.whiteColor,
                  borderColor: kColors.primaryColor,
                  btnColor: kColors.primaryColor,
                  img: kImages.buyer,
                  onTap: () {
                    goTo(context, CreateBuyerEscrowScreen());
                  },
                ),
              ),
              Height(h: 3),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 4,
                child: SelectTypeBtn(
                  txt: 'I AM THE SELLER',
                  txtColor: kColors.primaryColor,
                  borderColor: kColors.primaryColor,
                  btnColor: kColors.whiteColor,
                  img: kImages.seller,
                  onTap: () {
                    goTo(context, CreateSellerEscrowScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
