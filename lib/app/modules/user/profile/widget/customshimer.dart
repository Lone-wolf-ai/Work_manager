import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCircleShimmer extends StatelessWidget {
  const CustomCircleShimmer({super.key, this.height=120,this.width=120});
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width:width,
        height:height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
        ),
      ),
    );
  }
}


