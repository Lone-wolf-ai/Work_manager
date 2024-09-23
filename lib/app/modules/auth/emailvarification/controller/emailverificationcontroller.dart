import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/popups/loaders.dart';
import '../../../../data/service/repository/authrepository.dart';
import '../../../../navigation.dart';

class EmailVerificationController extends GetxController {
  static EmailVerificationController get instance => Get.find();

  // Logger instance
  final Logger logger = Logger();

  @override
  void onInit() {
    logger.d("Initializing EmailVerificationController.");
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      logger.d("Sending email verification.");
      await FirebaseRepo.instance.sendVerificationEmail();
      Loaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please check your inbox and verify your email');
      logger.d("Email verification sent successfully.");
    } catch (e) {
      logger.e("Failed to send email verification: $e");
      Loaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  setTimerForAutoRedirect() async {
    logger.d("Setting timer for auto redirect.");
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      logger.d("Checking email verification status.");
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        logger.d("Email verified. Redirecting to NavigationScreen.");
        Loaders.successSnackBar(
            title: "Email Verified", message: "You can proceed");
        Get.offAll(() => const NavigationScreen());
      }
    });
  }

  checkEmailVerificationStatus() async {
    logger.d("Checking email verification status.");
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      logger.d("Email verified. Redirecting to NavigationScreen.");
      Loaders.successSnackBar(
          title: "Email Verified", message: "You can proceed");
      Get.offAll(() => const NavigationScreen());
    }
  }
}
