// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/greetings_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_balance_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_top_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List img = [
    kImages.onboard,
    kImages.onboard2,
    kImages.onboard1,
    kImages.onboard
  ];
  List type = [
    '1',
    '2',
    '1',
    '2',
  ];
  List amount = ['30000', '13000', '100000', '5000'];
  List product = [
    'Tecno spark 4 phone 254g Ram',
    'Cinderella glass shoes',
    'Royce Black watch diamond',
    'Figo belt',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //   backgroundColor: kColors.primaryAccent.withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              Height(h: 2),
              HomeTopWidget(
                name: 'Emmanuel',
                img: kImages.onboard,
                bellTap: () {},
              ),
              Height(h: 2),
              HomeBalanceCard(
                amount: '350000',
                withdraw: () {},
              ),
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GenBtn(
                    size: size,
                    width: 43,
                    height: 5,
                    btnColor: kColors.blackColor,
                    txtColor: kColors.whiteColor,
                    btnText: 'Add Funds',
                    textSize: 13,
                  ),
                  Width(w: 3),
                  GenBtn(
                    size: size,
                    width: 43,
                    height: 5,
                    btnColor: kColors.primaryColor,
                    txtColor: kColors.whiteColor,
                    btnText: 'Create Escrow',
                    textSize: 13,
                  ),
                ],
              ),
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: '  Running escrows',
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      kTxt(
                        text: 'View all',
                        size: 13,
                        weight: FontWeight.w500,
                        color: kColors.textGrey,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: kColors.textGrey,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
              Height(h: 1),
              SizedBox(
                height: 20 * size.height / 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: 1.5 * size.width / 100,
                        bottom: 1 * size.height / 100,
                      ),
                      child: PendingEscrowsBox(
                        product: product[index],
                        amount: amount[index],
                        img: img[index],
                        type: type[index],
                      ),
                    );
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