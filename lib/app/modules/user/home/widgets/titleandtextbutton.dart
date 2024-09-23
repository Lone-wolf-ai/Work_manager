import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TitleAndTextButton extends StatelessWidget {
  const TitleAndTextButton({
    super.key,
    required this.title,
    required this.onPressed, this.addfun=false,
  });
  final String title;
  final VoidCallback onPressed;
  final bool addfun;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title.text.gray700.size(22).bold.make(),
      if(addfun)  Row(
          children: [
            "Check All".text.semiBold.gray500.size(16).make(),
            4.widthBox,
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Vx.gray500,
            )
          ],
        ).onTap(onPressed)
      ],
    );
  }
}
