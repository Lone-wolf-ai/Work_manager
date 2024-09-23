import 'package:velocity_x/velocity_x.dart';
import 'modules/user/attendance/attendance_view.dart';
import 'modules/user/home/home_view.dart';
import 'modules/user/home/widgets/longpressfab/view/view.dart';
import 'modules/user/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'modules/user/task/task_view.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              controller.changeIndex(index);
            },
            children: const [
              HomePage(),
              AttendanceView(),
              TaskView(),
              ProfileView(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: const BoxDecoration(
                color: Vx.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(
                      icon: Iconsax.home_15,
                      label: 'Home',
                      selected: controller.selectedIndex.value == 0,
                      onTap: () {
                        controller.changeIndex(0);
                      },
                    ),
                    _buildNavItem(
                      icon: Icons.check_circle,
                      label: 'Attendance',
                      selected: controller.selectedIndex.value == 1,
                      onTap: () {
                        controller.changeIndex(1);
                      },
                    ),
                    const SizedBox(width: 48), // Space for the floating action button
                    _buildNavItem(
                      icon: Iconsax.task_square5,
                      label: 'Tasks',
                      selected: controller.selectedIndex.value == 2,
                      onTap: () {
                        controller.changeIndex(2);
                      },
                    ),
                    _buildNavItem(
                      icon: Iconsax.profile_2user5,
                      label: 'Profile',
                      selected: controller.selectedIndex.value == 3,
                      onTap: () {
                        controller.changeIndex(3);
                      },
                    ),
                  ],
                ).paddingSymmetric(horizontal: 12);
              }),
            ),
          ),
          Positioned(
            bottom: 30.0,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: const LongPressFAB(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: selected ? Vx.gray800 : Colors.grey[500],
          ),
          Text(
            label,
            style: TextStyle(
              color: selected ? Vx.gray800 : Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);

  void changeIndex(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
