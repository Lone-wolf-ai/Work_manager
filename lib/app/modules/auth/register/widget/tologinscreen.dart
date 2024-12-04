import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../login/login_screen.dart';

class ToLoginScreen extends StatelessWidget {
  const ToLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        "Already have an account? ".text.semiBold.gray500.size(16).make(),
        "Login Here"
            .text
            .bold
            .gray600
            .size(16)
            .make()
            .onTap(() => Get.to(() => const LoginScreen())),
      ],
    );
  }
}