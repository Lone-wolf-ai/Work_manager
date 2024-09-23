import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../data/service/api/locationtimecontroller.dart';

class TimeAndDate extends StatelessWidget {
  const TimeAndDate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationTimeController());

    return Obx(() {
      final datetime = controller.datetime.value;

      if (datetime == null || datetime.time == null) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Vx.gray300,
            ),
          ),
        ).paddingSymmetric(vertical: 10);
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            datetime.time!.text.size(32).bold.gray700.make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                datetime.date!.text.semiBold.gray600.make(),
                " - ".text.semiBold.size(18).gray500.make(),
                datetime.dayOfWeek!.text.semiBold.gray500.size(18).make(),
              ],
            ),
          ],
        )
        .paddingSymmetric(horizontal: 10, vertical: 20)
        .box
        .width(double.infinity)
        .height(140)
        .make();
      }
    });
  }
}
