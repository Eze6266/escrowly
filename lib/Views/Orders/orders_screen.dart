import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/select_type_screen.dart';
import 'package:trustbridge/Views/HomeScreens/recent_order_full_screen.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_trxn_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var trxnProvider = Provider.of<TransactionProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
        child: Column(
          children: [
            Height(h: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrdersChip(
                  title: 'Total Pending Orders',
                  count: '20',
                ),
                OrdersChip(
                  title: 'Total Completed Orders',
                  count: '20',
                ),
              ],
            ),
            Height(h: 2),
            GenBtn(
              size: size,
              width: 93,
              height: 5,
              btnColor: kColors.primaryColor,
              txtColor: kColors.whiteColor,
              btnText: 'Create Escrow',
              textSize: 13,
              tap: () {
                goTo(context, SelectTypeScreen());
              },
            ),
            Height(h: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kTxt(
                  text: '  Recent Orders',
                  size: 13,
                  weight: FontWeight.w500,
                ),
                orderProvider.trns.isEmpty
                    ? SizedBox.shrink()
                    : GestureDetector(
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
            orderProvider.fetchTrxnsisLoading
                ? Center(
                    child: kTxt(text: 'Loading...'),
                  )
                : orderProvider.trns.isEmpty
                    ? Center(
                        child: kTxt(text: 'No transactions yet'),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: orderProvider.trns.length > 10
                              ? 10
                              : orderProvider.trns.length,
                          itemBuilder: (context, index) {
                            var order = orderProvider.trns[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 0.8 * size.height / 100),
                              child: GestureDetector(
                                onTap: () {
                                  goTo(
                                      context,
                                      FullRecentOrderScreen(
                                        status: order['status'].toString(),
                                        orderid: order['id'].toString(),
                                        amount: formatNumberWithCommas(
                                            order['amount'].toString()),
                                        fee: formatNumberWithCommas(
                                            order['fee'].toString()),
                                        date:
                                            formatDateTime(order['created_at']),
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
                                child: RecentTransactionTile(
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
    );
  }
}

class OrdersChip extends StatelessWidget {
  OrdersChip({
    super.key,
    required this.title,
    required this.count,
  });
  String title, count;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 0.5 * size.height / 100,
        horizontal: 2 * size.width / 100,
      ),
      height: 7 * size.height / 100,
      width: 45 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kColors.primaryAccent.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: kTxt(
              text: '$title',
              size: 12,
              color: kColors.textGrey,
            ),
          ),
          Height(h: 0.5),
          Align(
            alignment: Alignment.centerLeft,
            child: kTxt(
              text: '$count',
              size: 14,
              color: kColors.blackColor,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
