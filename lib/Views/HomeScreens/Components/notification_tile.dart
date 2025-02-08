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
    required this.viewTap,
    required this.status,
  });
  String title, description, date, time, status;
  Function() viewTap;
  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.parse(datetime);

    // String formattedDate =
    //     DateFormat('MMMM d').format(dateTime); // e.g., August 29
    // String formattedTime = DateFormat('h:mm a').format(dateTime);
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.5 * size.width / 100,
        vertical: 1 * size.height / 100,
      ),
      width: 90 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: status == '1'
            ? kColors.whiteColor
            : kColors.primaryColor.withOpacity(0.05),
        border: Border.all(
            color: status == '1'
                ? kColors.textGrey.withOpacity(0.2)
                : Colors.transparent),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 2.45 * size.height / 100,
                width: 5.45 * size.width / 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kImages.appicon),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Width(w: 2),
              SizedBox(
                width: 58 * size.width / 100,
                child: kTxt(
                  text: '$title',
                  color: kColors.blackColor,
                  weight: FontWeight.w600,
                  maxLine: 1,
                  textalign: TextAlign.left,
                  size: 12,
                ),
              ),
            ],
          ),
          Height(h: 1),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 70 * size.width / 100,
              child: kTxt(
                text: '$description',
                color: kColors.textGrey,
                weight: FontWeight.w600,
                maxLine: 2,
                textalign: TextAlign.left,
                size: 10,
              ),
            ),
          ),
          Height(h: 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kTxt(
                text: date,
                size: 10,
                weight: FontWeight.w500,
                color: kColors.textGrey.withOpacity(0.8),
              ),
              GestureDetector(
                onTap: viewTap,
                child: Text(
                  'View',
                  style: TextStyle(
                    color: kColors.primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
