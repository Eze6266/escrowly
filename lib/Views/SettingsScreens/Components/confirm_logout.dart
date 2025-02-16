import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustbridge/Utilities/Functions/show_toast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';
import 'package:trustbridge/Views/Auth/login_screen.dart';

void showConfirmLogoutAccountDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;

      return Dialog(
        insetPadding: EdgeInsets.all(10),
        child: ConfirmLogoutAccountDialog(size: size),
      );
    },
  );
}

class ConfirmLogoutAccountDialog extends StatefulWidget {
  ConfirmLogoutAccountDialog({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ConfirmLogoutAccountDialog> createState() =>
      _ConfirmLogoutAccountDialogState();
}

class _ConfirmLogoutAccountDialogState
    extends State<ConfirmLogoutAccountDialog> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94 * widget.size.width / 100,
      height: 21 * widget.size.height / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kColors.whiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  isLoading ? null : goBack(context);
                },
                child: CancelCircle(),
              ),
            ),
            kTxt(
              text: 'Confirm Logout',
              size: 18,
              weight: FontWeight.w600,
            ),
            Height(h: 4),
            GenBtn(
              size: widget.size,
              width: 78,
              borderRadius: 55,
              height: 5,
              btnColor: kColors.red,
              isLoading: isLoading,
              btnText: 'Logout',
              txtColor: kColors.whiteColor,
              tap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                goTo(context, LoginScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
