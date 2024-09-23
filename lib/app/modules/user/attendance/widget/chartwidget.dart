import '../../../../data/models/chartdata.dart';
import '../controller/chartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chartwidget extends StatelessWidget {
  final ChartController _controller = Get.put(ChartController());

  Chartwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: const ChartTitle(text: "January"),
      legend: const Legend(isVisible: true),
      tooltipBehavior: _controller.tooltip,
      series: <CircularSeries<ChartData, String>>[
        DoughnutSeries<ChartData, String>(
          dataSource: _controller.data,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          name: '',
        ),
      ],
    );
  }
}
