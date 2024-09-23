import '../../../../data/models/chartdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartController extends GetxController {
  var data = <ChartData>[
    ChartData('Present', 25, Colors.green),
    ChartData('Absent', 38, Colors.red),
    ChartData('Granted Leave', 20, Colors.blue),
  ].obs;
  late TooltipBehavior tooltip;

  @override
  void onInit() {
    super.onInit();
    tooltip = TooltipBehavior(enable: true);
  }
}
