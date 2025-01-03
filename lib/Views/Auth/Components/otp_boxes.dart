import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trustbridge/Utilities/app_colors.dart';

class OTPBoxes extends StatelessWidget {
  OTPBoxes({
    super.key,
    required this.size,
    required this.pinController,
    required this.otpclick,
  });

  final Size size;
  final TextEditingController pinController;
  Function() otpclick;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 6 * size.height / 100,
      width: 13 * size.width / 100,
      child: TextField(
        obscureText: false,
        obscuringCharacter: '*',
        showCursor: true,
        cursorColor: kColors.primaryColor,
        controller: pinController,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          otpclick;
        },
        decoration: InputDecoration(
          hintText: '',
          hintStyle: TextStyle(fontSize: 13),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: kColors.whitishGrey,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xffd2d2d2),
              width: 2.0,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
