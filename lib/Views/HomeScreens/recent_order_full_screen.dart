import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/get_first_letters.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/SupportScreens/support_screen.dart';

class FullRecentOrderScreen extends StatefulWidget {
  FullRecentOrderScreen({
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
    required this.status,
    required this.reference,
  });
  var amount,
      fee,
      total,
      feepayer,
      date,
      name,
      phone,
      type,
      reference,
      orderid,
      status,
      description;
  @override
  State<FullRecentOrderScreen> createState() => _FullRecentOrderScreenState();
}

class _FullRecentOrderScreenState extends State<FullRecentOrderScreen> {
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
                  isLoading
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            goBack(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 22,
                          ),
                        ),
                  Width(w: 3),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 3.5 * size.height / 100,
                      width: 7.8 * size.width / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kColors.textGrey,
                      ),
                      child: Center(
                        child: kTxt(
                          text: getFirstTwoLetters(widget.name),
                          size: 11,
                          weight: FontWeight.w600,
                          color: kColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  Width(w: 1),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kTxt(
                        text: widget.name,
                        size: 14,
                        weight: FontWeight.w600,
                        color: kColors.textGrey,
                      ),
                      kTxt(
                        text: widget.reference,
                        size: 10,
                        weight: FontWeight.w500,
                        color: kColors.textGrey,
                      ),
                    ],
                  ),
                ],
              ),
              Height(h: 1),
              Divider(),
              Height(h: 1),
              Align(
                alignment: Alignment.centerLeft,
                child: kTxt(
                  text: 'Order Details',
                  weight: FontWeight.w600,
                  size: 14,
                  color: kColors.blackColor.withOpacity(0.8),
                ),
              ),
              Height(h: 2),
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
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Status',
                rtxt: '${getStatusTxt(widget.status)}',
                rColor: getStatusTxtColor(widget.status),
              ),
              Height(h: 6),
              (widget.status == '1' || widget.status == '2') == false
                  ? GenBtn(
                      size: size,
                      width: 90,
                      isLoading: isLoading,
                      height: 6,
                      btnColor:
                          isLoading ? kColors.textGrey : kColors.whiteColor,
                      btnText: 'Raise Dispute',
                      txtColor: kColors.primaryColor,
                      borderColor: kColors.primaryColor,
                      tap: isLoading
                          ? () {}
                          : () {
                              goTo(context, SupportScreen());
                            },
                    )
                  : SizedBox.shrink(),
              Height(h: 1),
            ],
          ),
        ),
      ),
    );
  }
}
