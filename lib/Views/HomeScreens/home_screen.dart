// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/greetings_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_balance_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_top_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/select_bank_sheet.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_add_new_bank_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_withdraw_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/full_escrow_detail_screen.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/select_type_screen.dart';
import 'package:trustbridge/Views/HomeScreens/notification_screen.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_escrows.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_trxn_screen.dart';
import 'package:trustbridge/Views/HomeScreens/top_up_screen.dart';
import 'package:trustbridge/Views/HomeScreens/trxn_full_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageviewController = PageController();

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
  List fee = ['20', '90', '200', '10'];
  List date = [
    'December 23, 2024',
    'January 12, 2025',
    'October 04, 2023',
    'December 23, 2024',
  ];

  List product = [
    'Tecno spark 4 phone 254g Ram',
    'Cinderella glass shoes',
    'Royce Black watch diamond',
    'Figo belt',
  ];

  List typeT = ['1', '2', '3', '4'];
  List status = ['1', '2', '3', '4'];
  bool showRunning = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var trxnProvider = Provider.of<TransactionProvider>(context, listen: false);
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authProvider.getUser(context: context);
      trxnProvider.fetchAccNumbers(context: context);
      trxnProvider.fetchBalances(context: context);
      trxnProvider.fetchBankList(context: context);
      orderProvider.fetchIncomingOrder(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);

    return RefreshIndicator(
      onRefresh: () {
        authProvider.getUser(context: context);
        trxnProvider.fetchAccNumbers(context: context);
        trxnProvider.fetchBalances(context: context);
        trxnProvider.fetchBankList(context: context);
        orderProvider.fetchIncomingOrder(context: context);

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: kColors.whitishGrey.withOpacity(0.2),
        appBar: AppBar(
          backgroundColor: kColors.primaryColor,
          toolbarHeight: 0.001,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
            child: Column(
              children: [
                Height(h: 1.3),
                HomeTopWidget(
                  name: authProvider.userName ?? 'User',
                  img: kImages.onboard,
                  bellTap: () {
                    goTo(context, NotificationScreen());
                  },
                ),
                Height(h: 1.2),
                SizedBox(
                  height: 16 * size.height / 100,
                  child: PageView(
                    controller: pageviewController,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 2 * size.width / 100),
                        child: HomeBalanceCard(
                          amount: trxnProvider.walletBalance ?? '---',
                          withdraw: () {
                            showWithdrawFundsDialog(context);
                          },
                        ),
                      ),
                      HomePayoutBalanceCard(
                        amount: trxnProvider.payoutBalance ?? '---',
                        withdraw: () {
                          showWithdrawFundsDialog(context);
                        },
                      ),
                    ],
                  ),
                ),
                Height(h: 1),
                SmoothPageIndicator(
                  effect: WormEffect(
                    dotColor: Color.fromARGB(255, 214, 212, 212),
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 4,
                    radius: 100,
                    activeDotColor: kColors.primaryColor,
                    type: WormType.normal,
                  ),
                  count: 2,
                  controller: pageviewController,
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
                        btnText: 'Fund Wallet',
                        textSize: 13,
                        tap: () {
                          goTo(context, TopUpScreen());
                        }),
                    Width(w: 3),
                    GenBtn(
                      size: size,
                      width: 43,
                      height: 5,
                      btnColor: kColors.primaryColor,
                      txtColor: kColors.whiteColor,
                      btnText: 'Create Escrow',
                      textSize: 13,
                      tap: () {
                        goTo(context, SelectTypeScreen());
                      },
                    ),
                  ],
                ),
                Height(h: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kTxt(
                      text: '  Incoming Orders',
                      size: 13,
                      weight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: () {
                        goTo(context, SeeAllescrowsScreen());
                      },
                      child: Row(
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
                    ),
                  ],
                ),
                Height(h: 1),
                SizedBox(
                  height: 24 * size.height / 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: 1.5 * size.width / 100,
                          bottom: 1 * size.height / 100,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            goTo(context, FullEscrowDetailScreen());
                          },
                          child: IncomingOrdersBox(
                            amount: amount[index],
                            fee: fee[index],
                            date: date[index],
                            viewTap: () {},
                            acceptTap: () {},
                            rejectTap: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Height(h: 0.3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kTxt(
                      text: '  Show Running Escrows',
                      size: 12,
                      weight: FontWeight.w500,
                    ),
                    Switch(
                      activeColor: kColors.primaryColor,
                      value: showRunning,
                      onChanged: (value) {
                        setState(() {
                          showRunning = !showRunning;
                        });
                      },
                    ),
                  ],
                ),
                showRunning ? Height(h: 1) : SizedBox.shrink(),
                showRunning
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          kTxt(
                            text: '  Running Escrows',
                            size: 13,
                            weight: FontWeight.w500,
                          ),
                          GestureDetector(
                            onTap: () {
                              goTo(context, SeeAllescrowsScreen());
                            },
                            child: Row(
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
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                Height(h: 1),
                showRunning
                    ? SizedBox(
                        height: 10 * size.height / 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: 1.5 * size.width / 100,
                                bottom: 1 * size.height / 100,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  goTo(context, FullEscrowDetailScreen());
                                },
                                child: PendingEscrowsBox(
                                  product: product[index],
                                  amount: amount[index],
                                  img: img[index],
                                  type: type[index],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                Height(h: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    kTxt(
                      text: '  Recent Transactions',
                      size: 13,
                      weight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: () {
                        goTo(context, SeeAllTrxnScreen());
                      },
                      child: Row(
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
                    ),
                  ],
                ),
                Height(h: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: status.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(bottom: 0.8 * size.height / 100),
                        child: GestureDetector(
                          onTap: () {
                            goTo(context, TrxnFullDetailScreen());
                          },
                          child: RecentTransactionTile(
                            status: status[index],
                            type: typeT[index],
                            amount: amount[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
