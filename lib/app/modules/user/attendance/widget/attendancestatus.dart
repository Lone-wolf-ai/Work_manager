import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendanceStatus extends StatelessWidget {
  const AttendanceStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Present".text.bold.size(20).green500.make(),
            8.heightBox,
            "80".text.gray500.semiBold.size(20).make(),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Absent".text.red400.bold.size(20).make(),
            8.heightBox,
            "80".text.gray500.semiBold.size(20).make(),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Granted Leave".text.blue500.bold.size(20).make(),
            8.heightBox,
            "80".text.gray500.semiBold.size(20).make(),
          ],
        ),
      ],
    ).box.white.height(120).width(double.infinity).rounded.shadow.make();
  }
}
