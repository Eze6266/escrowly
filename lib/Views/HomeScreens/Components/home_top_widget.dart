import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trustbridge/Utilities/Functions/get_first_letters.dart';
import 'package:trustbridge/Utilities/Functions/greetings_function.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class HomeTopWidget extends StatelessWidget {
  HomeTopWidget({
    super.key,
    required this.bellTap,
    required this.img,
    required this.name,
  });

  String img, name;
  Function() bellTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                height: 4 * size.height / 100,
                width: 8.8 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kColors.textGrey,
                ),
                child: Center(
                  child: kTxt(
                    text: getFirstTwoLetters(name),
                    size: 12,
                    weight: FontWeight.w600,
                    color: kColors.whiteColor,
                  ),
                ),
              ),
            ),
            Width(w: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kTxt(
                  text: '${getGreetingMessage()}',
                  size: 12,
                  weight: FontWeight.w500,
                ),
                kTxt(
                  text: '$name',
                  size: 13,
                  weight: FontWeight.w600,
                  textalign: TextAlign.left,
                ),
              ],
            )
          ],
        ),
        Stack(
          children: [
            GestureDetector(
              onTap: bellTap,
              child: SvgPicture.asset(
                kImages.notifbell,
                color: kColors.blackColor,
              ),
            ),
            Positioned(
              left: 3.2 * size.width / 100,
              child: CircleAvatar(
                radius: 2.5,
                backgroundColor: kColors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
