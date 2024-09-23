import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/string_const.dart';
import '../../../core/utils/local_storage/storage_utility.dart';
import '../../auth/login/login_screen.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  LocalStorage localStorage=LocalStorage();
  var currentPage = 0.obs;

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void nextPage() {
    if (currentPage.value == 2) {
      localStorage.saveData(StringConst.isfirst,true);
      Get.to(()=>const LoginScreen());
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  bool get isLastPage => currentPage.value == 2;
}

         