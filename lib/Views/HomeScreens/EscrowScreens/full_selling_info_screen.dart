import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Utilities/Functions/add_comma_tostring_number.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/Components/reusables.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/order_success_dialog.dart';

class FullSellingDetailScreen extends StatefulWidget {
  FullSellingDetailScreen({
    super.key,
    required this.amount,
    required this.dateTime,
    required this.fee,
    required this.buyerEmail,
    required this.description,
    required this.whoPays,
    required this.buyerPhone,
  });
  var dateTime, buyerEmail, buyerPhone, amount, fee, description, whoPays;

  @override
  State<FullSellingDetailScreen> createState() =>
      _FullSellingDetailScreenState();
}

class _FullSellingDetailScreenState extends State<FullSellingDetailScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var orderProvider = Provider.of<OrderProvider>(context);
    isLoading = Provider.of<OrderProvider>(context).createSellerOrderIsLoading;

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
                  Width(w: 26),
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
                rtxt: 'Selling',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Date',
                rtxt: widget.dateTime,
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Buyer Email',
                rtxt: '${widget.buyerEmail}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'buyer Phone',
                rtxt: '${widget.buyerPhone}',
              ),
              Height(h: 3),
              RowTxtWitUnderline(
                lTxt: 'Who pays fee',
                rtxt: widget.whoPays == 'Buyer'
                    ? 'Buyer'
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
                btnText: 'Proceed',
                tap: () {
                  orderProvider
                      .createSellerOrder(
                    email: widget.buyerEmail,
                    phone: widget.buyerPhone,
                    description: widget.description,
                    amount: widget.amount,
                    payer: widget.whoPays == 'Buyer'
                        ? 'buyer'
                        : widget.fee == 'Me'
                            ? 'seller'
                            : 'split',
                    context: context,
                  )
                      .then((value) {
                    if (value == 'success') {
                      showCashoutSuccessDialog(context, widget.buyerEmail);
                    } else {
                      showCustomErrorToast(
                          context, orderProvider.createSellerOrderMessage);
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
