import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class Toaster {
  void showToast(message) {
    Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: kColors.blackColor,
      textColor: kColors.whiteColor,
      fontSize: 16.0,
    );
  }
}

void showCustomErrorToast(BuildContext context, String message) {
  Size size = MediaQuery.of(context).size;
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: kColors.whiteColor,
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          //     height: 7 * size.height / 100,
          width: 98 * size.width / 100,
          padding: EdgeInsets.symmetric(
            vertical: 0.6 * size.height / 100,
            horizontal: 2 * size.width / 100,
          ),
          decoration: BoxDecoration(
            color: kColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: kColors.red.withOpacity(0.2),
                    child: Icon(
                      Icons.error_outline,
                      color: kColors.red,
                      size: 20,
                    ),
                  ),
                  Width(w: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kTxt(
                        text: 'Error',
                        color: kColors.red,
                        weight: FontWeight.w600,
                        size: 13,
                      ),
                      SizedBox(
                        width: 57 * size.width / 100,
                        child: kTxt(
                          text: '$message',
                          color: kColors.textGrey,
                          weight: FontWeight.w400,
                          size: 12,
                          maxLine: 6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.close,
                color: kColors.blackColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 4)).then((_) => overlayEntry.remove());
}

void showCustomSuccessToast(BuildContext context, String message) {
  Size size = MediaQuery.of(context).size;
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 50.0,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: kColors.whiteColor,
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          // height: 7 * size.height / 100,
          width: 98 * size.width / 100,
          padding: EdgeInsets.symmetric(
            vertical: 0.6 * size.height / 100,
            horizontal: 2.5 * size.width / 100,
          ),
          decoration: BoxDecoration(
            color: kColors.whiteColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: kColors.greenColor.withOpacity(0.2),
                    child: Icon(
                      Icons.check,
                      color: kColors.greenColor,
                      size: 20,
                    ),
                  ),
                  Width(w: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kTxt(
                        text: 'Success',
                        color: kColors.primaryColor,
                        weight: FontWeight.w600,
                        size: 13,
                      ),
                      SizedBox(
                        width: 57 * size.width / 100,
                        child: kTxt(
                          text: '$message',
                          color: kColors.textGrey,
                          weight: FontWeight.w400,
                          size: 12,
                          maxLine: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.close,
                color: kColors.blackColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 4)).then((_) => overlayEntry.remove());
}
