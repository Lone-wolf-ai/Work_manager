import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/formatters/formatter.dart';
import '../../../../core/utils/local_storage/storage_utility.dart';
import '../../../../data/models/attendancerecord.dart';
import '../../../../data/models/datetime.dart';
import '../../../../data/service/api/locationtimecontroller.dart';
import '../../../../data/service/repository/authrepository.dart';

class AttendanceController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<AttendanceRecord> attendanceRecords = <AttendanceRecord>[].obs;
  final firebaseRepo = Get.put(FirebaseRepo());
  final timeController = Get.put(LocationTimeController());
  final box = LocalStorage();
  final Logger _logger = Logger();

  var isDataFetched = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Mark the app as restarted
    box.saveData(StringConst.isAppRestarted, true);
    loadLocalAttendanceRecords();
  }

  Future<void> fetchAttendanceRecords() async {
    try {
      _logger.i("Fetching attendance records for user: ${firebaseRepo.currenuser!.uid}");
      QuerySnapshot querySnapshot = await _firestore
          .collection(StringConst.userdata)
          .doc(firebaseRepo.currenuser!.uid)
          .collection(StringConst.attendancerecord)
          .get();

      final List<AttendanceRecord> fetchedRecords = querySnapshot.docs
          .map((doc) =>
              AttendanceRecord.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      _logger.d(
          "Fetched records: ${fetchedRecords.map((record) => record.checkIn).toList()}");
      attendanceRecords.assignAll(fetchedRecords);
      box.saveData(StringConst.attendancerecord, attendanceRecords.last);
      saveLocalAttendanceRecords(fetchedRecords);
      isDataFetched.value = true;
    } catch (e) {
      _logger.e("Failed to fetch attendance records: $e");
      Get.snackbar('Error', 'Failed to fetch attendance records: $e');
      isDataFetched.value = true;
    }
  }

  void saveLocalAttendanceRecords(List<AttendanceRecord> records) {
    try {
      _logger.i("Saving ${records.length} attendance records locally.");
      List<Map<String, dynamic>> jsonRecords =
          records.map((record) => record.toJson()).toList();
      box.saveData(StringConst.listofrec, jsonRecords);
    } catch (e) {
      _logger.e("Failed to save attendance records locally: $e");
    }
  }

  void loadLocalAttendanceRecords() async {
    try {
      _logger.i("Loading local attendance records.");
      List<dynamic> jsonRecords = box.readData(StringConst.listofrec) ?? [];
      if (jsonRecords.isEmpty) {
        _logger.i("No local records found, fetching from Firebase.");
        fetchAttendanceRecords();
      } else {
        final List<AttendanceRecord> localRecords =
            jsonRecords.map((json) => AttendanceRecord.fromJson(json)).toList();
        attendanceRecords.assignAll(localRecords);
        box.saveData(StringConst.attendancerecord, attendanceRecords.last);
        _logger.d(
            "Loaded records: ${localRecords.map((record) => record.checkIn).toList()}");
        isDataFetched.value = true;
        isDataFetched.refresh();
      }
    } catch (e) {
      _logger.e("Failed to load local attendance records: $e");
      isDataFetched.value = true;
      isDataFetched.refresh();
    }
  }

  // Check-in function with app restart flag set to false
  void checkIn(Datetime checkInTime) async {
    try {
      _logger.i("Checking in at: $checkInTime");
      AttendanceRecord newRecord = AttendanceRecord(
          checkIn: checkInTime, checkOut: null, totalHours: '');

      // Save the record locally and in Firestore
      box.saveData(StringConst.attendancerecord, newRecord);
      attendanceRecords.add(newRecord);
      attendanceRecords.refresh();
      saveLocalAttendanceRecords(attendanceRecords);

      // Mark that the app hasn't been restarted yet
      box.saveData(StringConst.isAppRestarted, false);

      await firebaseRepo.createSubCollection(
          StringConst.userdata,
          StringConst.attendancerecord,
          firebaseRepo.currenuser!.uid,
          checkInTime.date!.trim(),
          newRecord.toJson());
    } catch (e) {
      _logger.e("Failed to check in: $e");
      Get.snackbar('Error', 'Failed to check in: $e');
    }
  }

  // Check-out function with 30-minute wait and app restart requirement
  void checkOut(Datetime checkOutTime, String totalHours) async {
    try {
      _logger.i("Checking out at: $checkOutTime");

      if (attendanceRecords.isNotEmpty) {
        AttendanceRecord latestRecord = attendanceRecords.last;

        // Check if the app was restarted after check-in
        bool isAppRestarted = box.readData(StringConst.isAppRestarted) ?? false;
        if (!isAppRestarted) {
          Get.snackbar('Error', 'You must restart the app before checking out.');
          return;
        }

        // Calculate time difference between check-in and check-out
        DateTime checkInDateTime = latestRecord.checkIn!.toDateTime();
        DateTime checkOutDateTime = checkOutTime.toDateTime();
        final difference = checkOutDateTime.difference(checkInDateTime);
        if (difference.inMinutes < 30) {
          Get.snackbar('Error', 'You need to wait at least 30 minutes before checking out.');
          return;
        }

        // Proceed to check-out if all conditions are satisfied
        if (latestRecord.checkIn!.date!.trim() == Formatter.formatDatetime(timeController.datetime.value!).trim()) {
          latestRecord.checkOut = checkOutTime;
          latestRecord.totalHours = totalHours;
          attendanceRecords[attendanceRecords.length - 1] = latestRecord;

          // Save the updated record locally and to Firestore
          box.saveData(StringConst.attendancerecord, latestRecord);
          saveLocalAttendanceRecords(attendanceRecords);

          await firebaseRepo.updateSubcollectionData(
            StringConst.userdata,
            firebaseRepo.currenuser!.uid,
            latestRecord.checkIn!.date!,
            StringConst.attendancerecord,
            latestRecord.toJson()
          );

          // Reset the app restart flag after checkout
          box.saveData(StringConst.isAppRestarted, false);
        } else {
          _logger.e("Already checked out.");
          Get.snackbar('Error', 'Already checked out.');
        }
      } else {
        _logger.e("No check-in record found.");
        Get.snackbar('Error', 'No check-in record found.');
      }
    } catch (e) {
      _logger.e("Failed to check out: $e");
      Get.snackbar('Error', 'Failed to check out: $e');
    }
  }

  AttendanceRecord? getLastAttendanceRecord() {
    return attendanceRecords.isNotEmpty ? attendanceRecords.last : null;
  }
}
