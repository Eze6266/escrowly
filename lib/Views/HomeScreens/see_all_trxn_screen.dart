import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/recent_order_full_screen.dart';
import 'package:trustbridge/Views/HomeScreens/trxn_full_detail_screen.dart';

class SeeAllTrxnScreen extends StatefulWidget {
  const SeeAllTrxnScreen({super.key});

  @override
  State<SeeAllTrxnScreen> createState() => _SeeAllTrxnScreenState();
}

class _SeeAllTrxnScreenState extends State<SeeAllTrxnScreen> {
  List selectedList = [];
  String _searchQuery = ''; // Store the search query

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);
    selectedList = orderProvider.trns;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);

    // Filter transactions based on the search query
    List filteredTransactions = selectedList
        .where((order) =>
            order['reference_code'].toString().toLowerCase().contains(
                _searchQuery.toLowerCase()) || // Search by description
            order['status']
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
                    text: 'Recent Orders',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 2),
              Padding(
                padding: EdgeInsets.only(right: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: HomeCustomDropdown(
                    initialValue: 'All orders',
                    onChanged: (value) {
                      print('Selected value: $value');
                      value == 'All orders'
                          ? selectedList = orderProvider.trns
                          : value == 'Pending'
                              ? selectedList = orderProvider.pendingOrders
                              : value == 'In progress'
                                  ? selectedList = orderProvider.runningOrders
                                  : value == 'Completed'
                                      ? selectedList =
                                          orderProvider.completedOrders
                                      : selectedList = orderProvider.trns;
                      setState(() {});
                    },
                  ),
                ),
              ),
              Height(h: 2),
              TitleTField(
                radius: 10,
                hasTitle: false,
                hint: 'Search transactions',
                suffixIcon: Icon(Icons.search),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Update the search query
                  });
                },
              ),
              Height(h: 3),
              orderProvider.fetchTrxnsisLoading
                  ? kTxt(text: 'Loading...')
                  : Expanded(
                      child: filteredTransactions.isEmpty
                          ? Center(
                              child: kTxt(
                                  text: selectedList == orderProvider.trns
                                      ? 'No orders yet'
                                      : selectedList ==
                                              orderProvider.pendingOrders
                                          ? 'No pending orders'
                                          : selectedList ==
                                                  orderProvider.runningOrders
                                              ? 'No running orders'
                                              : 'No completed orders'),
                            )
                          : ListView.builder(
                              itemCount: filteredTransactions.length,
                              itemBuilder: (context, index) {
                                var order = filteredTransactions[index];

                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 0.8 * size.height / 100),
                                  child: GestureDetector(
                                    onTap: () {
                                      goTo(
                                          context,
                                          FullRecentOrderScreen(
                                            status: order['status'].toString(),
                                            reference: order['reference_code']
                                                .toString(),
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
                                    child: RecentTransactionTile(
                                      sender: order['created_by'].toString(),
                                      fee: formatNumberWithCommas(
                                          order['fee'].toString()),
                                      description:
                                          order['description'].toString(),
                                      userid: order['userid'].toString(),
                                      status: order['status'].toString(),
                                      type: order['role'],
                                      amount: order['amount'].toString(),
                                      datetime: order['created_at'].toString(),
                                      title: order['reference_code'],
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
