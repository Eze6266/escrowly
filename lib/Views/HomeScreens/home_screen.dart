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
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/Functions/greetings_function.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/lazy_loader.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_balance_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_top_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/select_bank_sheet.dart';
import 'package:trustbridge/Views/HomeScreens/Components/setup_trxn_pin.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_add_new_bank_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_withdraw_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/full_escrow_detail_screen.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/select_type_screen.dart';
import 'package:trustbridge/Views/HomeScreens/full_incoming_trxn.dart';
import 'package:trustbridge/Views/HomeScreens/notification_screen.dart';
import 'package:trustbridge/Views/HomeScreens/recent_order_full_screen.dart';
import 'package:trustbridge/Views/HomeScreens/recent_transaction_screen.dart';
import 'package:trustbridge/Views/HomeScreens/running_orders_full_detail.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_escrows.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_incoming.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_trxn_screen.dart';
import 'package:trustbridge/Views/HomeScreens/top_up_screen.dart';
import 'package:trustbridge/Views/HomeScreens/topup_sheet.dart';
import 'package:trustbridge/Views/HomeScreens/trxn_full_detail_screen.dart';
import 'package:trustbridge/Views/SupportScreens/support_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageviewController = PageController();

  bool showRunning = false;
  bool showIncomingOrder = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var trxnProvider = Provider.of<TransactionProvider>(context, listen: false);
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPrefs();
      authProvider.getUser(context: context);
      authProvider.getNotifcations(context: context);
      authProvider.checkUserPin(context: context);

      trxnProvider.fetchAccNumbers(context: context);
      trxnProvider.fetchWalletTrxns(context: context);

      trxnProvider.fetchBalances(context: context);
      trxnProvider.fetchWithdrawals(context: context);

      trxnProvider.fetchBankList(context: context);
      orderProvider.fetchIncomingOrder(context: context);
      orderProvider.fetchTrxns(context: context);
      orderProvider.fetchRecenttrxn(context: context);
    });
  }

  void initPrefs() {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.checkUserPin(context: context).then((value) {
      if (value == 'success') {
      } else {
        showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          builder: (context) => SetupPinSheet(),
        );
      }
    });
  }

  bool acceptOrderIsLoading = false;
  bool rejectOrderIsLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);
    // acceptOrderIsLoading =
    //     Provider.of<OrderProvider>(context).acceptOrderIsLoading;
    // rejectOrderIsLoading =
    //     Provider.of<OrderProvider>(context).rejectOrderIsLoading;

    return RefreshIndicator(
      onRefresh: () {
        authProvider.getUser(context: context);
        authProvider.getNotifcations(context: context);
        authProvider.checkUserPin(context: context);

        trxnProvider.fetchAccNumbers(context: context);
        trxnProvider.fetchWalletTrxns(context: context);

        trxnProvider.fetchBalances(context: context);
        trxnProvider.fetchWithdrawals(context: context);

        trxnProvider.fetchBankList(context: context);
        orderProvider.fetchIncomingOrder(context: context);
        orderProvider.fetchTrxns(context: context);
        orderProvider.fetchRecenttrxn(context: context);

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: kColors.whiteColor,
        appBar: AppBar(
          backgroundColor: kColors.primaryColor,
          toolbarHeight: 0.001,
        ),
        body: Padding(
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
                supportTap: () {
                  goTo(context, SupportScreen());
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
                  dotHeight: 2,
                  dotWidth: 10 * size.width / 100,
                  spacing: 4,
                  radius: 100,
                  activeDotColor: kColors.primaryColor,
                  type: WormType.normal,
                ),
                count: 2,
                controller: pageviewController,
              ),

              Height(h: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GenBtnWSvg(
                      imgurl: kImages.createordersvg,
                      borderRadius: 5,
                      size: size,
                      width: 29,
                      height: 4.5,
                      btnColor: kColors.dimPrimary,
                      borderColor: kColors.primaryColor,
                      txtColor: kColors.primaryColor,
                      btnText: 'Create order',
                      textSize: 11,
                      tap: () {
                        goTo(context, SelectTypeScreen());
                      }),
                  GenBtnWSvg(
                      imgurl: kImages.fundsvg,
                      borderColor: kColors.primaryColor,
                      borderRadius: 5,
                      size: size,
                      width: 29,
                      height: 4.5,
                      btnColor: kColors.dimPrimary,
                      txtColor: kColors.primaryColor,
                      btnText: 'Fund Wallet',
                      textSize: 11,
                      tap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          builder: (context) => TopupSheet(),
                        );
                        //    goTo(context, TopUpScreen());
                      }),
                  GenBtnWSvg(
                    imgurl: kImages.withdrawsvg,
                    borderRadius: 5,
                    size: size,
                    borderColor: kColors.primaryColor,
                    width: 29,
                    height: 4.5,
                    btnColor: kColors.dimPrimary,
                    txtColor: kColors.primaryColor,
                    btnText: 'Withdraw',
                    textSize: 11,
                    tap: () {
                      showWithdrawFundsDialog(context);
                    },
                  ),
                ],
              ),
              Height(h: 2),
              Height(h: 0.3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: '  Show Incoming Escrows',
                    size: 12,
                    weight: FontWeight.w500,
                  ),
                  Switch(
                    activeColor: kColors.primaryColor,
                    value: showIncomingOrder,
                    onChanged: (value) {
                      setState(() {
                        showIncomingOrder = !showIncomingOrder;
                      });
                    },
                  ),
                ],
              ),
              showIncomingOrder ? Height(h: 1) : SizedBox.shrink(),
              showIncomingOrder
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        kTxt(
                          text: '  Incoming Orders',
                          size: 13,
                          weight: FontWeight.w500,
                        ),
                        orderProvider.runningOrders.isEmpty
                            ? SizedBox.shrink()
                            : GestureDetector(
                                onTap: () {
                                  goTo(context, SeeAllIncomingOrdersScreen());
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
              showIncomingOrder
                  ? orderProvider.fetchIncomingOrderisLoading
                      ? Center(
                          child: SizedBox(
                            height: 12 * size.height / 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return IncomingLoader();
                              },
                            ),
                          ),
                        )
                      : orderProvider.incomingOrders.isEmpty
                          ? kTxt(text: 'You have no incoming order')
                          : SizedBox(
                              height: 17 * size.height / 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    orderProvider.incomingOrders.length > 10
                                        ? 10
                                        : orderProvider.incomingOrders.length,
                                itemBuilder: (context, index) {
                                  var order =
                                      orderProvider.incomingOrders[index];
                                  bool isAcceptLoading =
                                      orderProvider.acceptOrderLoading[
                                              order['id'].toString()] ??
                                          false;
                                  bool isRejectLoading =
                                      orderProvider.rejectOrderLoading[
                                              order['id'].toString()] ??
                                          false;

                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: 1.5 * size.width / 100,
                                      bottom: 1 * size.height / 100,
                                    ),
                                    child: IncomingOrdersBox(
                                      title: order['title'].toString(),
                                      isAcceptLoading: isAcceptLoading,
                                      isRejectLoading: isRejectLoading,
                                      width:
                                          orderProvider.incomingOrders.length ==
                                                  1
                                              ? 93
                                              : null,
                                      orderID:
                                          order['reference_code'].toString(),
                                      userid: order['userid'].toString(),
                                      description:
                                          order['description'].toString(),
                                      amount: formatNumberWithCommas(
                                          order['amount'].toString()),
                                      fee: formatNumberWithCommas(
                                          order['fee'].toString()),
                                      date: formatDateTime(order['created_at']),
                                      sender: order['created_by'].toString(),
                                      type: order['role'],
                                      viewTap: () {
                                        goTo(
                                            context,
                                            FullIncomingOrderScreen(
                                              title: order['title'].toString(),
                                              userId:
                                                  order['userid'].toString(),
                                              orderid: order['id'].toString(),
                                              amount: formatNumberWithCommas(
                                                  order['amount'].toString()),
                                              fee: formatNumberWithCommas(
                                                  order['fee'].toString()),
                                              date: formatDateTime(
                                                  order['created_at']),
                                              name: order['role'] == 'Selling'
                                                  ? order['seller']['firstname']
                                                  : order['buyer']['firstname'],
                                              phone: order['role'] == 'Selling'
                                                  ? order['seller']['firstname']
                                                  : order['buyer']['phone']
                                                      .toString(),
                                              total: formatNumberWithCommas(
                                                  order['total_amount']
                                                      .toString()),
                                              feepayer:
                                                  order['escrow_fee_payer'],
                                              type: order['role'],
                                              description: order['description'],
                                            ));
                                      },
                                      acceptTap: () {
                                        orderProvider
                                            .acceptOrder(
                                                orderid: order['id'].toString(),
                                                context: context)
                                            .then((value) {
                                          if (value == 'success') {
                                            trxnProvider.fetchWalletTrxns(
                                                context: context);
                                            trxnProvider.fetchBalances(
                                                context: context);
                                            orderProvider.fetchIncomingOrder(
                                                context: context);
                                          } else {
                                            showCustomErrorToast(
                                                context,
                                                orderProvider
                                                    .acceptOrderMessage);
                                          }
                                        });
                                      },
                                      rejectTap: () {
                                        orderProvider
                                            .rejectOrder(
                                                orderid: order['id'].toString(),
                                                context: context)
                                            .then((value) {
                                          if (value == 'success') {
                                            trxnProvider.fetchWalletTrxns(
                                                context: context);
                                            trxnProvider.fetchBalances(
                                                context: context);
                                            orderProvider.fetchIncomingOrder(
                                                context: context);
                                          } else {
                                            showCustomErrorToast(
                                                context,
                                                orderProvider
                                                    .acceptOrderMessage);
                                          }
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            )
                  : SizedBox.shrink(),
              // Height(h: 0.3),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     kTxt(
              //       text: '  Show Running Escrows',
              //       size: 12,
              //       weight: FontWeight.w500,
              //     ),
              //     Switch(
              //       activeColor: kColors.primaryColor,
              //       value: showRunning,
              //       onChanged: (value) {
              //         setState(() {
              //           showRunning = !showRunning;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              // showRunning ? Height(h: 1) : SizedBox.shrink(),
              // showRunning
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           kTxt(
              //             text: '  Running Escrows',
              //             size: 13,
              //             weight: FontWeight.w500,
              //           ),
              //           orderProvider.runningOrders.isEmpty
              //               ? SizedBox.shrink()
              //               : GestureDetector(
              //                   onTap: () {
              //                     goTo(context, SeeAllescrowsScreen());
              //                   },
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.end,
              //                     children: [
              //                       kTxt(
              //                         text: 'View all',
              //                         size: 13,
              //                         weight: FontWeight.w500,
              //                         color: kColors.textGrey,
              //                       ),
              //                       Icon(
              //                         Icons.arrow_forward,
              //                         color: kColors.textGrey,
              //                         size: 14,
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //         ],
              //       )
              //     : SizedBox.shrink(),
              // Height(h: 1),
              // showRunning
              //     ? orderProvider.fetchTrxnsisLoading
              //         ? Center(
              //             child: kTxt(text: 'Fetching transactions...'),
              //           )
              //         : orderProvider.runningOrders.isEmpty
              //             ? kTxt(text: 'You have no running order')
              //             : SizedBox(
              //                 height: 10 * size.height / 100,
              //                 child: ListView.builder(
              //                   scrollDirection: Axis.horizontal,
              //                   itemCount:
              //                       orderProvider.runningOrders.length,
              //                   itemBuilder: (context, index) {
              //                     var order =
              //                         orderProvider.runningOrders[index];
              //                     return Padding(
              //                       padding: EdgeInsets.only(
              //                         right: 1.5 * size.width / 100,
              //                         bottom: 1 * size.height / 100,
              //                       ),
              //                       child: GestureDetector(
              //                         onTap: () {
              //                           goTo(
              //                               context,
              //                               FullRunningOrderScreen(
              //                                 orderid:
              //                                     order['id'].toString(),
              //                                 amount:
              //                                     formatNumberWithCommas(
              //                                         order['amount']
              //                                             .toString()),
              //                                 fee: formatNumberWithCommas(
              //                                     order['fee'].toString()),
              //                                 date: formatDateTime(
              //                                     order['created_at']),
              //                                 name:
              //                                     order['role'] == 'Selling'
              //                                         ? order['seller']
              //                                             ['firstname']
              //                                         : order['buyer']
              //                                             ['firstname'],
              //                                 phone: order['role'] ==
              //                                         'Selling'
              //                                     ? order['seller']
              //                                         ['firstname']
              //                                     : order['buyer']['phone']
              //                                         .toString(),
              //                                 total: formatNumberWithCommas(
              //                                     order['total_amount']
              //                                         .toString()),
              //                                 feepayer:
              //                                     order['escrow_fee_payer'],
              //                                 type: order['role'],
              //                                 description:
              //                                     order['description'],
              //                               ));
              //                         },
              //                         child: PendingEscrowsBox(
              //                           product:
              //                               order['description'].toString(),
              //                           amount: formatNumberWithCommas(
              //                             order['amount'].toString(),
              //                           ),
              //                           type: order['role'].toString(),
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                 ),
              //               )
              //     : SizedBox.shrink(),
              Height(h: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: '  Ongoing orders',
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  orderProvider.runningOrders.isEmpty
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            goTo(context, SeeAllescrowsScreen());
                          },
                          child: kTxt(
                            text:
                                'View all(${orderProvider.runningOrders.length})',
                            size: 13,
                            weight: FontWeight.w500,
                            color: kColors.textGrey,
                          ),
                        ),
                ],
              ),
              Height(h: 1),
              Expanded(
                child: orderProvider.fetchTrxnsisLoading
                    ? Center(
                        child: OngoingLoader(),
                      )
                    : orderProvider.runningOrders.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                kImages.emptysvg,
                                height: 5 * size.height / 100,
                              ),
                              Height(h: 1),
                              kTxt(
                                text:
                                    'Your active orders are displayed here\n Looks like you dont\'t have any',
                                textalign: TextAlign.center,
                                size: 12,
                              )
                            ],
                          )
                        : ListView.builder(
                            itemCount: orderProvider.runningOrders.length,
                            itemBuilder: (context, index) {
                              var order = orderProvider.runningOrders[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: 1.5 * size.width / 100,
                                  bottom: 1.4 * size.height / 100,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    goTo(
                                        context,
                                        FullRunningOrderScreen(
                                          title: order['title'].toString(),
                                          orderid: order['id'].toString(),
                                          amount: formatNumberWithCommas(
                                              order['amount'].toString()),
                                          fee: formatNumberWithCommas(
                                              order['fee'].toString()),
                                          date: formatDateTime(
                                              order['created_at']),
                                          name: order['role'] == 'Selling'
                                              ? order['seller']['firstname']
                                              : order['buyer']['firstname'],
                                          phone: order['role'] == 'Selling'
                                              ? order['seller']['firstname']
                                              : order['buyer']['phone']
                                                  .toString(),
                                          total: formatNumberWithCommas(
                                              order['total_amount'].toString()),
                                          feepayer: order['escrow_fee_payer'],
                                          type: order['role'],
                                          description: order['description'],
                                        ));
                                  },
                                  child: PendingEscrowsBox(
                                    title: order['title'].toString(),
                                    date: order['created_at'].toString(),
                                    reference:
                                        order['reference_code'].toString(),
                                    product: order['description'].toString(),
                                    amount: formatNumberWithCommas(
                                      order['amount'].toString(),
                                    ),
                                    type: order['role'].toString(),
                                  ),
                                ),
                              );
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
