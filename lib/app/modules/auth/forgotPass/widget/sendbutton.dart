import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your send logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: "Send"
          .text
          .bold
          .white
          .size(20)
          .make()
          .centered()
          .box
          .width(double.infinity)
          .height(64)
          .make(),
    );
  }
}