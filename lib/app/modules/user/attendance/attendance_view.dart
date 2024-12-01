import 'widget/appbar.dart';
import 'widget/attendancelist.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: attendanceAppBar(),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // show attendance chart
              //Chartwidget().box.height(360).width(double.infinity).make(),
              // show attendance status
              //const AttendanceStatus(),
              // attendance list header
              //32.heightBox,
              //"Attendance List".text.size(24).bold.make(),
              16.heightBox,
              // expanded widget to ensure ListView takes available space
              const AttendanceList(),
              
              100.heightBox,
            ],
          ).box.padding(const EdgeInsets.symmetric(horizontal: 12)).make(),
        ),

      ),
    );
  }
}
