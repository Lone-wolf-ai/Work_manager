
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/exceptions/firebase_exceptions.dart';
import '../../../../core/utils/exceptions/platform_exceptions.dart';
import '../../../../core/utils/local_storage/hive_storage.dart';
import '../../../../core/utils/popups/loaders.dart';
import '../../../../data/models/userdata.dart';
import '../../../../data/service/repository/authrepository.dart';
import '../../../user/profile/controller/profilecontroller.dart';
import '../../emailvarification/emailverificationscreen.dart';

class RegisterController extends GetxController {
  // Singleton method
  static RegisterController get instance => Get.find();

  // Password obscure controller
  final RxBool showPassword = true.obs;
  final RxBool confirmShowPassword = true.obs;

  // Initialized Firebase repository
  final FirebaseRepo firebaseRepo = Get.put(FirebaseRepo());
  // Init profile controller
  final profileController = Get.put(ProfileController());
  // Input controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Initialize local storage
  final LocalStorage localStorage = LocalStorage();

  // Logger instance
  final Logger logger = Logger();



  /// Register a new user account.
  Future<void> registerAccount() async {
    try {
      logger.d("Starting account registration process.");
      final UserCredential userCredential = await firebaseRepo.registerWithEmailandPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      await userCredential.user!.sendEmailVerification();
      logger.d("Email verification sent to ${emailController.text.trim()}.");

      // Create variable
      final UserModel newUser = UserModel(
        name: usernameController.text.trim(),
        id: userCredential.user!.uid,
        email: emailController.text.trim(),
        phonenumber: phoneNumberController.text.trim(),
        address: addressController.text.trim(), fullname: fullnameController.text.trim(),
      );
      
      // Upload to database using user credential uid as doc id
      await firebaseRepo.createCollection(
        StringConst.userdata,
        newUser.toJson(),
        docId: userCredential.user!.uid,
      );
      logger.d("New user data uploaded to Firestore.");

      // Assign data to profile user data
      profileController.userdata.value = newUser;

      // Saving user data to minimize database read
      await localStorage.saveData(StringConst.userdata, newUser.toJson());
      await localStorage.saveData(StringConst.registered, true);
      await localStorage.saveData(StringConst.verified, false);
      logger.d("User data saved locally.");
      
    } on FirebaseAuthException catch (e) {
      logger.e("FirebaseAuthException: ${e.message}");
      Get.snackbar('Registration Error', FirebaseExceptionString(e.code).message);
    } on PlatformException catch (e) {
      logger.e("PlatformException: ${e.message}");
      Get.snackbar('Platform Error', PlatformExceptionString(e.code).message);
    } catch (e) {
      logger.e("Exception: ${e.toString()}");
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      Loaders.successSnackBar(
        title: "Your Account has been created.",
        message: "We sent an email to verify your email. Please click on the link",
      );
      logger.d("Account registration process completed. Navigating to EmailVerificationScreen.");
      Get.to(() => const Emailverificationscreen());
    }
  }
}
