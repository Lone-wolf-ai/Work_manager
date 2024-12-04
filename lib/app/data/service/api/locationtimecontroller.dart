import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/string_const.dart';
import '../../../core/utils/formatters/formatter.dart';
import '../../../core/utils/local_storage/storage_utility.dart';
import '../../../loader/datafetching.dart';
import '../../models/datetime.dart';

class LocationTimeController extends GetxController {
  final Rx<Datetime?> datetime = Datetime().obs;
  final RxBool isDataFetched = false.obs;
  final Logger logger = Logger();
  final LocalStorage localStorage = LocalStorage();
  StreamSubscription<DateTime?>? _timeSubscription;
  final RxDouble lat=0.0.obs;
  final RxDouble lon=0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _requestLocationPermissionAndFetchTime();
  }

  @override
  void onClose() {
    _timeSubscription?.cancel();
    super.onClose();
  }

  Future<void> _requestLocationPermissionAndFetchTime() async {
    final permission = await Permission.location.request();
    if (permission.isGranted) {
      await _fetchTimeFromAPI();
    } else {
      _handleError('Location permission denied');
    }
  }

  Future<void> _fetchTimeFromAPI() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best
      );

      final url = Uri.parse(
        "https://timeapi.io/api/Time/current/coordinate?latitude=${position.latitude}&longitude=${position.longitude}"
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        datetime.value = Datetime.fromJson(data);
        await localStorage.saveData(StringConst.date, Formatter.formatDatetime(datetime.value!));
        isDataFetched.value = true;
        if (localStorage.readData(StringConst.fasttimeloggedin) == null) {
          Get.offAll(() => const DataFetching());
        }
        _startTimer();
      } else {
        _handleError('Failed to get location time');
      }
    } catch (e) {
      _handleError('Error fetching time zone data: $e');
    }
  }

  void _startTimer() {
    _timeSubscription?.cancel();
    _timeSubscription = Stream<DateTime?>.periodic(const Duration(seconds: 1), (_) {
      if (datetime.value != null) {
        return DateTime(
          datetime.value!.year!,
          datetime.value!.month!,
          datetime.value!.day!,
          datetime.value!.hour!,
          datetime.value!.minute!,
          datetime.value!.seconds!,
          datetime.value!.milliSeconds!,
        ).add(const Duration(seconds: 1));
      }
      return null;
    }).listen((currentDateTime) {
      if (currentDateTime != null) {
        datetime.update((val) {
          val!
            ..year = currentDateTime.year
            ..month = currentDateTime.month
            ..day = currentDateTime.day
            ..hour = currentDateTime.hour
            ..minute = currentDateTime.minute
            ..seconds = currentDateTime.second
            ..milliSeconds = currentDateTime.millisecond
            ..dateTime = currentDateTime.toIso8601String()
            ..date = "${currentDateTime.year}-${currentDateTime.month.toString().padLeft(2, '0')}-${currentDateTime.day.toString().padLeft(2, '0')}"
            ..time = "${currentDateTime.hour.toString().padLeft(2, '0')}:${currentDateTime.minute.toString().padLeft(2, '0')}:${currentDateTime.second.toString().padLeft(2, '0')}";
        });
      }
    });
  }

  void _handleError(String message) {
    logger.e(message);
    if (kDebugMode) {
      print(message);
    }
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }
}
