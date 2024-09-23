import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'widget/form.dart';
import 'widget/sendbutton.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: "Forgot Password".text.bold.make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      "Please fill the email form.We will send you a link to reset your password. Click the link to reset your password."
                          .text
                          .size(16)
                          .gray500
                          .semiBold
                          .make(),
                      32.heightBox,
                      const ForgotPasswordForm(),
                      const SizedBox(height: 32.0),
                      const SendButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



