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
import 'package:trustbridge/Views/SupportScreens/support_screen.dart';

class FullRunningOrderScreen extends StatefulWidget {
  FullRunningOrderScreen({
    super.key,
    required this.amount,
    required this.date,
    required this.fee,
    required this.feepayer,
    required this.name,
    required this.phone,
    required this.total,
    required this.type,
    required this.title,
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
      title,
      type,
      orderid,
      description;
  @override
  State<FullRunningOrderScreen> createState() => _FullRunningOrderScreenState();
}

class _FullRunningOrderScreenState extends State<FullRunningOrderScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);
    // acceptIsLoading = Provider.of<OrderProvider>(context).acceptOrderIsLoading;

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
                  isLoading ? SizedBox.shrink() : BckBtn(),
                  Width(w: 28),
                  kTxt(
                    text: 'Order Details',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 5),
              RowTxtWitUnderline(
                lTxt: 'Title',
                rtxt: 'N${widget.title}',
              ),
              Height(h: 3),
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
                isLoading: isLoading,
                borderColor: kColors.primaryColor,
                height: 6,
                btnColor: isLoading ? kColors.textGrey : kColors.whiteColor,
                btnText: 'Raise Dispute',
                txtColor: kColors.primaryColor,
                tap: isLoading
                    ? () {}
                    : () {
                        // orderProvider
                        //     .acceptOrder(
                        //         orderid: widget.orderid, context: context)
                        //     .then((value) {
                        //   if (value == 'success') {
                        //     goBack(context);
                        //     orderProvider.fetchIncomingOrder(context: context);
                        //     authProvider.getUser(context: context);
                        //   } else {
                        //     showCustomErrorToast(
                        //         context, orderProvider.acceptOrderMessage);
                        //   }
                        // });
                        goTo(context, SupportScreen());
                      },
              ),
              Height(h: 1),
            ],
          ),
        ),
      ),
    );
  }
}
