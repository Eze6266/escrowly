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
                    text: 'Create order',
                    weight: FontWeight.w500,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: kTxt(
                  text: 'Choose your role',
                  color: kColors.textGrey,
                  weight: FontWeight.w500,
                  size: 14,
                ),
              ),
              Height(h: 5),
              Center(
                child: SelectTypeBtn(
                  txt: 'I am the seler',
                  txtColor: kColors.whiteColor,
                  iconColor: kColors.whiteColor,
                  borderColor: kColors.primaryColor,
                  btnColor: kColors.primaryColor,
                  img: kImages.iamseller,
                  onTap: () {
                    goTo(context, CreateSellerEscrowScreen());
                  },
                ),
              ),
              Height(h: 3),
              SelectTypeBtn(
                txt: 'I am the buyer',
                txtColor: kColors.blackColor.withOpacity(0.8),
                borderColor: kColors.textGrey.withOpacity(0.6),
                btnColor: kColors.whiteColor,
                img: kImages.iambuyer,
                onTap: () {
                  goTo(context, CreateBuyerEscrowScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
