import 'package:clipboard/clipboard.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:provider/provider.dart';
import 'package:trustbridge/Controllers/Providers/AuthProviders/auth_provider.dart';
import 'package:trustbridge/Controllers/Providers/OrderProviders/order_provider.dart';
import 'package:trustbridge/Controllers/Providers/TransactionProviders/transaction_provider.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/custom_txtfield.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/Components/otp_boxes.dart';
import 'package:trustbridge/Views/HomeScreens/Components/withdraw_processing.dart';
import 'package:trustbridge/Views/HomeScreens/EscrowScreens/Components/order_success_dialog.dart';
import 'package:trustbridge/Views/bottom_nav.dart';

class AcceptOrderSuccessSheet extends StatefulWidget {
  AcceptOrderSuccessSheet({
    super.key,
  });
  @override
  State<AcceptOrderSuccessSheet> createState() =>
      _AcceptOrderSuccessSheetState();
}

class _AcceptOrderSuccessSheetState extends State<AcceptOrderSuccessSheet> {
  final confetticontroller = ConfettiController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context);
    var orderProvider = Provider.of<OrderProvider>(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 35 * size.height / 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: kColors.whiteColor,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 4 * size.width / 100,
          vertical: 2 * size.height / 100,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GenBtn(
                size: size,
                width: 15,
                height: 0.3,
                btnColor: kColors.textGrey.withOpacity(0.5),
                btnText: '',
              ),
              Height(h: 2.5),
              kTxt(
                text: 'Payment successful',
                size: 18,
                weight: FontWeight.w500,
                color: kColors.blackColor.withOpacity(0.8),
              ),
              Height(h: 2),
              SvgPicture.asset(
                kImages.checksvgblue,
              ),
              Height(h: 2),
              SizedBox(
                width: 88 * size.width / 100,
                child: kTxt(
                  text:
                      'Your payment has been successfully processed! The seller has been notified and your order is now in progress',
                  maxLine: 4,
                  size: 12,
                  textalign: TextAlign.center,
                  weight: FontWeight.w500,
                  color: kColors.textGrey.withOpacity(0.9),
                ),
              ),
              Height(h: 5),
              GenBtn(
                size: size,
                width: 85,
                isLoading: isLoading,
                height: 5.5,
                btnColor: kColors.primaryColor,
                btnText: 'Done',
                txtColor: kColors.whiteColor,
                tap: () {
                  goBack(context);
                  goTo(context, BottomNav(chosenmyIndex: 0));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
