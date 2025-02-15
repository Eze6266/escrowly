import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustbridge/Utilities/app_colors.dart';

void goTo(BuildContext context, Widget screen) {
  final random = Random();
  final animations = [
    _fadeTransition,
    _scaleTransition,
  ];
  final randomAnimation = animations[random.nextInt(animations.length)];

  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration:
          const Duration(milliseconds: 700), // Adjust duration for emphasis
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: randomAnimation,
    ),
  );
}

Widget _fadeTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic),
    child: child,
  );
}

Widget _scaleTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  const begin = 0.0;
  const end = 1.0;
  const curve = Curves.easeInOutBack;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var scaleAnimation = animation.drive(tween);

  return ScaleTransition(
    scale: scaleAnimation,
    child: child,
  );
}

// Define the goback function
void goBack(BuildContext context) {
  Navigator.pop(context);
}

class Height extends StatelessWidget {
  Height({
    super.key,
    required this.h,
  });
  double h;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: h * size.height / 100);
  }
}

class Width extends StatelessWidget {
  Width({
    super.key,
    required this.w,
  });
  double w;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(width: w * size.width / 100);
  }
}

class kTxt extends StatelessWidget {
  kTxt(
      {super.key,
      this.color,
      this.size,
      required this.text,
      this.weight,
      this.textalign,
      this.letterSpace,
      this.maxLine,
      this.softRap,
      s});
  String text;
  Color? color;
  double? size, letterSpace;
  TextAlign? textalign;
  FontWeight? weight;
  int? maxLine;
  bool? softRap;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        fontFamily: 'Rany',
        color: color ?? kColors.blackColor,
        fontSize: size ?? 14.0,
        fontWeight: weight ?? FontWeight.w400,
        decoration: TextDecoration.none,
        letterSpacing: letterSpace ?? 0,
      ),
      textAlign: textalign ?? TextAlign.left,
      softWrap: softRap ?? false,
      maxLines: maxLine ?? null,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class GenBtn extends StatelessWidget {
  GenBtn({
    super.key,
    required this.size,
    required this.width,
    required this.height,
    required this.btnColor,
    this.textSize,
    this.borderColor,
    this.txtColor,
    required this.btnText,
    this.txtWeight,
    this.tap,
    this.borderRadius,
    this.isLoading,
  });

  final Size size;
  double? textSize, borderRadius;
  double width;
  double height;
  Color? btnColor, txtColor, borderColor;
  String btnText;
  FontWeight? txtWeight;
  Function()? tap;
  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap ?? () {},
      child: Container(
        height: height * size.height / 100,
        width: width * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          color: btnColor ?? kColors.whiteColor,
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: isLoading ?? false
            ? Center(
                child: SizedBox(
                  height: 2 * size.height / 100,
                  width: 4 * size.width / 100,
                  child: CircularProgressIndicator(
                    color: kColors.whiteColor,
                  ),
                ),
              )
            : Center(
                child: kTxt(
                  text: btnText,
                  size: textSize ?? 14,
                  weight: txtWeight ?? FontWeight.w600,
                  color: txtColor ?? kColors.blackColor,
                ),
              ),
      ),
    );
  }
}

class BckBtn extends StatelessWidget {
  const BckBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => goBack(context),
      child: Container(
        // height: 4.6 * size.height / 100,
        // width: 10.5 * size.width / 100,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(8),
        //   color: kColors.primaryColor.withOpacity(0.2),
        // ),
        child: Padding(
          padding: EdgeInsets.only(left: 1.3 * size.width / 100),
          child: Icon(
            Icons.arrow_back_ios,
            color: kColors.blackColor,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class CancelCircle extends StatelessWidget {
  const CancelCircle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: kColors.whitishGrey,
      child: Icon(
        Icons.close,
        color: kColors.blackColor,
        size: 16,
      ),
    );
  }
}

class RowDropDown extends StatelessWidget {
  RowDropDown({
    super.key,
    required this.size,
    required this.onTap,
    required this.txt,
    required this.title,
    this.txtColor,
    this.important,
    this.rowWidth,
  });

  final Size size;
  String txt, title;
  Function() onTap;
  bool? important;
  double? rowWidth;
  Color? txtColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                kTxt(
                  text: '$title',
                  color: kColors.textGrey,
                  weight: FontWeight.w500,
                ),
                important ?? false
                    ? kTxt(
                        text: ' *',
                        color: kColors.red,
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          Height(h: 0.5),
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
              height: 6 * size.height / 100,
              width: 100 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: kColors.whitishGrey),
                color: kColors.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: (rowWidth ?? 74) * size.width / 100,
                    child: kTxt(
                      text: '$txt',
                      maxLine: 1,
                      color: txtColor ?? Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: kColors.textGrey,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerBody extends StatelessWidget {
  ContainerBody({super.key, required this.child, s});
  Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.5 * size.width / 100,
        vertical: 0.7 * size.height / 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kColors.whitishGrey),
      ),
      child: child,
    );
  }
}

class SelectChip extends StatelessWidget {
  SelectChip({
    super.key,
    required this.clicked,
    required this.txt,
    required this.onTap,
  });

  String txt;
  bool clicked;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        height: 3.6 * size.height / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: clicked ? kColors.greenColor : kColors.whitishGrey,
        ),
        child: Center(
          child: kTxt(
            text: '$txt',
            color: clicked ? kColors.whiteColor : kColors.blackColor,
            weight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class GenBtnWSvg extends StatelessWidget {
  GenBtnWSvg({
    super.key,
    required this.size,
    required this.width,
    required this.height,
    required this.btnColor,
    this.textSize,
    this.borderColor,
    this.txtColor,
    required this.btnText,
    this.txtWeight,
    this.tap,
    this.borderRadius,
    this.isLoading,
    required this.imgurl,
  });

  final Size size;
  double? textSize, borderRadius;
  double width;
  double height;
  Color? btnColor, txtColor, borderColor;
  String btnText, imgurl;
  FontWeight? txtWeight;
  Function()? tap;
  bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap ?? () {},
      child: Container(
        height: height * size.height / 100,
        width: width * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          color: btnColor ?? kColors.whiteColor,
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: isLoading ?? false
            ? Center(
                child: SizedBox(
                  height: 2 * size.height / 100,
                  width: 4 * size.width / 100,
                  child: CircularProgressIndicator(
                    color: kColors.whiteColor,
                  ),
                ),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      imgurl,
                      color: kColors.primaryColor,
                      height: 2 * size.height / 100,
                    ),
                    Width(w: 1),
                    kTxt(
                      text: btnText,
                      size: textSize ?? 14,
                      weight: txtWeight ?? FontWeight.w600,
                      color: txtColor ?? kColors.blackColor,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class HomeCustomDropdown extends StatefulWidget {
  final String initialValue;
  final Function(String) onChanged;

  const HomeCustomDropdown({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _HomeCustomDropdownState createState() => _HomeCustomDropdownState();
}

class _HomeCustomDropdownState extends State<HomeCustomDropdown> {
  late String _selectedValue;

  final List<String> _options = [
    'All orders',
    'Pending',
    'In progress',
    'Completed',
  ];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 4 * size.height / 100,
      padding: EdgeInsets.symmetric(
        horizontal: 2 * size.width / 100,
      ),
      decoration: BoxDecoration(
        color: kColors.ongoingBg, // Background color matching the image
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedValue,
          icon: Icon(
            Icons.expand_more_outlined,
            color: kColors.textGrey,
          ),
          items: _options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Width(w: 1),
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Rany',
                      color: kColors.textGrey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedValue = newValue;
              });
              widget.onChanged(newValue);
            }
          },
        ),
      ),
    );
  }
}
