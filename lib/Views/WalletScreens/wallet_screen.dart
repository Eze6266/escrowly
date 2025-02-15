import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/lazy_loader.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_balance_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/notification_detail_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_withdraw_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_escrows.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_withdraw.dart';
import 'package:trustbridge/Views/HomeScreens/top_up_screen.dart';
import 'package:trustbridge/Views/HomeScreens/topup_sheet.dart';
import 'package:trustbridge/Views/WalletScreens/see_all_topup_screen.dart';
import 'package:trustbridge/Views/WalletScreens/withdraw_detail_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool withdraw = true;
  bool topup = false;
  final pageviewController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);

    return RefreshIndicator(
      onRefresh: () {
        authProvider.getUser(context: context);
        authProvider.getNotifcations(context: context);

        trxnProvider.fetchAccNumbers(context: context);
        trxnProvider.fetchWalletTrxns(context: context);

        trxnProvider.fetchBalances(context: context);
        trxnProvider.fetchWithdrawals(context: context);

        trxnProvider.fetchBankList(context: context);
        orderProvider.fetchIncomingOrder(context: context);
        orderProvider.fetchTrxns(context: context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kColors.primaryColor,
          toolbarHeight: 0.001,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
          child: Column(
            children: [
              Height(h: 3),
              SizedBox(
                height: 16 * size.height / 100,
                child: PageView(
                  controller: pageviewController,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 1 * size.width / 100),
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
              Height(h: 2),
              GenBtn(
                size: size,
                width: 93,
                height: 5,
                btnColor: kColors.primaryColor,
                txtColor: kColors.whiteColor,
                btnText: 'Fund Wallet',
                textSize: 13,
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
                },
              ),
              Height(h: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TabTitle(
                    txt: 'Withdrawal history',
                    active: withdraw,
                    onTap: () {
                      setState(() {
                        topup = false;
                        withdraw = true;
                      });
                    },
                  ),
                  Width(w: 8),
                  TabTitle(
                    txt: 'Topup history',
                    active: topup,
                    onTap: () {
                      setState(() {
                        topup = true;
                        withdraw = false;
                      });
                    },
                  ),
                ],
              ),
              Height(h: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: withdraw
                        ? ' Withdrawal Transactions'
                        : 'Topup Transactions',
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  GestureDetector(
                    onTap: () {
                      withdraw
                          ? goTo(context, SeeAllWithdrawScreen())
                          : goTo(context, SeeAllTopupScreen());
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
              Height(h: 2),
              withdraw
                  ? trxnProvider.fetchWithdrawalsIsLoading
                      ? Center(
                          child: OngoingLoader(),
                        )
                      : Expanded(
                          child: trxnProvider.withdrawlist.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        kImages.emptysvg,
                                        height: 5 * size.height / 100,
                                      ),
                                      Height(h: 1),
                                      kTxt(
                                        text:
                                            'Your withdrawals are displayed here\n Looks like you dont\'t have any',
                                        textalign: TextAlign.center,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      trxnProvider.withdrawlist.length > 18
                                          ? 18
                                          : trxnProvider.withdrawlist.length,
                                  itemBuilder: (context, index) {
                                    var wallet =
                                        trxnProvider.withdrawlist[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 0.8 * size.height / 100),
                                      child: GestureDetector(
                                        onTap: () {
                                          goTo(
                                              context,
                                              WithdrawDetailScreen(
                                                amount: formatNumberWithCommas(
                                                    wallet['amount']
                                                        .toString()),
                                                statusTxt: getWithdrawStatusTxt(
                                                    wallet['status']
                                                        .toString()),
                                                statusColor: getStatusTxtColor(
                                                    wallet['status']
                                                        .toString()),
                                                accname: wallet['accountname']
                                                    .toString(),
                                                accNum: wallet['accountnumber']
                                                    .toString(),
                                                bankName: wallet['bankname']
                                                    .toString(),
                                                dateTime:
                                                    '${formatDateTime(wallet['created_at'])}',
                                                withdrawId:
                                                    wallet['withdrawalid']
                                                        .toString(),
                                                description: wallet['narration']
                                                    .toString(),
                                              ));
                                          // showWithdrawDetailDialog(
                                          // dateTime:
                                          //     '${formatDateTime(wallet['created_at'])}',
                                          // description: wallet['narration'].toString(),
                                          // accName: wallet['accountname'].toString(),
                                          // accNumber: wallet['accountnumber'].toString(),
                                          // bankName: wallet['bankname'].toString(),
                                          //   context: context,
                                          // title: wallet['withdrawalid'].toString(),
                                          //   status: wallet['status'].toString(),
                                          //   amount: formatNumberWithCommas(
                                          //       wallet['amount'].toString()),
                                          // );
                                        },
                                        child: WalletTransactionTile(
                                          bank: wallet['bankname'].toString(),
                                          status: wallet['status'].toString(),
                                          type: '2',
                                          amount: formatNumberWithCommas(
                                              wallet['amount'].toString()),
                                          datetime:
                                              '${formatDateTime(wallet['created_at'])}',
                                          title: '',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        )
                  : trxnProvider.fetchWalletTrxnsIsLoading
                      ? Center(
                          child: OngoingLoader(),
                        )
                      : Expanded(
                          child: trxnProvider.topupList.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        kImages.emptysvg,
                                        height: 5 * size.height / 100,
                                      ),
                                      Height(h: 1),
                                      kTxt(
                                        text:
                                            'Your topups are displayed here\n Looks like you dont\'t have any',
                                        textalign: TextAlign.center,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: trxnProvider.topupList.length > 18
                                      ? 18
                                      : trxnProvider.topupList.length,
                                  itemBuilder: (context, index) {
                                    var wallet = trxnProvider.topupList[index];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 0.8 * size.height / 100),
                                      child: GestureDetector(
                                        onTap: () {
                                          // goTo(
                                          //     context,
                                          //     WithdrawDetailScreen(
                                          //       amount: formatNumberWithCommas(
                                          //           wallet['amount'].toString()),
                                          //       statusTxt: getWithdrawStatusTxt(
                                          //           wallet['status'].toString()),
                                          //       statusColor: getStatusTxtColor(
                                          //           wallet['status'].toString()),
                                          //     ));
                                          // showWithdrawDetailDialog(
                                          //   dateTime:
                                          //       '${formatDateTime(wallet['created_at'])}',
                                          //   description: wallet['narration'].toString(),
                                          //   accName: wallet['accountname'].toString(),
                                          //   accNumber: wallet['accountnumber'].toString(),
                                          //   bankName: wallet['bankname'].toString(),
                                          //   context: context,
                                          //   title: wallet['withdrawalid'].toString(),
                                          //   status: wallet['status'].toString(),
                                          // amount: formatNumberWithCommas(
                                          //     wallet['amount'].toString()),
                                          // );
                                        },
                                        child: TopupTransactionTile(
                                          status: wallet['status'].toString(),
                                          amount: formatNumberWithCommas(
                                              wallet['amount'].toString()),
                                          datetime:
                                              '${formatDateTime(wallet['created_at'])}',
                                          name: wallet['description'],
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
    );
  }
}

class TabTitle extends StatelessWidget {
  TabTitle({
    super.key,
    required this.txt,
    required this.onTap,
    required this.active,
  });
  String txt;
  Function() onTap;
  bool active;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            kTxt(
              text: '$txt',
              size: 14,
              color: active
                  ? kColors.primaryColor
                  : kColors.textGrey.withOpacity(0.8),
              weight: active ? FontWeight.w500 : FontWeight.w300,
            ),
            Height(h: 0.5),
            Container(
              height: 0.15 * size.height / 100,
              width: 14 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: active ? kColors.primaryColor : kColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
