import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/format_date_function.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/lazy_loader.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/select_type_screen.dart';
import 'package:trustbridge/Views/HomeScreens/full_incoming_trxn.dart';
import 'package:trustbridge/Views/HomeScreens/recent_order_full_screen.dart';
import 'package:trustbridge/Views/HomeScreens/recent_transaction_screen.dart';
import 'package:trustbridge/Views/HomeScreens/running_orders_full_detail.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_escrows.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_incoming.dart';
import 'package:trustbridge/Views/HomeScreens/see_all_trxn_screen.dart';
import 'package:trustbridge/Views/Orders/Components/order_payment_info_sheet.dart';

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
    var authProvider = Provider.of<AuthProvider>(context);

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
        backgroundColor: kColors.whiteColor,
        appBar: AppBar(
          backgroundColor: kColors.primaryColor,
          toolbarHeight: 0.001,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4 * size.width / 100),
          child: Column(
            children: [
              Height(h: 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: 'Orders',
                    size: 16,
                    color: kColors.blackColor,
                    weight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      goTo(context, SelectTypeScreen());
                    },
                    child: kTxt(
                      text: 'Create order',
                      size: 12,
                      color: kColors.primaryColor,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrdersChip(
                    color: kColors.dimPink,
                    title: 'Active orders',
                    count: '${orderProvider.runningOrders.length}',
                  ),
                  OrdersChip(
                    color: kColors.dimOrange,
                    title: 'Incoming orders',
                    count: '${orderProvider.incomingOrders.length}',
                  ),
                ],
              ),
              Height(h: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: '   Incoming Orders',
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  orderProvider.trns.isEmpty
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            goTo(context, SeeAllIncomingOrdersScreen());
                          },
                          child: kTxt(
                            text:
                                'See all(${orderProvider.incomingOrders.length})',
                            size: 13,
                            weight: FontWeight.w500,
                            color: kColors.textGrey,
                          ),
                        ),
                ],
              ),
              Height(h: 1),
              orderProvider.fetchIncomingOrderisLoading
                  ? Center(
                      child: NormalLoader(),
                    )
                  : orderProvider.incomingOrders.isEmpty
                      ? Center(
                          child: kTxt(
                            text:
                                'Your incoming orders are displayed here\n Looks like you dont\'t have any',
                            textalign: TextAlign.center,
                            size: 12,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: orderProvider.incomingOrders.length > 2
                                ? 2
                                : orderProvider.incomingOrders.length,
                            itemBuilder: (context, index) {
                              var order = orderProvider.incomingOrders[index];
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
                                  bottom: 1 * size.height / 100,
                                ),
                                child: IncomingOrdersBox(
                                  createdTime: order['created_at'].toString(),
                                  title: order['title'].toString(),
                                  isAcceptLoading: isAcceptLoading,
                                  isRejectLoading: isRejectLoading,
                                  width:
                                      orderProvider.incomingOrders.length == 1
                                          ? 93
                                          : null,
                                  orderID: order['reference_code'].toString(),
                                  description: order['description'].toString(),
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
                                          status: order['status'].toString(),
                                          reference: order['reference_code']
                                              .toString(),
                                          userId: order['userid'].toString(),
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
                                  acceptTap: () {
                                    if (order['role'].toString() == 'Seller') {
                                      orderProvider
                                          .acceptOrder(
                                              orderid: order['id'].toString(),
                                              pin: '',
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
                                    } else {
                                      showModalBottomSheet(
                                        isDismissible: true,
                                        isScrollControlled: true,
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(30),
                                          ),
                                        ),
                                        builder: (context) =>
                                            OrderPaymentInfoSheet(
                                          amount: formatNumberWithCommas(
                                              order['amount'].toString()),
                                          fee: formatNumberWithCommas(
                                              order['fee'].toString()),
                                          total: formatNumberWithCommas(
                                              order['total_amount'].toString()),
                                          orderid: order['id'].toString(),
                                        ),
                                      );
                                    }
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
              Height(h: 2),
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
                                'See all(${orderProvider.runningOrders.length})',
                            size: 13,
                            weight: FontWeight.w500,
                            color: kColors.textGrey,
                          ),
                        ),
                ],
              ),
              Height(h: 1),
              orderProvider.fetchTrxnsisLoading
                  ? Center(
                      child: NormalLoader(),
                    )
                  : orderProvider.runningOrders.isEmpty
                      ? Center(
                          child: kTxt(
                            text:
                                'Your ongoing orders are displayed here\n Looks like you dont\'t have any',
                            textalign: TextAlign.center,
                            size: 12,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: orderProvider.runningOrders.length > 2
                                ? 2
                                : orderProvider.runningOrders.length,
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
                                          status: order['status'].toString(),
                                          reference: order['reference_code']
                                              .toString(),
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
                        ),
              Height(h: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  kTxt(
                    text: '   Recent orders',
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  orderProvider.trns.isEmpty
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            goTo(context, SeeAllTrxnScreen());
                          },
                          child: kTxt(
                            text: 'See all(${orderProvider.trns.length})',
                            size: 13,
                            weight: FontWeight.w500,
                            color: kColors.textGrey,
                          ),
                        ),
                ],
              ),
              Height(h: 1),
              orderProvider.fetchTrxnsisLoading
                  ? Center(
                      child: NormalLoader(),
                    )
                  : orderProvider.trns.isEmpty
                      ? Center(
                          child: kTxt(
                            text:
                                'Your recent orders are displayed here\n Looks like you dont\'t have any',
                            textalign: TextAlign.center,
                            size: 12,
                            maxLine: 3,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: orderProvider.trns.length > 2
                                ? 2
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
                                          reference: order['reference_code']
                                              .toString(),
                                          status: order['status'].toString(),
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
                                    title: order['title'],
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

class OrdersChip extends StatelessWidget {
  OrdersChip({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });
  String title, count;
  Color color;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 0.5 * size.height / 100,
        horizontal: 4 * size.width / 100,
      ),
      height: 8 * size.height / 100,
      width: 45 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
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
