
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:work_manger_tool/app/data/models/weathermodel.dart';
import 'package:work_manger_tool/app/data/service/api/weatherdata.dart';
import 'package:work_manger_tool/app/modules/user/attendance/controller/attendancecontroller.dart';

import '../../../../core/utils/constants/string_const.dart';
import '../../../../core/utils/formatters/formatter.dart';
import '../../../../core/utils/local_storage/storage_utility.dart';
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
    final Rx<Weathemodel> emptyWeathemodel = Weathemodel(
    coord: Coord(lon: 0.0, lat: 0.0),
    weather: [],
    base: '',
    main: Main(
        temp: 0.0,
        feelsLike: 0.0,
        tempMin: 0.0,
        tempMax: 0.0,
        pressure: 0,
        humidity: 0),
    visibility: 0,
    wind: Wind(speed: 0.0, deg: 0),
    clouds: Clouds(all: 0),
    dt: 0,
    sys: Sys(type: 0, id: 0, country: '', sunrise: 0, sunset: 0),
    timezone: 0,
    id: 0,
    name: '',
    cod: 0,
  ).obs;
  final locationname="".obs;
  @override
  void onInit() async {
    super.onInit();
    emptyWeathemodel.value= await WeatherService().getCurrentWeather();
    getAddressFromLatLng();
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
    Future<void> getAddressFromLatLng() async {
         final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude); // Example coordinates for San Francisco
      Placemark place = placemarks[0];
      locationname.value = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

    
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