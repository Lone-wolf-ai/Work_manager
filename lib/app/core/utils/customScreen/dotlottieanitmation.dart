import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:work_manger_tool/app/core/utils/constants/string_const.dart';

class CustomAnimationScreen1 extends StatelessWidget {
  const CustomAnimationScreen1({super.key, required this.asset, required this.detail});
  final String asset;
  final String detail;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Vx.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DotLottieLoader.fromAsset(asset,
                frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
              if (dotlottie != null) {
                return Lottie.memory(dotlottie.animations.values.single);
              } else {
                return Container();
              }
            }).box.width(double.infinity).make().pSymmetric(h: 12),
            detail
                .text
                .gray400
                .make(),
            8.heightBox,
            const LinearProgressIndicator().box.width(120).make(),
          ],
        ),
      ),
    );
  }
}