import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: "Login"
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
