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
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/full_escrow_detail_screen.dart';
import 'package:trustbridge/Views/HomeScreens/running_orders_full_detail.dart';

class SeeAllescrowsScreen extends StatefulWidget {
  const SeeAllescrowsScreen({super.key});

  @override
  State<SeeAllescrowsScreen> createState() => _SeeAllescrowsScreenState();
}

class _SeeAllescrowsScreenState extends State<SeeAllescrowsScreen> {
  String _searchQuery = ''; // Store the search query

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);

    // Filter transactions based on the search query
    List filteredTransactions = orderProvider.runningOrders
        .where((order) =>
            order['title'].toString().toLowerCase().contains(
                _searchQuery.toLowerCase()) || // Search by description
            order['reference_code']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())) // Search by status
        .toList();

    return Scaffold(
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
                    text: 'Ongoing orders',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 2),
              TitleTField(
                radius: 10,
                hasTitle: false,
                hint: 'Search escrows by title or order reference',
                suffixIcon: Icon(
                  Icons.search,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Update the search query
                  });
                },
              ),
              Height(h: 3),
              Expanded(
                child: filteredTransactions.isEmpty
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
                                  'Your ongoing orders are displayed here\n Looks like you dont\'t have any',
                              textalign: TextAlign.center,
                              size: 12,
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredTransactions.length,
                        itemBuilder: (context, index) {
                          var order = filteredTransactions[index];
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
                                      status: order['status'].toString(),
                                      reference:
                                          order['reference_code'].toString(),
                                      title: order['title'].toString(),
                                      orderid: order['id'].toString(),
                                      amount: formatNumberWithCommas(
                                          order['amount'].toString()),
                                      fee: formatNumberWithCommas(
                                          order['fee'].toString()),
                                      date: formatDateTime(order['created_at']),
                                      name: order['role'] == 'Selling'
                                          ? order['seller']['firstname']
                                          : order['buyer']['firstname'],
                                      phone: order['role'] == 'Selling'
                                          ? order['seller']['firstname']
                                          : order['buyer']['phone'].toString(),
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
                                reference: order['reference_code'].toString(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
