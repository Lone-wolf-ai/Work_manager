import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class Loaders {
  static void hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  // static void customToast({required String message}) {
  //   ScaffoldMessenger.of(Get.context!).showSnackBar(
  //     SnackBar(
  //       elevation: 0, // Remove shadow effect
  //       duration:
  //           const Duration(seconds: 3), // Duration for which the toast appears
  //       backgroundColor: Colors.transparent, // Make background transparent
  //       content: Container(
  //         padding: const EdgeInsets.all(12.0), // Padding around the content
  //         margin:
  //             const EdgeInsets.symmetric(horizontal: 30), // Horizontal margin
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(30), // Rounded corners
  //           color: THelperFunctions.isDarkMode(Get.context!)
  //               ? CustomColour.darkerGrey.withOpacity(0.9)
  //               : CustomColour.white, // Adjust color based on dark mode
  //         ),
  //         child: Center(
  //           child: Text(
  //             message,
  //             style: Theme.of(Get.context!).textTheme.labelLarge, // Text style
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static void successSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Vx.gray500,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds:3),
      icon: const Icon(Icons.check_circle_outline, color:Vx.green400),
    );
  }

  static void warningSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Vx.gray500,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.warning, color:Vx.yellow500),
    );
  }

  static void errorSnackBar({
    required String title,
    String message = '',
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Vx.white,
      backgroundColor: Vx.gray500,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color:Vx.red500),
    );
  }

  static void notificationSnackBar() {
    Get.snackbar("No image selected",
     '',
     duration: const Duration(seconds: 3),
     snackPosition: SnackPosition.BOTTOM);
  }
}
