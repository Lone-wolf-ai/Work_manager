import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:work_manger_tool/app/core/utils/constants/string_const.dart';
import 'package:work_manger_tool/app/data/service/api/locationtimecontroller.dart';

import '../../models/weathermodel.dart';

class WeatherService{
  
  Future<Weathemodel> getCurrentWeather() async {
     final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best
      );
    var link =
        "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${StringConst.apiKey}&units=metric";
    var res = await http.get(Uri.parse(link));
    
    if (res.statusCode == 200) {
      var data = weathemodelFromJson(res.body.toString());
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

}
