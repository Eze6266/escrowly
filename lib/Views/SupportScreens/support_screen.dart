// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';
import 'package:trustbridge/Utilities/reusables.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColors.primaryColor,
        toolbarHeight: 0.001,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                kImages.supportimg,
                height: 30 * size.height / 100,
                width: double.infinity,
              ),
            ),
            kTxt(
              text: 'How can we help you?',
              size: 16,
              weight: FontWeight.w500,
            ),
            Height(h: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SupportBoxes(
                  txt: 'Live Chat',
                  txt2: 'Chat now',
                  img: kImages.livechat,
                  onTap: () {},
                ),
                Width(w: 6),
                SupportBoxes(
                  txt: 'Facebook',
                  txt2: '@escrowly',
                  img: kImages.facebook,
                  onTap: () {},
                ),
              ],
            ),
            Height(h: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SupportBoxes(
                  txt: 'Instagram',
                  txt2: '@escrowly',
                  img: kImages.instagram,
                  onTap: () {},
                ),
                Width(w: 6),
                SupportBoxes(
                  txt: 'X(Twitter)',
                  txt2: '@escrowly',
                  img: kImages.twitter,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SupportBoxes extends StatelessWidget {
  SupportBoxes({
    super.key,
    required this.img,
    required this.txt,
    required this.txt2,
    required this.onTap,
  });
  String txt, img, txt2;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 0.5,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 16 * size.height / 100,
          width: 38 * size.width / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kColors.whitishGrey.withOpacity(0.3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: kColors.purple,
                backgroundImage: AssetImage(
                  img,
                ),
              ),
              Height(h: 1),
              Shimmer.fromColors(
                period: Duration(seconds: 3),
                baseColor: kColors.primaryColor,
                highlightColor: Color(0xffFFD700),
                child: kTxt(
                  text: txt,
                  weight: FontWeight.w500,
                ),
              ),
              Height(h: 1),
              kTxt(
                text: txt2,
                weight: FontWeight.w400,
                size: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
