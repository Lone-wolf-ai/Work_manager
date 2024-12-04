import 'attendancecarddate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    this.totalHours = '',
    this.checkedIn = '',
    this.checkedOut = '',
    this.day = '',
    this.month = '',
    this.year = '',
  });

  final String totalHours;
  final String checkedIn;
  final String checkedOut;
  final String day;
  final String month;
  final String year;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        AttendanceCardDate(
          day: day,
          month: month,
          year: year,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Check In".text.bold.black.size(18).make(),
                8.heightBox,
                checkedIn.text.gray700.bold.size(16).make()
              ],
            ).box.make().paddingOnly(right: 8,left: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Check Out".text.bold.black.size(18).make(),
                8.heightBox,
                checkedOut.text.gray700.bold.size(16).make()
              ],
            ).box.make().paddingSymmetric(horizontal: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Hrs".text.bold.black.size(18).make(),
                8.heightBox,
                totalHours.text.gray700.bold.size(16).make()
              ],
            ).box.make()
          ],
        )
      ],
    )
        .box
        .gray200
        .shadowXs
        .border(color: Vx.gray700, width: 2)
        .width(double.infinity)
        .rounded
        .make()
        .paddingOnly(bottom: 24);
  }
}
