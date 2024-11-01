import 'package:flutter/material.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class BusinesInfoTile extends StatelessWidget {
  BusinesInfoTile({
    super.key,
    required this.sub,
    required this.title,
  });
  String title, sub;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
      height: 7 * size.height / 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kColors.whitishGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          kTxt(
            text: '$title',
            weight: FontWeight.w500,
            size: 15,
          ),
          Height(h: 0.3),
          kTxt(
            text: '$sub',
            weight: FontWeight.w400,
            color: kColors.textGrey,
            size: 15,
          ),
        ],
      ),
    );
  }
}
