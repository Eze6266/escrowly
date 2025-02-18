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
import 'package:trustbridge/Views/Orders/Components/order_payment_info_sheet.dart';
import 'package:trustbridge/Views/Orders/Components/pay_seller_payinfo_sheet.dart';
import 'package:trustbridge/Views/Orders/Components/pay_seller_pin_sheet.dart';
import 'package:trustbridge/Views/SupportScreens/support_screen.dart';

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
    required this.title,
    required this.orderid,
    required this.description,
    required this.userId,
    required this.reference,
    required this.status,
  });
  var amount,
      fee,
      total,
      feepayer,
      date,
      name,
      phone,
      type,
      title,
      orderid,
      userId,
      status,
      reference,
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
    acceptIsLoading =
        orderProvider.acceptOrderLoading[widget.orderid.toString()] ?? false;
    rejectIsLoading =
        orderProvider.rejectOrderLoading[widget.orderid.toString()] ?? false;

    // acceptIsLoading = Provider.of<OrderProvider>(context).acceptOrderIsLoading;
    // rejectIsLoading = Provider.of<OrderProvider>(context).rejectOrderIsLoading;

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
                  GestureDetector(
                    onTap: () {
                      goBack(context);
                    },
                    child: (acceptIsLoading || rejectIsLoading)
                        ? SizedBox.shrink()
                        : Icon(
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
                lTxt: 'Title',
                rtxt: 'N${widget.title}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: 'Amount',
                rtxt: 'N${widget.amount}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: 'Escrowly Fee',
                rtxt: 'N${widget.fee}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: 'Total Amount',
                rtxt: 'N${widget.total}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: 'Escrowly Fee Payer',
                rtxt: '${widget.feepayer}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: 'Date',
                rtxt: '${widget.date}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: '${widget.type == 'Selling' ? 'Seller' : 'Buyer'} Name',
                rtxt: '${widget.name}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: '${widget.type == 'Selling' ? 'Seller' : 'Buyer'} Phone',
                rtxt: '${widget.phone}',
              ),
              Height(h: 2),
              RowTxtWitUnderlineScrolling(
                lTxt: 'Description',
                rtxt: '${widget.description}',
              ),
              Height(h: 2),
              RowTxtWitUnderline(
                lTxt: 'Status',
                rtxt: '${getStatusTxt(widget.status)}',
                rColor: getStatusTxtColor(widget.status),
              ),
              Height(h: 1),
              Divider(),
              Height(h: 1),
              Align(
                alignment: Alignment.centerLeft,
                child: kTxt(
                  text: 'Payment Details',
                  weight: FontWeight.w600,
                  size: 14,
                  color: kColors.blackColor.withOpacity(0.8),
                ),
              ),
              Height(h: 2),
              RowTxtWitUnderline(lTxt: 'Amount', rtxt: 'N${widget.amount}'),
              Height(h: 1.5),
              RowTxtWitUnderline(lTxt: 'Fee', rtxt: 'N${widget.fee}'),
              Height(h: 1.5),
              RowTxtWitUnderline(lTxt: 'Total', rtxt: 'N${widget.total}'),
              // widget.status == '2' ? Height(h: 3) : Height(h: 0),
              // widget.status == '2'
              //     ? Align(
              //         alignment: Alignment.centerRight,
              //         child: GenBtn(
              //           size: size,
              //           borderRadius: 10,
              //           width: 43,
              //           height: 5,
              //           btnColor: kColors.primaryColor,
              //           btnText: 'Pay seller',
              //           txtColor: kColors.whiteColor,
              //           tap: () {
              //             showModalBottomSheet(
              //               isDismissible: true,
              //               isScrollControlled: true,
              //               context: context,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.vertical(
              //                   top: Radius.circular(30),
              //                 ),
              //               ),
              //               builder: (context) => PaySellerpaymentInfoSheet(
              //                 amount: widget.amount,
              //                 fee: widget.fee,
              //                 total: widget.total,
              //                 orderid: widget.orderid,
              //               ),
              //             );
              //           },
              //         ),
              //       )
              //     : SizedBox.shrink(),
              Height(h: 6),
              (widget.userId == Provider.of<AuthProvider>(context).userID)
                  ? SizedBox()
                  : widget.status == '0'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GenBtn(
                              size: size,
                              width: 43,
                              borderColor: kColors.primaryColor,
                              isLoading: acceptIsLoading,
                              height: 5,
                              btnColor: rejectIsLoading
                                  ? kColors.textGrey
                                  : kColors.whiteColor,
                              btnText: 'Accept Order',
                              txtColor: kColors.primaryColor,
                              tap: (rejectIsLoading || acceptIsLoading)
                                  ? () {}
                                  : () {
                                      if (widget.type == 'Seller') {
                                        orderProvider
                                            .acceptOrder(
                                                orderid: widget.orderid,
                                                pin: '',
                                                context: context)
                                            .then((value) {
                                          if (value == 'success') {
                                            goBack(context);
                                            orderProvider.fetchIncomingOrder(
                                                context: context);
                                            authProvider.getUser(
                                                context: context);
                                          } else {
                                            showCustomErrorToast(
                                                context,
                                                orderProvider
                                                    .acceptOrderMessage);
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
                                            amount: widget.amount,
                                            fee: widget.fee,
                                            total: widget.total,
                                            orderid: widget.orderid,
                                          ),
                                        );
                                      }
                                    },
                            ),
                            Width(w: 5),
                            GenBtn(
                              size: size,
                              width: 43,
                              isLoading: rejectIsLoading,
                              borderColor: kColors.red,
                              height: 5,
                              btnColor: acceptIsLoading
                                  ? kColors.textGrey
                                  : kColors.whiteColor,
                              btnText: 'Reject Order',
                              txtColor: kColors.red,
                              tap: (acceptIsLoading || rejectIsLoading)
                                  ? () {}
                                  : () {
                                      orderProvider
                                          .rejectOrder(
                                              orderid: widget.orderid,
                                              context: context)
                                          .then((value) {
                                        if (value == 'success') {
                                          goBack(context);
                                          orderProvider.fetchIncomingOrder(
                                              context: context);
                                          authProvider.getUser(
                                              context: context);
                                        } else {
                                          showCustomErrorToast(context,
                                              orderProvider.acceptOrderMessage);
                                        }
                                      });
                                    },
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
              Height(h: 2),
              widget.status == '2'
                  ? GenBtn(
                      size: size,
                      borderRadius: 10,
                      width: 88,
                      borderColor: kColors.primaryColor,
                      height: 5,
                      btnColor: kColors.whiteColor,
                      btnText: 'Raise Dispute',
                      txtColor: kColors.primaryColor,
                      tap: () {
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
