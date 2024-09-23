import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendanceCardDate extends StatelessWidget {
  const AttendanceCardDate({
    super.key,
    this.day = '',
    this.month = '',
    this.year = '',
  });
  final String day;
  final String month;
  final String year;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        day.text.white.size(18).bold.make(),
        2.heightBox,
        month.text.white.size(18).bold.make(),
        2.heightBox,
        year.text.white.size(18).bold.make(),
      ],
    ).box.gray700.leftRounded(value: 12).height(100).width(100).make();
  }
}
