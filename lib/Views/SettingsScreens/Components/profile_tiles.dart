import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class ProfileScreenTile extends StatelessWidget {
  ProfileScreenTile({
    super.key,
    required this.img,
    required this.onTap,
    required this.txt,
    this.color,
  });
  String txt, img;
  Function() onTap;
  Color? color;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3 * size.width / 100,
          vertical: 0.5 * size.height / 100,
        ),
        height: 6 * size.height / 100,
        width: 95 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kColors.whitishGrey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kColors.lightGrey,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      img,
                      color: color ?? kColors.blackColor,
                    ),
                  ),
                ),
                Width(w: 2),
                kTxt(
                  text: '$txt',
                  size: 15,
                  weight: FontWeight.w500,
                  color: color ?? kColors.blackColor,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleDarkModeScreenTile extends StatefulWidget {
  ToggleDarkModeScreenTile({
    super.key,
    required this.img,
    required this.onTap,
    required this.txt,
    this.color,
  });
  String txt, img;
  Function() onTap;
  Color? color;

  @override
  State<ToggleDarkModeScreenTile> createState() =>
      _ToggleDarkModeScreenTileState();
}

class _ToggleDarkModeScreenTileState extends State<ToggleDarkModeScreenTile> {
  bool toggledark = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3 * size.width / 100,
        vertical: 0.5 * size.height / 100,
      ),
      height: 6 * size.height / 100,
      width: 95 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kColors.whitishGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kColors.lightGrey,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    widget.img,
                    color: widget.color ?? kColors.blackColor,
                  ),
                ),
              ),
              Width(w: 2),
              kTxt(
                text: '${widget.txt}',
                size: 15,
                weight: FontWeight.w500,
                color: widget.color ?? kColors.blackColor,
              ),
            ],
          ),
          CupertinoSwitch(
            activeColor: kColors.primaryColor,
            value: toggledark,
            onChanged: (value) {
              setState(() {
                toggledark = !toggledark;
              });
            },
          ),
        ],
      ),
    );
  }
}
