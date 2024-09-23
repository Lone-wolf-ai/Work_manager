import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TimeFetch extends StatelessWidget {
  const TimeFetch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          "Loading time data of your Zone....".text.gray400.make(),
          8.heightBox,
          const LinearProgressIndicator().box.width(120).make(),
        ],
      ),
    );
  }
}
