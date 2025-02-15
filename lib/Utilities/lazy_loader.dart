import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trustbridge/Utilities/app_colors.dart';

class OngoingLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: List.generate(4, (index) => buildShimmerItem(size)),
        ),
      ),
    );
  }

  Widget buildShimmerItem(Size size) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1 * size.height / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 10 * size.height / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class NormalLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: List.generate(1, (index) => buildShimmerItem(size)),
        ),
      ),
    );
  }

  Widget buildShimmerItem(Size size) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1 * size.height / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 10 * size.height / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class IncomingLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: List.generate(1, (index) => buildShimmerItem(size)),
        ),
      ),
    );
  }

  Widget buildShimmerItem(Size size) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80 * size.width / 100,
            height: 11 * size.height / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class FavLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: List.generate(1, (index) => buildShimmerItem(size)),
        ),
      ),
    );
  }

  Widget buildShimmerItem(Size size) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Container(
        width: 20 * size.width / 100,
        height: 35 * size.height / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kColors.whiteColor,
        ),
      ),
    );
  }
}
