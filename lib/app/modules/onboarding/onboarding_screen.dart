
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../core/utils/constants/string_const.dart';
import 'controller/onboarding_controller.dart';
import 'widget/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});



  @override
  Widget build(BuildContext context) {
      final OnboardingController onboardingController =
      Get.put(OnboardingController());
    return SafeArea(
      top: false,
        child: Scaffold(
          backgroundColor: Vx.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: onboardingController.pageController,
              onPageChanged: onboardingController.onPageChanged,
              children: const [
                OnboardingPage(
                  animation: StringConst.first,
                  title: 'Welcome',
                  subtitle: 'Here you can manage your Attendance',
                ),
                OnboardingPage(
                  animation: StringConst.second,
                  title: 'Explore',
                  subtitle:
                      'We added few extra features(notification, task manager) to make it easier to manage your work',
                ),
                OnboardingPage(
                  animation: StringConst.third,
                  title: 'Get Started',
                  subtitle: 'Register/Login to use this app',
                ),
              ],
            ),
          ),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return buildDot(
                    index, context, onboardingController.currentPage.value);
              }),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: onboardingController.nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), 
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 24.0), 
              ),
              child: Obx(() {
                return Text(
                  onboardingController.isLastPage ? 'Get Started' : 'Next',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                );
              }),
            ),
          ).objectTopRight(),
        ],
      ),
    ));
  }

  Widget buildDot(int index, BuildContext context, int currentPage) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.grey[800] : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
