import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class NotificationTile extends StatelessWidget {
  NotificationTile({
    super.key,
    required this.date,
    required this.time,
    required this.description,
    required this.title,
    required this.status,
  });
  String title, description, date, time, status;
  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.parse(datetime);

    // String formattedDate =
    //     DateFormat('MMMM d').format(dateTime); // e.g., August 29
    // String formattedTime = DateFormat('h:mm a').format(dateTime);
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 1.8 * size.width / 100,
        vertical: 1 * size.height / 100,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: status == '1'
            ? kColors.whiteColor
            : kColors.primaryColor.withOpacity(0.1),
        border: Border.all(
            color: status == '1'
                ? kColors.textGrey.withOpacity(0.2)
                : Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: kColors.primaryColor.withOpacity(0.06),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    kImages.appicon,
                  ),
                ),
              ),
              Width(w: 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // kTxt(
                  //   text: 'Withdraw',
                  //   color: kColors.greenColor,
                  //   weight: FontWeight.w600,
                  //   size: 10,
                  // ),
                  SizedBox(
                    width: 58 * size.width / 100,
                    child: kTxt(
                      text: '$title',
                      color: kColors.blackColor,
                      weight: FontWeight.w600,
                      maxLine: 1,
                      size: 12,
                    ),
                  ),
                  Height(h: 0.5),
                  SizedBox(
                    width: 58 * size.width / 100,
                    child: kTxt(
                      text: '$description',
                      color: kColors.textGrey,
                      weight: FontWeight.w600,
                      maxLine: 1,
                      size: 9,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              kTxt(
                text: '$date',
                color: kColors.blackColor.withOpacity(0.6),
                size: 9,
                weight: FontWeight.w900,
              ),
              Height(h: 0.3),
              kTxt(
                text: '$time',
                color: kColors.blackColor.withOpacity(0.6),
                size: 10,
                weight: FontWeight.w900,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
