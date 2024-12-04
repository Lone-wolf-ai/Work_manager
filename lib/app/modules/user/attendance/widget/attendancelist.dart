
import 'package:get/get.dart';

import '../../../../core/utils/constants/string_const.dart';
import '../controller/attendancecontroller.dart';
import 'attendancecard.dart';
import 'package:flutter/material.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    final controller = Get.put(AttendanceController());
    return Obx(
      ()=> ListView.separated(
          shrinkWrap: true,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final record = controller.attendanceRecords[index];
            return AttendanceCard(
              totalHours: record.totalHours ?? "__/__",
              checkedIn: record.checkIn?.time ?? "__/__",
              checkedOut: record.checkOut==null?"__/__":record.checkOut!.time!,
              day:record.checkIn?.day!=null? record.checkIn!.day.toString():"__/__",
              month:record.checkIn?.month!=null?StringConst.months[record.checkIn!.month!-1]:"__/__",
              year: record.checkIn?.year!=null?record.checkIn!.year.toString():"__/__",
            );
          },
          separatorBuilder: (_, __) => const SizedBox(
                height: 0,
              ),
          itemCount: controller.attendanceRecords.length),
    );
  }
}
