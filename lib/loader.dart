import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/data/service/api/locationtimecontroller.dart';
import 'app/loader/datafetching.dart';
import 'app/loader/timefetch.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    final timeController = Get.put(LocationTimeController());

    return Scaffold(
      body: Obx(() => timeController.isDataFetched.value
          ? const DataFetching()
          : const TimeFetch()),
    );
  }
}


