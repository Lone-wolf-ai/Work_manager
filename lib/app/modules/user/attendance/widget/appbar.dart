import 'popmenuebutton.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar attendanceAppBar() {
  return AppBar(
    surfaceTintColor: Colors.white,
    backgroundColor: Vx.white,
    title: "Check Your Attendance".text.bold.black.size(24).make(),
    // actions: const [CustomPoPMenue()],
  );
}
