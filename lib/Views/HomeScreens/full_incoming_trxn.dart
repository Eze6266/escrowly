import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';

class FullIncomingOrderScreen extends StatefulWidget {
  FullIncomingOrderScreen({
    super.key,
    required this.amount,
    required this.date,
    required this.fee,
    required this.feepayer,
    required this.name,
    required this.phone,
    required this.total,
    required this.type,
    required this.orderid,
    required this.description,
  });
  var amount,
      fee,
      total,
      feepayer,
      date,
      name,
      phone,
      type,
      orderid,
      description;
  @override
  State<FullIncomingOrderScreen> createState() =>
      _FullIncomingOrderScreenState();
}

class _FullIncomingOrderScreenState extends State<FullIncomingOrderScreen> {
  bool acceptIsLoading = false;
  bool rejectIsLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    acceptIsLoading = Provider.of<OrderProvider>(context).acceptOrderIsLoading;
    rejectIsLoading = Provider.of<OrderProvider>(context).rejectOrderIsLoading;

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
                  (acceptIsLoading || rejectIsLoading)
                      ? SizedBox.shrink()
                      : BckBtn(),
                  Width(w: 20),
                  kTxt(
                    text: 'Transaction Details',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 5),
              RowTxtWitUnderline(
                lTxt: 'Amount',
                rtxt: 'N${widget.amount}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Escrowly Fee',
                rtxt: 'N${widget.fee}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Total Amount',
                rtxt: 'N${widget.total}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Escrowly Fee Payer',
                rtxt: '${widget.feepayer}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Date',
                rtxt: '${widget.date}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: '${widget.type == 'Selling' ? 'Seller' : 'Buyer'} Name',
                rtxt: '${widget.name}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: '${widget.type == 'Selling' ? 'Seller' : 'Buyer'} Phone',
                rtxt: '${widget.phone}',
              ),
              Height(h: 3),
              RowTxtWitUnderlineScrolling(
                lTxt: 'Description',
                rtxt: '${widget.description}',
              ),
              Height(h: 6),
              GenBtn(
                size: size,
                width: 90,
                isLoading: acceptIsLoading,
                height: 6,
                btnColor:
                    rejectIsLoading ? kColors.textGrey : kColors.primaryColor,
                btnText: 'Accept Order',
                txtColor: kColors.whiteColor,
                tap: (rejectIsLoading || acceptIsLoading)
                    ? () {}
                    : () {
                        orderProvider
                            .acceptOrder(
                                orderid: widget.orderid, context: context)
                            .then((value) {
                          if (value == 'success') {
                            goBack(context);
                            orderProvider.fetchIncomingOrder(context: context);
                            authProvider.getUser(context: context);
                          } else {
                            showCustomErrorToast(
                                context, orderProvider.acceptOrderMessage);
                          }
                        });
                      },
              ),
              Height(h: 1),
              GenBtn(
                size: size,
                width: 90,
                isLoading: rejectIsLoading,
                height: 6,
                btnColor: acceptIsLoading ? kColors.textGrey : kColors.red,
                btnText: 'Reject Order',
                txtColor: kColors.whiteColor,
                tap: (acceptIsLoading || rejectIsLoading)
                    ? () {}
                    : () {
                        orderProvider
                            .rejectOrder(
                                orderid: widget.orderid, context: context)
                            .then((value) {
                          if (value == 'success') {
                            goBack(context);
                            orderProvider.fetchIncomingOrder(context: context);
                            authProvider.getUser(context: context);
                          } else {
                            showCustomErrorToast(
                                context, orderProvider.acceptOrderMessage);
                          }
                        });
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
