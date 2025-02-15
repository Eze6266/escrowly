import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/enter_buyer_pay_pin.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/order_success_dialog.dart';
import 'package:trustbridge/Views/HomeScreens/topup_sheet.dart';

class FullBuyingDetailScreen extends StatefulWidget {
  FullBuyingDetailScreen({
    super.key,
    required this.amount,
    required this.dateTime,
    required this.fee,
    required this.sellerEmail,
    required this.description,
    required this.whoPays,
    required this.sellerPhone,
  });
  var dateTime, sellerEmail, sellerPhone, amount, fee, description, whoPays;

  @override
  State<FullBuyingDetailScreen> createState() => _FullBuyingDetailScreenState();
}

class _FullBuyingDetailScreenState extends State<FullBuyingDetailScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);
    isLoading = Provider.of<OrderProvider>(context).createBuyerOrderIsLoading;

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
                  Width(w: 25),
                  kTxt(
                    text: 'Order Summary',
                    weight: FontWeight.w600,
                    size: 16,
                  ),
                ],
              ),
              Height(h: 5),
              RowTxtWitUnderline(
                lTxt: 'I am ',
                rtxt: 'Buying',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Date',
                rtxt: widget.dateTime,
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Seller Email',
                rtxt: '${widget.sellerEmail}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Seller Phone',
                rtxt: '${widget.sellerPhone}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Who pays fee',
                rtxt: widget.whoPays == 'Seller'
                    ? 'Seller'
                    : widget.whoPays == 'Split'
                        ? 'Split'
                        : 'Me',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Amount',
                rtxt: 'N${formatNumberWithCommas(widget.amount)}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Escrowly Fee',
                rtxt: 'N${formatNumberWithCommas(widget.fee)}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                  lTxt: 'Total Amount',
                  rtxt:
                      'N${formatNumberWithCommas((int.parse(widget.amount) + int.parse(widget.fee)))}'),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Description',
                rtxt: '${widget.description}',
              ),
              Height(h: 8),
              GenBtn(
                size: size,
                width: 90,
                isLoading: isLoading,
                height: 6,
                btnColor: kColors.primaryColor,
                txtColor: kColors.whiteColor,
                btnText: 'Make payment',
                tap: () {
                  showModalBottomSheet(
                    isDismissible: false,
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    builder: (context) => BuyerPayPinSheet(
                      amount: widget.amount,
                      dateTime: widget.dateTime,
                      fee: widget.fee,
                      sellerEmail: widget.sellerEmail,
                      description: widget.description.toString(),
                      whoPays: widget.whoPays,
                      sellerPhone: widget.sellerPhone,
                    ),
                  );
                  // orderProvider
                  //     .createBuyerOrder(
                  //   email: widget.sellerEmail,
                  //   phone: widget.sellerPhone,
                  //   description: widget.description,
                  //   amount: widget.amount,
                  //   payer: widget.whoPays == 'Seller'
                  //       ? 'seller'
                  //       : widget.fee == 'Me'
                  //           ? 'buyer'
                  //           : 'split',
                  //   context: context,
                  // )
                  //     .then((value) {
                  //   if (value == 'success') {
                  //     showCashoutSuccessDialog(context, widget.sellerEmail);
                  //   } else {
                  //     showCustomErrorToast(
                  //         context, orderProvider.createBuyerOrderMessage);
                  //   }
                  // });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
