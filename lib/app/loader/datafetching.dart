import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/utils/constants/string_const.dart';
import '../core/utils/local_storage/storage_utility.dart';
import '../modules/user/attendance/controller/attendancecontroller.dart';
import '../navigation.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Fetching your information from the database...."
                .text
                .gray400
                .make(),
            8.heightBox,
            const LinearProgressIndicator().box.width(120).make(),
          ],
        ),
      ),
    );
  }
}
