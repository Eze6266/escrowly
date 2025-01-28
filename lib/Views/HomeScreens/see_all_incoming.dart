import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/full_escrow_detail_screen.dart';
import 'package:trustbridge/Views/HomeScreens/full_incoming_trxn.dart';
import 'package:trustbridge/Views/HomeScreens/recent_order_full_screen.dart';
import 'package:trustbridge/Views/HomeScreens/trxn_full_detail_screen.dart';

class SeeAllIncomingOrdersScreen extends StatefulWidget {
  const SeeAllIncomingOrdersScreen({super.key});

  @override
  State<SeeAllIncomingOrdersScreen> createState() =>
      _SeeAllIncomingOrdersScreenState();
}

class _SeeAllIncomingOrdersScreenState
    extends State<SeeAllIncomingOrdersScreen> {
  bool acceptOrderIsLoading = false;
  bool rejectOrderIsLoading = false;
  String _searchQuery = ''; // Store the search query

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);
    var trxnProvider = Provider.of<TransactionProvider>(context);

    // Filter transactions based on the search query
    List filteredTransactions = orderProvider.incomingOrders
        .where((order) =>
            order['reference_code'].toString().toLowerCase().contains(
                _searchQuery.toLowerCase()) || // Search by description
            order['created_by']
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
                  (acceptOrderIsLoading || rejectOrderIsLoading)
                      ? SizedBox.shrink()
                      : BckBtn(),
                  Width(w: 18),
                  kTxt(
                    text: 'Incoming Escrows',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 2),
              TitleTField(
                hasTitle: false,
                hint: 'Search escrows',
                suffixIcon: Icon(Icons.search),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Update the search query
                  });
                },
              ),
              Height(h: 3),
              orderProvider.fetchIncomingOrderisLoading
                  ? kTxt(text: 'Loading...')
                  : Expanded(
                      child: filteredTransactions.isEmpty
                          ? Center(
                              child: kTxt(text: 'No incoming orders'),
                            )
                          : ListView.builder(
                              itemCount: orderProvider.incomingOrders.length,
                              itemBuilder: (context, index) {
                                var order = orderProvider.incomingOrders[index];
                                bool isAcceptLoading = orderProvider
                                        .acceptOrderLoading[order['id']] ??
                                    false;
                                bool isRejectLoading = orderProvider
                                        .rejectOrderLoading[order['id']] ??
                                    false;

                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: 1.5 * size.width / 100,
                                    bottom: 1 * size.height / 100,
                                  ),
                                  child: IncomingOrdersBox(
                                    isAcceptLoading: isAcceptLoading,
                                    isRejectLoading: isRejectLoading,
                                    width:
                                        orderProvider.incomingOrders.length == 1
                                            ? 93
                                            : null,
                                    orderID: order['reference_code'].toString(),
                                    userid: order['userid'].toString(),
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
                                            feepayer: order['escrow_fee_payer'],
                                            type: order['role'],
                                            description: order['description'],
                                          ));
                                    },
                                    acceptTap: () {
                                      orderProvider
                                          .acceptOrder(
                                              orderid: order['id'],
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
                                          showCustomErrorToast(context,
                                              orderProvider.acceptOrderMessage);
                                        }
                                      });
                                    },
                                    rejectTap: () {
                                      orderProvider
                                          .rejectOrder(
                                              orderid: order['id'],
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
                                          showCustomErrorToast(context,
                                              orderProvider.acceptOrderMessage);
                                        }
                                      });
                                    },
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
