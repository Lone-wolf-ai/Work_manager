import 'dart:async';
import 'package:get/get.dart';
import 'package:work_manger_tool/app/modules/user/home/controller/homecontroller.dart';

class LongPressFABController extends GetxController {
  var isPressed = false.obs;
  var progressValue = 0.0.obs;
  Timer? _timer;
  final homecontroller=Get.put(HomeController());
  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      progressValue.value += 0.05;
      if (progressValue.value >= 1.0) {
        executeFunction();
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    progressValue.value = 0.0;
  }

  void executeFunction() {
    homecontroller.checkincheckout();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
