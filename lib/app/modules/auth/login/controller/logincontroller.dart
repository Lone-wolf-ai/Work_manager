import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import '../../../../../loader.dart';
import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../../core/utils/local_storage/storage_utility.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../../../data/service/api/locationtimecontroller.dart';
import '../../emailvarification/emailverificationscreen.dart';

class LoginController extends GetxController {
  // Singleton pattern for AuthController instance
  static LoginController get instance => Get.find();

  // Firebase repository instance
  // final FirebaseRepo firebaseRepo = Get.put(FirebaseRepo());

  // Controllers for user input
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final RxBool showPassword = false.obs;

  // Initialize local storage
  final LocalStorage localStorage = LocalStorage();

  // Logger instance
  final Logger logger = Logger();

  /// Sign in user with email and password.
  Future<void> signInWithEmailAndPassword() async {
    bool isConnected = await InternetConnection().hasInternetAccess;
    if (!isConnected) {
      Get.snackbar('Error', 'No internet connection detected.');
      return; 
    }
    try {
      if (loginEmailController.text.trim() != '' &&
          loginPasswordController.text.trim() != '') {
        logger.d("Starting sign in process.");
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: loginEmailController.text.trim(),
                password: loginPasswordController.text.trim());

        if (userCredential.user != null &&
            userCredential.user!.emailVerified == true) {
          Loaders.successSnackBar(title: "Successfully logged in");
          await localStorage.saveData(StringConst.loggedin, true);
          logger.d(
              "User signed in and email verified. Restarting LocationTimeController and navigating to Test screen.");

          // Restart LocationTimeController
          Get.delete<LocationTimeController>();
          Get.put(LocationTimeController());
          Get.offAll(() => const Test());
        } else if (userCredential.user != null &&
            userCredential.user!.emailVerified == false) {
          logger.d(
              "User signed in but email not verified. Navigating to EmailVerificationScreen.");
          Get.offAll(() => const Emailverificationscreen());
        } else if (userCredential.user == null) {}
      } else {
        Loaders.warningSnackBar(
            title: "Email or password is empty",
            message: "Please recheck both  than login");
      }
    } on FirebaseAuthException catch (e) {
      logger.e("FirebaseAuthException: ${e.message}");
      Get.snackbar('Sign In Error', FirebaseExceptionString(e.code).message);
    } on PlatformException catch (e) {
      logger.e("PlatformException: ${e.message}");
      Get.snackbar('Platform Error', PlatformExceptionString(e.code).message);
    } catch (e) {
      logger.e("Exception: ${e.toString()}");
      if (kDebugMode) {
        print(e.toString());
      }
      Get.snackbar('Error', 'An unexpected error occurred.');
    }
  }
}
