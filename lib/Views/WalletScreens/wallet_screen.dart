import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/home_balance_widget.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/show_withdraw_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_escrows.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_withdraw.dart';
import 'package:trustbridge/Views/HomeScreens/top_up_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final pageviewController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
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
            GenBtn(
              size: size,
              width: 93,
              height: 5,
              btnColor: kColors.primaryColor,
              txtColor: kColors.whiteColor,
              btnText: 'Fund Wallet',
              textSize: 13,
              tap: () {
                goTo(context, TopUpScreen());
              },
            ),
            Height(h: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kTxt(
                  text: ' Wallet Transactions',
                  size: 13,
                  weight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () {
                    goTo(context, SeeAllWithdrawScreen());
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
            Expanded(
              child: ListView.builder(
                itemCount: trxnProvider.withdrawlist.length > 18
                    ? 18
                    : trxnProvider.withdrawlist.length,
                itemBuilder: (context, index) {
                  var wallet = trxnProvider.withdrawlist[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 0.8 * size.height / 100),
                    child: GestureDetector(
                      onTap: () {},
                      child: WalletTransactionTile(
                        status: wallet['status'].toString(),
                        type: '2',
                        amount:
                            formatNumberWithCommas(wallet['amount'].toString()),
                        datetime:
                            '${formatDateTime(wallet['created_at'])} ${formatTime(wallet['created_at'])}',
                        title: '',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
