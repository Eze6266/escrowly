import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/lazy_loader.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/notification_detail_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/trxn_full_detail_screen.dart';

class SeeAllTopupScreen extends StatefulWidget {
  const SeeAllTopupScreen({super.key});

  @override
  State<SeeAllTopupScreen> createState() => _SeeAllTopupScreenState();
}

class _SeeAllTopupScreenState extends State<SeeAllTopupScreen> {
  String _searchQuery = ''; // Store the search query

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);

    // Filter the withdraw list based on the search query
    List filteredWithdrawList = trxnProvider.topupList
        .where((wallet) =>
            wallet['amount']
                .toString()
                .contains(_searchQuery) || // Search by amount
            wallet['status']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())) // Search by status
        .toList();

    return Scaffold(
      backgroundColor: kColors.whiteColor,
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
              Row(
                children: [
                  BckBtn(),
                  Width(w: 26),
                  kTxt(
                    text: 'Transactions',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 2),
              TitleTField(
                height: 5 * size.height / 100,
                hasTitle: false,
                hint: 'Search by amount or status',
                suffixIcon: Icon(Icons.search),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Update the search query
                  });
                },
              ),
              Height(h: 3),
              trxnProvider.fetchWalletTrxnsIsLoading
                  ? Center(
                      child: OngoingLoader(),
                    )
                  : Expanded(
                      child: filteredWithdrawList.isEmpty
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
                              itemCount: trxnProvider.topupList.length,
                              itemBuilder: (context, index) {
                                var wallet = filteredWithdrawList[index];
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
