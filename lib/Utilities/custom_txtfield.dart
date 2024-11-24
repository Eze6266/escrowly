// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class TitleTField extends StatelessWidget {
  TitleTField({
    super.key,
    required this.hint,
    this.hasTitle,
    this.height,
    this.radius,
    this.title,
    this.width,
    this.keyType,
    this.suffixIcon,
    this.elevated,
    this.obscure,
    this.fillColor,
    this.maxLine,
    this.controller,
    this.isLoading,
    this.onChanged,
    this.inputFormatters,
    this.important,
  });
  String? title, hint;
  bool? hasTitle, elevated, obscure, isLoading, important;
  double? height, width, radius;
  int? maxLine;
  TextInputType? keyType;
  Widget? suffixIcon;
  Color? fillColor;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? 90 * size.width / 100,
      child: Column(
        children: [
          hasTitle ?? true
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      kTxt(
                        text: title ?? '',
                        weight: FontWeight.w500,
                        size: 13,
                        color: kColors.blackColor.withOpacity(0.8),
                      ),
                      important ?? false
                          ? kTxt(
                              text: ' *',
                              color: kColors.red,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          hasTitle ?? true ? Height(h: 0.3) : SizedBox.shrink(),
          Material(
            elevation: elevated ?? false ? 1 : 0,
            borderRadius: BorderRadius.circular(radius ?? 5),
            child: SizedBox(
              //  height: height ?? 7 * size.height / 100,
              child: TextField(
                showCursor: true,
                cursorRadius: Radius.zero,
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                style: TextStyle(
                  fontSize: 12,
                ),
                controller: controller,
                maxLines: maxLine ?? 1,
                keyboardType: keyType ?? TextInputType.text,
                obscureText: obscure ?? false ? true : false,
                obscuringCharacter: '*',
                cursorColor: kColors.blackColor,
                readOnly: isLoading ?? false ? true : false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 2 * size.width / 100),
                  filled: true,
                  fillColor: fillColor ?? kColors.whiteColor,
                  hintText: '$hint',
                  hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: kColors.textGrey,
                      fontSize: 12,
                    ),
                  ),
                  suffixIcon: suffixIcon ?? SizedBox.shrink(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 5),
                    borderSide: BorderSide(
                      color: kColors.textGrey,
                      width: 0.1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 5),
                    borderSide: BorderSide(
                      color: kColors.textGrey,
                      width: 0.1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius ?? 5),
                    borderSide: BorderSide(
                      color: kColors.textGrey,
                      width: 0.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTField extends StatelessWidget {
  SearchTField({
    super.key,
    required this.hint,
    this.height,
    this.radius,
    this.width,
    this.keyType,
    this.prefixicon,
    this.elevated,
    this.obscure,
    this.fillColor,
    this.controller,
    this.onChanged,
    this.focused,
  });
  String? hint;
  bool? elevated, obscure;
  double? height, width, radius;
  TextInputType? keyType;
  Widget? prefixicon;
  Color? fillColor;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  FocusNode? focused;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? 90 * size.width / 100,
      child: Column(
        children: [
          SizedBox(
            height: height ?? 6 * size.height / 100,
            child: TextField(
              onChanged: onChanged,
              focusNode: focused ?? null,
              controller: controller ?? null,
              keyboardType: keyType ?? TextInputType.text,
              obscureText: obscure ?? false ? true : false,
              obscuringCharacter: '*',
              cursorColor: kColors.blackColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: fillColor ?? kColors.whitishGrey,
                hintText: '$hint',
                hintStyle: TextStyle(
                  fontFamily: 'Rany',
                  color: kColors.textGrey,
                  fontSize: 14,
                ),
                prefixIcon: prefixicon ?? SizedBox.shrink(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15),
                  borderSide: BorderSide(
                    color: kColors.textGrey,
                    width: 0.1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15),
                  borderSide: BorderSide(
                    color: kColors.textGrey,
                    width: 0.1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15),
                  borderSide: BorderSide(
                    color: kColors.textGrey,
                    width: 0.1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
