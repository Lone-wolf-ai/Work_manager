import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:work_manger_tool/app/core/utils/customScreen/dotlottieanitmation.dart';

import '../core/utils/constants/string_const.dart';
import '../core/utils/local_storage/storage_utility.dart';
import '../modules/user/attendance/controller/attendancecontroller.dart';
import '../core/utils/navigation/navigation.dart';

class DataFetching extends StatelessWidget {
  const DataFetching({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = Get.put(AttendanceController());
    LocalStorage localStorage = LocalStorage();

    // Perform the necessary actions and save data
    if (attendanceController.isDataFetched.value) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(() => const NavigationScreen());
      });
      localStorage.saveData(StringConst.fasttimeloggedin, true);
    }
    return const CustomAnimationScreen1(asset: StringConst.animation1, detail: StringConst.screendata2);
  }
}
