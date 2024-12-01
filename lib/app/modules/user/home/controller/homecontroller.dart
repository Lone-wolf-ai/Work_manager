
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:work_manger_tool/app/modules/user/attendance/controller/attendancecontroller.dart';

import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/formatters/formatter.dart';
import '../../../../core/utils/local_storage/hive_storage.dart';
import '../../../../data/models/attendancerecord.dart';
import '../../../../data/models/datetime.dart';
import '../../../../data/service/api/locationtimecontroller.dart';
import '../../../../data/service/repository/authrepository.dart';

class HomeController extends GetxController {
  ///singleton method
  static HomeController get instance => Get.find();
  //location time controller
  final LocationTimeController timeController =
      Get.put(LocationTimeController());
  //attendance controller
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final FirebaseRepo firebaseRepo = Get.put(FirebaseRepo());
  Rx<AttendanceRecord> record = AttendanceRecord().obs;
  final checkedIn = false.obs;
  final checkedOut = false.obs;
  final loader = false.obs;
  final LocalStorage localStorage = LocalStorage();
  final Logger logger = Logger();

  @override
  void onInit() async {
    super.onInit();
    if (localStorage.readData(StringConst.attendancerecord) != null) {
      logger.d("local data is not null");
      final AttendanceRecord temp=localStorage.readData(StringConst.attendancerecord);
      logger.d("current atendance rec ${temp.toJson()}");
      logger.d("current time date ${localStorage.readData(StringConst.date)}");
      if (temp.checkIn!.date ==
          localStorage.readData(StringConst.date)) {
        record.value = localStorage.readData(StringConst.attendancerecord);
        if(record.value.checkIn!=null) checkedIn.value=true;
        if(record.value.checkOut!=null) checkedOut.value=true;
      } else {
        localStorage.removeData(StringConst.attendancerecord);
      }
    }else{
      logger.d("local storage null");
    }
  }

  getattendanceData() {
    final doc = localStorage.readData(StringConst.attendancerecord);
    if (doc.checkIn != null) {
      if (doc.checkIn!.date!.trim() !=
          Formatter.formatDatetime(timeController.datetime.value!)) {
        logger.d(
            "Not found doc date ${doc.checkIn!.date!.trim()} and time controller ${timeController.datetime.value!.date!.trim()}");
      } else {
        record.value = doc;
        record.refresh();
        logger.d("updated");
      }
    } else {
      logger.d("Attendance record is null");
    }
  }

  checkincheckout() {
    if (checkedIn.value == false && checkedOut.value == false) {
      final timedata = timeController.datetime.value;
      final time=timedata;
      logger.d("Cheking in .......");

      record.value=AttendanceRecord(checkIn: time,checkOut: null,totalHours: null);
      attendanceController.checkIn(timedata!);
      logger.d("Set value to true in checkin in value");
      checkedIn.value = true;
      checkedIn.refresh();
      logger.d("saving value to local storage");
      localStorage.saveData(StringConst.checkedIn, checkedIn.value);
    } else if (checkedIn.value == true && checkedOut.value == false) {
      final timedata = timeController.datetime.value;
      final time=timedata;
      
      logger.d("Cheking out.......");
      record.update((user){
        user!.checkOut=time;
        user.totalHours=_calculateTotalHours(record.value.checkIn,time);
      });
      attendanceController.checkOut(timedata!,record.value.totalHours!);
      localStorage.saveData(StringConst.attendancerecord, record.value);
      logger.d("Set value to true in checkout in value");
      checkedOut.value= true;
      logger.d("saving value to local storage");
      localStorage.saveData(StringConst.checkedout, checkedOut.value);
    }else if(checkedIn.value == true && checkedOut.value == true){
      Get.snackbar("You Already Checked Out today","Wish you a good day");
    }else{
      Get.snackbar("You Already Checked Out today","Wish you a good day");
    }
  }

  String _calculateTotalHours(Datetime? checkIn, Datetime? checkOut) {
    if (checkIn == null || checkOut == null) return '0h 0m 0s';

    final checkInDateTime = DateTime(
      checkIn.year!,
      checkIn.month!,
      checkIn.day!,
      checkIn.hour!,
      checkIn.minute!,
      checkIn.seconds ?? 0,
      checkIn.milliSeconds ?? 0,
    );

    final checkOutDateTime = DateTime(
      checkOut.year!,
      checkOut.month!,
      checkOut.day!,
      checkOut.hour!,
      checkOut.minute!,
      checkOut.seconds ?? 0,
      checkOut.milliSeconds ?? 0,
    );

    final duration = checkOutDateTime.difference(checkInDateTime);

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return '${hours}h ${minutes}m ${seconds}s';
  }

  void updateCheckInStatus(AttendanceRecord record) {
    this.record.value = record;
    checkedIn.value = true;
    checkedOut.value = false;
  }

  void updateCheckOutStatus(AttendanceRecord record) {
    this.record.value = record;
    checkedOut.value = true;
  }
}