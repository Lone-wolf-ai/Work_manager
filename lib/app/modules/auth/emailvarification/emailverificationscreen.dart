import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../login/login_screen.dart';
import 'controller/emailverificationcontroller.dart';

class Emailverificationscreen extends StatelessWidget {
  const Emailverificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(EmailVerificationController());
    return Scaffold(
      appBar: AppBar(
        title: "Email Verification".text.bold.make(),
      ),
      body: Column(
        children: [
          "Please click on the link we send to your email to verify.If you dont get the link, click on Resend verification email button or consider re-register."
              .text.semiBold.gray600
              .make(),
          64.heightBox,
          ElevatedButton(
              onPressed: ()=>controller.sendEmailVerification,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: "Resend verification email".text.white.semiBold.make()),
              8.heightBox,
              ElevatedButton(
              onPressed: ()=>Get.to(()=>const LoginScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: "Back to Login Screen".text.white.semiBold.make())
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
