
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../core/utils/popups/loaders.dart';
import 'controller/registercontroller.dart';
import 'widget/registerbutton.dart';
import 'widget/registerform.dart';
import 'widget/tologinscreen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: "Register Here".text.bold.make(),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => RegisterForm(
                          username: controller.usernameController,
                          email: controller.emailController,
                          password: controller.passwordController,
                          confirmpassword: controller.confirmPasswordController,
                          phonenumber: controller.phoneNumberController,
                          obscurepass: controller.showPassword.value,
                          obscureconfirmpass:
                              controller.confirmShowPassword.value,
                          obscurepassfunc: () => controller.showPassword.value =
                              !controller.showPassword.value,
                          obscureconfirmpassfunc: () => controller
                              .confirmShowPassword
                              .value = !controller.confirmShowPassword.value,
                          address: controller.addressController, fullname: controller.fullnameController,
                        ),
                      ),
                      const SizedBox(height: 64.0),
                      RegisterButton(
                        onPressed: () {
                          if (controller.passwordController.text.trim() ==
                              controller.confirmPasswordController.text
                                  .trim()) {
                            controller.registerAccount();
                          }else if(controller.passwordController.text.trim()!=controller.confirmPasswordController.text.trim()){
                            Loaders.errorSnackBar(title: "Password doesn't match",message: "Check Password and Confirm password");                          }
                        },
                      ),
                      32.heightBox,
                      const ToLoginScreen(),
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
