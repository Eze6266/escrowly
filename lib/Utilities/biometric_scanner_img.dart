import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/app_colors.dart';
import 'package:trustbridge/Utilities/image_constants.dart';

class BiometricScan extends StatelessWidget {
  const BiometricScan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      period: Duration(seconds: 3),
      baseColor: kColors.primaryColor,
      highlightColor: Color(0xffFFD700),
      child: Image.asset(
        kImages.fingerprint,
        height: 5 * size.height / 100,
        color: kColors.primaryColor,
      ),
    );
  }
}
