import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Orwidget extends StatelessWidget {
  const Orwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 0.8, color: Vx.gray500)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: "or".text.bold.gray500.size(16).make(),
        ),
        const Expanded(child: Divider(thickness: 0.8, color: Vx.gray500)),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}